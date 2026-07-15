"use client";

import Link from "next/link";
import { useParams } from "next/navigation";
import { TopNav } from "@/components/layout/TopNav";
import { LeaderboardTable } from "@/components/course/LeaderboardTable";
import { useCourse, useLeaderboard } from "@/hooks/useCourses";
import { courseTimeline } from "@/lib/courseTimeline";

/** Per-course standings. Member-only: RLS returns rows only to members. */
export default function LeaderboardPage() {
  // URL param is the join code; the leaderboard query needs the uuid.
  const params = useParams<{ id: string }>();
  const courseCode = params.id;

  const { data: course, isLoading: courseLoading } = useCourse(courseCode);
  const { data: entries, isLoading } = useLeaderboard(course?.id ?? "");

  const timeline = course ? courseTimeline(course) : null;

  return (
    <div className="min-h-screen flex flex-col bg-background">
      <TopNav
        actions={
          <Link
            href={`/course/${courseCode}`}
            className="px-3 py-1.5 rounded border border-outline-variant text-label-md font-label-md text-on-surface-variant hover:border-primary hover:text-on-surface transition-colors"
          >
            Back to course
          </Link>
        }
      />

      <main className="flex-1 w-full max-w-2xl mx-auto px-gutter py-8 flex flex-col gap-4">
        {courseLoading || isLoading ? (
          <p className="text-body-md text-on-surface-variant">Loading…</p>
        ) : !course ? (
          <div className="text-center py-16 flex flex-col items-center gap-3">
            <span className="material-symbols-outlined text-5xl text-outline-variant">
              lock
            </span>
            <p className="text-body-md text-on-surface-variant max-w-sm">
              Only members of this course can see its leaderboard.
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
            <div className="flex items-center justify-between gap-3 flex-wrap">
              <h1 className="font-headline-sm text-headline-sm text-on-surface">
                Leaderboard · {course.name}
              </h1>
            </div>
            {timeline?.state === "ended" && (
              <p className="flex items-center gap-1.5 text-body-sm text-on-surface-variant">
                <span className="material-symbols-outlined text-[16px]">
                  flag
                </span>
                The course has ended — these are the final standings.
              </p>
            )}
            <LeaderboardTable entries={entries ?? []} />
          </>
        )}
      </main>
    </div>
  );
}
