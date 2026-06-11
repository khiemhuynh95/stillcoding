"use client";

import { useState } from "react";
import type { ProblemDetail } from "@/lib/types";
import { DifficultyBadge } from "@/components/browse/DifficultyBadge";
import { sanitizeHtml } from "@/lib/sanitize";

export function ProblemHeader({ detail }: { detail: ProblemDetail }) {
  const [showHints, setShowHints] = useState(false);
  const acRate = detail.parsedStats?.acRate;

  return (
    <div className="space-y-4">
      <h1 className="font-headline-sm text-headline-sm text-on-surface">
        {detail.questionFrontendId}. {detail.title}
      </h1>

      <div className="flex flex-wrap items-center gap-3">
        <DifficultyBadge difficulty={detail.difficulty} />
        {acRate && (
          <span className="flex items-center gap-1 text-label-md text-on-surface-variant">
            <span className="material-symbols-outlined text-[16px]">analytics</span>
            {acRate} acceptance
          </span>
        )}
        <span className="flex items-center gap-1 text-label-md text-on-surface-variant">
          <span className="material-symbols-outlined text-[16px]">thumb_up</span>
          {detail.likes.toLocaleString()}
        </span>
        {detail.source === "custom" ? (
          <span className="flex items-center gap-1 text-label-md font-label-md text-on-secondary-container bg-secondary-container/40 px-2 py-0.5 rounded-full">
            <span className="material-symbols-outlined text-[16px]">edit_note</span>
            Custom problem
          </span>
        ) : (
          detail.url && (
            <a
              href={detail.url}
              target="_blank"
              rel="noreferrer"
              className="flex items-center gap-1 text-label-md text-primary hover:underline"
            >
              <span className="material-symbols-outlined text-[16px]">open_in_new</span>
              View on LeetCode
            </a>
          )
        )}
      </div>

      {detail.topicTags.length > 0 && (
        <div className="flex flex-wrap gap-2">
          {detail.topicTags.map((t) => (
            <span
              key={t.name}
              className="bg-surface-container-highest px-3 py-1 rounded-full text-label-md font-label-md text-on-surface"
            >
              {t.name}
            </span>
          ))}
        </div>
      )}

      {detail.hints.length > 0 && (
        <div className="bg-secondary-container/20 rounded-lg border border-secondary-container/50 overflow-hidden">
          <button
            type="button"
            onClick={() => setShowHints((s) => !s)}
            className="flex items-center gap-2 w-full px-4 py-2 text-label-md font-label-md text-on-secondary-container"
          >
            <span className="material-symbols-outlined text-[18px]">
              {showHints ? "expand_less" : "lightbulb"}
            </span>
            {showHints
              ? "Hide hints"
              : `Show ${detail.hints.length} hint${detail.hints.length > 1 ? "s" : ""}`}
          </button>
          {showHints && (
            <ol className="list-decimal ml-8 mr-4 pb-4 space-y-2">
              {detail.hints.map((hint, i) => (
                <li
                  key={i}
                  className="text-body-sm text-on-surface-variant problem-content"
                  dangerouslySetInnerHTML={{ __html: sanitizeHtml(hint) }}
                />
              ))}
            </ol>
          )}
        </div>
      )}
    </div>
  );
}
