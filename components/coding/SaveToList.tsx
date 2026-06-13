"use client";

import { useEffect, useRef, useState } from "react";
import { useLists } from "@/hooks/useLists";
import { cn } from "@/lib/utils";

/** Header control to add/remove the current problem to/from the user's lists. */
export function SaveToList({ slug }: { slug: string }) {
  const { lists, hydrated, createList, toggleProblem } = useLists();
  const [open, setOpen] = useState(false);
  const [newName, setNewName] = useState("");
  const ref = useRef<HTMLDivElement>(null);

  const savedCount = hydrated
    ? lists.reduce((n, l) => n + (l.slugs.includes(slug) ? 1 : 0), 0)
    : 0;

  // Close on outside click or Escape.
  useEffect(() => {
    if (!open) return;
    const onClick = (e: MouseEvent) => {
      if (ref.current && !ref.current.contains(e.target as Node)) {
        setOpen(false);
      }
    };
    const onKey = (e: KeyboardEvent) => {
      if (e.key === "Escape") setOpen(false);
    };
    document.addEventListener("mousedown", onClick);
    document.addEventListener("keydown", onKey);
    return () => {
      document.removeEventListener("mousedown", onClick);
      document.removeEventListener("keydown", onKey);
    };
  }, [open]);

  const handleCreate = () => {
    const name = newName.trim();
    if (!name) return;
    const id = createList(name);
    toggleProblem(id, slug, true);
    setNewName("");
  };

  return (
    <div className="relative" ref={ref}>
      <button
        type="button"
        onClick={() => setOpen((o) => !o)}
        title="Save this problem to a list"
        className={cn(
          "flex items-center gap-1 px-3 sm:px-4 py-1.5 rounded font-label-md text-label-md border transition-colors",
          savedCount > 0
            ? "border-primary text-primary bg-primary-tint"
            : "border-outline-variant text-on-surface-variant hover:border-primary hover:text-on-surface",
        )}
      >
        <span
          className={cn(
            "material-symbols-outlined text-[18px]",
            savedCount > 0 && "fill",
          )}
        >
          {savedCount > 0 ? "bookmark_added" : "bookmark_add"}
        </span>
        <span className="hidden sm:inline">
          {savedCount > 0 ? `Saved (${savedCount})` : "Save to list"}
        </span>
      </button>

      {open && (
        <div className="absolute right-0 mt-2 w-64 bg-surface-container-lowest border border-outline-variant rounded-lg shadow-lg z-50 overflow-hidden">
          <div className="px-3 py-2 border-b border-outline-variant">
            <span className="text-label-md font-label-md text-on-surface-variant uppercase tracking-wider">
              Save to list
            </span>
          </div>

          <div className="max-h-60 overflow-y-auto custom-scrollbar py-1">
            {!hydrated ? null : lists.length === 0 ? (
              <p className="px-3 py-3 text-body-sm text-on-surface-variant">
                You have no lists yet. Create one below.
              </p>
            ) : (
              lists.map((l) => {
                const checked = l.slugs.includes(slug);
                return (
                  <label
                    key={l.id}
                    className="flex items-center gap-3 px-3 py-2 cursor-pointer hover:bg-surface-variant"
                  >
                    <input
                      type="checkbox"
                      checked={checked}
                      onChange={() => toggleProblem(l.id, slug)}
                      className="w-4 h-4 rounded-sm accent-primary cursor-pointer shrink-0"
                    />
                    <span className="flex-1 truncate text-body-md text-on-surface">
                      {l.name}
                    </span>
                    <span className="text-body-sm tabular-nums text-on-surface-variant shrink-0">
                      {l.slugs.length}
                    </span>
                  </label>
                );
              })
            )}
          </div>

          <div className="flex items-center gap-2 p-2 border-t border-outline-variant">
            <input
              type="text"
              value={newName}
              onChange={(e) => setNewName(e.target.value)}
              onKeyDown={(e) => {
                if (e.key === "Enter") {
                  e.preventDefault();
                  handleCreate();
                }
              }}
              placeholder="New list name"
              className="flex-1 min-w-0 bg-surface-container-lowest border border-outline-variant rounded px-2 py-1.5 text-body-sm text-on-surface outline-none focus:ring-2 focus:ring-primary"
            />
            <button
              type="button"
              onClick={handleCreate}
              disabled={!newName.trim()}
              className="px-3 py-1.5 rounded bg-primary text-on-primary text-label-md font-label-md hover:opacity-90 disabled:opacity-40 disabled:cursor-not-allowed shrink-0"
            >
              Add
            </button>
          </div>
        </div>
      )}
    </div>
  );
}
