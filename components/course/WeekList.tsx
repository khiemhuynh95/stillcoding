"use client";

import Link from "next/link";
import { DifficultyBadge } from "@/components/browse/DifficultyBadge";
import { ProgressBadge } from "@/components/course/ProgressBadge";
import type {
  CourseWeek,
  ProblemProgress,
  ProblemSummary,
} from "@/lib/types";

/**
 * A course's weeks with their ordered problems. Slugs are resolved against
 * the normalized catalog (source-agnostic); a slug missing from the catalog
 * is silently skipped, matching the preset-list behavior.
 */
export function WeekList({
  weeks,
  courseId,
  problemsBySlug,
  progressBySlug,
}: {
  weeks: CourseWeek[];
  courseId: string;
  problemsBySlug: Map<string, ProblemSummary>;
  progressBySlug: Map<string, ProblemProgress>;
}) {
  if (weeks.length === 0) {
    return (
      <p className="text-body-md text-on-surface-variant py-8 text-center">
        No weeks yet — the course admin hasn&apos;t added content.
      </p>
    );
  }

  return (
    <div className="flex flex-col gap-6">
      {weeks.map((week) => {
        const rows = week.problems
          .map((p) => ({ ref: p, problem: problemsBySlug.get(p.titleSlug) }))
          .filter((r) => r.problem != null);
        return (
          <section key={week.id}>
            <h3 className="text-label-md font-label-md uppercase tracking-wider text-on-surface-variant mb-2">
              {week.title}
            </h3>
            {rows.length === 0 ? (
              <p className="text-body-sm text-on-surface-variant px-1 py-2">
                No problems in this week yet.
              </p>
            ) : (
              <div className="bg-surface-container-lowest border border-outline-variant rounded-lg divide-y divide-outline-variant overflow-hidden">
                {rows.map(({ ref, problem }) => (
                  <Link
                    key={ref.id}
                    href={`/problems/${ref.titleSlug}?course=${courseId}`}
                    className="flex items-center gap-3 px-4 py-3 hover:bg-surface-container transition-colors"
                  >
                    <span className="w-10 shrink-0 text-body-sm tabular-nums text-on-surface-variant">
                      {problem!.frontend_id}
                    </span>
                    <span className="flex-1 truncate text-body-md text-on-surface">
                      {problem!.title}
                    </span>
                    <ProgressBadge progress={progressBySlug.get(ref.titleSlug)} />
                    <DifficultyBadge
                      difficulty={problem!.difficulty}
                      className="hidden sm:inline-block"
                    />
                  </Link>
                ))}
              </div>
            )}
          </section>
        );
      })}
    </div>
  );
}
