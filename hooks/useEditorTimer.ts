"use client";

import { useCallback, useEffect, useState } from "react";
import { storageGet, storageSet, storageKeys } from "@/lib/storage";
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

/**
 * Per-problem countdown timer backed by localStorage — the solo counterpart to
 * the collab session's shared timer, exposing the same {@link Timer} shape so
 * one component renders either. Persists across reloads (the reading is derived
 * from the wall clock, so a countdown left running keeps ticking down).
 */
export function useEditorTimer(slug: string): Timer {
  const [snap, setSnap] = useState<TimerSnapshot>(EMPTY_TIMER);
  const [, setTick] = useState(0);

  // Load this problem's saved snapshot whenever the slug changes.
  useEffect(() => {
    setSnap(
      coerceTimer(storageGet<Record<string, unknown> | null>(storageKeys.timer(slug), null)),
    );
  }, [slug]);

  // Tick once a second while running so the derived reading advances.
  useEffect(() => {
    if (!snap.running) return;
    const id = setInterval(() => setTick((t) => t + 1), 1000);
    return () => clearInterval(id);
  }, [snap.running]);

  // Apply a pure transition and persist it. The functional updater + no-op
  // transitions keep it correct under React StrictMode's double-invoke.
  const apply = useCallback(
    (fn: (s: TimerSnapshot) => TimerSnapshot) => {
      setSnap((s) => {
        const next = fn(s);
        if (next !== s) storageSet(storageKeys.timer(slug), next);
        return next;
      });
    },
    [slug],
  );

  const remainingMs = remainingFrom(snap, Date.now());

  // Freeze at zero once the countdown crosses the deadline.
  useEffect(() => {
    if (snap.running && remainingMs <= 0) apply(finishTimer);
  }, [snap.running, remainingMs, apply]);

  const start = useCallback(() => apply((s) => startTimer(s, Date.now())), [apply]);
  const stop = useCallback(() => apply((s) => pauseTimer(s, Date.now())), [apply]);
  const reset = useCallback(() => apply(resetTimer), [apply]);
  const setDuration = useCallback(
    (ms: number) => apply((s) => withDuration(s, ms)),
    [apply],
  );

  return {
    running: snap.running,
    remainingMs,
    durationMs: snap.durationMs,
    finished: remainingMs === 0,
    start,
    stop,
    reset,
    setDuration,
  };
}
