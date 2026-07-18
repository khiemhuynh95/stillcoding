import type { Course } from "./types";

/**
 * Pure helpers for the course timeline (start_date → end_date, either side
 * nullable). Points only count inside the window — that rule is enforced
 * server-side by the record_submission RPC; these helpers just drive the UI
 * labels.
 */

export type TimelineState = "upcoming" | "active" | "ended";

export interface CourseTimeline {
  state: TimelineState;
  /** Short human label, e.g. "Ends Aug 30" / "Starts Jul 10" / "Ended". */
  label: string;
}

function formatDate(iso: string): string {
  const d = new Date(`${iso}T00:00:00`);
  return d.toLocaleDateString(undefined, { month: "short", day: "numeric" });
}

/** Local calendar date as YYYY-MM-DD (course dates are date-only). */
function todayIso(): string {
  const now = new Date();
  const m = String(now.getMonth() + 1).padStart(2, "0");
  const d = String(now.getDate()).padStart(2, "0");
  return `${now.getFullYear()}-${m}-${d}`;
}

export function courseTimeline(
  course: Pick<Course, "startDate" | "endDate">,
): CourseTimeline {
  const today = todayIso();
  if (course.startDate && today < course.startDate) {
    return { state: "upcoming", label: `Starts ${formatDate(course.startDate)}` };
  }
  if (course.endDate && today > course.endDate) {
    return { state: "ended", label: "Ended" };
  }
  if (course.endDate) {
    return { state: "active", label: `Ends ${formatDate(course.endDate)}` };
  }
  return { state: "active", label: "Open-ended" };
}
