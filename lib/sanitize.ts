import DOMPurify from "isomorphic-dompurify";

/** Sanitize untrusted HTML (problem content/hints) before rendering. */
export function sanitizeHtml(html: string | null | undefined): string {
  if (!html) return "";
  return DOMPurify.sanitize(html, { ADD_ATTR: ["target", "rel"] });
}
