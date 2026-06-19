"use client";

import { useCallback, useEffect, useRef, useState } from "react";
import * as Y from "yjs";
import type { Awareness } from "y-protocols/awareness";
import {
  type CollabSession,
  type CollabStatus,
  type CollabUser,
  SupabaseYjsProvider,
  base64ToBytes,
  bytesToBase64,
  collabEnabled,
  getCollabIdentity,
  loadCollabSession,
  saveCollabSnapshot,
  setCollabName,
} from "@/lib/collab";
import {
  type Timer,
  type TimerSnapshot,
  EMPTY_TIMER,
  coerceTimer,
  remainingFrom,
  startTimer,
  pauseTimer,
  resetTimer,
  withDuration,
  finishTimer,
} from "@/lib/timer";

/** A peer currently present in the session (from Yjs awareness). */
export interface CollabPeer {
  clientId: number;
  user: CollabUser;
}

/** Read the timer snapshot off the shared map, tolerating a fresh/empty map. */
function readTimer(map: Y.Map<unknown>): TimerSnapshot {
  return coerceTimer({
    durationMs: map.get("durationMs"),
    running: map.get("running"),
    startedAt: map.get("startedAt"),
    remainingMs: map.get("remainingMs"),
  });
}

/** Write a snapshot onto the shared map in one transaction (one Yjs update). */
function writeTimer(map: Y.Map<unknown>, next: TimerSnapshot): void {
  map.doc?.transact(() => {
    map.set("durationMs", next.durationMs);
    map.set("running", next.running);
    map.set("startedAt", next.startedAt);
    map.set("remainingMs", next.remainingMs);
  });
}

export interface CollabState {
  /** True once a session id is set and Supabase is configured. */
  active: boolean;
  status: CollabStatus;
  /** The shared text the editor binds to (null until the doc is ready). */
  ytext: Y.Text | null;
  awareness: Awareness | null;
  /** Other collaborators present (excludes the local user). */
  peers: CollabPeer[];
  /** Session metadata (slug, language) once loaded from the DB. */
  session: CollabSession | null;
  /**
   * True once the lookup has completed and no row exists — i.e. the session was
   * never created or has been reaped by retention. Distinct from the initial
   * loading state (where this is false and `session` is still null).
   */
  sessionMissing: boolean;
  /** The local user's identity. */
  me: CollabUser;
  /** Rename the local user (persisted + broadcast to peers). */
  setName: (name: string) => void;
  /** Shared session countdown (synced; anyone can start/stop/set). */
  timer: Timer;
}

const SNAPSHOT_DEBOUNCE_MS = 4000;

/**
 * Joins a collaboration session by id: spins up a Yjs doc bound to Supabase
 * Realtime, loads the persisted snapshot, debounces snapshot writes back, and
 * exposes the shared text + presence for the editor to bind to.
 *
 * Pass `null` to disable (no session) — the hook then does nothing and reports
 * `active: false`, so the coding screen keeps its normal localStorage drafts.
 */
export function useCollabSession(sessionId: string | null): CollabState {
  const meRef = useRef<CollabUser>(getCollabIdentity());
  const awarenessRef = useRef<Awareness | null>(null);
  const active = !!sessionId && collabEnabled;

  const [me, setMe] = useState<CollabUser>(meRef.current);
  const [status, setStatus] = useState<CollabStatus>("connecting");
  const [ytext, setYtext] = useState<Y.Text | null>(null);
  const [awareness, setAwareness] = useState<Awareness | null>(null);
  const [peers, setPeers] = useState<CollabPeer[]>([]);
  const [session, setSession] = useState<CollabSession | null>(null);
  const [sessionMissing, setSessionMissing] = useState(false);
  const [timerMap, setTimerMap] = useState<Y.Map<unknown> | null>(null);

  useEffect(() => {
    if (!sessionId || !collabEnabled) {
      setStatus("disconnected");
      return;
    }

    const doc = new Y.Doc();
    const text = doc.getText("monaco");
    const timer = doc.getMap("timer");
    const provider = new SupabaseYjsProvider(sessionId, doc);
    let snapshotTimer: ReturnType<typeof setTimeout> | null = null;
    let cancelled = false;

    provider.awareness.setLocalStateField("user", meRef.current);
    awarenessRef.current = provider.awareness;
    setYtext(text);
    setAwareness(provider.awareness);
    setTimerMap(timer);

    const offStatus = provider.onStatus(setStatus);

    // Track present collaborators (excluding ourselves).
    const syncPeers = () => {
      const next: CollabPeer[] = [];
      provider.awareness.getStates().forEach((state, clientId) => {
        if (clientId === doc.clientID) return;
        const user = (state as { user?: CollabUser }).user;
        if (user?.name) next.push({ clientId, user });
      });
      setPeers(next);
    };
    provider.awareness.on("change", syncPeers);

    // Debounced snapshot persistence so late-joiners/reloads get the buffer.
    const onDocUpdate = () => {
      if (snapshotTimer) clearTimeout(snapshotTimer);
      snapshotTimer = setTimeout(() => {
        void saveCollabSnapshot(
          sessionId,
          bytesToBase64(Y.encodeStateAsUpdate(doc)),
        );
      }, SNAPSHOT_DEBOUNCE_MS);
    };
    doc.on("update", onDocUpdate);

    // Seed from the persisted snapshot (peers may also stream state in).
    void loadCollabSession(sessionId).then((row) => {
      if (cancelled) return;
      setSession(row);
      setSessionMissing(row == null);
      if (row?.doc) Y.applyUpdate(doc, base64ToBytes(row.doc));
    });

    return () => {
      cancelled = true;
      if (snapshotTimer) clearTimeout(snapshotTimer);
      doc.off("update", onDocUpdate);
      provider.awareness.off("change", syncPeers);
      offStatus();
      provider.destroy();
      doc.destroy();
      awarenessRef.current = null;
      setYtext(null);
      setAwareness(null);
      setTimerMap(null);
      setPeers([]);
      setSession(null);
      setSessionMissing(false);
    };
  }, [sessionId]);

  // --- Shared countdown -----------------------------------------------------
  // Mirror the Yjs timer map into React state, then locally tick once a second
  // while running so the displayed value advances without any network traffic
  // (the map only changes on start/stop/reset/set, which is what actually syncs).
  const [timerSnap, setTimerSnap] = useState<TimerSnapshot>(EMPTY_TIMER);
  const [, setTick] = useState(0);

  useEffect(() => {
    if (!timerMap) {
      setTimerSnap(EMPTY_TIMER);
      return;
    }
    const sync = () => setTimerSnap(readTimer(timerMap));
    sync();
    timerMap.observe(sync);
    return () => timerMap.unobserve(sync);
  }, [timerMap]);

  useEffect(() => {
    if (!timerSnap.running) return;
    const id = setInterval(() => setTick((t) => t + 1), 1000);
    return () => clearInterval(id);
  }, [timerSnap.running]);

  // Apply a pure transition to the shared map (skips a write on a no-op).
  const applyTimer = useCallback(
    (fn: (s: TimerSnapshot) => TimerSnapshot) => {
      if (!timerMap) return;
      const current = readTimer(timerMap);
      const next = fn(current);
      if (next !== current) writeTimer(timerMap, next);
    },
    [timerMap],
  );

  const remainingMs = remainingFrom(timerSnap, Date.now());

  // Freeze at zero once the countdown crosses the deadline. (Every present
  // client may fire this; the no-op guard makes the redundant writes harmless.)
  useEffect(() => {
    if (timerSnap.running && remainingMs <= 0) applyTimer(finishTimer);
  }, [timerSnap.running, remainingMs, applyTimer]);

  const timer: Timer = {
    running: timerSnap.running,
    remainingMs,
    durationMs: timerSnap.durationMs,
    finished: remainingMs === 0,
    start: useCallback(() => applyTimer((s) => startTimer(s, Date.now())), [applyTimer]),
    stop: useCallback(() => applyTimer((s) => pauseTimer(s, Date.now())), [applyTimer]),
    reset: useCallback(() => applyTimer(resetTimer), [applyTimer]),
    setDuration: useCallback((ms: number) => applyTimer((s) => withDuration(s, ms)), [applyTimer]),
  };

  const setName = useCallback((name: string) => {
    const updated = setCollabName(name);
    meRef.current = updated;
    setMe(updated);
    awarenessRef.current?.setLocalStateField("user", updated);
  }, []);

  return {
    active,
    status,
    ytext,
    awareness,
    peers,
    session,
    sessionMissing,
    me,
    setName,
    timer,
  };
}
