"use client";

import { useQueryClient } from "@tanstack/react-query";
import { useCallback, useState } from "react";
import type { RunResult, SubmitResult } from "@/components/coding/CodeEditor";
import { useCourse, useCourseWeeks } from "@/hooks/useCourses";
import { recordSubmission, recordTestRun } from "@/lib/course";
import { useAuth } from "@/providers/AuthProvider";
import type { ProblemProgress } from "@/lib/types";

/**
 * Bridges the editor's Run/Submit actions to the grading RPCs. `active` only
 * when the user opened the problem from a course (`?course=` on
 * /problems/[slug]), is signed in, is a member of that course, and the course
 * actually contains the problem.
 *
 * Run is a free metric: when active, `reportRun` bumps the server-side
 * run_count and nothing else. Submit is the graded action: `reportSubmission`
 * always saves the code + test result (course context or not, as long as the
 * user is signed in); inside an active course the server also counts the
 * submit, penalizes failures, and freezes points at the first successful
 * submission — earlier in the course window scores more. The server
 * (record_submission RPC) owns all counters, the timeline check, and the
 * points formula.
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
    (_result: RunResult) => {
      if (!courseId) return;
      // Fire-and-forget: run counts are a lazy metric, no cache invalidation,
      // and a hiccup must never break the run console.
      recordTestRun(courseId, slug).catch(() => {});
    },
    [courseId, slug],
  );

  const reportSubmission = useCallback(
    (result: SubmitResult) => {
      if (!user) return;
      const passed =
        result.status === "done" &&
        result.summary != null &&
        result.summary.total > 0 &&
        result.summary.failed === 0;

      // Was this problem already completed before this submission? (The RPC
      // returns the frozen row unchanged on later passes, so distinguish here
      // to only toast the submission that actually completed it.)
      const alreadyCompleted = courseId
        ? queryClient
            .getQueryData<ProblemProgress[]>([
              "course",
              "progress",
              courseId,
              user.id,
            ])
            ?.some((p) => p.titleSlug === slug && p.completedAt != null)
        : false;

      recordSubmission({
        courseId: active ? courseId : null,
        titleSlug: slug,
        lang: result.langId,
        code: result.code,
        summary: result.summary,
        passed,
      })
        .then((progress) => {
          if (!progress) return; // practice submit — saved, not scored
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
          // Best-effort: a grading hiccup must never break the run console.
        });
    },
    [active, courseId, slug, queryClient, user],
  );

  const dismissCompletion = useCallback(() => setLastCompletion(null), []);

  return { active, reportRun, reportSubmission, lastCompletion, dismissCompletion };
}
