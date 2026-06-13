"use client";

import { useEffect } from "react";
import Link from "next/link";
import type { RoadmapNode } from "@/lib/roadmap";
import { getPractice } from "@/lib/practice";
import type { ProblemSummary } from "@/lib/types";
import type { SolvedMap } from "@/hooks/useSolvedStatus";
import { DifficultyBadge } from "@/components/browse/DifficultyBadge";
import { StatusIcon } from "@/components/browse/StatusIcon";

export function StageModal({
  node,
  lookup,
  solvedMap,
  onClose,
}: {
  node: RoadmapNode;
  lookup: Map<string, ProblemSummary>;
  solvedMap: SolvedMap;
  onClose: () => void;
}) {
  useEffect(() => {
    const onKey = (e: KeyboardEvent) => {
      if (e.key === "Escape") onClose();
    };
    document.addEventListener("keydown", onKey);
    return () => document.removeEventListener("keydown", onKey);
  }, [onClose]);

  const solvedCount = node.problems.filter(
    (s) => solvedMap[s] === "solved",
  ).length;
  const hasPractice = getPractice(node.id) != null;

  return (
    <div
      className="fixed inset-0 z-[60] flex items-center justify-center p-4"
      role="dialog"
      aria-modal="true"
      aria-label={node.title}
    >
      <div className="absolute inset-0 bg-black/40" onClick={onClose} />
      <div className="relative bg-surface-container-lowest border border-outline-variant rounded-xl shadow-ambient w-full max-w-lg max-h-[80vh] flex flex-col">
        <div className="flex items-center justify-between gap-4 p-4 border-b border-outline-variant">
          <div>
            <h2 className="font-headline-sm text-headline-sm text-on-surface">
              {node.title}
            </h2>
            <p className="text-label-md text-on-surface-variant mt-0.5">
              {solvedCount}/{node.problems.length} solved
            </p>
          </div>
          <button
            type="button"
            onClick={onClose}
            aria-label="Close"
            className="material-symbols-outlined text-on-surface-variant hover:text-on-surface p-1"
          >
            close
          </button>
        </div>
        {hasPractice && (
          <Link
            href={`/practice/${node.id}`}
            className="flex items-center gap-2 mx-4 mt-3 px-3 py-2.5 rounded-lg bg-primary-tint border border-primary/30 text-primary hover:border-primary transition-colors"
          >
            <span className="material-symbols-outlined text-[20px]">
              menu_book
            </span>
            <span className="flex-1 font-label-md text-label-md font-bold">
              Review syntax first
            </span>
            <span className="material-symbols-outlined text-[18px]">
              chevron_right
            </span>
          </Link>
        )}
        <ul className="overflow-y-auto custom-scrollbar divide-y divide-outline-variant">
          {node.problems.map((slug) => {
            const p = lookup.get(slug);
            return (
              <li key={slug}>
                <Link
                  href={`/problems/${slug}`}
                  className="flex items-center gap-3 px-4 py-3 hover:bg-surface-container-low/50 transition-colors"
                >
                  <StatusIcon state={solvedMap[slug]} />
                  <span className="flex-1 font-body-md text-body-md text-on-surface">
                    {p ? `${p.frontend_id}. ${p.title}` : slug}
                  </span>
                  {p && <DifficultyBadge difficulty={p.difficulty} />}
                </Link>
              </li>
            );
          })}
        </ul>
      </div>
    </div>
  );
}
