"use client";

import type { RoadmapNode } from "@/lib/roadmap";
import { cn } from "@/lib/utils";

const CELL_W = 200;
const CELL_H = 148;
const NODE_W = 176;
const NODE_H = 82;

export interface NodeProgress {
  solved: number;
  total: number;
}

const centerX = (n: RoadmapNode) => n.col * CELL_W + CELL_W / 2;
const topY = (n: RoadmapNode) => n.row * CELL_H + (CELL_H - NODE_H) / 2;

export function RoadmapGraph({
  nodes,
  cols,
  progress,
  onSelect,
}: {
  nodes: RoadmapNode[];
  cols: number;
  progress: Record<string, NodeProgress>;
  onSelect: (node: RoadmapNode) => void;
}) {
  const maxRow = Math.max(...nodes.map((n) => n.row));
  const width = cols * CELL_W;
  const height = (maxRow + 1) * CELL_H;
  const byId = new Map(nodes.map((n) => [n.id, n]));

  return (
    <div className="overflow-x-auto custom-scrollbar pb-4">
      <div className="relative mx-auto" style={{ width, height }}>
        {/* Connector edges (drawn behind the nodes) */}
        <svg
          className="absolute inset-0 pointer-events-none"
          width={width}
          height={height}
        >
          {nodes.flatMap((n) =>
            (n.deps ?? []).map((depId) => {
              const parent = byId.get(depId);
              if (!parent) return null;
              const x1 = centerX(parent);
              const y1 = topY(parent) + NODE_H;
              const x2 = centerX(n);
              const y2 = topY(n);
              const midY = (y1 + y2) / 2;
              const pr = progress[depId];
              const done = pr && pr.total > 0 && pr.solved === pr.total;
              return (
                <path
                  key={`${depId}-${n.id}`}
                  d={`M ${x1} ${y1} C ${x1} ${midY}, ${x2} ${midY}, ${x2} ${y2}`}
                  fill="none"
                  strokeWidth={2}
                  className={done ? "stroke-secondary" : "stroke-outline-variant"}
                />
              );
            }),
          )}
        </svg>

        {/* Topic nodes */}
        {nodes.map((n) => {
          const pr = progress[n.id] ?? { solved: 0, total: n.problems.length };
          const complete = pr.total > 0 && pr.solved === pr.total;
          const started = pr.solved > 0 && !complete;
          const pct = pr.total ? Math.round((pr.solved / pr.total) * 100) : 0;
          return (
            <button
              key={n.id}
              type="button"
              onClick={() => onSelect(n)}
              style={{
                left: centerX(n) - NODE_W / 2,
                top: topY(n),
                width: NODE_W,
                height: NODE_H,
              }}
              className={cn(
                "absolute rounded-lg border p-3 text-left flex flex-col justify-between shadow-ambient transition-transform hover:scale-[1.03] hover:border-primary focus:outline-none focus:ring-2 focus:ring-primary",
                complete
                  ? "bg-secondary-container/40 border-secondary"
                  : started
                    ? "bg-primary-tint border-primary/40"
                    : "bg-surface-container-lowest border-outline-variant",
              )}
            >
              <div className="flex items-start justify-between gap-2">
                <span className="font-label-md text-label-md font-bold text-on-surface line-clamp-2 leading-tight">
                  {n.title}
                </span>
                {complete && (
                  <span className="material-symbols-outlined fill text-secondary text-[18px] shrink-0">
                    check_circle
                  </span>
                )}
              </div>
              <div className="flex items-center gap-2">
                <div className="flex-1 bg-surface-variant h-1.5 rounded-full overflow-hidden">
                  <div className="h-full bg-primary" style={{ width: `${pct}%` }} />
                </div>
                <span className="text-label-md text-on-surface-variant whitespace-nowrap">
                  {pr.solved}/{pr.total}
                </span>
              </div>
            </button>
          );
        })}
      </div>
    </div>
  );
}
