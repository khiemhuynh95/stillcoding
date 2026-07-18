import { marked } from "marked";
import { sanitizeHtml } from "./sanitize";

/**
 * Markdown → HTML → DOMPurify. The only sanctioned path for rendering
 * markdown (marked stopped sanitizing at v8, so the sanitize step is
 * mandatory, matching the problem-HTML invariant).
 */
export function markdownToSafeHtml(markdown: string | null | undefined): string {
  if (!markdown?.trim()) return "";
  const html = marked.parse(markdown, { async: false, gfm: true }) as string;
  return sanitizeHtml(html);
}
