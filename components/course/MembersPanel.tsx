"use client";

import { useCourseMembers, useMemberMutations } from "@/hooks/useCourses";
import { useAuth } from "@/providers/AuthProvider";
import type { CourseRole } from "@/lib/types";

/** Roster management: role changes and removal. Course admins only. */
export function MembersPanel({ courseId }: { courseId: string }) {
  const { user } = useAuth();
  const { data: members, isLoading } = useCourseMembers(courseId);
  const { remove, changeRole } = useMemberMutations(courseId);

  if (isLoading) {
    return <p className="text-body-sm text-on-surface-variant">Loading…</p>;
  }

  return (
    <div className="bg-surface-container-lowest border border-outline-variant rounded-lg divide-y divide-outline-variant overflow-hidden">
      {(members ?? []).map((m) => {
        const isSelf = m.userId === user?.id;
        return (
          <div key={m.userId} className="flex items-center gap-3 px-4 py-3">
            <span className="flex-1 truncate text-body-md text-on-surface">
              {m.displayName}
              {isSelf && (
                <span className="text-on-surface-variant text-body-sm"> (you)</span>
              )}
            </span>
            <select
              value={m.role}
              disabled={isSelf}
              onChange={(e) =>
                changeRole.mutate({
                  userId: m.userId,
                  role: e.target.value as CourseRole,
                })
              }
              className="bg-surface-container-lowest border border-outline-variant rounded px-2 py-1 text-body-sm text-on-surface outline-none focus:ring-2 focus:ring-primary disabled:opacity-40"
            >
              <option value="member">Member</option>
              <option value="admin">Admin</option>
            </select>
            <button
              type="button"
              disabled={isSelf}
              onClick={() => {
                if (window.confirm(`Remove ${m.displayName} from the course?`)) {
                  remove.mutate(m.userId);
                }
              }}
              className="material-symbols-outlined text-[20px] text-on-surface-variant hover:text-error disabled:opacity-30 transition-colors"
              aria-label={`Remove ${m.displayName}`}
            >
              person_remove
            </button>
          </div>
        );
      })}
      {members && members.length === 0 && (
        <p className="px-4 py-3 text-body-sm text-on-surface-variant">
          No members yet.
        </p>
      )}
    </div>
  );
}
