import type { SolvedState } from "@/hooks/useSolvedStatus";

/** Status glyph for a problem row, driven by local solved/attempted state. */
export function StatusIcon({ state }: { state?: SolvedState }) {
  if (state === "solved") {
    return (
      <span className="material-symbols-outlined fill text-secondary" title="Solved">
        check_circle
      </span>
    );
  }
  if (state === "attempted") {
    return (
      <span
        className="material-symbols-outlined fill text-tertiary-fixed-dim"
        title="Attempted"
      >
        history
      </span>
    );
  }
  return (
    <span className="material-symbols-outlined text-outline-variant" title="Not started">
      circle
    </span>
  );
}
