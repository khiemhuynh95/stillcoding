"use client";

import { useRouter } from "next/navigation";
import { useState } from "react";
import { TopNav } from "@/components/layout/TopNav";
import { CourseCard } from "@/components/course/CourseCard";
import { useAuth } from "@/providers/AuthProvider";
import {
  useCreateCourse,
  useJoinCourse,
  useLeaveCourse,
  useMyCourses,
} from "@/hooks/useCourses";
import type { Course } from "@/lib/types";

/** Course dashboard: the switcher between a user's courses. */
export default function CourseDashboardPage() {
  const router = useRouter();
  const { profile, signOut } = useAuth();
  const { data: courses, isLoading } = useMyCourses();
  const joinMutation = useJoinCourse();
  const leaveMutation = useLeaveCourse();
  const createMutation = useCreateCourse();

  const [joinCode, setJoinCode] = useState("");
  const [showCreate, setShowCreate] = useState(false);
  const [newName, setNewName] = useState("");
  const [newDescription, setNewDescription] = useState("");
  const [newStart, setNewStart] = useState("");
  const [newEnd, setNewEnd] = useState("");
  const [error, setError] = useState<string | null>(null);

  const handleJoin = async () => {
    const code = joinCode.trim();
    if (!code) return;
    setError(null);
    try {
      await joinMutation.mutateAsync(code);
      setJoinCode("");
      // Course URLs use the join code the user just typed.
      router.push(`/course/${code.toLowerCase()}`);
    } catch (e) {
      setError(e instanceof Error ? e.message : "Could not join course");
    }
  };

  const handleLeave = (course: Course) => {
    if (
      !window.confirm(
        `Leave "${course.name}"? Your points are kept — rejoin with the course ID anytime.`,
      )
    ) {
      return;
    }
    leaveMutation.mutate(course.id);
  };

  const handleCreate = async () => {
    const name = newName.trim();
    if (!name) return;
    setError(null);
    try {
      const course = await createMutation.mutateAsync({
        name,
        description: newDescription.trim(),
        startDate: newStart || null,
        endDate: newEnd || null,
      });
      router.push(`/course/${course.joinCode}/manage`);
    } catch (e) {
      setError(e instanceof Error ? e.message : "Could not create course");
    }
  };

  return (
    <div className="min-h-screen flex flex-col bg-background">
      <TopNav
        actions={
          <div className="flex items-center gap-2">
            <button
              type="button"
              onClick={() => {
                void signOut().then(() => router.replace("/"));
              }}
              className="px-3 py-1.5 rounded border border-outline-variant text-label-md font-label-md text-on-surface-variant hover:border-primary hover:text-on-surface transition-colors"
            >
              Sign out
            </button>
          </div>
        }
      />

      <main className="flex-1 w-full max-w-4xl mx-auto px-gutter py-8 flex flex-col gap-8">
        <div className="flex items-center justify-between gap-4 flex-wrap">
          <h1 className="font-headline-sm text-headline-sm text-on-surface">
            {profile?.isAdmin ? "All courses" : "Your courses"}
          </h1>
          {profile?.isAdmin && (
            <button
              type="button"
              onClick={() => setShowCreate((s) => !s)}
              className="px-4 py-2 rounded bg-primary text-on-primary text-label-md font-label-md hover:opacity-90"
            >
              {showCreate ? "Cancel" : "New course"}
            </button>
          )}
        </div>

        {showCreate && (
          <div className="bg-surface-container-lowest border border-outline-variant rounded-lg p-4 flex flex-col gap-3">
            <input
              type="text"
              value={newName}
              onChange={(e) => setNewName(e.target.value)}
              placeholder="Course name"
              className="bg-surface-container-lowest border border-outline-variant rounded px-3 py-2 text-body-md text-on-surface outline-none focus:ring-2 focus:ring-primary"
            />
            <input
              type="text"
              value={newDescription}
              onChange={(e) => setNewDescription(e.target.value)}
              placeholder="Description (optional)"
              className="bg-surface-container-lowest border border-outline-variant rounded px-3 py-2 text-body-md text-on-surface outline-none focus:ring-2 focus:ring-primary"
            />
            <div className="flex items-center gap-3 flex-wrap">
              <label className="flex items-center gap-2 text-body-sm text-on-surface-variant">
                Starts
                <input
                  type="date"
                  value={newStart}
                  onChange={(e) => setNewStart(e.target.value)}
                  className="bg-surface-container-lowest border border-outline-variant rounded px-2 py-1.5 text-body-sm text-on-surface outline-none focus:ring-2 focus:ring-primary"
                />
              </label>
              <label className="flex items-center gap-2 text-body-sm text-on-surface-variant">
                Ends
                <input
                  type="date"
                  value={newEnd}
                  onChange={(e) => setNewEnd(e.target.value)}
                  className="bg-surface-container-lowest border border-outline-variant rounded px-2 py-1.5 text-body-sm text-on-surface outline-none focus:ring-2 focus:ring-primary"
                />
              </label>
              <button
                type="button"
                onClick={handleCreate}
                disabled={!newName.trim() || createMutation.isPending}
                className="ml-auto px-4 py-2 rounded bg-primary text-on-primary text-label-md font-label-md hover:opacity-90 disabled:opacity-40 disabled:cursor-not-allowed"
              >
                Create
              </button>
            </div>
          </div>
        )}

        {error && (
          <p className="text-body-sm text-error" role="alert">
            {error}
          </p>
        )}

        {isLoading ? (
          <p className="text-body-md text-on-surface-variant">Loading…</p>
        ) : courses && courses.length > 0 ? (
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            {courses.map((c) => (
              <CourseCard key={c.id} course={c} onLeave={handleLeave} />
            ))}
          </div>
        ) : (
          <p className="text-body-md text-on-surface-variant">
            {profile?.isAdmin
              ? "No courses exist yet — create the first one with “New course”."
              : "You're not in any course yet. Enter a course ID below to join."}
          </p>
        )}

        <div className="flex items-center gap-2 max-w-sm">
          <input
            type="text"
            value={joinCode}
            onChange={(e) => setJoinCode(e.target.value)}
            onKeyDown={(e) => {
              if (e.key === "Enter") {
                e.preventDefault();
                void handleJoin();
              }
            }}
            placeholder="Course ID"
            className="flex-1 min-w-0 bg-surface-container-lowest border border-outline-variant rounded px-3 py-2 text-body-md text-on-surface outline-none focus:ring-2 focus:ring-primary"
          />
          <button
            type="button"
            onClick={() => void handleJoin()}
            disabled={!joinCode.trim() || joinMutation.isPending}
            className="px-4 py-2 rounded bg-primary text-on-primary text-label-md font-label-md hover:opacity-90 disabled:opacity-40 disabled:cursor-not-allowed shrink-0"
          >
            Join
          </button>
        </div>
      </main>
    </div>
  );
}
