"use client";

import { useCallback, useEffect, useRef, useState } from "react";
import type { OutputLine, RunStatus } from "./useRunPython";

/**
 * Runs JavaScript in a throwaway Web Worker (see public/js-worker.js). Unlike the
 * Python runner (Pyodide/WASM from a CDN) and the Java runner (server-side
 * Wandbox), JS is the platform — it executes natively in the worker, so there's
 * no runtime download and nothing leaves the browser. A fresh worker per run
 * makes cancel/timeout a simple terminate(). Returns the same interface as
 * useRunPython so the editor can swap runners by language.
 */

/** Max wall time for a run (kills infinite loops via worker terminate). */
const RUN_TIMEOUT_MS = 15_000;

interface WorkerMessage {
  id: number;
  type: "status" | "stdout" | "stderr" | "error" | "done";
  status?: RunStatus;
  text?: string;
  ok?: boolean;
}

export function useRunJavaScript() {
  const workerRef = useRef<Worker | null>(null);
  const runIdRef = useRef(0);
  const timeoutRef = useRef<ReturnType<typeof setTimeout> | null>(null);
  const startedAtRef = useRef<number | null>(null);
  const [status, setStatus] = useState<RunStatus>("idle");
  const [output, setOutput] = useState<OutputLine[]>([]);
  // Wall-clock of the last finished run; null while running / before a run.
  const [durationMs, setDurationMs] = useState<number | null>(null);

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

  // The worker batches stdout/stderr; split into one OutputLine per line so each
  // can be tone-classified by the console (same as the Python runner).
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
      setStatus("running");
      setDurationMs(null);
      startedAtRef.current = performance.now();

      let worker: Worker;
      try {
        // ?v= cache-busts the worker; bump it (and RUNNER_VERSION in the worker)
        // whenever public/js-worker.js changes so browsers don't run a stale copy.
        worker = new Worker("/js-worker.js?v=1");
      } catch (err) {
        append({
          stream: "stderr",
          text:
            "Could not start the JavaScript runner worker: " +
            String((err as { message?: string })?.message ?? err),
        });
        setStatus("error");
        return;
      }
      workerRef.current = worker;
      const id = ++runIdRef.current;

      // No runtime to download — time the run from the start.
      timeoutRef.current = setTimeout(() => {
        terminate();
        append({
          stream: "system",
          text: `\n[timed out after ${RUN_TIMEOUT_MS / 1000}s — possible infinite loop]`,
        });
        setStatus("error");
      }, RUN_TIMEOUT_MS);

      worker.onmessage = (e: MessageEvent<WorkerMessage>) => {
        const msg = e.data;
        if (msg.id !== id) return;
        switch (msg.type) {
          case "status":
            if (msg.status) setStatus(msg.status);
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
            if (startedAtRef.current != null) {
              setDurationMs(Math.round(performance.now() - startedAtRef.current));
            }
            setStatus((s) => (s === "error" ? s : msg.ok ? "done" : "error"));
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

  const isBusy = status === "running";

  return { status, output, durationMs, isBusy, run, cancel, clear };
}
