import type { ProblemProgress } from "@/lib/types";

/** Per-problem course progress: frozen points, tries so far, or nothing. */
export function ProgressBadge({ progress }: { progress?: ProblemProgress }) {
  if (progress?.completedAt) {
    return (
      <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-full bg-secondary-container/40 text-on-secondary-container text-label-md font-label-md whitespace-nowrap">
        <span className="material-symbols-outlined text-[14px] fill">
          check_circle
        </span>
        {progress.points ?? 0} pts
      </span>
    );
  }
  if (progress && progress.failedAttempts > 0) {
    return (
      <span className="inline-flex items-center px-2 py-0.5 rounded-full bg-surface-container text-on-surface-variant text-label-md font-label-md whitespace-nowrap">
        {progress.failedAttempts}{" "}
        {progress.failedAttempts === 1 ? "try" : "tries"}
      </span>
    );
  }
  return <span className="text-on-surface-variant/50 text-body-sm">—</span>;
}
