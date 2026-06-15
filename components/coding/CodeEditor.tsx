"use client";

import dynamic from "next/dynamic";
import { useEffect, useRef, useState } from "react";
import type * as Y from "yjs";
import type { Awareness } from "y-protocols/awareness";
import { languageById } from "@/lib/starterTemplates";
import {
  type ICodeEditor as BindableEditor,
  MonacoYjsBinding,
} from "@/lib/monacoYjsBinding";
import type { SaveStatus } from "@/hooks/useCodeDraft";
import { useRunPython } from "@/hooks/useRunPython";
import { LanguageSelect } from "./LanguageSelect";
import { EditorStatusBar } from "./EditorStatusBar";
import { OutputConsole } from "./OutputConsole";

const MonacoEditor = dynamic(
  () => import("@monaco-editor/react").then((m) => m.default),
  {
    ssr: false,
    loading: () => (
      <div className="flex-1 flex items-center justify-center text-on-surface-variant text-body-sm">
        Loading editor…
      </div>
    ),
  },
);

// Minimal structural type for the Monaco editor instance bits we use, so we
// don't need to depend on the full `monaco-editor` types package. Extends the
// shape the Yjs binding needs (BindableEditor) with the cursor + value reads
// the editor chrome uses.
interface EditorInstance extends BindableEditor {
  onDidChangeCursorPosition(
    cb: (e: { position: { lineNumber: number; column: number } }) => void,
  ): void;
  getValue(): string;
}

// Syntax themes per DESIGN.md: desaturated Google hues for long-session comfort
// (keywords blue, strings green, numbers/constants red, comments grey).
function defineEditorThemes(monaco: {
  editor: { defineTheme: (name: string, data: unknown) => void };
}) {
  monaco.editor.defineTheme("devstudio-light", {
    base: "vs",
    inherit: true,
    rules: [
      { token: "keyword", foreground: "1a73e8" },
      { token: "keyword.control", foreground: "1a73e8" },
      { token: "string", foreground: "188038" },
      { token: "string.escape", foreground: "188038" },
      { token: "number", foreground: "d93025" },
      { token: "constant", foreground: "d93025" },
      { token: "constant.language", foreground: "d93025" },
      { token: "comment", foreground: "70757a", fontStyle: "italic" },
      { token: "type", foreground: "795900" },
      { token: "type.identifier", foreground: "795900" },
    ],
    colors: {
      "editor.background": "#ffffff",
      "editorLineNumber.foreground": "#94a3b8",
      "editorLineNumber.activeForeground": "#414754",
      "editor.lineHighlightBackground": "#f3f4f5",
      "editor.selectionBackground": "#d8e2ff",
      "editorCursor.foreground": "#005bbf",
    },
  });
  monaco.editor.defineTheme("devstudio-dark", {
    base: "vs-dark",
    inherit: true,
    rules: [
      { token: "keyword", foreground: "8ab4f8" },
      { token: "keyword.control", foreground: "8ab4f8" },
      { token: "string", foreground: "81c995" },
      { token: "number", foreground: "f28b82" },
      { token: "constant", foreground: "f28b82" },
      { token: "comment", foreground: "9aa0a6", fontStyle: "italic" },
      { token: "type", foreground: "fdd663" },
    ],
    colors: {
      "editor.background": "#1e1e1e",
      "editorLineNumber.foreground": "#5f6368",
    },
  });
}

/** Tracks the global `.dark` class so the editor theme follows the app theme. */
function useIsDark(): boolean {
  const [dark, setDark] = useState(false);
  useEffect(() => {
    const el = document.documentElement;
    const update = () => setDark(el.classList.contains("dark"));
    update();
    const observer = new MutationObserver(update);
    observer.observe(el, { attributes: true, attributeFilter: ["class"] });
    return () => observer.disconnect();
  }, []);
  return dark;
}

export function CodeEditor({
  langId,
  code,
  onChange,
  onLanguageChange,
  onReset,
  status,
  lastSavedAt,
  collab = null,
}: {
  langId: string;
  code: string;
  onChange: (value: string) => void;
  onLanguageChange: (id: string) => void;
  onReset: () => void;
  status: SaveStatus;
  lastSavedAt: number | null;
  /**
   * When set, the editor is in live-collaboration mode: the Monaco model is
   * bound to the shared Yjs text (localStorage autosave + controlled value are
   * bypassed), the language is locked, and Reset is hidden.
   */
  collab?: { ytext: Y.Text; awareness: Awareness } | null;
}) {
  const lang = languageById(langId);
  const isDark = useIsDark();
  const [pos, setPos] = useState({ line: 1, column: 1 });
  const editorRef = useRef<EditorInstance | null>(null);
  const [editorMounted, setEditorMounted] = useState(false);
  const collabActive = collab != null;

  // Bind Monaco ⇄ Yjs once both the editor and the shared text are ready.
  useEffect(() => {
    const editor = editorRef.current;
    if (!editor || !collab?.ytext || !collab?.awareness) return;
    const model = editor.getModel();
    if (!model) return;
    const binding = new MonacoYjsBinding(
      collab.ytext,
      editor,
      model,
      collab.awareness,
    );
    return () => binding.destroy();
  }, [collab?.ytext, collab?.awareness, editorMounted]);

  // In-browser execution is Python-only (Pyodide). Other languages stay
  // editor-only until a server-side runner exists.
  const isPython = langId === "python3";
  const {
    status: runStatus,
    output,
    isBusy,
    run,
    cancel,
    clear,
  } = useRunPython();
  const [consoleOpen, setConsoleOpen] = useState(false);

  const handleRun = () => {
    setConsoleOpen(true);
    // In collab mode the live buffer lives in the bound model, not `code`.
    const source = collabActive ? (editorRef.current?.getValue() ?? code) : code;
    // Defer so the console renders even if run() somehow throws synchronously.
    setTimeout(() => run(source), 0);
  };

  const handleMount = (editor: EditorInstance) => {
    editorRef.current = editor;
    setEditorMounted(true);
    editor.onDidChangeCursorPosition((e) => {
      setPos({ line: e.position.lineNumber, column: e.position.column });
    });
  };

  return (
    <section className="flex-1 flex flex-col bg-surface-container-lowest min-w-0 min-h-0">
      {/* Editor header */}
      <div className="h-10 flex items-center justify-between px-4 bg-surface-container-low border-b border-outline-variant shrink-0">
        <LanguageSelect
          value={langId}
          onChange={onLanguageChange}
          disabled={collabActive}
        />
        <div className="flex items-center gap-3">
          {isBusy ? (
            <button
              type="button"
              onClick={cancel}
              title="Stop execution"
              className="flex items-center gap-1 text-error hover:opacity-80 transition-opacity text-label-md font-label-md"
            >
              <span className="material-symbols-outlined text-[18px]">stop_circle</span>
              <span className="hidden sm:inline">Stop</span>
            </button>
          ) : (
            <button
              type="button"
              onClick={handleRun}
              disabled={!isPython}
              title={
                isPython
                  ? "Run code (Python, in your browser)"
                  : "In-browser run supports Python only"
              }
              className="flex items-center gap-1 text-primary hover:opacity-80 transition-opacity text-label-md font-label-md disabled:opacity-40 disabled:hover:opacity-40"
            >
              <span className="material-symbols-outlined text-[18px]">play_arrow</span>
              <span className="hidden sm:inline">Run</span>
            </button>
          )}
          {!collabActive && (
            <button
              type="button"
              onClick={onReset}
              title="Reset to starter template"
              className="flex items-center gap-1 text-outline hover:text-on-surface transition-colors text-label-md font-label-md"
            >
              <span className="material-symbols-outlined text-[18px]">
                restart_alt
              </span>
              <span className="hidden sm:inline">Reset</span>
            </button>
          )}
        </div>
      </div>

      {/* Editor surface */}
      <div className="flex-1 min-h-0">
        <MonacoEditor
          height="100%"
          language={lang.monaco}
          // In collab mode the bound model owns the content — leave it
          // uncontrolled so the binding isn't fought by the `value` prop.
          value={collabActive ? undefined : code}
          theme={isDark ? "devstudio-dark" : "devstudio-light"}
          beforeMount={defineEditorThemes}
          onChange={collabActive ? undefined : (value) => onChange(value ?? "")}
          onMount={handleMount}
          options={{
            minimap: { enabled: false },
            fontSize: 14,
            fontFamily: "JetBrains Mono, monospace",
            lineNumbers: "on",
            scrollBeyondLastLine: false,
            automaticLayout: true,
            tabSize: 4,
            padding: { top: 12, bottom: 12 },
            renderLineHighlight: "all",
            smoothScrolling: true,
            cursorBlinking: "smooth",
            scrollbar: { verticalScrollbarSize: 8, horizontalScrollbarSize: 8 },
          }}
        />
      </div>

      {consoleOpen && (
        <OutputConsole
          status={runStatus}
          output={output}
          onClear={clear}
          onClose={() => setConsoleOpen(false)}
        />
      )}

      <EditorStatusBar
        status={status}
        lastSavedAt={lastSavedAt}
        line={pos.line}
        column={pos.column}
        langLabel={lang.label}
      />
    </section>
  );
}
