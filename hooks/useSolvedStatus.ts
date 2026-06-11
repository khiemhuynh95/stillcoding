"use client";

import { useCallback } from "react";
import { useLocalStorage } from "./useLocalStorage";
import { storageKeys } from "@/lib/storage";

export type SolvedState = "solved" | "attempted";
export type SolvedMap = Record<string, SolvedState>;

/** Per-problem solved/attempted status, keyed by title_slug, in localStorage. */
export function useSolvedStatus() {
  const [map, setMap, hydrated] = useLocalStorage<SolvedMap>(
    storageKeys.solved,
    {},
  );

  const setStatus = useCallback(
    (slug: string, state: SolvedState | null) => {
      setMap((prev) => {
        const next = { ...prev };
        if (state === null) delete next[slug];
        else next[slug] = state;
        return next;
      });
    },
    [setMap],
  );

  return { map, setStatus, hydrated };
}
