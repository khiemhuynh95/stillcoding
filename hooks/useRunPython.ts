"use client";

import { useCallback, useEffect, useRef, useState } from "react";

export type RunStatus =
  | "idle"
  | "loading-runtime"
  | "running"
  | "done"
  | "error";

export interface OutputLine {
  stream: "stdout" | "stderr" | "system";
  text: string;
}

export interface TestSummary {
  total: number;
  passed: number;
  failed: number;
}

/**
 * Parses Python `unittest` output into a pass/fail summary. unittest prints a
 * `Ran N tests` line followed by `OK` or `FAILED (failures=.., errors=..)`.
 * Returns null when the output isn't a unittest run (e.g. plain prints).
 */
export function parseTestSummary(output: OutputLine[]): TestSummary | null {
  const text = output.map((l) => l.text).join("\n");
  const ran = text.match(/Ran (\d+) tests?\b/);
  if (!ran) return null;
  const total = Number(ran[1]);
  const failedBlock = text.match(/^FAILED\s*\(([^)]*)\)/m);
  let failed = 0;
  if (failedBlock) {
    const failures = failedBlock[1].match(/failures=(\d+)/);
    const errors = failedBlock[1].match(/errors=(\d+)/);
    failed =
      (failures ? Number(failures[1]) : 0) + (errors ? Number(errors[1]) : 0);
  }
  return { total, passed: Math.max(0, total - failed), failed };
}

/**
 * Finds the line number to jump to on error: the deepest traceback frame that
 * points at the user's code. The worker compiles the editor buffer with the
 * filename `<editor>`, so frames reading `File "<editor>", line N` are the
 * user's own lines (vs. unittest/stdlib internals). The last such frame is
 * where the failure actually surfaced. Returns null when there's no traceback.
 */
export function parseErrorLine(output: OutputLine[]): number | null {
  let line: number | null = null;
  for (const l of output) {
    if (l.stream !== "stderr") continue;
    const m = l.text.match(/File "<editor>", line (\d+)/);
    if (m) line = Number(m[1]);
  }
  return line;
}

export type LineTone = "normal" | "muted" | "success" | "error";

/**
 * Picks a display tone for a single output line. `unittest` writes its *whole*
 * report to stderr — progress dots, separators, the `Ran N tests` line and
 * `OK`/`FAILED` — so painting every stderr line red makes a clean pass look
 * like a crash. We mute the framing, green the `OK`, and reserve red for the
 * lines that actually signal a failure (tracebacks, `FAIL:`/`ERROR:` blocks).
 */
export function lineTone(line: OutputLine): LineTone {
  if (line.stream === "stdout") return "normal";
  if (line.stream === "system") return "muted";

  const t = line.text.trim();
  if (t === "") return "muted";
  if (/^[-=]+$/.test(t)) return "muted"; // section separators
  if (/^[.FEsx]+$/.test(t)) return "muted"; // non-verbose progress chars
  if (/^Ran \d+ tests?\b/.test(t)) return "muted";
  if (/^OK\b/.test(t)) return "success"; // "OK" / "OK (skipped=2)"
  if (/^FAILED\b/.test(t)) return "error";
  if (/^(FAIL|ERROR):/.test(t)) return "error";
  if (/\.\.\. ok$/i.test(t)) return "muted"; // verbose: "test_x (...) ... ok"
  if (/\.\.\. skipped/i.test(t)) return "muted";
  if (/\.\.\. (FAIL|ERROR)\b/i.test(t)) return "error";
  return "error"; // tracebacks & genuine runtime errors
}

/** Max wall time for *execution* (after the runtime has loaded). */
const RUN_TIMEOUT_MS = 15_000;

interface WorkerMessage {
  id: number;
  type: "status" | "stdout" | "stderr" | "error" | "done";
  status?: RunStatus;
  text?: string;
  ok?: boolean;
}

/**
 * Runs Python in a throwaway Web Worker via Pyodide (see public/pyodide-worker.js).
 * A fresh worker per run makes cancel/timeout a simple terminate(); the runtime
 * download (first run only) is uncapped, the execution that follows is timed.
 */
export function useRunPython() {
  const workerRef = useRef<Worker | null>(null);
  const runIdRef = useRef(0);
  const timeoutRef = useRef<ReturnType<typeof setTimeout> | null>(null);
  const [status, setStatus] = useState<RunStatus>("idle");
  const [output, setOutput] = useState<OutputLine[]>([]);

  const clearTimer = () => {
    if (timeoutRef.current) clearTimeout(timeoutRef.current);
    timeoutRef.current = null;
  };

  const terminate = useCallback(() => {
    workerRef.current?.terminate();
    workerRef.current = null;
    clearTimer();
  }, []);

  useEffect(() => () => terminate(), [terminate]);

  const append = (line: OutputLine) => setOutput((prev) => [...prev, line]);

  // Pyodide hands us stdout/stderr as one batched blob with embedded newlines.
  // Split it into one OutputLine per line so each can be tone-classified
  // (unittest's report — dots, separators, OK/FAILED — all arrives via stderr).
  const appendChunk = (stream: "stdout" | "stderr", text: string) =>
    setOutput((prev) => [
      ...prev,
      ...text
        .replace(/\n$/, "")
        .split("\n")
        .map((t) => ({ stream, text: t })),
    ]);

  const cancel = useCallback(() => {
    terminate();
    append({ stream: "system", text: "\n[stopped]" });
    setStatus("idle");
  }, [terminate]);

  const run = useCallback(
    (code: string) => {
      terminate();
      setOutput([]);
      setStatus("loading-runtime");

      // Worker construction can throw synchronously (SecurityError, blocked URL).
      // Catch it so the caller never throws — otherwise React discards the
      // pending state updates and the console panel never opens.
      let worker: Worker;
      try {
        // ?v= cache-busts the worker so browsers don't run a stale copy.
        // Bump this (and RUNNER_VERSION in the worker) whenever the worker
        // changes, otherwise the browser/CDN keeps serving the cached build.
        worker = new Worker("/pyodide-worker.js?v=3");
      } catch (err) {
        append({
          stream: "stderr",
          text:
            "Could not start the Python runner worker: " +
            String((err as { message?: string })?.message ?? err),
        });
        setStatus("error");
        return;
      }
      workerRef.current = worker;
      const id = ++runIdRef.current;

      worker.onmessage = (e: MessageEvent<WorkerMessage>) => {
        const msg = e.data;
        if (msg.id !== id) return;
        switch (msg.type) {
          case "status":
            if (msg.status) setStatus(msg.status);
            // Only time the execution phase, not the (first-run) runtime download.
            if (msg.status === "running") {
              timeoutRef.current = setTimeout(() => {
                terminate();
                append({
                  stream: "system",
                  text: `\n[timed out after ${RUN_TIMEOUT_MS / 1000}s — possible infinite loop]`,
                });
                setStatus("error");
              }, RUN_TIMEOUT_MS);
            }
            break;
          case "stdout":
            appendChunk("stdout", msg.text ?? "");
            break;
          case "stderr":
            appendChunk("stderr", msg.text ?? "");
            break;
          case "error":
            appendChunk("stderr", msg.text ?? "");
            setStatus("error");
            break;
          case "done":
            clearTimer();
            setStatus((s) => (s === "error" ? s : "done"));
            break;
        }
      };

      worker.onerror = (e) => {
        const where = e.filename
          ? ` (${e.filename}:${e.lineno}:${e.colno})`
          : "";
        append({
          stream: "stderr",
          text: (e.message || "Worker failed to start") + where,
        });
        setStatus("error");
        clearTimer();
        terminate();
      };

      worker.postMessage({ id, code });
    },
    [terminate],
  );

  const clear = useCallback(() => {
    setOutput([]);
    if (status === "done" || status === "error") setStatus("idle");
  }, [status]);

  const isBusy = status === "loading-runtime" || status === "running";

  return { status, output, isBusy, run, cancel, clear };
}
