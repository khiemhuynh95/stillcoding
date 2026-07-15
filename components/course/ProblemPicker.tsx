"use client";

import { useMemo, useState } from "react";
import { DifficultyBadge } from "@/components/browse/DifficultyBadge";
import { useProblems } from "@/hooks/useProblems";

const MAX_RESULTS = 12;

/**
 * Catalog search for adding problems to a week. Reads through the normalized
 * data layer (custom problems included automatically); matches title or
 * frontend_id case-insensitively, same as the browse search.
 */
export function ProblemPicker({
  excludeSlugs,
  onPick,
  disabled,
}: {
  excludeSlugs: Set<string>;
  onPick: (titleSlug: string) => void;
  disabled?: boolean;
}) {
  const { data: problems } = useProblems(null);
  const [query, setQuery] = useState("");

  const results = useMemo(() => {
    const q = query.trim().toLowerCase();
    if (!q || !problems) return [];
    const out = [];
    for (const p of problems) {
      if (excludeSlugs.has(p.title_slug)) continue;
      if (
        p.title.toLowerCase().includes(q) ||
        p.frontend_id.toLowerCase() === q
      ) {
        out.push(p);
        if (out.length >= MAX_RESULTS) break;
      }
    }
    return out;
  }, [query, problems, excludeSlugs]);

  return (
    <div className="flex flex-col gap-1">
      <input
        type="text"
        value={query}
        onChange={(e) => setQuery(e.target.value)}
        placeholder="Add a problem — search by title or #"
        disabled={disabled}
        className="bg-surface-container-lowest border border-outline-variant rounded px-3 py-2 text-body-sm text-on-surface outline-none focus:ring-2 focus:ring-primary disabled:opacity-40"
      />
      {results.length > 0 && (
        <div className="border border-outline-variant rounded max-h-56 overflow-y-auto custom-scrollbar divide-y divide-outline-variant bg-surface-container-lowest">
          {results.map((p) => (
            <button
              key={p.title_slug}
              type="button"
              onClick={() => {
                onPick(p.title_slug);
                setQuery("");
              }}
              className="w-full flex items-center gap-3 px-3 py-2 text-left hover:bg-surface-container transition-colors"
            >
              <span className="w-10 shrink-0 text-body-sm tabular-nums text-on-surface-variant">
                {p.frontend_id}
              </span>
              <span className="flex-1 truncate text-body-sm text-on-surface">
                {p.title}
              </span>
              <DifficultyBadge difficulty={p.difficulty} className="scale-90" />
            </button>
          ))}
        </div>
      )}
    </div>
  );
}
