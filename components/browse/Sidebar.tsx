"use client";

import type { Difficulty, Tag } from "@/lib/types";
import { cn } from "@/lib/utils";

const DIFFICULTIES: Difficulty[] = ["Easy", "Medium", "Hard"];
const MAX_TOPICS = 12;

export function Sidebar({
  difficulties,
  tag,
  onToggleDifficulty,
  onSelectTag,
  tags,
  tagsLoading,
}: {
  difficulties: Difficulty[];
  tag: string | null;
  onToggleDifficulty: (d: Difficulty) => void;
  onSelectTag: (slug: string | null) => void;
  tags: Tag[] | undefined;
  tagsLoading: boolean;
}) {
  return (
    <aside className="w-sidebar-width bg-surface-container-low border-r border-outline-variant flex-col hidden lg:flex shrink-0">
      <div className="p-6 flex flex-col gap-8 overflow-y-auto custom-scrollbar">
        {/* Categories */}
        <div>
          <h3 className="font-label-md text-label-md text-on-surface-variant uppercase tracking-wider mb-4">
            Categories
          </h3>
          <div className="flex flex-col gap-1">
            <button
              type="button"
              onClick={() => onSelectTag(null)}
              className={cn(
                "flex items-center gap-3 w-full p-2 rounded font-label-md text-label-md transition-colors",
                tag === null
                  ? "bg-primary-tint text-primary"
                  : "text-on-surface-variant hover:bg-surface-variant",
              )}
            >
              <span className="material-symbols-outlined fill">dashboard</span>
              All Problems
            </button>
          </div>
        </div>

        {/* Difficulty */}
        <div>
          <h3 className="font-label-md text-label-md text-on-surface-variant uppercase tracking-wider mb-4">
            Difficulty
          </h3>
          <div className="flex flex-col gap-2">
            {DIFFICULTIES.map((d) => (
              <label
                key={d}
                className="flex items-center gap-3 cursor-pointer group select-none"
              >
                <input
                  type="checkbox"
                  checked={difficulties.includes(d)}
                  onChange={() => onToggleDifficulty(d)}
                  className="w-4 h-4 rounded-sm accent-primary cursor-pointer"
                />
                <span className="font-body-md text-body-md text-on-surface group-hover:text-primary">
                  {d}
                </span>
              </label>
            ))}
          </div>
        </div>

        {/* Popular Topics */}
        <div>
          <h3 className="font-label-md text-label-md text-on-surface-variant uppercase tracking-wider mb-4">
            Popular Topics
          </h3>
          {tagsLoading ? (
            <div className="flex flex-wrap gap-2">
              {Array.from({ length: 8 }).map((_, i) => (
                <span
                  key={i}
                  className="h-6 w-16 rounded-full bg-surface-variant animate-pulse"
                />
              ))}
            </div>
          ) : (
            <div className="flex flex-wrap gap-2">
              {(tags ?? []).slice(0, MAX_TOPICS).map((t) => {
                const active = tag === t.slug;
                return (
                  <button
                    key={t.slug}
                    type="button"
                    title={`${t.problem_count} problems`}
                    onClick={() => onSelectTag(active ? null : t.slug)}
                    className={cn(
                      "px-3 py-1 rounded-full text-label-md font-label-md transition-colors",
                      active
                        ? "bg-primary text-on-primary"
                        : "bg-surface-container-highest text-on-surface hover:bg-primary-container hover:text-on-primary-container",
                    )}
                  >
                    {t.name}
                  </button>
                );
              })}
            </div>
          )}
        </div>
      </div>
    </aside>
  );
}
