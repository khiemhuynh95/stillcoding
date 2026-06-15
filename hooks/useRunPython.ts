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
        worker = new Worker("/pyodide-worker.js?v=2");
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
            append({ stream: "stdout", text: msg.text ?? "" });
            break;
          case "stderr":
            append({ stream: "stderr", text: msg.text ?? "" });
            break;
          case "error":
            append({ stream: "stderr", text: msg.text ?? "" });
            setStatus("error");
            break;
          case "done":
            clearTimer();
            setStatus((s) => (s === "error" ? s : "done"));
            break;
        }
      };

      worker.onerror = (e) => {
        const where = e.filename ? ` (${e.filename}:${e.lineno}:${e.colno})` : "";
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
