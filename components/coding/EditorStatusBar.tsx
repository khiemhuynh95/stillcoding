"use client";

import type { SaveStatus } from "@/hooks/useCodeDraft";

function formatRelative(ts: number): string {
  const seconds = Math.round((Date.now() - ts) / 1000);
  if (seconds < 5) return "just now";
  if (seconds < 60) return `${seconds}s ago`;
  const minutes = Math.round(seconds / 60);
  if (minutes < 60) return `${minutes}m ago`;
  const hours = Math.round(minutes / 60);
  if (hours < 24) return `${hours}h ago`;
  return `${Math.round(hours / 24)}d ago`;
}

export function EditorStatusBar({
  status,
  lastSavedAt,
  line,
  column,
  langLabel,
}: {
  status: SaveStatus;
  lastSavedAt: number | null;
  line: number;
  column: number;
  langLabel: string;
}) {
  const statusText =
    status === "unsaved"
      ? "Unsaved changes"
      : status === "saved"
        ? "All changes saved"
        : "Ready";

  return (
    <div className="h-8 flex items-center px-4 bg-surface-container-low border-t border-outline-variant text-label-md font-label-md text-on-surface-variant">
      <div className="flex items-center gap-4">
        <span className="flex items-center gap-1">
          <span className="material-symbols-outlined text-[16px]">
            {status === "unsaved" ? "sync" : "cloud_done"}
          </span>
          {statusText}
        </span>
        {lastSavedAt && (
          <span className="hidden sm:flex items-center gap-1">
            <span className="material-symbols-outlined text-[16px]">history</span>
            Saved {formatRelative(lastSavedAt)}
          </span>
        )}
      </div>
      <div className="ml-auto flex items-center gap-3">
        <span>
          Ln {line}, Col {column}
        </span>
        <span className="hidden sm:inline">{langLabel}</span>
        <span className="hidden md:inline">UTF-8</span>
      </div>
    </div>
  );
}
