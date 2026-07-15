"use client";

import Link from "next/link";
import { useParams, useRouter } from "next/navigation";
import { useEffect, useState } from "react";
import { TopNav } from "@/components/layout/TopNav";
import { InvitesPanel } from "@/components/course/InvitesPanel";
import { MembersPanel } from "@/components/course/MembersPanel";
import { WeekEditor } from "@/components/course/WeekEditor";
import {
  useCourse,
  useCourseWeeks,
  useUpdateCourse,
  useWeekMutations,
} from "@/hooks/useCourses";
import { cn } from "@/lib/utils";

type Tab = "weeks" | "members" | "settings";

/** Course administration: content (weeks), people, and settings. */
export default function CourseManagePage() {
  // URL param is the join code; mutations/queries below use the resolved uuid.
  const params = useParams<{ id: string }>();
  const courseCode = params.id;
  const router = useRouter();

  const { data: course, isLoading } = useCourse(courseCode);
  const courseId = course?.id ?? "";
  const { data: weeks } = useCourseWeeks(courseId);
  const updateMutation = useUpdateCourse(courseId);
  const { create: createWeekMutation } = useWeekMutations(courseId);

  const [tab, setTab] = useState<Tab>("weeks");
  const [copied, setCopied] = useState(false);
  const [newWeekTitle, setNewWeekTitle] = useState("");

  // Settings form state, seeded from the course row.
  const [name, setName] = useState("");
  const [description, setDescription] = useState("");
  const [startDate, setStartDate] = useState("");
  const [endDate, setEndDate] = useState("");
  useEffect(() => {
    if (course) {
      setName(course.name);
      setDescription(course.description);
      setStartDate(course.startDate ?? "");
      setEndDate(course.endDate ?? "");
    }
  }, [course]);

  // Only course admins belong here.
  useEffect(() => {
    if (!isLoading && course && course.myRole !== "admin") {
      router.replace(`/course/${courseCode}`);
    }
  }, [isLoading, course, courseCode, router]);

  if (isLoading || !course || course.myRole !== "admin") {
    return (
      <div className="min-h-screen flex flex-col bg-background">
        <TopNav />
        <main className="flex-1 flex items-center justify-center">
          <p className="text-body-md text-on-surface-variant">
            {isLoading ? "Loading…" : "Not available."}
          </p>
        </main>
      </div>
    );
  }

  const handleAddWeek = () => {
    if (createWeekMutation.isPending) return;
    createWeekMutation.mutate({
      title: newWeekTitle.trim() || `Week ${(weeks?.length ?? 0) + 1}`,
      position: weeks?.length ?? 0,
    });
    setNewWeekTitle("");
  };

  const copyJoinCode = () => {
    void navigator.clipboard.writeText(course.joinCode).then(() => {
      setCopied(true);
      setTimeout(() => setCopied(false), 1500);
    });
  };

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

      <main className="flex-1 w-full max-w-4xl mx-auto px-gutter py-8 flex flex-col gap-6">
        <div className="flex items-center justify-between gap-4 flex-wrap">
          <h1 className="font-headline-sm text-headline-sm text-on-surface truncate">
            Manage · {course.name}
          </h1>
          <button
            type="button"
            onClick={copyJoinCode}
            title="Share this code — anyone can join with it"
            className="flex items-center gap-1.5 px-3 py-1.5 rounded border border-outline-variant text-label-md font-label-md text-on-surface-variant hover:border-primary hover:text-on-surface transition-colors"
          >
            <span className="material-symbols-outlined text-[16px]">
              {copied ? "check" : "content_copy"}
            </span>
            Course ID: <span className="font-mono">{course.joinCode}</span>
          </button>
        </div>

        <div className="flex gap-1 border-b border-outline-variant">
          {(
            [
              ["weeks", "Weeks"],
              ["members", "Members"],
              ["settings", "Settings"],
            ] as const
          ).map(([key, label]) => (
            <button
              key={key}
              type="button"
              onClick={() => setTab(key)}
              className={cn(
                "px-4 py-2 text-label-md font-label-md transition-colors",
                tab === key
                  ? "text-primary border-b-[3px] border-primary"
                  : "text-on-surface-variant hover:text-on-surface",
              )}
            >
              {label}
            </button>
          ))}
        </div>

        {tab === "weeks" && (
          <div className="flex flex-col gap-4">
            {(weeks ?? []).map((week) => (
              <WeekEditor key={week.id} week={week} courseId={courseId} />
            ))}
            <div className="flex items-center gap-2 max-w-md">
              <input
                type="text"
                value={newWeekTitle}
                onChange={(e) => setNewWeekTitle(e.target.value)}
                onKeyDown={(e) => {
                  if (e.key === "Enter") {
                    e.preventDefault();
                    handleAddWeek();
                  }
                }}
                placeholder={`Week ${(weeks?.length ?? 0) + 1}`}
                className="flex-1 min-w-0 bg-surface-container-lowest border border-outline-variant rounded px-3 py-2 text-body-sm text-on-surface outline-none focus:ring-2 focus:ring-primary"
                aria-label="New week title"
              />
              <button
                type="button"
                onClick={handleAddWeek}
                disabled={createWeekMutation.isPending}
                className="px-4 py-2 rounded bg-primary text-on-primary text-label-md font-label-md hover:opacity-90 disabled:opacity-40 shrink-0"
              >
                Add week
              </button>
            </div>
            <p className="text-body-sm text-on-surface-variant -mt-2">
              Leave the title empty to use the placeholder. Click a week&apos;s
              title above to rename it (Enter saves, Esc cancels).
            </p>
          </div>
        )}

        {tab === "members" && (
          <div className="flex flex-col gap-6">
            <MembersPanel courseId={courseId} />
            <div>
              <h2 className="text-label-md font-label-md uppercase tracking-wider text-on-surface-variant mb-2">
                Invites
              </h2>
              <InvitesPanel courseId={courseId} />
            </div>
          </div>
        )}

        {tab === "settings" && (
          <div className="bg-surface-container-lowest border border-outline-variant rounded-lg p-4 flex flex-col gap-3 max-w-lg">
            <label className="flex flex-col gap-1 text-body-sm text-on-surface-variant">
              Name
              <input
                type="text"
                value={name}
                onChange={(e) => setName(e.target.value)}
                className="bg-surface-container-lowest border border-outline-variant rounded px-3 py-2 text-body-md text-on-surface outline-none focus:ring-2 focus:ring-primary"
              />
            </label>
            <label className="flex flex-col gap-1 text-body-sm text-on-surface-variant">
              Description
              <input
                type="text"
                value={description}
                onChange={(e) => setDescription(e.target.value)}
                className="bg-surface-container-lowest border border-outline-variant rounded px-3 py-2 text-body-md text-on-surface outline-none focus:ring-2 focus:ring-primary"
              />
            </label>
            <div className="flex items-center gap-3 flex-wrap">
              <label className="flex items-center gap-2 text-body-sm text-on-surface-variant">
                Starts
                <input
                  type="date"
                  value={startDate}
                  onChange={(e) => setStartDate(e.target.value)}
                  className="bg-surface-container-lowest border border-outline-variant rounded px-2 py-1.5 text-body-sm text-on-surface outline-none focus:ring-2 focus:ring-primary"
                />
              </label>
              <label className="flex items-center gap-2 text-body-sm text-on-surface-variant">
                Ends
                <input
                  type="date"
                  value={endDate}
                  onChange={(e) => setEndDate(e.target.value)}
                  className="bg-surface-container-lowest border border-outline-variant rounded px-2 py-1.5 text-body-sm text-on-surface outline-none focus:ring-2 focus:ring-primary"
                />
              </label>
            </div>
            <p className="text-body-sm text-on-surface-variant">
              Points are only earned between these dates (leave empty for
              open-ended).
            </p>
            <button
              type="button"
              onClick={() =>
                updateMutation.mutate({
                  name: name.trim(),
                  description: description.trim(),
                  startDate: startDate || null,
                  endDate: endDate || null,
                })
              }
              disabled={!name.trim() || updateMutation.isPending}
              className="self-start px-4 py-2 rounded bg-primary text-on-primary text-label-md font-label-md hover:opacity-90 disabled:opacity-40"
            >
              {updateMutation.isPending ? "Saving…" : "Save settings"}
            </button>
          </div>
        )}
      </main>
    </div>
  );
}
