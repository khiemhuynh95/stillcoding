/**
 * Warms the Monaco editor chunk so it's already downloaded by the time the user
 * lands on a coding page. Kept in its own module (rather than re-exported from
 * CodeEditor) so importing it doesn't pull the editor's module graph into the
 * browse bundle — only the lazy `@monaco-editor/react` chunk is fetched, and
 * webpack shares it with CodeEditor's own dynamic import.
 */
let warmed = false;
export function prefetchEditor() {
  if (warmed) return;
  warmed = true;
  void import("@monaco-editor/react");
}
