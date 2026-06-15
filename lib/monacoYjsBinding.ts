/**
 * Minimal Monaco ⇄ Yjs binding.
 *
 * Why custom (not y-monaco): y-monaco imports its own `monaco-editor` npm
 * package, but this app loads Monaco lazily from a CDN via @monaco-editor/react
 * (same lazy strategy as Pyodide). Bundling a second Monaco copy would bloat the
 * build and risk a dual-instance mismatch. This binding instead drives the
 * *live* editor + model instance handed to us in `onMount`, so there is exactly
 * one Monaco. It uses only Yjs for relative positions; no Monaco namespace is
 * needed (plain IRange objects suffice for edits/decorations).
 *
 * It keeps the model text in sync with a Y.Text, preserves the local caret
 * across remote edits, and renders remote selections/cursors from awareness.
 */

import * as Y from "yjs";
import type { Awareness } from "y-protocols/awareness";
import type { CollabUser } from "./collab";

interface IPosition {
  lineNumber: number;
  column: number;
}
interface IRange {
  startLineNumber: number;
  startColumn: number;
  endLineNumber: number;
  endColumn: number;
}
interface IDisposable {
  dispose(): void;
}
export interface ITextModel {
  getValue(): string;
  setValue(value: string): void;
  getOffsetAt(p: IPosition): number;
  getPositionAt(offset: number): IPosition;
  applyEdits(edits: { range: IRange; text: string }[]): void;
  onDidChangeContent(
    cb: (e: {
      changes: { rangeOffset: number; rangeLength: number; text: string }[];
    }) => void,
  ): IDisposable;
  onWillDispose(cb: () => void): IDisposable;
}
interface ISelection {
  getStartPosition(): IPosition;
  getEndPosition(): IPosition;
}
export interface ICodeEditor {
  getModel(): ITextModel | null;
  getSelection(): ISelection | null;
  setSelection(range: IRange): void;
  onDidChangeCursorSelection(cb: () => void): IDisposable;
  deltaDecorations(
    old: string[],
    next: { range: IRange; options: Record<string, unknown> }[],
  ): string[];
}

const STYLE_EL_ID = "yjs-remote-cursors";

function ensureStyleEl(): HTMLStyleElement {
  let el = document.getElementById(STYLE_EL_ID) as HTMLStyleElement | null;
  if (!el) {
    el = document.createElement("style");
    el.id = STYLE_EL_ID;
    document.head.appendChild(el);
  }
  return el;
}

export class MonacoYjsBinding {
  private mux = false;
  private decorations: string[] = [];
  private disposers: IDisposable[] = [];
  private readonly doc: Y.Doc;
  private readonly styleEl: HTMLStyleElement;

  constructor(
    private readonly ytext: Y.Text,
    private readonly editor: ICodeEditor,
    private readonly model: ITextModel,
    private readonly awareness: Awareness,
  ) {
    this.doc = ytext.doc!;
    this.styleEl = ensureStyleEl();

    // Seed the model from the shared text (binding is authoritative).
    const initial = ytext.toString();
    if (model.getValue() !== initial) {
      this.locked(() => model.setValue(initial));
    }

    // Yjs → Monaco: apply remote text deltas, preserving the local caret.
    this.ytextObserver = this.ytextObserver.bind(this);
    ytext.observe(this.ytextObserver);

    // Monaco → Yjs: local edits become Yjs ops.
    this.disposers.push(
      model.onDidChangeContent((e) => {
        if (this.mux) return;
        this.locked(() => {
          this.doc.transact(() => {
            // Right-to-left so earlier offsets stay valid as we mutate.
            [...e.changes]
              .sort((a, b) => b.rangeOffset - a.rangeOffset)
              .forEach((c) => {
                if (c.rangeLength > 0) ytext.delete(c.rangeOffset, c.rangeLength);
                if (c.text) ytext.insert(c.rangeOffset, c.text);
              });
          }, this);
        });
      }),
    );

    this.disposers.push(model.onWillDispose(() => this.destroy()));

    // Local selection → awareness (as relative positions, edit-stable).
    this.disposers.push(
      editor.onDidChangeCursorSelection(() => {
        const sel = editor.getSelection();
        if (!sel) return;
        const anchor = model.getOffsetAt(sel.getStartPosition());
        const head = model.getOffsetAt(sel.getEndPosition());
        awareness.setLocalStateField("selection", {
          anchor: Y.createRelativePositionFromTypeIndex(ytext, anchor),
          head: Y.createRelativePositionFromTypeIndex(ytext, head),
        });
      }),
    );

    this.rerenderCursors = this.rerenderCursors.bind(this);
    awareness.on("change", this.rerenderCursors);
    this.rerenderCursors();
  }

  /** Run `fn` with the reentrancy guard held so the paired handler skips. */
  private locked(fn: () => void) {
    if (this.mux) {
      fn();
      return;
    }
    this.mux = true;
    try {
      fn();
    } finally {
      this.mux = false;
    }
  }

  private ytextObserver(event: Y.YTextEvent) {
    if (this.mux) return;
    // Remember the local selection so we can restore it after remote edits.
    const sel = this.editor.getSelection();
    const saved =
      sel != null
        ? {
            anchor: Y.createRelativePositionFromTypeIndex(
              this.ytext,
              this.model.getOffsetAt(sel.getStartPosition()),
            ),
            head: Y.createRelativePositionFromTypeIndex(
              this.ytext,
              this.model.getOffsetAt(sel.getEndPosition()),
            ),
          }
        : null;

    this.locked(() => {
      let index = 0;
      event.delta.forEach((op) => {
        if (op.retain !== undefined) {
          index += op.retain;
        } else if (op.insert !== undefined) {
          const pos = this.model.getPositionAt(index);
          const text = String(op.insert);
          this.model.applyEdits([
            {
              range: {
                startLineNumber: pos.lineNumber,
                startColumn: pos.column,
                endLineNumber: pos.lineNumber,
                endColumn: pos.column,
              },
              text,
            },
          ]);
          index += text.length;
        } else if (op.delete !== undefined) {
          const start = this.model.getPositionAt(index);
          const end = this.model.getPositionAt(index + op.delete);
          this.model.applyEdits([
            {
              range: {
                startLineNumber: start.lineNumber,
                startColumn: start.column,
                endLineNumber: end.lineNumber,
                endColumn: end.column,
              },
              text: "",
            },
          ]);
        }
      });
    });

    if (saved) {
      const a = Y.createAbsolutePositionFromRelativePosition(saved.anchor, this.doc);
      const h = Y.createAbsolutePositionFromRelativePosition(saved.head, this.doc);
      if (a && h) {
        const ap = this.model.getPositionAt(a.index);
        const hp = this.model.getPositionAt(h.index);
        this.editor.setSelection({
          startLineNumber: ap.lineNumber,
          startColumn: ap.column,
          endLineNumber: hp.lineNumber,
          endColumn: hp.column,
        });
      }
    }
    this.rerenderCursors();
  }

  private rerenderCursors() {
    const next: { range: IRange; options: Record<string, unknown> }[] = [];
    const rules: string[] = [];

    this.awareness.getStates().forEach((state, clientId) => {
      if (clientId === this.doc.clientID) return;
      const s = state as {
        selection?: { anchor: Y.RelativePosition; head: Y.RelativePosition };
        user?: CollabUser;
      };
      if (!s.selection?.anchor || !s.selection?.head) return;
      const anchor = Y.createAbsolutePositionFromRelativePosition(
        s.selection.anchor,
        this.doc,
      );
      const head = Y.createAbsolutePositionFromRelativePosition(
        s.selection.head,
        this.doc,
      );
      if (!anchor || !head || anchor.type !== this.ytext || head.type !== this.ytext)
        return;

      const color = s.user?.color ?? "#888888";
      const name = (s.user?.name ?? "Anon").replace(/["\\]/g, "");
      const lo = Math.min(anchor.index, head.index);
      const hi = Math.max(anchor.index, head.index);
      const sp = this.model.getPositionAt(lo);
      const ep = this.model.getPositionAt(hi);
      const headPos = this.model.getPositionAt(head.index);

      if (hi > lo) {
        next.push({
          range: {
            startLineNumber: sp.lineNumber,
            startColumn: sp.column,
            endLineNumber: ep.lineNumber,
            endColumn: ep.column,
          },
          options: { className: `yRemoteSelection-${clientId}` },
        });
      }
      // Zero-width caret at the head, drawn via a ::before element.
      next.push({
        range: {
          startLineNumber: headPos.lineNumber,
          startColumn: headPos.column,
          endLineNumber: headPos.lineNumber,
          endColumn: headPos.column,
        },
        options: {
          className: `yRemoteCaret-${clientId}`,
          beforeContentClassName: `yRemoteCaret-${clientId}`,
          hoverMessage: { value: name },
        },
      });

      rules.push(
        `.yRemoteSelection-${clientId}{background-color:${color}40;}`,
        `.yRemoteCaret-${clientId}{border-left:2px solid ${color};margin-left:-1px;}`,
      );
    });

    this.decorations = this.editor.deltaDecorations(this.decorations, next);
    this.styleEl.textContent = rules.join("\n");
  }

  destroy() {
    this.ytext.unobserve(this.ytextObserver);
    this.awareness.off("change", this.rerenderCursors);
    this.disposers.forEach((d) => d.dispose());
    this.disposers = [];
    this.decorations = this.editor.deltaDecorations(this.decorations, []);
    this.styleEl.textContent = "";
  }
}
