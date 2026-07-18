"use client";

import { useEffect } from "react";
import type { ProblemProgress } from "@/lib/types";

/** Celebration toast for the first successful submission of a course problem. */
export function PointsToast({
  completion,
  onDismiss,
}: {
  completion: ProblemProgress | null;
  onDismiss: () => void;
}) {
  useEffect(() => {
    if (!completion) return;
    const timer = setTimeout(onDismiss, 6000);
    return () => clearTimeout(timer);
  }, [completion, onDismiss]);

  if (!completion) return null;

  return (
    <div
      role="status"
      className="fixed bottom-6 left-1/2 -translate-x-1/2 z-50 flex items-center gap-2 px-4 py-3 rounded-lg bg-inverse-surface text-inverse-on-surface shadow-lg"
    >
      <span className="material-symbols-outlined text-secondary-fixed-dim fill">
        emoji_events
      </span>
      <span className="text-body-md">
        Solved! <span className="font-bold">+{completion.points} pts</span>
        {completion.failedSubmits > 0 &&
          ` after ${completion.failedSubmits} failed ${
            completion.failedSubmits === 1 ? "submission" : "submissions"
          }`}
      </span>
      <button
        type="button"
        onClick={onDismiss}
        aria-label="Dismiss"
        className="material-symbols-outlined text-[18px] opacity-70 hover:opacity-100"
      >
        close
      </button>
    </div>
  );
}
