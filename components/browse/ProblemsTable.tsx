"use client";

import { useRef } from "react";
import { useRouter } from "next/navigation";
import { useQueryClient } from "@tanstack/react-query";
import type { ProblemSummary } from "@/lib/types";
import type { SolvedMap } from "@/hooks/useSolvedStatus";
import { getProblem } from "@/lib/leetcode";
import { prefetchEditor } from "@/lib/prefetch";
import { DifficultyBadge } from "./DifficultyBadge";
import { StatusIcon } from "./StatusIcon";

const FIVE_MIN = 5 * 60 * 1000;

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
  const queryClient = useQueryClient();
  const warmed = useRef<Set<string>>(new Set());

  const open = (slug: string) => router.push(`/problems/${slug}`);

  // On hover/focus, warm everything the coding page needs so the click is
  // instant: the route chunk, the problem detail query, and the editor chunk.
  const warm = (slug: string) => {
    if (warmed.current.has(slug)) return;
    warmed.current.add(slug);
    router.prefetch(`/problems/${slug}`);
    queryClient.prefetchQuery({
      queryKey: ["problem", slug],
      queryFn: () => getProblem(slug),
      staleTime: FIVE_MIN,
    });
    prefetchEditor();
  };

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
        </tr>
      </thead>
      <tbody className="divide-y divide-outline-variant">
        {problems.map((p) => (
          <tr
            key={p.id}
            onClick={() => open(p.title_slug)}
            onMouseEnter={() => warm(p.title_slug)}
            onFocus={() => warm(p.title_slug)}
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
          </tr>
        ))}
      </tbody>
    </table>
  );
}
