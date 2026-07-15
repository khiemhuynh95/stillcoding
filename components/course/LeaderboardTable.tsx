"use client";

import { useAuth } from "@/providers/AuthProvider";
import type { LeaderboardEntry } from "@/lib/types";
import { cn } from "@/lib/utils";

/** Ranked standings for one course (rank, name, solved, points). */
export function LeaderboardTable({ entries }: { entries: LeaderboardEntry[] }) {
  const { user } = useAuth();

  if (entries.length === 0) {
    return (
      <p className="text-body-md text-on-surface-variant py-8 text-center">
        No members yet.
      </p>
    );
  }

  return (
    <div className="bg-surface-container-lowest border border-outline-variant rounded-lg overflow-hidden">
      <table className="w-full">
        <thead>
          <tr className="border-b border-outline-variant text-left">
            <th className="w-14 px-4 py-2.5 text-label-md font-label-md uppercase tracking-wider text-on-surface-variant">
              #
            </th>
            <th className="px-2 py-2.5 text-label-md font-label-md uppercase tracking-wider text-on-surface-variant">
              Member
            </th>
            <th className="w-20 px-2 py-2.5 text-right text-label-md font-label-md uppercase tracking-wider text-on-surface-variant">
              Solved
            </th>
            <th className="w-24 px-4 py-2.5 text-right text-label-md font-label-md uppercase tracking-wider text-on-surface-variant">
              Points
            </th>
          </tr>
        </thead>
        <tbody className="divide-y divide-outline-variant">
          {entries.map((entry, index) => {
            const isMe = entry.userId === user?.id;
            return (
              <tr
                key={entry.userId}
                className={cn(isMe && "bg-primary-fixed/30")}
              >
                <td className="px-4 py-2.5 text-body-sm tabular-nums text-on-surface-variant">
                  {index + 1}
                </td>
                <td className="px-2 py-2.5 text-body-md text-on-surface truncate">
                  {entry.displayName}
                  {isMe && (
                    <span className="text-on-surface-variant text-body-sm">
                      {" "}
                      (you)
                    </span>
                  )}
                </td>
                <td className="px-2 py-2.5 text-right text-body-md tabular-nums text-on-surface">
                  {entry.solved}
                </td>
                <td className="px-4 py-2.5 text-right text-body-md tabular-nums font-bold text-on-surface">
                  {entry.points}
                </td>
              </tr>
            );
          })}
        </tbody>
      </table>
    </div>
  );
}
