"use client";

import type { Difficulty } from "@/lib/types";
import type { SolvedMap } from "@/hooks/useSolvedStatus";
import type { UserList } from "@/hooks/useLists";
import { PRESET_LISTS, type ProblemList } from "@/lib/lists";
import { POPULAR_TOPICS } from "@/lib/topics";
import { cn } from "@/lib/utils";

const DIFFICULTIES: Difficulty[] = ["Easy", "Medium", "Hard"];

export interface SidebarContentProps {
  difficulties: Difficulty[];
  tag: string | null;
  activeListId: string | null;
  userLists: UserList[];
  listsHydrated: boolean;
  solvedMap: SolvedMap;
  solvedHydrated: boolean;
  onToggleDifficulty: (d: Difficulty) => void;
  onSelectTag: (slug: string | null) => void;
  onSelectList: (id: string | null) => void;
  onCreateList: (name: string) => string;
  onDeleteList: (id: string) => void;
}

/**
 * The filter controls (Categories, Lists, Difficulty, Popular Topics) shared by
 * the desktop `Sidebar` aside and the mobile `MobileFilters` drawer so the two
 * surfaces never drift.
 */
export function SidebarContent({
  difficulties,
  tag,
  activeListId,
  userLists,
  listsHydrated,
  solvedMap,
  solvedHydrated,
  onToggleDifficulty,
  onSelectTag,
  onSelectList,
  onCreateList,
  onDeleteList,
}: SidebarContentProps) {
  const solvedCount = (list: ProblemList) =>
    list.slugs.reduce(
      (n, slug) => n + (solvedMap[slug] === "solved" ? 1 : 0),
      0,
    );

  const handleCreate = () => {
    const name = window.prompt("Name your list");
    if (name == null) return;
    const trimmed = name.trim();
    if (!trimmed) return;
    const id = onCreateList(trimmed);
    onSelectList(id);
  };

  const handleDelete = (id: string, name: string) => {
    if (!window.confirm(`Delete the list "${name}"? This can't be undone.`)) {
      return;
    }
    if (activeListId === id) onSelectList(null);
    onDeleteList(id);
  };

  const renderListButton = (list: ProblemList, deletable: boolean) => {
    const active = activeListId === list.id;
    const total = list.slugs.length;
    const done = solvedHydrated ? solvedCount(list) : 0;
    return (
      <div key={list.id} className="group/list relative">
        <button
          type="button"
          onClick={() => onSelectList(active ? null : list.id)}
          title={list.description}
          className={cn(
            "flex items-center gap-3 w-full p-2 pr-8 rounded font-label-md text-label-md transition-colors text-left",
            active
              ? "bg-primary-tint text-primary"
              : "text-on-surface-variant hover:bg-surface-variant",
          )}
        >
          <span className="material-symbols-outlined text-[20px]">
            {list.preset ? "verified" : "bookmark"}
          </span>
          <span className="flex-1 truncate">{list.name}</span>
          <span className="text-body-sm tabular-nums text-on-surface-variant shrink-0">
            {solvedHydrated ? `${done}/${total}` : total}
          </span>
        </button>
        {deletable && (
          <button
            type="button"
            onClick={() => handleDelete(list.id, list.name)}
            aria-label={`Delete ${list.name}`}
            className="material-symbols-outlined text-[16px] absolute right-1.5 top-1/2 -translate-y-1/2 p-1 rounded text-on-surface-variant opacity-0 group-hover/list:opacity-100 hover:text-error hover:bg-surface-container transition-opacity"
          >
            delete
          </button>
        )}
      </div>
    );
  };

  return (
    <div className="p-6 flex flex-col gap-8 overflow-y-auto custom-scrollbar">
      {/* Categories */}
      <div>
        <h3 className="font-label-md text-label-md text-on-surface-variant uppercase tracking-wider mb-4">
          Categories
        </h3>
        <div className="flex flex-col gap-1">
          <button
            type="button"
            onClick={() => {
              onSelectTag(null);
              onSelectList(null);
            }}
            className={cn(
              "flex items-center gap-3 w-full p-2 rounded font-label-md text-label-md transition-colors",
              tag === null && activeListId === null
                ? "bg-primary-tint text-primary"
                : "text-on-surface-variant hover:bg-surface-variant",
            )}
          >
            <span className="material-symbols-outlined fill">dashboard</span>
            All Problems
          </button>
        </div>
      </div>

      {/* Lists */}
      <div>
        <div className="flex items-center justify-between mb-4">
          <h3 className="font-label-md text-label-md text-on-surface-variant uppercase tracking-wider">
            Lists
          </h3>
          <button
            type="button"
            onClick={handleCreate}
            title="Create a new list"
            className="flex items-center gap-1 text-label-md font-label-md text-primary hover:underline"
          >
            <span className="material-symbols-outlined text-[18px]">add</span>
            New
          </button>
        </div>
        <div className="flex flex-col gap-1">
          {PRESET_LISTS.map((l) => renderListButton(l, false))}
          {listsHydrated && userLists.length > 0 && (
            <div className="my-1 border-t border-outline-variant/60" />
          )}
          {listsHydrated && userLists.map((l) => renderListButton(l, true))}
          {listsHydrated && userLists.length === 0 && (
            <p className="text-body-sm text-on-surface-variant px-2 pt-1">
              No lists yet. Use{" "}
              <span className="text-primary">+ New</span> or “Save to list” on a
              problem.
            </p>
          )}
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
        <div className="flex flex-wrap gap-2">
          {POPULAR_TOPICS.map((t) => {
            const active = tag === t.slug;
            return (
              <button
                key={t.slug}
                type="button"
                title={`Filter by ${t.name}`}
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
      </div>
    </div>
  );
}
