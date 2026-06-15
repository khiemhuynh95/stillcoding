"use client";

import { useEffect, useRef } from "react";
import type { OutputLine, RunStatus } from "@/hooks/useRunPython";
import { cn } from "@/lib/utils";

const STATUS_LABEL: Record<RunStatus, string> = {
  idle: "Output",
  "loading-runtime": "Loading Python…",
  running: "Running…",
  done: "Finished",
  error: "Finished with errors",
};

export function OutputConsole({
  status,
  output,
  onClear,
  onClose,
}: {
  status: RunStatus;
  output: OutputLine[];
  onClear: () => void;
  onClose: () => void;
}) {
  const scrollRef = useRef<HTMLDivElement | null>(null);

  const busy = status === "loading-runtime" || status === "running";

  // While output is still streaming, follow the bottom. Once the run finishes
  // (Pyodide delivers stdout/stderr in one batch), jump to the top so the first
  // line — e.g. the first failing test / traceback — is visible without having
  // to scroll up in this short panel.
  useEffect(() => {
    const el = scrollRef.current;
    if (!el) return;
    el.scrollTop = busy ? el.scrollHeight : 0;
  }, [output, busy]);

  return (
    <div className="flex flex-col border-t border-outline-variant bg-surface-container-lowest shrink-0 h-48">
      <div className="h-8 flex items-center px-4 bg-surface-container-low border-b border-outline-variant text-label-md font-label-md text-on-surface-variant">
        <span className="flex items-center gap-1.5">
          {busy && (
            <span className="material-symbols-outlined text-[16px] animate-spin">
              progress_activity
            </span>
          )}
          {STATUS_LABEL[status]}
        </span>
        <div className="ml-auto flex items-center gap-3">
          <button
            type="button"
            onClick={onClear}
            disabled={busy || output.length === 0}
            className="hover:text-on-surface transition-colors disabled:opacity-40"
          >
            Clear
          </button>
          <button
            type="button"
            onClick={onClose}
            title="Hide console"
            className="flex items-center hover:text-on-surface transition-colors"
          >
            <span className="material-symbols-outlined text-[18px]">close</span>
          </button>
        </div>
      </div>

      <div
        ref={scrollRef}
        className="flex-1 overflow-y-auto custom-scrollbar px-4 py-2 font-mono text-body-sm leading-relaxed whitespace-pre-wrap break-words"
      >
        {output.length === 0 ? (
          <span className="text-on-surface-variant">
            {status === "loading-runtime"
              ? "Loading the Python runtime (first run downloads ~10 MB)…"
              : busy
                ? "Starting…"
                : status === "done" || status === "error"
                  ? "Program finished with no output. Add print(...) or run unittest.main() to see results."
                  : "Run your code to see output here."}
          </span>
        ) : (
          output.map((line, i) => (
            <div
              key={i}
              className={cn(
                line.stream === "stderr" && "text-error",
                line.stream === "system" && "text-on-surface-variant italic",
              )}
            >
              {/* Pyodide's batched callback strips the trailing newline, so each
                  chunk is one line; render blank chunks as a real blank line. */}
              {line.text === "" ? " " : line.text}
            </div>
          ))
        )}
      </div>
    </div>
  );
}
