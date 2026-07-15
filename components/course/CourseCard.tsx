"use client";

import Link from "next/link";
import type { Course } from "@/lib/types";
import { courseTimeline } from "@/lib/courseTimeline";
import { cn } from "@/lib/utils";

/** One course on the dashboard (the course switcher). */
export function CourseCard({
  course,
  onLeave,
}: {
  course: Course;
  onLeave: (course: Course) => void;
}) {
  const timeline = courseTimeline(course);

  return (
    <div className="relative flex flex-col gap-2 bg-surface-container-lowest border border-outline-variant rounded-lg p-4 hover:border-primary transition-colors">
      <Link
        href={`/course/${course.joinCode}`}
        className="absolute inset-0"
        aria-label={`Open ${course.name}`}
      />
      <div className="flex items-start justify-between gap-2">
        <h3 className="text-body-md font-bold text-on-surface truncate">
          {course.name}
        </h3>
        {course.myRole === "admin" && (
          <span className="shrink-0 px-2 py-0.5 rounded-full bg-primary-fixed text-on-primary-fixed text-label-md font-label-md">
            Admin
          </span>
        )}
      </div>
      {course.description && (
        <p className="text-body-sm text-on-surface-variant line-clamp-2">
          {course.description}
        </p>
      )}
      <div className="mt-auto flex items-center justify-between gap-2 pt-1">
        <span
          className={cn(
            "text-body-sm",
            timeline.state === "active"
              ? "text-on-secondary-container"
              : "text-on-surface-variant",
          )}
        >
          {timeline.label}
        </span>
        {course.enrolled ? (
          <button
            type="button"
            onClick={(e) => {
              e.preventDefault();
              onLeave(course);
            }}
            className="relative z-10 text-label-md font-label-md text-on-surface-variant hover:text-error transition-colors"
          >
            Leave
          </button>
        ) : (
          // App admin viewing a course they haven't joined.
          <span className="text-label-md font-label-md text-on-surface-variant/60">
            Not enrolled
          </span>
        )}
      </div>
    </div>
  );
}
