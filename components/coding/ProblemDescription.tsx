"use client";

import type { ProblemDetail } from "@/lib/types";
import { ProblemHeader } from "./ProblemHeader";
import { sanitizeHtml } from "@/lib/sanitize";

export function ProblemDescription({ detail }: { detail: ProblemDetail }) {
  const html = sanitizeHtml(detail.content);

  return (
    <div className="space-y-6">
      <ProblemHeader detail={detail} />
      {html ? (
        <div
          className="problem-content"
          dangerouslySetInnerHTML={{ __html: html }}
        />
      ) : (
        <div className="bg-tertiary-container/10 border border-tertiary-container/40 rounded-lg p-5 flex flex-col items-start gap-2">
          <span className="material-symbols-outlined text-tertiary text-3xl">lock</span>
          <p className="text-body-md text-on-surface font-semibold">
            {detail.isPaidOnly
              ? "This is a LeetCode Premium problem"
              : "Description unavailable"}
          </p>
          <p className="text-body-sm text-on-surface-variant">
            The full statement isn&apos;t available through the public API. You
            can still pick a language and draft a solution, or read it on
            LeetCode.
          </p>
          <a
            href={detail.url}
            target="_blank"
            rel="noreferrer"
            className="mt-1 flex items-center gap-1 text-label-md font-label-md text-primary hover:underline"
          >
            <span className="material-symbols-outlined text-[16px]">open_in_new</span>
            Open on LeetCode
          </a>
        </div>
      )}
    </div>
  );
}
