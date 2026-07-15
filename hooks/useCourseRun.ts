"use client";

import { useQueryClient } from "@tanstack/react-query";
import { useCallback, useState } from "react";
import type { RunResult } from "@/components/coding/CodeEditor";
import { useCourse, useCourseWeeks } from "@/hooks/useCourses";
import { recordRun } from "@/lib/course";
import { useAuth } from "@/providers/AuthProvider";
import type { ProblemProgress } from "@/lib/types";

/**
 * Scores runs for the course feature. Active only when the user opened the
 * problem from a course (`?course=` on /problems/[slug]), is signed in, is a
 * member of that course, and the course actually contains the problem —
 * otherwise `reportRun` is inert and the run pipeline behaves exactly as for
 * public usage.
 *
 * Classification: a run with a test summary and zero failures is a pass; a
 * run that errored or had failing tests is a failed attempt; a run with no
 * summary and no error (plain prints / exploration) is ignored. The server
 * (record_run RPC) owns attempts, the timeline check, and the points formula.
 */
export function useCourseRun(slug: string, courseCode: string | null) {
  const { user } = useAuth();
  const queryClient = useQueryClient();
  // ?course= carries the join code; resolve it to the course (and its uuid).
  const { data: course } = useCourse(courseCode ?? "");
  const courseId = course?.id ?? null;
  const { data: weeks } = useCourseWeeks(courseId ?? "");
  const [lastCompletion, setLastCompletion] = useState<ProblemProgress | null>(
    null,
  );

  const inCourse =
    weeks?.some((w) => w.problems.some((p) => p.titleSlug === slug)) ?? false;
  const active = Boolean(user && course && inCourse);

  const reportRun = useCallback(
    (result: RunResult) => {
      if (!courseId) return;
      const passed =
        result.status === "done" &&
        result.summary != null &&
        result.summary.total > 0 &&
        result.summary.failed === 0;
      const failed =
        result.status === "error" ||
        (result.summary != null && result.summary.failed > 0);
      if (!passed && !failed) return; // exploratory run — not an attempt

      // Was this problem already completed before this run? (The RPC returns
      // the frozen row unchanged on later passes, so distinguish here to only
      // toast the run that actually completed it.)
      const alreadyCompleted = user
        ? queryClient
            .getQueryData<ProblemProgress[]>([
              "course",
              "progress",
              courseId,
              user.id,
            ])
            ?.some((p) => p.titleSlug === slug && p.completedAt != null)
        : false;

      recordRun(courseId, slug, passed, passed ? result.durationMs : null)
        .then((progress) => {
          queryClient.invalidateQueries({ queryKey: ["course", "progress"] });
          queryClient.invalidateQueries({
            queryKey: ["course", "leaderboard"],
          });
          if (
            passed &&
            !alreadyCompleted &&
            progress.completedAt &&
            progress.points != null
          ) {
            setLastCompletion(progress);
          }
        })
        .catch(() => {
          // Best-effort: a scoring hiccup must never break the run console.
        });
    },
    [courseId, slug, queryClient, user],
  );

  const dismissCompletion = useCallback(() => setLastCompletion(null), []);

  return { active, reportRun, lastCompletion, dismissCompletion };
}
