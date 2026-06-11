"use client";

import { useEffect, useMemo, useState } from "react";
import { useParams } from "next/navigation";
import Link from "next/link";
import { Panel, PanelGroup, PanelResizeHandle } from "react-resizable-panels";
import { TopNav } from "@/components/layout/TopNav";
import { Footer } from "@/components/layout/Footer";
import { ProblemDescription } from "@/components/coding/ProblemDescription";
import { CodeEditor } from "@/components/coding/CodeEditor";
import { useProblem } from "@/hooks/useProblems";
import { useLocalStorage } from "@/hooks/useLocalStorage";
import { useCodeDraft } from "@/hooks/useCodeDraft";
import { useSolvedStatus } from "@/hooks/useSolvedStatus";
import { storageKeys } from "@/lib/storage";
import { DEFAULT_LANGUAGE, getStarterTemplate } from "@/lib/starterTemplates";
import { cn } from "@/lib/utils";

function useIsDesktop(): boolean {
  const [desktop, setDesktop] = useState(false);
  useEffect(() => {
    const mq = window.matchMedia("(min-width: 1024px)");
    const update = () => setDesktop(mq.matches);
    update();
    mq.addEventListener("change", update);
    return () => mq.removeEventListener("change", update);
  }, []);
  return desktop;
}

export default function CodingPage() {
  const params = useParams<{ slug: string }>();
  const slug = String(params?.slug ?? "");

  const { data: detail, isLoading, isError, refetch } = useProblem(slug);
  const [lang, setLang] = useLocalStorage<string>(
    storageKeys.lang,
    DEFAULT_LANGUAGE,
  );
  // Prefer a custom problem's own starter code for the language; otherwise the
  // generic template. Memoized so the editor doesn't reset on every render.
  const starter = useMemo(
    () => detail?.starterCode?.[lang] ?? getStarterTemplate(lang, detail?.title),
    [detail, lang],
  );
  const { code, setCode, resetToTemplate, status, lastSavedAt } =
    useCodeDraft(slug, lang, starter);
  const { map: solvedMap, setStatus, hydrated } = useSolvedStatus();

  const isDesktop = useIsDesktop();
  const solved = hydrated && solvedMap[slug] === "solved";

  useEffect(() => {
    if (detail) document.title = `${detail.title} | StillCoding`;
  }, [detail]);

  const handleCodeChange = (value: string) => {
    setCode(value);
    if (hydrated && solvedMap[slug] === undefined) {
      setStatus(slug, "attempted");
    }
  };

  const actions = (
    <div className="flex items-center gap-2">
      <span
        className="flex items-center gap-1 px-2 text-label-md text-on-surface-variant"
        title="Your code auto-saves to this browser"
      >
        <span className="material-symbols-outlined text-[18px]">
          {status === "unsaved" ? "sync" : "cloud_done"}
        </span>
        <span className="hidden sm:inline">
          {status === "unsaved" ? "Saving…" : "Saved"}
        </span>
      </span>
      <button
        type="button"
        onClick={() => setStatus(slug, solved ? null : "solved")}
        className={cn(
          "flex items-center gap-1 px-3 sm:px-4 py-1.5 rounded font-label-md text-label-md transition-all",
          solved
            ? "bg-secondary text-on-secondary hover:opacity-90"
            : "bg-primary text-on-primary hover:opacity-90",
        )}
      >
        <span className="material-symbols-outlined text-[18px]">
          {solved ? "check_circle" : "done"}
        </span>
        <span className="hidden sm:inline">
          {solved ? "Solved" : "Mark Solved"}
        </span>
      </button>
    </div>
  );

  const direction = isDesktop ? "horizontal" : "vertical";

  return (
    <div className="h-screen flex flex-col">
      <TopNav actions={actions} />
      <main className="flex flex-1 overflow-hidden">
        {isLoading ? (
          <CodingSkeleton />
        ) : isError || !detail ? (
          <CodingError onRetry={() => refetch()} />
        ) : (
          <PanelGroup key={direction} direction={direction} className="flex-1">
            <Panel defaultSize={50} minSize={20} className="flex flex-col min-h-0">
              <div className="flex-1 overflow-y-auto custom-scrollbar bg-surface-container-lowest p-gutter lg:p-6">
                <ProblemDescription detail={detail} />
              </div>
            </Panel>
            <PanelResizeHandle
              className={cn(
                "bg-outline-variant/40 hover:bg-primary/50 transition-colors shrink-0",
                direction === "horizontal"
                  ? "w-1.5 cursor-col-resize"
                  : "h-1.5 cursor-row-resize",
              )}
            />
            <Panel defaultSize={50} minSize={20} className="flex flex-col min-h-0">
              <CodeEditor
                langId={lang}
                code={code}
                onChange={handleCodeChange}
                onLanguageChange={setLang}
                onReset={resetToTemplate}
                status={status}
                lastSavedAt={lastSavedAt}
              />
            </Panel>
          </PanelGroup>
        )}
      </main>
      <Footer />
    </div>
  );
}

function CodingSkeleton() {
  return (
    <div className="flex-1 flex items-center justify-center">
      <div className="flex items-center gap-2 text-on-surface-variant">
        <span className="material-symbols-outlined animate-spin">
          progress_activity
        </span>
        Loading problem…
      </div>
    </div>
  );
}

function CodingError({ onRetry }: { onRetry: () => void }) {
  return (
    <div className="flex-1 flex flex-col items-center justify-center text-center px-6 gap-3">
      <span className="material-symbols-outlined text-5xl text-error">
        cloud_off
      </span>
      <p className="text-body-md text-on-surface font-semibold">
        Couldn&apos;t load this problem
      </p>
      <div className="flex items-center gap-3 mt-2">
        <button
          type="button"
          onClick={onRetry}
          className="px-4 py-2 bg-primary text-on-primary rounded text-label-md font-label-md hover:opacity-90"
        >
          Retry
        </button>
        <Link
          href="/"
          className="px-4 py-2 border border-outline-variant rounded text-label-md font-label-md hover:border-primary"
        >
          Back to browse
        </Link>
      </div>
    </div>
  );
}
