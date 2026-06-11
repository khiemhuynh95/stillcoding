"use client";

import { useLocalStorage } from "./useLocalStorage";
import { storageKeys } from "@/lib/storage";
import type { Difficulty } from "@/lib/types";

// Only sorts derivable from the list endpoint (no acceptance rate available).
export type SortKey = "newest" | "oldest" | "easiest" | "hardest";

export interface Filters {
  difficulties: Difficulty[];
  tag: string | null;
  sort: SortKey;
  search: string;
}

export const defaultFilters: Filters = {
  difficulties: [],
  tag: null,
  sort: "newest",
  search: "",
};

/** Filter state persisted to localStorage (restored on landing). */
export function useFilters() {
  return useLocalStorage<Filters>(storageKeys.filters, defaultFilters);
}
