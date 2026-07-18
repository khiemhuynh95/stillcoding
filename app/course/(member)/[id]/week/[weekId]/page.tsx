"use client";

import { useMemo } from "react";
import Link from "next/link";
import { useParams } from "next/navigation";
import { TopNav } from "@/components/layout/TopNav";
import { useCourse, useCourseWeeks } from "@/hooks/useCourses";
import { markdownToSafeHtml } from "@/lib/markdown";

/** A week's study material, rendered from admin-authored markdown. */
export default function WeekMaterialPage() {
  // URL param is the join code; the weeks query needs the uuid.
  const params = useParams<{ id: string; weekId: string }>();
  const courseCode = params.id;
  const weekId = params.weekId;

  const { data: course, isLoading: courseLoading } = useCourse(courseCode);
  const { data: weeks, isLoading } = useCourseWeeks(course?.id ?? "");

  const week = weeks?.find((w) => w.id === weekId);
  const html = useMemo(
    () => markdownToSafeHtml(week?.material),
    [week?.material],
  );

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

      <main className="flex-1 w-full max-w-4xl mx-auto px-gutter py-8 flex flex-col gap-4">
        {courseLoading || isLoading ? (
          <p className="text-body-md text-on-surface-variant">Loading…</p>
        ) : !course ? (
          <div className="text-center py-16 flex flex-col items-center gap-3">
            <span className="material-symbols-outlined text-5xl text-outline-variant">
              lock
            </span>
            <p className="text-body-md text-on-surface-variant max-w-sm">
              Only members of this course can see its study material.
            </p>
            <Link
              href="/course"
              className="mt-2 px-4 py-2 rounded bg-primary text-on-primary text-label-md font-label-md hover:opacity-90"
            >
              Back to my courses
            </Link>
          </div>
        ) : !week || !html ? (
          <div className="text-center py-16 flex flex-col items-center gap-3">
            <span className="material-symbols-outlined text-5xl text-outline-variant">
              menu_book
            </span>
            <p className="text-body-md text-on-surface-variant max-w-sm">
              No study material for this week.
            </p>
            <Link
              href={`/course/${courseCode}`}
              className="mt-2 px-4 py-2 rounded bg-primary text-on-primary text-label-md font-label-md hover:opacity-90"
            >
              Back to course
            </Link>
          </div>
        ) : (
          <>
            <div className="flex flex-col gap-1">
              <p className="text-label-md font-label-md uppercase tracking-wider text-on-surface-variant">
                {course.name}
              </p>
              <h1 className="font-headline-sm text-headline-sm text-on-surface">
                {week.title}
              </h1>
            </div>
            <div
              className="problem-content"
              dangerouslySetInnerHTML={{ __html: html }}
            />
          </>
        )}
      </main>
    </div>
  );
}
