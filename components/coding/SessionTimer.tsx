"use client";

import { useEffect, useRef, useState } from "react";
import type { Timer } from "@/lib/timer";
import { MAX_DURATION_MS } from "@/lib/timer";
import { cn } from "@/lib/utils";

const PRESET_MINUTES = [5, 15, 25, 45, 60];

/** Format milliseconds as m:ss, or h:mm:ss once past an hour. */
function formatDuration(ms: number): string {
  const total = Math.ceil(ms / 1000);
  const h = Math.floor(total / 3600);
  const m = Math.floor((total % 3600) / 60);
  const s = total % 60;
  const pad = (n: number) => String(n).padStart(2, "0");
  return h > 0 ? `${h}:${pad(m)}:${pad(s)}` : `${m}:${pad(s)}`;
}

/**
 * Editor-header countdown. Renders either the solo (localStorage) timer or the
 * shared collab-session timer — both expose the same {@link Timer} shape. The
 * user sets a duration in minutes and it counts down; in a session the value is
 * synced and any collaborator can start / pause / reset / change it (`shared`
 * only adjusts the tooltips so that intent is clear).
 */
export function SessionTimer({
  timer,
  shared = false,
}: {
  timer: Timer;
  shared?: boolean;
}) {
  const { running, remainingMs, durationMs, finished, start, stop, reset, setDuration } =
    timer;
  const ref = useRef<HTMLDivElement>(null);
  const [open, setOpen] = useState(false);
  const [draft, setDraft] = useState(String(Math.round(durationMs / 60000)));

  // Keep the input in sync when the duration changes elsewhere (e.g. a peer).
  useEffect(() => {
    setDraft(String(Math.round(durationMs / 60000)));
  }, [durationMs]);

  // Close the popover on outside click / Escape.
  useEffect(() => {
    if (!open) return;
    const onClick = (e: MouseEvent) => {
      if (ref.current && !ref.current.contains(e.target as Node)) setOpen(false);
    };
    const onKey = (e: KeyboardEvent) => {
      if (e.key === "Escape") setOpen(false);
    };
    document.addEventListener("mousedown", onClick);
    document.addEventListener("keydown", onKey);
    return () => {
      document.removeEventListener("mousedown", onClick);
      document.removeEventListener("keydown", onKey);
    };
  }, [open]);

  const what = shared ? "shared timer" : "timer";
  const maxMin = Math.floor(MAX_DURATION_MS / 60000);

  const applyDraft = () => {
    const mins = Math.max(0, Math.min(maxMin, Math.round(Number(draft) || 0)));
    setDraft(String(mins));
    setDuration(mins * 60000);
  };

  return (
    <div className="relative" ref={ref}>
      <div
        className={cn(
          "flex items-center rounded border transition-colors",
          finished
            ? "border-error text-error bg-error/10"
            : running
              ? "border-primary text-primary bg-primary-tint"
              : "border-outline-variant text-on-surface-variant",
        )}
      >
        <button
          type="button"
          onClick={running ? stop : start}
          title={
            finished
              ? `Time's up — restart ${what}`
              : running
                ? `Pause ${what}`
                : `Start ${what}`
          }
          aria-label={running ? `Pause ${what}` : `Start ${what}`}
          className="flex items-center gap-1 pl-2.5 pr-2 py-1.5 font-label-md text-label-md hover:text-on-surface"
        >
          <span className="material-symbols-outlined text-[18px]">
            {finished ? "restart_alt" : running ? "pause" : "play_arrow"}
          </span>
          <span className="tabular-nums">{formatDuration(remainingMs)}</span>
        </button>
        <button
          type="button"
          onClick={() => setOpen((o) => !o)}
          title={`Set ${what} duration`}
          aria-label={`Set ${what} duration`}
          className="px-1.5 py-1.5 border-l border-current/20 hover:text-on-surface"
        >
          <span className="material-symbols-outlined text-[18px]">
            {open ? "expand_less" : "expand_more"}
          </span>
        </button>
      </div>

      {open && (
        <div className="absolute right-0 mt-2 w-60 bg-surface-container-lowest border border-outline-variant rounded-lg shadow-lg z-50 overflow-hidden">
          <div className="px-3 py-2 border-b border-outline-variant flex items-center justify-between">
            <span className="text-label-md font-label-md text-on-surface-variant uppercase tracking-wider">
              Countdown
            </span>
            {shared && (
              <span className="text-body-sm text-on-surface-variant">Synced</span>
            )}
          </div>

          <div className="p-3 flex flex-col gap-3">
            <label className="flex flex-col gap-1.5">
              <span className="text-body-sm text-on-surface">Minutes</span>
              <div className="flex items-center gap-2">
                <input
                  type="number"
                  min={0}
                  max={maxMin}
                  value={draft}
                  onChange={(e) => setDraft(e.target.value)}
                  onKeyDown={(e) => {
                    if (e.key === "Enter") {
                      applyDraft();
                      e.currentTarget.blur();
                    }
                  }}
                  className="w-20 bg-surface-variant border border-outline-variant rounded px-2 py-1.5 text-body-md text-on-surface outline-none focus:ring-2 focus:ring-primary tabular-nums"
                />
                <button
                  type="button"
                  onClick={applyDraft}
                  className="px-3 py-1.5 rounded bg-primary text-on-primary text-label-md font-label-md hover:opacity-90"
                >
                  Set
                </button>
              </div>
            </label>

            <div className="flex flex-wrap gap-1.5">
              {PRESET_MINUTES.map((m) => (
                <button
                  key={m}
                  type="button"
                  onClick={() => setDuration(m * 60000)}
                  className="px-2.5 py-1 rounded border border-outline-variant text-label-md font-label-md text-on-surface-variant hover:border-primary hover:text-primary transition-colors tabular-nums"
                >
                  {m}m
                </button>
              ))}
            </div>

            <button
              type="button"
              onClick={reset}
              className="w-full px-3 py-1.5 rounded border border-outline-variant text-label-md font-label-md text-on-surface-variant hover:border-primary hover:text-on-surface transition-colors"
            >
              Reset to {Math.round(durationMs / 60000)}m
            </button>
          </div>
        </div>
      )}
    </div>
  );
}
