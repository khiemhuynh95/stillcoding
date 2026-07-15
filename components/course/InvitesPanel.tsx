"use client";

import { useState } from "react";
import { useCourseInvites, useMemberMutations } from "@/hooks/useCourses";
import type { CourseRole } from "@/lib/types";

/**
 * Email invites (no email is sent — a matching registration or the next
 * sign-in of an existing account auto-enrolls). Course admins only.
 */
export function InvitesPanel({ courseId }: { courseId: string }) {
  const { data: invites } = useCourseInvites(courseId);
  const { invite, revoke } = useMemberMutations(courseId);

  const [email, setEmail] = useState("");
  const [role, setRole] = useState<CourseRole>("member");
  const [error, setError] = useState<string | null>(null);

  const handleInvite = async () => {
    const value = email.trim();
    if (!value) return;
    setError(null);
    try {
      await invite.mutateAsync({ email: value, role });
      setEmail("");
    } catch (e) {
      setError(e instanceof Error ? e.message : "Invite failed");
    }
  };

  const pending = (invites ?? []).filter((i) => !i.redeemedAt);

  return (
    <div className="flex flex-col gap-3">
      <div className="flex items-center gap-2 flex-wrap">
        <input
          type="email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          onKeyDown={(e) => {
            if (e.key === "Enter") {
              e.preventDefault();
              void handleInvite();
            }
          }}
          placeholder="email@example.com"
          className="flex-1 min-w-48 bg-surface-container-lowest border border-outline-variant rounded px-3 py-2 text-body-sm text-on-surface outline-none focus:ring-2 focus:ring-primary"
        />
        <select
          value={role}
          onChange={(e) => setRole(e.target.value as CourseRole)}
          className="bg-surface-container-lowest border border-outline-variant rounded px-2 py-2 text-body-sm text-on-surface outline-none focus:ring-2 focus:ring-primary"
        >
          <option value="member">Member</option>
          <option value="admin">Admin</option>
        </select>
        <button
          type="button"
          onClick={() => void handleInvite()}
          disabled={!email.trim() || invite.isPending}
          className="px-4 py-2 rounded bg-primary text-on-primary text-label-md font-label-md hover:opacity-90 disabled:opacity-40 disabled:cursor-not-allowed"
        >
          Invite
        </button>
      </div>

      {error && (
        <p className="text-body-sm text-error" role="alert">
          {error}
        </p>
      )}

      <p className="text-body-sm text-on-surface-variant">
        No email is sent — share the login link yourself. Registering with the
        invited address (or the next sign-in of an existing account) enrolls
        automatically.
      </p>

      {pending.length > 0 && (
        <div className="bg-surface-container-lowest border border-outline-variant rounded-lg divide-y divide-outline-variant overflow-hidden">
          {pending.map((i) => (
            <div key={i.id} className="flex items-center gap-3 px-4 py-2.5">
              <span className="flex-1 truncate text-body-sm text-on-surface">
                {i.email}
              </span>
              <span className="text-body-sm text-on-surface-variant capitalize">
                {i.role}
              </span>
              <button
                type="button"
                onClick={() => revoke.mutate(i.id)}
                className="material-symbols-outlined text-[18px] text-on-surface-variant hover:text-error transition-colors"
                aria-label={`Revoke invite for ${i.email}`}
              >
                close
              </button>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
