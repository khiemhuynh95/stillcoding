"use client";

import { cn } from "@/lib/utils";

function pageList(page: number, pageCount: number): (number | "...")[] {
  if (pageCount <= 7) {
    return Array.from({ length: pageCount }, (_, i) => i + 1);
  }
  const pages: (number | "...")[] = [1];
  const start = Math.max(2, page - 1);
  const end = Math.min(pageCount - 1, page + 1);
  if (start > 2) pages.push("...");
  for (let i = start; i <= end; i += 1) pages.push(i);
  if (end < pageCount - 1) pages.push("...");
  pages.push(pageCount);
  return pages;
}

export function Pagination({
  page,
  pageCount,
  total,
  pageSize,
  onPageChange,
}: {
  page: number;
  pageCount: number;
  total: number;
  pageSize: number;
  onPageChange: (page: number) => void;
}) {
  const from = total === 0 ? 0 : (page - 1) * pageSize + 1;
  const to = Math.min(page * pageSize, total);

  return (
    <div className="bg-surface-container-low/40 border-t border-outline-variant px-6 py-4 flex flex-col sm:flex-row items-center justify-between gap-3">
      <span className="text-body-sm text-on-surface-variant">
        Showing {from.toLocaleString()}–{to.toLocaleString()} of{" "}
        {total.toLocaleString()} problems
      </span>
      <div className="flex items-center gap-1">
        <button
          type="button"
          disabled={page <= 1}
          onClick={() => onPageChange(page - 1)}
          className="p-2 rounded hover:bg-surface-variant disabled:opacity-30 disabled:hover:bg-transparent"
          aria-label="Previous page"
        >
          <span className="material-symbols-outlined">chevron_left</span>
        </button>
        {pageList(page, pageCount).map((p, i) =>
          p === "..." ? (
            <span key={`gap-${i}`} className="px-2 text-on-surface-variant">
              …
            </span>
          ) : (
            <button
              key={p}
              type="button"
              onClick={() => onPageChange(p)}
              className={cn(
                "w-8 h-8 flex items-center justify-center rounded text-body-sm",
                p === page
                  ? "bg-primary text-on-primary font-bold"
                  : "hover:bg-surface-variant",
              )}
            >
              {p}
            </button>
          ),
        )}
        <button
          type="button"
          disabled={page >= pageCount}
          onClick={() => onPageChange(page + 1)}
          className="p-2 rounded hover:bg-surface-variant disabled:opacity-30 disabled:hover:bg-transparent"
          aria-label="Next page"
        >
          <span className="material-symbols-outlined">chevron_right</span>
        </button>
      </div>
    </div>
  );
}
