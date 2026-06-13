"use client";

import { useEffect } from "react";
import { useParams, notFound } from "next/navigation";
import Link from "next/link";
import { TopNav } from "@/components/layout/TopNav";
import { MobileNav } from "@/components/layout/MobileNav";
import { LanguageSelect } from "@/components/coding/LanguageSelect";
import { SyntaxCard } from "@/components/practice/SyntaxCard";
import { useLocalStorage } from "@/hooks/useLocalStorage";
import { storageKeys } from "@/lib/storage";
import { DEFAULT_LANGUAGE, languageById } from "@/lib/starterTemplates";
import { ROADMAP } from "@/lib/roadmap";
import { getPractice } from "@/lib/practice";

export default function PracticePage() {
  const params = useParams<{ topic: string }>();
  const topicId = String(params?.topic ?? "");

  const node = ROADMAP.find((n) => n.id === topicId);
  const practice = getPractice(topicId);

  // Shares the editor's language preference, so the cheat sheet matches the
  // language they code in.
  const [lang, setLang] = useLocalStorage<string>(
    storageKeys.lang,
    DEFAULT_LANGUAGE,
  );

  useEffect(() => {
    if (node) document.title = `${node.title} · Syntax | StillCoding`;
  }, [node]);

  // Unknown topic, or one without authored content yet → 404.
  if (!node || !practice) notFound();

  const langLabel = languageById(lang).label;
  const firstProblem = node.problems[0];

  return (
    <div className="h-screen flex flex-col">
      <TopNav />
      <main className="flex-1 overflow-y-auto custom-scrollbar p-gutter lg:p-8 pb-28">
        <div className="max-w-3xl mx-auto">
          <Link
            href="/roadmap"
            className="inline-flex items-center gap-1 text-label-md font-label-md text-on-surface-variant hover:text-on-surface mb-4"
          >
            <span className="material-symbols-outlined text-[18px]">
              arrow_back
            </span>
            Roadmap
          </Link>

          <header className="mb-6">
            <div className="flex items-start justify-between gap-4 flex-wrap">
              <div>
                <p className="text-label-md font-label-md text-primary uppercase tracking-wide">
                  Syntax review
                </p>
                <h1 className="font-headline-sm text-headline-sm text-on-surface mt-0.5">
                  {node.title}
                </h1>
              </div>
              <LanguageSelect value={lang} onChange={setLang} />
            </div>
            <p className="text-body-md text-on-surface-variant mt-3">
              {practice.summary}
            </p>
          </header>

          <div className="flex flex-col gap-4">
            {practice.sections.map((section) => (
              <SyntaxCard
                key={section.title}
                section={section}
                langId={lang}
                langLabel={langLabel}
              />
            ))}
          </div>

          <div className="mt-8 flex items-center gap-3 flex-wrap">
            {firstProblem && (
              <Link
                href={`/problems/${firstProblem}`}
                className="inline-flex items-center gap-1.5 px-5 py-2.5 bg-primary text-on-primary rounded text-label-md font-label-md hover:opacity-90"
              >
                <span className="material-symbols-outlined text-[18px]">
                  play_arrow
                </span>
                Start solving {node.title}
              </Link>
            )}
            <Link
              href="/roadmap"
              className="inline-flex items-center px-5 py-2.5 border border-outline-variant rounded text-label-md font-label-md text-on-surface hover:border-primary"
            >
              Back to roadmap
            </Link>
          </div>
        </div>
      </main>
      <MobileNav />
    </div>
  );
}
