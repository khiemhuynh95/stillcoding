"use client";

import { useRouter } from "next/navigation";
import type { ProblemSummary } from "@/lib/types";
import type { SolvedMap } from "@/hooks/useSolvedStatus";
import { DifficultyBadge } from "./DifficultyBadge";
import { StatusIcon } from "./StatusIcon";

export function ProblemsTable({
  problems,
  solvedMap,
  hydrated,
}: {
  problems: ProblemSummary[];
  solvedMap: SolvedMap;
  hydrated: boolean;
}) {
  const router = useRouter();

  const open = (slug: string) => router.push(`/problems/${slug}`);

  return (
    <table className="w-full text-left border-collapse">
      <thead>
        <tr className="bg-surface-container-low/50 border-b border-outline-variant">
          <th className="py-4 px-4 sm:px-6 font-label-md text-label-md text-on-surface-variant uppercase tracking-wider w-16">
            Status
          </th>
          <th className="py-4 px-4 sm:px-6 font-label-md text-label-md text-on-surface-variant uppercase tracking-wider">
            Title
          </th>
          <th className="py-4 px-4 sm:px-6 font-label-md text-label-md text-on-surface-variant uppercase tracking-wider w-28">
            Difficulty
          </th>
          <th className="py-4 px-6 font-label-md text-label-md text-on-surface-variant uppercase tracking-wider w-16 hidden sm:table-cell">
            Open
          </th>
        </tr>
      </thead>
      <tbody className="divide-y divide-outline-variant">
        {problems.map((p) => (
          <tr
            key={p.id}
            onClick={() => open(p.title_slug)}
            className="group hover:bg-surface-container-low/40 transition-colors cursor-pointer"
          >
            <td className="py-4 px-4 sm:px-6">
              <StatusIcon state={hydrated ? solvedMap[p.title_slug] : undefined} />
            </td>
            <td className="py-4 px-4 sm:px-6">
              <div className="flex items-center gap-2">
                <span className="font-body-md text-body-md font-semibold text-on-surface group-hover:text-primary transition-colors">
                  {p.frontend_id}. {p.title}
                </span>
                {p.paid_only && (
                  <span
                    className="material-symbols-outlined text-[16px] text-tertiary"
                    title="Premium problem"
                  >
                    lock
                  </span>
                )}
                {p.source === "custom" && (
                  <span className="text-[10px] font-bold uppercase tracking-wide px-1.5 py-0.5 rounded bg-secondary-container/50 text-on-secondary-container">
                    Custom
                  </span>
                )}
              </div>
            </td>
            <td className="py-4 px-4 sm:px-6">
              <DifficultyBadge difficulty={p.difficulty} />
            </td>
            <td className="py-4 px-6 hidden sm:table-cell">
              <span className="material-symbols-outlined text-on-surface-variant opacity-0 group-hover:opacity-100 transition-opacity">
                code
              </span>
            </td>
          </tr>
        ))}
      </tbody>
    </table>
  );
}
