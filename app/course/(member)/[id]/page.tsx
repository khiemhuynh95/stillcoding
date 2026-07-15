"use client";

import Link from "next/link";
import { useParams } from "next/navigation";
import { useMemo } from "react";
import { TopNav } from "@/components/layout/TopNav";
import { WeekList } from "@/components/course/WeekList";
import { useProblems } from "@/hooks/useProblems";
import {
  useCourse,
  useCourseWeeks,
  useMyProgress,
} from "@/hooks/useCourses";
import { courseTimeline } from "@/lib/courseTimeline";
import type { ProblemProgress, ProblemSummary } from "@/lib/types";
import { cn } from "@/lib/utils";

/** A single course: header + timeline, weeks with problems and progress. */
export default function CoursePage() {
  // The URL carries the shareable join code ("Course ID"), not the uuid.
  const params = useParams<{ id: string }>();
  const courseCode = params.id;

  const { data: course, isLoading: courseLoading } = useCourse(courseCode);
  const { data: weeks } = useCourseWeeks(course?.id ?? "");
  const { data: progress } = useMyProgress(course?.id ?? "");
  const { data: problems } = useProblems(null);

  const problemsBySlug = useMemo(() => {
    const map = new Map<string, ProblemSummary>();
    for (const p of problems ?? []) map.set(p.title_slug, p);
    return map;
  }, [problems]);

  const progressBySlug = useMemo(() => {
    const map = new Map<string, ProblemProgress>();
    for (const p of progress ?? []) map.set(p.titleSlug, p);
    return map;
  }, [progress]);

  const totalPoints = useMemo(
    () => (progress ?? []).reduce((n, p) => n + (p.points ?? 0), 0),
    [progress],
  );

  const timeline = course ? courseTimeline(course) : null;

  return (
    <div className="min-h-screen flex flex-col bg-background">
      <TopNav
        actions={
          <Link
            href="/course"
            className="px-3 py-1.5 rounded border border-outline-variant text-label-md font-label-md text-on-surface-variant hover:border-primary hover:text-on-surface transition-colors"
          >
            My courses
          </Link>
        }
      />

      <main className="flex-1 w-full max-w-4xl mx-auto px-gutter py-8 flex flex-col gap-6">
        {courseLoading ? (
          <p className="text-body-md text-on-surface-variant">Loading…</p>
        ) : !course ? (
          <div className="text-center py-16 flex flex-col items-center gap-3">
            <span className="material-symbols-outlined text-5xl text-outline-variant">
              lock
            </span>
            <p className="text-body-md text-on-surface-variant max-w-sm">
              You&apos;re not a member of this course. Join it with its course
              ID from the dashboard.
            </p>
            <Link
              href="/course"
              className="mt-2 px-4 py-2 rounded bg-primary text-on-primary text-label-md font-label-md hover:opacity-90"
            >
              Back to my courses
            </Link>
          </div>
        ) : (
          <>
            <div className="flex items-start justify-between gap-4 flex-wrap">
              <div className="flex flex-col gap-1 min-w-0">
                <h1 className="font-headline-sm text-headline-sm text-on-surface truncate">
                  {course.name}
                </h1>
                {course.description && (
                  <p className="text-body-md text-on-surface-variant">
                    {course.description}
                  </p>
                )}
                {timeline && (
                  <span
                    className={cn(
                      "text-body-sm",
                      timeline.state === "ended"
                        ? "text-error"
                        : "text-on-surface-variant",
                    )}
                  >
                    {timeline.label}
                    {timeline.state === "ended" &&
                      " — runs no longer earn points"}
                  </span>
                )}
              </div>
              <div className="flex items-center gap-2 shrink-0">
                <span className="px-3 py-1.5 rounded-full bg-surface-container text-on-surface text-label-md font-label-md tabular-nums">
                  {totalPoints} pts
                </span>
                <Link
                  href={`/course/${courseCode}/leaderboard`}
                  className="px-3 py-1.5 rounded border border-outline-variant text-label-md font-label-md text-on-surface-variant hover:border-primary hover:text-on-surface transition-colors"
                >
                  Leaderboard
                </Link>
                {course.myRole === "admin" && (
                  <Link
                    href={`/course/${courseCode}/manage`}
                    className="px-3 py-1.5 rounded bg-primary text-on-primary text-label-md font-label-md hover:opacity-90"
                  >
                    Manage
                  </Link>
                )}
              </div>
            </div>

            <WeekList
              weeks={weeks ?? []}
              courseId={courseCode}
              problemsBySlug={problemsBySlug}
              progressBySlug={progressBySlug}
            />
          </>
        )}
      </main>
    </div>
  );
}
