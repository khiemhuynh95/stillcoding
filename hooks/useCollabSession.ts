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

/** A peer currently present in the session (from Yjs awareness). */
export interface CollabPeer {
  clientId: number;
  user: CollabUser;
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
  /** The local user's identity. */
  me: CollabUser;
  /** Rename the local user (persisted + broadcast to peers). */
  setName: (name: string) => void;
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

  useEffect(() => {
    if (!sessionId || !collabEnabled) {
      setStatus("disconnected");
      return;
    }

    const doc = new Y.Doc();
    const text = doc.getText("monaco");
    const provider = new SupabaseYjsProvider(sessionId, doc);
    let snapshotTimer: ReturnType<typeof setTimeout> | null = null;
    let cancelled = false;

    provider.awareness.setLocalStateField("user", meRef.current);
    awarenessRef.current = provider.awareness;
    setYtext(text);
    setAwareness(provider.awareness);

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
      setPeers([]);
      setSession(null);
    };
  }, [sessionId]);

  const setName = useCallback((name: string) => {
    const updated = setCollabName(name);
    meRef.current = updated;
    setMe(updated);
    awarenessRef.current?.setLocalStateField("user", updated);
  }, []);

  return { active, status, ytext, awareness, peers, session, me, setName };
}
