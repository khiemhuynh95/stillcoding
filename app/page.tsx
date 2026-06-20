"use client";

import { useEffect, useMemo, useState } from "react";
import { TopNav } from "@/components/layout/TopNav";
import { MobileNav } from "@/components/layout/MobileNav";
import { Sidebar } from "@/components/browse/Sidebar";
import { SearchBar } from "@/components/browse/SearchBar";
import { ProblemsTable } from "@/components/browse/ProblemsTable";
import { Pagination } from "@/components/browse/Pagination";
import { RandomFab } from "@/components/browse/RandomFab";
import { useFilters, type SortKey } from "@/hooks/useFilters";
import { useProblems } from "@/hooks/useProblems";
import { useSolvedStatus } from "@/hooks/useSolvedStatus";
import { useLists } from "@/hooks/useLists";
import { findPresetList, isUserListId, type ProblemList } from "@/lib/lists";
import { POPULAR_TOPICS } from "@/lib/topics";
import type { Difficulty, ProblemSummary } from "@/lib/types";
import { cn } from "@/lib/utils";

const PAGE_SIZE = 20;
const DIFFICULTIES: Difficulty[] = ["Easy", "Medium", "Hard"];
const DIFF_ORDER: Record<Difficulty, number> = { Easy: 0, Medium: 1, Hard: 2 };

const SORT_OPTIONS: { value: SortKey; label: string }[] = [
  { value: "newest", label: "Newest" },
  { value: "oldest", label: "Oldest" },
  { value: "easiest", label: "Easiest first" },
  { value: "hardest", label: "Hardest first" },
];

function sortProblems(list: ProblemSummary[], sort: SortKey): ProblemSummary[] {
  // Custom problems have non-numeric ids (e.g. "C1") — rank them as newest.
  const byId = (p: ProblemSummary) => {
    const n = parseInt(p.frontend_id, 10);
    return Number.isNaN(n) ? Number.POSITIVE_INFINITY : n;
  };
  const copy = [...list];
  switch (sort) {
    case "newest":
      return copy.sort((a, b) => byId(b) - byId(a));
    case "oldest":
      return copy.sort((a, b) => byId(a) - byId(b));
    case "easiest":
      return copy.sort(
        (a, b) =>
          DIFF_ORDER[a.difficulty] - DIFF_ORDER[b.difficulty] || byId(a) - byId(b),
      );
    case "hardest":
      return copy.sort(
        (a, b) =>
          DIFF_ORDER[b.difficulty] - DIFF_ORDER[a.difficulty] || byId(a) - byId(b),
      );
    default:
      return copy;
  }
}

export default function BrowsePage() {
  const [filters, setFilters] = useFilters();
  const { data: problems, isLoading, isError, refetch } = useProblems(filters.tag);
  const { map: solvedMap, hydrated: solvedHydrated } = useSolvedStatus();
  const {
    lists: userLists,
    createList,
    deleteList,
    hydrated: listsHydrated,
  } = useLists();
  const [page, setPage] = useState(1);

  // The list currently being browsed (preset or user-made), if any.
  const activeList: ProblemList | null = useMemo(() => {
    if (!filters.list) return null;
    if (isUserListId(filters.list)) {
      return userLists.find((l) => l.id === filters.list) ?? null;
    }
    return findPresetList(filters.list) ?? null;
  }, [filters.list, userLists]);

  const view = useMemo(() => {
    let list = problems ?? [];
    if (activeList) {
      const order = new Map(activeList.slugs.map((s, i) => [s, i] as const));
      list = list
        .filter((p) => order.has(p.title_slug))
        .sort((a, b) => order.get(a.title_slug)! - order.get(b.title_slug)!);
    }
    if (filters.difficulties.length) {
      list = list.filter((p) => filters.difficulties.includes(p.difficulty));
    }
    const q = filters.search.trim().toLowerCase();
    if (q) {
      list = list.filter(
        (p) =>
          p.title.toLowerCase().includes(q) ||
          p.frontend_id.toLowerCase().includes(q),
      );
    }
    // A list keeps its curated order; otherwise apply the sort dropdown.
    return activeList ? list : sortProblems(list, filters.sort);
  }, [problems, activeList, filters.difficulties, filters.search, filters.sort]);

  // Reset to the first page whenever the result set changes.
  useEffect(() => {
    setPage(1);
  }, [filters.difficulties, filters.tag, filters.list, filters.search, filters.sort]);

  const pageCount = Math.max(1, Math.ceil(view.length / PAGE_SIZE));
  const safePage = Math.min(page, pageCount);
  const current = view.slice((safePage - 1) * PAGE_SIZE, safePage * PAGE_SIZE);

  const toggleDifficulty = (d: Difficulty) =>
    setFilters((f) => ({
      ...f,
      difficulties: f.difficulties.includes(d)
        ? f.difficulties.filter((x) => x !== d)
        : [...f.difficulties, d],
    }));

  // Tag and list are mutually exclusive scopes — picking one clears the other.
  const selectTag = (slug: string | null) =>
    setFilters((f) => ({ ...f, tag: slug, list: slug ? null : f.list }));

  const selectList = (id: string | null) =>
    setFilters((f) => ({ ...f, list: id, tag: id ? null : f.tag }));

  const activeTagName =
    POPULAR_TOPICS.find((t) => t.slug === filters.tag)?.name ?? filters.tag;

  return (
    <div className="h-screen flex flex-col">
      <TopNav />
      <div className="flex flex-1 overflow-hidden">
        <Sidebar
          difficulties={filters.difficulties}
          tag={filters.tag}
          activeListId={filters.list}
          userLists={userLists}
          listsHydrated={listsHydrated}
          solvedMap={solvedMap}
          solvedHydrated={solvedHydrated}
          onToggleDifficulty={toggleDifficulty}
          onSelectTag={selectTag}
          onSelectList={selectList}
          onCreateList={createList}
          onDeleteList={deleteList}
        />
        <main className="flex-1 overflow-y-auto custom-scrollbar p-gutter lg:p-8 pb-28">
          <div className="max-w-6xl mx-auto">
            {/* Controls */}
            <div className="flex flex-col gap-4 mb-6">
              <div className="flex flex-wrap items-center gap-3">
                <SearchBar
                  value={filters.search}
                  onChange={(v) => setFilters((f) => ({ ...f, search: v }))}
                  className="flex-1 min-w-[220px]"
                />
                <div className="flex items-center gap-2">
                  <span className="text-label-md text-on-surface-variant hidden sm:inline">
                    Sort by:
                  </span>
                  <select
                    value={filters.sort}
                    onChange={(e) =>
                      setFilters((f) => ({ ...f, sort: e.target.value as SortKey }))
                    }
                    className="bg-surface-container-lowest border border-outline-variant rounded px-3 py-2 text-label-md text-on-surface cursor-pointer outline-none focus:ring-2 focus:ring-primary"
                  >
                    {SORT_OPTIONS.map((o) => (
                      <option key={o.value} value={o.value}>
                        {o.label}
                      </option>
                    ))}
                  </select>
                </div>
              </div>

              {/* Difficulty pills (mobile/tablet) + active topic chip */}
              <div className="flex flex-wrap items-center gap-2">
                {DIFFICULTIES.map((d) => {
                  const active = filters.difficulties.includes(d);
                  return (
                    <button
                      key={d}
                      type="button"
                      onClick={() => toggleDifficulty(d)}
                      className={cn(
                        "px-3 py-1.5 rounded text-label-md font-label-md border transition-colors lg:hidden",
                        active
                          ? "bg-primary text-on-primary border-primary"
                          : "bg-surface-container-lowest border-outline-variant hover:border-primary",
                      )}
                    >
                      {d}
                    </button>
                  );
                })}
                {filters.tag && (
                  <span className="flex items-center gap-1 pl-3 pr-2 py-1.5 rounded-full bg-primary-tint text-primary text-label-md font-label-md">
                    {activeTagName}
                    <button
                      type="button"
                      onClick={() => selectTag(null)}
                      aria-label="Clear topic filter"
                      className="material-symbols-outlined text-[16px]"
                    >
                      close
                    </button>
                  </span>
                )}
                {activeList && (
                  <span className="flex items-center gap-1 pl-3 pr-2 py-1.5 rounded-full bg-primary-tint text-primary text-label-md font-label-md">
                    <span className="material-symbols-outlined text-[16px]">
                      list_alt
                    </span>
                    {activeList.name}
                    <button
                      type="button"
                      onClick={() => selectList(null)}
                      aria-label="Clear list filter"
                      className="material-symbols-outlined text-[16px]"
                    >
                      close
                    </button>
                  </span>
                )}
              </div>
            </div>

            {/* Table card */}
            <div className="bg-surface-container-lowest border border-outline-variant rounded-lg overflow-hidden">
              {isError ? (
                <ErrorState onRetry={() => refetch()} />
              ) : isLoading ? (
                <LoadingState />
              ) : view.length === 0 ? (
                <EmptyState />
              ) : (
                <>
                  <div className="overflow-x-auto custom-scrollbar">
                    <ProblemsTable
                      problems={current}
                      solvedMap={solvedMap}
                      hydrated={solvedHydrated}
                    />
                  </div>
                  <Pagination
                    page={safePage}
                    pageCount={pageCount}
                    total={view.length}
                    pageSize={PAGE_SIZE}
                    onPageChange={setPage}
                  />
                </>
              )}
            </div>
          </div>
        </main>
      </div>
      <MobileNav />
      <RandomFab />
    </div>
  );
}

function LoadingState() {
  return (
    <div className="divide-y divide-outline-variant">
      {Array.from({ length: 8 }).map((_, i) => (
        <div key={i} className="flex items-center gap-4 py-4 px-6">
          <div className="w-6 h-6 rounded-full bg-surface-variant animate-pulse" />
          <div className="h-4 flex-1 max-w-md rounded bg-surface-variant animate-pulse" />
          <div className="h-6 w-16 rounded-full bg-surface-variant animate-pulse" />
        </div>
      ))}
    </div>
  );
}

function EmptyState() {
  return (
    <div className="flex flex-col items-center justify-center py-20 text-center px-6">
      <span className="material-symbols-outlined text-5xl text-outline-variant mb-3">
        search_off
      </span>
      <p className="text-body-md text-on-surface font-semibold">
        No problems match your filters
      </p>
      <p className="text-body-sm text-on-surface-variant mt-1">
        Try clearing the search or difficulty filters.
      </p>
    </div>
  );
}

function ErrorState({ onRetry }: { onRetry: () => void }) {
  return (
    <div className="flex flex-col items-center justify-center py-20 text-center px-6">
      <span className="material-symbols-outlined text-5xl text-error mb-3">
        cloud_off
      </span>
      <p className="text-body-md text-on-surface font-semibold">
        Couldn&apos;t load problems
      </p>
      <p className="text-body-sm text-on-surface-variant mt-1 mb-4">
        The LeetCode API may be temporarily unavailable.
      </p>
      <button
        type="button"
        onClick={onRetry}
        className="px-4 py-2 bg-primary text-on-primary rounded text-label-md font-label-md hover:opacity-90"
      >
        Retry
      </button>
    </div>
  );
}
