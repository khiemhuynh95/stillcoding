"use client";

import { useEffect, useState } from "react";
import { SidebarContent, type SidebarContentProps } from "./SidebarContent";
import { cn } from "@/lib/utils";

/**
 * Mobile/tablet replacement for the desktop `Sidebar`: a trigger button that
 * opens a slide-over drawer with the same `SidebarContent` filters (Categories,
 * Lists, Difficulty, Popular Topics), which are otherwise unreachable below
 * `lg`. Hidden at `lg` and up, where the persistent sidebar takes over.
 */
export function MobileFilters(props: SidebarContentProps) {
  const [open, setOpen] = useState(false);

  const activeCount =
    props.difficulties.length +
    (props.tag ? 1 : 0) +
    (props.activeListId ? 1 : 0);

  // Lock body scroll and allow Escape to close while the drawer is open.
  useEffect(() => {
    if (!open) return;
    const prev = document.body.style.overflow;
    document.body.style.overflow = "hidden";
    const onKey = (e: KeyboardEvent) => {
      if (e.key === "Escape") setOpen(false);
    };
    window.addEventListener("keydown", onKey);
    return () => {
      document.body.style.overflow = prev;
      window.removeEventListener("keydown", onKey);
    };
  }, [open]);

  return (
    <div className="lg:hidden">
      <button
        type="button"
        onClick={() => setOpen(true)}
        className="flex items-center gap-2 px-3 py-2 rounded border border-outline-variant bg-surface-container-lowest text-label-md font-label-md text-on-surface hover:border-primary transition-colors"
      >
        <span className="material-symbols-outlined text-[18px]">tune</span>
        Filters
        {activeCount > 0 && (
          <span className="min-w-5 h-5 px-1 flex items-center justify-center rounded-full bg-primary text-on-primary text-[11px] font-bold">
            {activeCount}
          </span>
        )}
      </button>

      {open && (
        <div className="fixed inset-0 z-[60]">
          <div
            className="absolute inset-0 bg-black/40"
            onClick={() => setOpen(false)}
            aria-hidden
          />
          <div
            role="dialog"
            aria-modal="true"
            aria-label="Filters"
            className={cn(
              "absolute inset-y-0 left-0 w-[85%] max-w-sm flex flex-col",
              "bg-surface-container-low border-r border-outline-variant shadow-ambient",
            )}
          >
            <div className="flex items-center justify-between px-6 h-14 border-b border-outline-variant shrink-0">
              <h2 className="text-headline-sm font-headline-sm font-bold text-on-surface">
                Filters
              </h2>
              <button
                type="button"
                onClick={() => setOpen(false)}
                aria-label="Close filters"
                className="material-symbols-outlined text-on-surface-variant p-2 -mr-2 hover:bg-surface-container rounded-full transition-colors"
              >
                close
              </button>
            </div>
            <div className="flex-1 min-h-0 overflow-y-auto">
              <SidebarContent {...props} />
            </div>
            <div className="p-4 border-t border-outline-variant shrink-0">
              <button
                type="button"
                onClick={() => setOpen(false)}
                className="w-full py-2.5 rounded bg-primary text-on-primary text-label-md font-label-md hover:opacity-90"
              >
                Show results
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
