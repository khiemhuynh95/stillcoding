"use client";

import { useMemo, useState } from "react";
import { TopNav } from "@/components/layout/TopNav";
import { MobileNav } from "@/components/layout/MobileNav";
import { RoadmapGraph, type NodeProgress } from "@/components/roadmap/RoadmapGraph";
import { StageModal } from "@/components/roadmap/StageModal";
import { ROADMAP, ROADMAP_COLS, type RoadmapNode } from "@/lib/roadmap";
import { useProblems } from "@/hooks/useProblems";
import { useSolvedStatus } from "@/hooks/useSolvedStatus";
import type { ProblemSummary } from "@/lib/types";

export default function RoadmapPage() {
  const { data: problems } = useProblems(null);
  const { map: solvedMap } = useSolvedStatus();
  const [selected, setSelected] = useState<RoadmapNode | null>(null);

  // slug -> summary, for titles/difficulty in the modal (from the cached list).
  const lookup = useMemo(() => {
    const m = new Map<string, ProblemSummary>();
    for (const p of problems ?? []) m.set(p.title_slug, p);
    return m;
  }, [problems]);

  const progress = useMemo(() => {
    const result: Record<string, NodeProgress> = {};
    for (const n of ROADMAP) {
      result[n.id] = {
        total: n.problems.length,
        solved: n.problems.filter((s) => solvedMap[s] === "solved").length,
      };
    }
    return result;
  }, [solvedMap]);

  const overall = useMemo(() => {
    const unique = Array.from(new Set(ROADMAP.flatMap((n) => n.problems)));
    const solved = unique.filter((s) => solvedMap[s] === "solved").length;
    const total = unique.length;
    return { solved, total, pct: total ? Math.round((solved / total) * 100) : 0 };
  }, [solvedMap]);

  return (
    <div className="h-screen flex flex-col">
      <TopNav />
      <main className="flex-1 overflow-y-auto custom-scrollbar p-gutter lg:p-8 pb-28">
        <div className="max-w-5xl mx-auto">
          <header className="mb-8">
            <h1 className="font-headline-sm text-headline-sm text-on-surface">
              Roadmap
            </h1>
            <p className="text-body-md text-on-surface-variant mt-1">
              A guided path through core topics. Click a stage to open its
              problems.
            </p>
            <div className="flex items-center gap-3 mt-4 max-w-md">
              <div className="flex-1 bg-surface-variant h-2 rounded-full overflow-hidden">
                <div
                  className="h-full bg-primary transition-all"
                  style={{ width: `${overall.pct}%` }}
                />
              </div>
              <span className="text-label-md text-on-surface-variant whitespace-nowrap">
                {overall.solved}/{overall.total} solved · {overall.pct}%
              </span>
            </div>
          </header>

          <RoadmapGraph
            nodes={ROADMAP}
            cols={ROADMAP_COLS}
            progress={progress}
            onSelect={setSelected}
          />
        </div>
      </main>

      {selected && (
        <StageModal
          node={selected}
          lookup={lookup}
          solvedMap={solvedMap}
          onClose={() => setSelected(null)}
        />
      )}
      <MobileNav />
    </div>
  );
}
