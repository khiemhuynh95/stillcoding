"use client";

import { useLocalStorage } from "./useLocalStorage";
import { storageKeys } from "@/lib/storage";
import type { Difficulty } from "@/lib/types";

// Only sorts derivable from the list endpoint (no acceptance rate available).
export type SortKey = "newest" | "oldest" | "easiest" | "hardest";

export interface Filters {
  difficulties: Difficulty[];
  tag: string | null;
  /** Active problem list id (preset like "blind-75" or "user:..."), or null. */
  list: string | null;
  sort: SortKey;
  search: string;
}

export const defaultFilters: Filters = {
  difficulties: [],
  tag: null,
  list: null,
  sort: "newest",
  search: "",
};

/** Filter state persisted to localStorage (restored on landing). */
export function useFilters() {
  return useLocalStorage<Filters>(storageKeys.filters, defaultFilters);
}
