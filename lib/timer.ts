/**
 * Countdown timer shared by the editor's two backends: a localStorage-backed
 * solo timer (`useEditorTimer`) and the Yjs-synced shared session timer
 * (`useCollabSession`). Both expose the same `Timer` shape so one component
 * renders either.
 *
 * The persisted form stores the configured `durationMs`, the `remainingMs` at
 * the moment the current run started (or the frozen remaining while paused),
 * and the wall-clock `startedAt`. The live reading is therefore *derived* from
 * the clock — a running countdown needs no per-tick writes and keeps ticking
 * correctly across reloads / late joins. The pure transitions below are shared
 * by both backends so the state machine lives in one place.
 */

/** Default countdown length when none has been set (25 min, Pomodoro-ish). */
export const DEFAULT_DURATION_MS = 25 * 60 * 1000;

/** Hard cap on a settable duration (10 hours) to keep inputs sane. */
export const MAX_DURATION_MS = 10 * 60 * 60 * 1000;

/** A countdown timer with a derived remaining reading. */
export interface Timer {
  /** True while counting down. */
  running: boolean;
  /** Milliseconds left (counts down while running, clamped at 0). */
  remainingMs: number;
  /** Configured countdown length. */
  durationMs: number;
  /** True once the countdown has reached zero. */
  finished: boolean;
  /** Start or resume (restarts from the full duration if already finished). */
  start: () => void;
  /** Pause, keeping the remaining time. */
  stop: () => void;
  /** Back to the full configured duration, paused. */
  reset: () => void;
  /** Set a new duration (ms) and reset to it, paused. */
  setDuration: (ms: number) => void;
}

/** Persisted countdown fields — the canonical state both backends store. */
export interface TimerSnapshot {
  /** Configured countdown length. */
  durationMs: number;
  running: boolean;
  /** Epoch ms when the current run started, or null when paused. */
  startedAt: number | null;
  /** Remaining ms captured at the run's start (or frozen while paused). */
  remainingMs: number;
}

/** A loosely-typed snapshot as it comes back from storage or a Yjs map. */
type RawTimer = { [K in keyof TimerSnapshot]?: unknown };

export const EMPTY_TIMER: TimerSnapshot = {
  durationMs: DEFAULT_DURATION_MS,
  running: false,
  startedAt: null,
  remainingMs: DEFAULT_DURATION_MS,
};

/** Coerce an unknown value (from storage or a Yjs map) into a TimerSnapshot. */
export function coerceTimer(raw: RawTimer | null | undefined): TimerSnapshot {
  if (!raw) return EMPTY_TIMER;
  const durationMs =
    typeof raw.durationMs === "number" && raw.durationMs > 0
      ? raw.durationMs
      : DEFAULT_DURATION_MS;
  return {
    durationMs,
    running: raw.running === true,
    startedAt: typeof raw.startedAt === "number" ? raw.startedAt : null,
    remainingMs:
      typeof raw.remainingMs === "number" ? raw.remainingMs : durationMs,
  };
}

/** Remaining ms implied by a snapshot at wall-clock time `now` (clamped ≥ 0). */
export function remainingFrom(t: TimerSnapshot, now: number): number {
  const base =
    t.running && t.startedAt != null
      ? t.remainingMs - (now - t.startedAt)
      : t.remainingMs;
  return Math.max(0, base);
}

// --- Pure transitions (return the same ref on a no-op so callers can skip a
// write). `now` is passed in so both backends stay clock-source agnostic. ---

export function startTimer(t: TimerSnapshot, now: number): TimerSnapshot {
  if (t.running) return t;
  const remaining = remainingFrom(t, now);
  const from = remaining > 0 ? remaining : t.durationMs;
  if (from <= 0) return t; // nothing to count down
  return { ...t, running: true, startedAt: now, remainingMs: from };
}

export function pauseTimer(t: TimerSnapshot, now: number): TimerSnapshot {
  if (!t.running) return t;
  return {
    ...t,
    running: false,
    startedAt: null,
    remainingMs: remainingFrom(t, now),
  };
}

export function resetTimer(t: TimerSnapshot): TimerSnapshot {
  if (!t.running && t.remainingMs === t.durationMs) return t;
  return { ...t, running: false, startedAt: null, remainingMs: t.durationMs };
}

export function withDuration(t: TimerSnapshot, durationMs: number): TimerSnapshot {
  const d = Math.min(MAX_DURATION_MS, Math.max(0, Math.round(durationMs)));
  return { durationMs: d, running: false, startedAt: null, remainingMs: d };
}

/** Freeze a running countdown at zero (called when it crosses the deadline). */
export function finishTimer(t: TimerSnapshot): TimerSnapshot {
  if (!t.running) return t;
  return { ...t, running: false, startedAt: null, remainingMs: 0 };
}
