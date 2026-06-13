"use client";

import { useState } from "react";
import type { PracticeSection } from "@/lib/practice";
import { resolveSnippet } from "@/lib/practice";

/** One topic syntax snippet: title, optional note, and a copyable code block. */
export function SyntaxCard({
  section,
  langId,
  langLabel,
}: {
  section: PracticeSection;
  langId: string;
  langLabel: string;
}) {
  const { code, isFallback } = resolveSnippet(section, langId);
  const [copied, setCopied] = useState(false);

  const copy = async () => {
    try {
      await navigator.clipboard.writeText(code);
      setCopied(true);
      setTimeout(() => setCopied(false), 1500);
    } catch {
      /* clipboard blocked — ignore */
    }
  };

  return (
    <section className="bg-surface-container-lowest border border-outline-variant rounded-xl overflow-hidden">
      <div className="flex items-start justify-between gap-3 px-4 pt-3">
        <div>
          <h3 className="font-label-md text-label-md font-bold text-on-surface">
            {section.title}
          </h3>
          {section.note && (
            <p className="text-body-sm text-on-surface-variant mt-0.5">
              {section.note}
            </p>
          )}
        </div>
        <button
          type="button"
          onClick={copy}
          aria-label="Copy snippet"
          className="flex items-center gap-1 text-outline hover:text-on-surface transition-colors text-label-md font-label-md shrink-0"
        >
          <span className="material-symbols-outlined text-[18px]">
            {copied ? "check" : "content_copy"}
          </span>
          <span className="hidden sm:inline">{copied ? "Copied" : "Copy"}</span>
        </button>
      </div>

      {isFallback && (
        <p className="mx-4 mt-2 text-label-md text-on-surface-variant bg-surface-container rounded px-2 py-1 inline-flex items-center gap-1">
          <span className="material-symbols-outlined text-[14px]">info</span>
          Shown in Python — {langLabel} version coming soon.
        </p>
      )}

      <pre className="mt-3 px-4 pb-4 overflow-x-auto custom-scrollbar">
        <code className="font-code-md text-code-md text-on-surface whitespace-pre">
          {code}
        </code>
      </pre>
    </section>
  );
}
