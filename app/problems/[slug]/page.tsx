"use client";

import { Suspense, useEffect, useMemo, useState } from "react";
import { useParams, useRouter, useSearchParams } from "next/navigation";
import Link from "next/link";
import { Panel, PanelGroup, PanelResizeHandle } from "react-resizable-panels";
import { TopNav } from "@/components/layout/TopNav";
import { Footer } from "@/components/layout/Footer";
import { ProblemDescription } from "@/components/coding/ProblemDescription";
import { CodeEditor } from "@/components/coding/CodeEditor";
import { SaveToList } from "@/components/coding/SaveToList";
import { ShareButton } from "@/components/coding/ShareButton";
import { SessionTimer } from "@/components/coding/SessionTimer";
import { BrownNoise } from "@/components/coding/BrownNoise";
import { useProblem } from "@/hooks/useProblems";
import { useLocalStorage } from "@/hooks/useLocalStorage";
import { useCodeDraft } from "@/hooks/useCodeDraft";
import { useCollabSession } from "@/hooks/useCollabSession";
import { useEditorTimer } from "@/hooks/useEditorTimer";
import { useSolvedStatus } from "@/hooks/useSolvedStatus";
import { collabEnabled } from "@/lib/collab";
import { storageGet, storageKeys, storageRemove, storageSet } from "@/lib/storage";
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

function CodingPage() {
  const params = useParams<{ slug: string }>();
  const slug = String(params?.slug ?? "");
  const searchParams = useSearchParams();
  const sessionId = searchParams.get("session");
  const router = useRouter();

  const collab = useCollabSession(sessionId);
  // Per-problem solo stopwatch; in a collab session the shared timer takes over
  // so everyone sees the same clock.
  const soloTimer = useEditorTimer(slug);
  const timer = collab.active ? collab.timer : soloTimer;

  const { data: detail, isLoading, isError, refetch } = useProblem(slug);
  const [lang, setLang] = useLocalStorage<string>(
    storageKeys.lang,
    DEFAULT_LANGUAGE,
  );
  // In a collab session the language is fixed by the session; otherwise use the
  // user's chosen language. (Not persisted to localStorage in collab mode.)
  const effectiveLang = collab.active ? collab.session?.language ?? lang : lang;
  // Prefer a custom problem's own starter code for the language; otherwise the
  // generic template. Memoized so the editor doesn't reset on every render.
  const starter = useMemo(
    () =>
      detail?.starterCode?.[effectiveLang] ??
      getStarterTemplate(effectiveLang, detail?.title),
    [detail, effectiveLang],
  );
  const { code, setCode, resetToTemplate, status, lastSavedAt } =
    useCodeDraft(slug, effectiveLang, starter);
  const { map: solvedMap, setStatus, hydrated } = useSolvedStatus();

  const isDesktop = useIsDesktop();
  const solved = hydrated && solvedMap[slug] === "solved";

  useEffect(() => {
    if (detail) document.title = `${detail.title} | StillCoding`;
  }, [detail]);

  // Remember the most recent live session per problem so the user can resume it
  // after navigating away; forget it once it's confirmed gone (expired).
  useEffect(() => {
    if (!sessionId) return;
    if (collab.session && !collab.sessionMissing) {
      storageSet(storageKeys.collabLast(slug), sessionId);
    } else if (collab.sessionMissing) {
      storageRemove(storageKeys.collabLast(slug));
    }
  }, [sessionId, collab.session, collab.sessionMissing, slug]);

  // When back on the problem without a ?session= link, offer to resume the
  // remembered session (unless dismissed for this visit).
  const [resumeId, setResumeId] = useState<string | null>(null);
  const [resumeDismissed, setResumeDismissed] = useState(false);
  useEffect(() => {
    if (sessionId || !collabEnabled) {
      setResumeId(null);
      return;
    }
    setResumeId(storageGet<string | null>(storageKeys.collabLast(slug), null));
  }, [sessionId, slug]);
  const showResume = !sessionId && !!resumeId && !resumeDismissed;

  const handleCodeChange = (value: string) => {
    setCode(value);
    if (hydrated && solvedMap[slug] === undefined) {
      setStatus(slug, "attempted");
    }
  };

  const actions = (
    <div className="flex items-center gap-2">
      {!sessionId && (
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
      )}
      <BrownNoise />
      <SessionTimer timer={timer} shared={collab.active} />
      <ShareButton
        slug={slug}
        language={effectiveLang}
        code={code}
        sessionId={sessionId}
        sessionMissing={collab.sessionMissing}
        status={collab.status}
        peers={collab.peers}
        me={collab.me}
        onRename={collab.setName}
      />
      <SaveToList slug={slug} />
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
      {showResume && resumeId && (
        <ResumeBanner
          onResume={() =>
            router.replace(`/problems/${slug}?session=${resumeId}`)
          }
          onDismiss={() => setResumeDismissed(true)}
        />
      )}
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
              {collab.active && collab.sessionMissing ? (
                <ExpiredSession slug={slug} />
              ) : (
                <CodeEditor
                  langId={effectiveLang}
                  code={code}
                  onChange={handleCodeChange}
                  onLanguageChange={setLang}
                  onReset={resetToTemplate}
                  status={status}
                  lastSavedAt={lastSavedAt}
                  collab={
                    collab.active && collab.ytext && collab.awareness
                      ? { ytext: collab.ytext, awareness: collab.awareness }
                      : null
                  }
                />
              )}
            </Panel>
          </PanelGroup>
        )}
      </main>
      <Footer />
    </div>
  );
}

// `useSearchParams` requires a Suspense boundary in the App Router.
export default function CodingPageWrapper() {
  return (
    <Suspense fallback={<CodingSkeleton />}>
      <CodingPage />
    </Suspense>
  );
}

/**
 * Slim bar offering to rejoin a collaboration session the user previously had
 * for this problem, shown when they return without the `?session=` link.
 */
function ResumeBanner({
  onResume,
  onDismiss,
}: {
  onResume: () => void;
  onDismiss: () => void;
}) {
  return (
    <div className="flex items-center gap-3 px-gutter lg:px-6 py-2 bg-primary-tint border-b border-outline-variant shrink-0">
      <span className="material-symbols-outlined text-[18px] text-primary">
        group
      </span>
      <span className="flex-1 text-body-sm text-on-surface">
        You have a collaboration session for this problem.
      </span>
      <button
        type="button"
        onClick={onResume}
        className="px-3 py-1 rounded bg-primary text-on-primary text-label-md font-label-md hover:opacity-90 shrink-0"
      >
        Resume
      </button>
      <button
        type="button"
        onClick={onDismiss}
        title="Dismiss"
        className="text-on-surface-variant hover:text-on-surface shrink-0"
      >
        <span className="material-symbols-outlined text-[18px]">close</span>
      </button>
    </div>
  );
}

/**
 * Shown in the editor panel when the `?session=` link points at a session that
 * no longer exists — never created, or reaped after 30 days of inactivity.
 */
function ExpiredSession({ slug }: { slug: string }) {
  const router = useRouter();
  return (
    <section className="flex-1 flex flex-col items-center justify-center text-center px-6 gap-3 bg-surface-container-lowest min-h-0">
      <span className="material-symbols-outlined text-5xl text-on-surface-variant">
        link_off
      </span>
      <p className="text-body-md text-on-surface font-semibold">
        This collaboration session has expired
      </p>
      <p className="text-body-sm text-on-surface-variant max-w-xs">
        The link is no longer active — sessions are removed after 30 days of
        inactivity. You can keep working on this problem on your own.
      </p>
      <button
        type="button"
        onClick={() => router.replace(`/problems/${slug}`)}
        className="mt-2 px-4 py-2 bg-primary text-on-primary rounded text-label-md font-label-md hover:opacity-90"
      >
        Continue solo
      </button>
    </section>
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
