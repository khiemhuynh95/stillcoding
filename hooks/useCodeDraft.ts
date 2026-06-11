"use client";

import { useCallback, useEffect, useRef, useState } from "react";
import { storageGet, storageSet, storageKeys } from "@/lib/storage";

interface Draft {
  code: string;
  updatedAt: number;
}

export type SaveStatus = "idle" | "unsaved" | "saved";

const DEBOUNCE_MS = 800;

/**
 * Per-(problem, language) code draft with debounced autosave to localStorage.
 * Loads an existing draft or falls back to the generic starter template, and
 * persists any pending edits when the problem or language changes.
 */
export function useCodeDraft(slug: string, lang: string, starter: string) {
  const [code, setCodeState] = useState("");
  const [status, setStatus] = useState<SaveStatus>("idle");
  const [lastSavedAt, setLastSavedAt] = useState<number | null>(null);

  const codeRef = useRef("");
  const dirtyRef = useRef(false);
  const timer = useRef<ReturnType<typeof setTimeout> | null>(null);

  const persist = useCallback((targetSlug: string, targetLang: string, value: string) => {
    const updatedAt = Date.now();
    storageSet<Draft>(storageKeys.draft(targetSlug, targetLang), {
      code: value,
      updatedAt,
    });
    return updatedAt;
  }, []);

  // Load draft (or template) whenever the problem/language/title changes, and
  // flush any unsaved edits to the *previous* key on the way out.
  useEffect(() => {
    const existing = storageGet<Draft | null>(storageKeys.draft(slug, lang), null);
    const next =
      existing && typeof existing.code === "string"
        ? existing.code
        : starter;

    setCodeState(next);
    codeRef.current = next;
    dirtyRef.current = false;
    setLastSavedAt(existing?.updatedAt ?? null);
    setStatus(existing ? "saved" : "idle");

    return () => {
      if (timer.current) clearTimeout(timer.current);
      if (dirtyRef.current) {
        persist(slug, lang, codeRef.current);
        dirtyRef.current = false;
      }
    };
  }, [slug, lang, starter, persist]);

  // Safety net for autosave: persist pending edits if the tab is hidden or
  // closed within the debounce window (there is no manual save button).
  useEffect(() => {
    const flushIfDirty = () => {
      if (dirtyRef.current) {
        persist(slug, lang, codeRef.current);
        dirtyRef.current = false;
      }
    };
    const onVisibility = () => {
      if (document.visibilityState === "hidden") flushIfDirty();
    };
    document.addEventListener("visibilitychange", onVisibility);
    window.addEventListener("pagehide", flushIfDirty);
    return () => {
      document.removeEventListener("visibilitychange", onVisibility);
      window.removeEventListener("pagehide", flushIfDirty);
    };
  }, [slug, lang, persist]);

  const flush = useCallback(() => {
    if (timer.current) clearTimeout(timer.current);
    const updatedAt = persist(slug, lang, codeRef.current);
    dirtyRef.current = false;
    setLastSavedAt(updatedAt);
    setStatus("saved");
  }, [persist, slug, lang]);

  const setCode = useCallback(
    (value: string) => {
      setCodeState(value);
      codeRef.current = value;
      dirtyRef.current = true;
      setStatus("unsaved");
      if (timer.current) clearTimeout(timer.current);
      timer.current = setTimeout(flush, DEBOUNCE_MS);
    },
    [flush],
  );

  const resetToTemplate = useCallback(() => {
    const tpl = starter;
    setCodeState(tpl);
    codeRef.current = tpl;
    const updatedAt = persist(slug, lang, tpl);
    dirtyRef.current = false;
    setLastSavedAt(updatedAt);
    setStatus("saved");
  }, [starter, persist, slug, lang]);

  return { code, setCode, saveNow: flush, resetToTemplate, status, lastSavedAt };
}
