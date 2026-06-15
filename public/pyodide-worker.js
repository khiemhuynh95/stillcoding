/*
 * In-browser Python runner.
 *
 * Classic Web Worker that lazily loads Pyodide (CPython compiled to WASM) from
 * the jsdelivr CDN on first run, then executes the editor's code and returns its
 * stdout/stderr. Running in a worker keeps the UI responsive and lets the main
 * thread terminate() us to kill an infinite loop.
 *
 * Output capture: we redirect stdout/stderr into Python StringIO buffers and
 * read them back after the run, rather than relying on pyodide.setStdout()
 * streaming callbacks (which proved flaky across browsers). Output therefore
 * arrives in one batch when the run finishes — fine for this use case.
 */

const RUNNER_VERSION = 3;
const PYODIDE_VERSION = "0.26.4";
const INDEX_URL = `https://cdn.jsdelivr.net/pyodide/v${PYODIDE_VERSION}/full/`;

let pyodideReadyPromise = null;

function loadPyodideOnce() {
  if (!pyodideReadyPromise) {
    // eslint-disable-next-line no-undef
    importScripts(`${INDEX_URL}pyodide.js`);
    // eslint-disable-next-line no-undef
    pyodideReadyPromise = self.loadPyodide({ indexURL: INDEX_URL });
  }
  return pyodideReadyPromise;
}

// Run the user's code as a script (exec into the real __main__ dict so a trailing
// unittest.main() discovers their TestCases), capturing stdout+stderr into
// buffers and swallowing the SystemExit that unittest.main()/sys.exit() raises.
function buildDriver(code) {
  return [
    "import sys, io, contextlib, traceback",
    "_OUT = io.StringIO()",
    "_ERR = io.StringIO()",
    "__src = " + JSON.stringify(code),
    "_ns = sys.modules['__main__'].__dict__",
    "with contextlib.redirect_stdout(_OUT), contextlib.redirect_stderr(_ERR):",
    "    try:",
    "        exec(compile(__src, '<editor>', 'exec'), _ns)",
    "    except SystemExit as _e:",
    "        _c = _e.code",
    "        _n = 0 if _c is None else (_c if isinstance(_c, int) else 1)",
    "        if _n != 0:",
    "            print('[exited with status ' + str(_n) + ']', file=sys.stderr)",
    "    except BaseException:",
    "        traceback.print_exc()",
  ].join("\n");
}

self.onmessage = async (e) => {
  const { id, code } = e.data || {};
  const post = (msg) => self.postMessage({ id, ...msg });

  try {
    post({ type: "status", status: "loading-runtime" });

    let pyodide;
    try {
      pyodide = await loadPyodideOnce();
    } catch (loadErr) {
      post({
        type: "error",
        text:
          "Failed to load the Python runtime from the CDN: " +
          String((loadErr && loadErr.message) || loadErr),
      });
      post({ type: "done", ok: false });
      return;
    }

    post({ type: "status", status: "running" });
    await pyodide.runPythonAsync(buildDriver(code));

    const out = pyodide.globals.get("_OUT").getvalue();
    const err = pyodide.globals.get("_ERR").getvalue();
    if (out) post({ type: "stdout", text: out });
    if (err) post({ type: "stderr", text: err });

    post({ type: "done", ok: true });
  } catch (err) {
    post({ type: "error", text: String((err && err.message) || err) });
    post({ type: "done", ok: false });
  }
};
