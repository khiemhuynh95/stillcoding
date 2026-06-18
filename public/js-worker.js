/*
 * In-browser JavaScript runner.
 *
 * Classic Web Worker that executes the editor's code natively (no WASM, no CDN
 * — JS is the platform), capturing console output and uncaught errors. Running
 * in a worker keeps the UI responsive and lets the main thread terminate() us to
 * kill an infinite loop. Mirrors the message protocol of pyodide-worker.js so
 * hooks/useRunJavaScript.ts can drive it the same way as the Python runner.
 *
 * Output capture: console.* is redirected into buffers and flushed when the run
 * finishes (one batch), matching the Python runner. Execution is synchronous —
 * a trailing console.log(...) in the buffer is how the user sees results, just
 * like a trailing unittest.main() in Python.
 */

const RUNNER_VERSION = 1;

// Best-effort console-style formatting of a single value.
function fmt(value) {
  if (typeof value === "string") return value;
  if (value === null) return "null";
  if (value === undefined) return "undefined";
  if (typeof value === "bigint") return String(value) + "n";
  if (
    typeof value === "number" ||
    typeof value === "boolean" ||
    typeof value === "symbol"
  ) {
    return String(value);
  }
  if (typeof value === "function") return value.toString();
  if (value instanceof Error) return value.stack || String(value);
  try {
    return JSON.stringify(
      value,
      (_k, v) => (typeof v === "bigint" ? String(v) + "n" : v),
    );
  } catch {
    return String(value);
  }
}

const line = (args) => args.map(fmt).join(" ");

self.onmessage = (e) => {
  const { id, code } = e.data || {};
  const post = (msg) => self.postMessage({ id, ...msg });

  const out = [];
  const err = [];
  // Redirect console: log/info/debug -> stdout; warn/error -> stderr.
  console.log = console.info = console.debug = (...a) => out.push(line(a));
  console.warn = console.error = (...a) => err.push(line(a));

  post({ type: "status", status: "running" });

  try {
    // Indirect eval runs in the worker's global scope (not this function's),
    // so top-level `function`/`var`/`let` declarations behave naturally.
    // The sourceURL makes uncaught-error stack frames read "editor.js:line:col".
    (0, eval)(code + "\n//# sourceURL=editor.js");
  } catch (e2) {
    err.push(e2 && e2.stack ? e2.stack : String(e2));
  }

  if (out.length) post({ type: "stdout", text: out.join("\n") + "\n" });
  if (err.length) post({ type: "stderr", text: err.join("\n") + "\n" });
  post({ type: "done", ok: err.length === 0 });
};
