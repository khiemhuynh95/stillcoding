"use client";

import { useEffect, useRef, useState } from "react";
import { usePathname, useRouter } from "next/navigation";
import type { CollabPeer } from "@/hooks/useCollabSession";
import type { CollabStatus, CollabUser } from "@/lib/collab";
import {
  collabEnabled,
  createCollabSession,
  encodeSeedSnapshot,
} from "@/lib/collab";
import { storageKeys, storageRemove } from "@/lib/storage";
import { cn } from "@/lib/utils";

const STATUS_LABEL: Record<CollabStatus, string> = {
  connecting: "Connecting…",
  connected: "Live",
  disconnected: "Offline",
};

/**
 * Header control for collaboration. When not in a session it creates one
 * (seeded with the current buffer) and switches the URL into collab mode; when
 * in a session it shows live presence + the shareable link and a Leave action.
 */
export function ShareButton({
  slug,
  language,
  code,
  sessionId,
  sessionMissing = false,
  status,
  peers,
  me,
  onRename,
}: {
  slug: string;
  language: string;
  code: string;
  sessionId: string | null;
  sessionMissing?: boolean;
  status: CollabStatus;
  peers: CollabPeer[];
  me: CollabUser;
  onRename: (name: string) => void;
}) {
  const router = useRouter();
  const pathname = usePathname();
  const ref = useRef<HTMLDivElement>(null);
  const [open, setOpen] = useState(false);
  const [creating, setCreating] = useState(false);
  const [copied, setCopied] = useState(false);
  const [nameDraft, setNameDraft] = useState(me.name);

  useEffect(() => setNameDraft(me.name), [me.name]);

  // Close on outside click / Escape.
  useEffect(() => {
    if (!open) return;
    const onClick = (e: MouseEvent) => {
      if (ref.current && !ref.current.contains(e.target as Node)) setOpen(false);
    };
    const onKey = (e: KeyboardEvent) => {
      if (e.key === "Escape") setOpen(false);
    };
    document.addEventListener("mousedown", onClick);
    document.addEventListener("keydown", onKey);
    return () => {
      document.removeEventListener("mousedown", onClick);
      document.removeEventListener("keydown", onKey);
    };
  }, [open]);

  // Collaboration needs Supabase. Without it the feature is hidden entirely
  // (the rest of the app runs keyless), rather than showing a dead button.
  if (!collabEnabled) return null;

  const link =
    sessionId && typeof window !== "undefined"
      ? `${window.location.origin}${pathname}?session=${sessionId}`
      : "";

  const handleStart = async () => {
    if (creating) return;
    setCreating(true);
    try {
      const id = await createCollabSession(slug, language, encodeSeedSnapshot(code));
      if (id) {
        router.replace(`${pathname}?session=${id}`);
        setOpen(true);
      }
    } catch (err) {
      console.error(err);
    } finally {
      setCreating(false);
    }
  };

  const handleCopy = async () => {
    if (!link) return;
    try {
      await navigator.clipboard.writeText(link);
      setCopied(true);
      setTimeout(() => setCopied(false), 1500);
    } catch {
      /* clipboard blocked — the input is selectable as a fallback */
    }
  };

  const handleLeave = () => {
    // Explicit leave = forget this session, so returning doesn't re-prompt to
    // resume it (the session itself stays alive in the DB until retention).
    storageRemove(storageKeys.collabLast(slug));
    router.replace(pathname);
    setOpen(false);
  };

  // Not collaborating yet — or the session in the URL is gone (expired): show
  // the plain "Collaborate" button, which can start a fresh session.
  if (!sessionId || sessionMissing) {
    return (
      <button
        type="button"
        onClick={handleStart}
        disabled={creating}
        title="Start a live collaboration session and share the link"
        className="flex items-center gap-1 px-3 sm:px-4 py-1.5 rounded font-label-md text-label-md border border-outline-variant text-on-surface-variant hover:border-primary hover:text-on-surface transition-colors disabled:opacity-50"
      >
        <span className="material-symbols-outlined text-[18px]">group_add</span>
        <span className="hidden sm:inline">
          {creating ? "Starting…" : "Collaborate"}
        </span>
      </button>
    );
  }

  const live = status === "connected";

  return (
    <div className="relative" ref={ref}>
      <button
        type="button"
        onClick={() => setOpen((o) => !o)}
        title="Collaboration session"
        className="flex items-center gap-1.5 px-3 sm:px-4 py-1.5 rounded font-label-md text-label-md border border-primary text-primary bg-primary-tint transition-colors"
      >
        <span
          className={cn(
            "w-2 h-2 rounded-full shrink-0",
            live ? "bg-secondary animate-pulse" : "bg-outline",
          )}
        />
        <span className="hidden sm:inline">
          {live ? `Live · ${peers.length + 1}` : STATUS_LABEL[status]}
        </span>
        {/* Stacked presence dots */}
        <span className="flex -space-x-1">
          {peers.slice(0, 3).map((p) => (
            <span
              key={p.clientId}
              title={p.user.name}
              className="w-4 h-4 rounded-full border border-surface-container-lowest text-[9px] leading-4 text-center text-white font-label-md"
              style={{ backgroundColor: p.user.color }}
            >
              {p.user.name.charAt(0)}
            </span>
          ))}
        </span>
      </button>

      {open && (
        <div className="absolute right-0 mt-2 w-72 bg-surface-container-lowest border border-outline-variant rounded-lg shadow-lg z-50 overflow-hidden">
          <div className="px-3 py-2 border-b border-outline-variant flex items-center justify-between">
            <span className="text-label-md font-label-md text-on-surface-variant uppercase tracking-wider">
              Collaborating
            </span>
            <span className="text-body-sm text-on-surface-variant">
              {STATUS_LABEL[status]}
            </span>
          </div>

          {/* Shareable link */}
          <div className="p-3 border-b border-outline-variant">
            <label className="block text-body-sm text-on-surface-variant mb-1">
              Anyone with this link can edit
            </label>
            <div className="flex items-center gap-2">
              <input
                type="text"
                readOnly
                value={link}
                onFocus={(e) => e.currentTarget.select()}
                className="flex-1 min-w-0 bg-surface-variant border border-outline-variant rounded px-2 py-1.5 text-body-sm text-on-surface outline-none"
              />
              <button
                type="button"
                onClick={handleCopy}
                className="px-3 py-1.5 rounded bg-primary text-on-primary text-label-md font-label-md hover:opacity-90 shrink-0"
              >
                {copied ? "Copied" : "Copy"}
              </button>
            </div>
          </div>

          {/* Your display name */}
          <div className="p-3 border-b border-outline-variant">
            <label className="block text-body-sm text-on-surface-variant mb-1">
              Your name
            </label>
            <div className="flex items-center gap-2">
              <span
                className="w-4 h-4 rounded-full shrink-0"
                style={{ backgroundColor: me.color }}
              />
              <input
                type="text"
                value={nameDraft}
                onChange={(e) => setNameDraft(e.target.value)}
                onBlur={() => onRename(nameDraft)}
                onKeyDown={(e) => {
                  if (e.key === "Enter") e.currentTarget.blur();
                }}
                className="flex-1 min-w-0 bg-surface-container-lowest border border-outline-variant rounded px-2 py-1.5 text-body-sm text-on-surface outline-none focus:ring-2 focus:ring-primary"
              />
            </div>
          </div>

          {/* Present collaborators */}
          <div className="px-3 py-2 max-h-32 overflow-y-auto custom-scrollbar">
            {peers.length === 0 ? (
              <p className="text-body-sm text-on-surface-variant py-1">
                No one else here yet. Send the link!
              </p>
            ) : (
              peers.map((p) => (
                <div key={p.clientId} className="flex items-center gap-2 py-1">
                  <span
                    className="w-3 h-3 rounded-full shrink-0"
                    style={{ backgroundColor: p.user.color }}
                  />
                  <span className="text-body-md text-on-surface truncate">
                    {p.user.name}
                  </span>
                </div>
              ))
            )}
          </div>

          <div className="p-2 border-t border-outline-variant">
            <button
              type="button"
              onClick={handleLeave}
              className="w-full px-3 py-1.5 rounded border border-outline-variant text-label-md font-label-md text-on-surface-variant hover:border-error hover:text-error transition-colors"
            >
              Leave session
            </button>
          </div>
        </div>
      )}
    </div>
  );
}
