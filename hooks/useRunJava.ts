"use client";

import { useCallback, useEffect, useRef, useState } from "react";
import type { OutputLine, RunStatus } from "./useRunPython";

/**
 * Runs Java via the public Wandbox API (https://github.com/melpon/wandbox).
 * Unlike the Python runner (Pyodide / WASM, fully client-side), there is no
 * practical in-browser JVM, so the source is POSTed to Wandbox, compiled + run
 * server-side, and the combined compile/run output is mapped into the same
 * `OutputLine[]` shape the console renders.
 *
 * Trade-off vs. the Pyodide path: the user's code leaves the browser, the call
 * needs network, and it's subject to the public instance's fair-use limits. No
 * API key required. Returns the same interface as `useRunPython` so the editor
 * can swap runners by language.
 *
 * (We moved off the public Piston instance, which went whitelist-only in
 * Feb 2026; Wandbox keeps the same no-key, no-infra trade-off profile.)
 */

const WANDBOX_LIST = "https://wandbox.org/api/list.json";
const WANDBOX_COMPILE = "https://wandbox.org/api/compile.json";
/** Used only if the live compiler list can't be fetched. Bump if it 404s. */
const FALLBACK_COMPILER = "openjdk-jdk-22+36";
/** Soft wall-clock cap; we abort the fetch after this. */
const RUN_TIMEOUT_MS = 20_000;

interface WandboxCompiler {
  name: string;
  language: string;
}
interface WandboxResult {
  status?: string; // "0" on success, non-zero otherwise
  compiler_error?: string;
  program_output?: string;
  program_error?: string;
}

// Wandbox's compiler ids carry a build suffix (e.g. "openjdk-jdk-22+36") that
// changes over time, so resolve the newest OpenJDK from the live list once and
// cache it for the session rather than hard-coding a build that will rot.
let compilerPromise: Promise<string> | null = null;
function resolveCompiler(signal: AbortSignal): Promise<string> {
  if (!compilerPromise) {
    compilerPromise = fetch(WANDBOX_LIST, { signal })
      .then((r) => (r.ok ? r.json() : Promise.reject()))
      .then((list: WandboxCompiler[]) => {
        const jdks = list
          .filter((c) => c.name.startsWith("openjdk-jdk-"))
          .map((c) => c.name)
          .sort();
        return jdks.at(-1) ?? FALLBACK_COMPILER;
      })
      .catch(() => {
        compilerPromise = null; // let a later run retry the lookup
        return FALLBACK_COMPILER;
      });
  }
  return compilerPromise;
}

// Wandbox always compiles a file named prog.java, so a top-level `public class`
// fails ("should be declared in a file named …"). Drop the `public` modifier
// from an outermost (column-0) class so pasted `public class Main` still runs;
// indented nested classes are untouched.
function stripTopLevelPublic(code: string): string {
  return code.replace(
    /^public(\s+(?:final\s+|abstract\s+|sealed\s+|strictfp\s+)*class\s)/gm,
    "$1",
  );
}

function toLines(stream: "stdout" | "stderr", text: string): OutputLine[] {
  return text
    .replace(/\n$/, "")
    .split("\n")
    .map((t) => ({ stream, text: t }));
}

export function useRunJava() {
  const abortRef = useRef<AbortController | null>(null);
  const [status, setStatus] = useState<RunStatus>("idle");
  const [output, setOutput] = useState<OutputLine[]>([]);
  // Wall-clock of the last finished run. Includes the Wandbox round-trip
  // (network + compile), so it overstates pure execution time — accepted
  // beta caveat for the course speed bonus.
  const [durationMs, setDurationMs] = useState<number | null>(null);

  const abort = useCallback(() => {
    abortRef.current?.abort();
    abortRef.current = null;
  }, []);

  useEffect(() => () => abort(), [abort]);

  const run = useCallback(
    async (code: string) => {
      abort();
      setOutput([]);
      setStatus("running");
      setDurationMs(null);
      const startedAt = performance.now();

      const controller = new AbortController();
      abortRef.current = controller;
      const timer = setTimeout(() => controller.abort(), RUN_TIMEOUT_MS);

      try {
        const compiler = await resolveCompiler(controller.signal);
        const res = await fetch(WANDBOX_COMPILE, {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            compiler,
            code: stripTopLevelPublic(code),
            stdin: "",
          }),
          signal: controller.signal,
        });

        if (!res.ok) {
          setOutput([
            {
              stream: "stderr",
              text: `Run service error: ${res.status} ${res.statusText}`,
            },
          ]);
          setStatus("error");
          return;
        }

        const data = (await res.json()) as WandboxResult;
        const lines: OutputLine[] = [];
        // Compile errors/warnings first (so the failing source line is on top).
        if (data.compiler_error?.trim()) {
          lines.push(...toLines("stderr", data.compiler_error));
        }
        if (data.program_output) {
          lines.push(...toLines("stdout", data.program_output));
        }
        if (data.program_error) {
          lines.push(...toLines("stderr", data.program_error));
        }

        setOutput(lines);
        setDurationMs(Math.round(performance.now() - startedAt));
        setStatus(data.status === "0" ? "done" : "error");
      } catch (err) {
        // cancel() aborts the fetch and owns the UI in that case.
        if ((err as Error)?.name === "AbortError") return;
        setOutput([
          {
            stream: "stderr",
            text:
              "Could not reach the Java run service: " +
              String((err as { message?: string })?.message ?? err),
          },
        ]);
        setStatus("error");
      } finally {
        clearTimeout(timer);
        abortRef.current = null;
      }
    },
    [abort],
  );

  const cancel = useCallback(() => {
    abort();
    setOutput((prev) => [...prev, { stream: "system", text: "\n[stopped]" }]);
    setStatus("idle");
  }, [abort]);

  const clear = useCallback(() => {
    setOutput([]);
    setStatus((s) => (s === "done" || s === "error" ? "idle" : s));
  }, []);

  const isBusy = status === "running";

  return { status, output, durationMs, isBusy, run, cancel, clear };
}
