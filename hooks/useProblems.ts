"use client";

import { useQuery } from "@tanstack/react-query";
import { getProblem, getProblems, getProblemsByTag } from "@/lib/leetcode";

const FIVE_MIN = 5 * 60 * 1000;

/** The full list (no tag) or a tag-filtered list, cached per key. */
export function useProblems(tag: string | null) {
  return useQuery({
    queryKey: tag ? ["problems", "tag", tag] : ["problems", "all"],
    queryFn: () => (tag ? getProblemsByTag(tag) : getProblems()),
    staleTime: FIVE_MIN,
  });
}

export function useProblem(slug: string) {
  return useQuery({
    queryKey: ["problem", slug],
    queryFn: () => getProblem(slug),
    staleTime: FIVE_MIN,
    enabled: Boolean(slug),
  });
}
