"use client";

import { useRouter } from "next/navigation";
import { useState } from "react";
import { useQueryClient } from "@tanstack/react-query";
import { getRandomProblem } from "@/lib/leetcode";
import type { ProblemSummary } from "@/lib/types";
import { cn } from "@/lib/utils";

/** Floating button that jumps to a random problem (GET /random). */
export function RandomFab() {
  const router = useRouter();
  const queryClient = useQueryClient();
  const [loading, setLoading] = useState(false);

  async function pick() {
    if (loading) return;
    setLoading(true);
    try {
      // Prefer the already-loaded merged list so custom problems are included.
      const cached = queryClient.getQueryData<ProblemSummary[]>([
        "problems",
        "all",
      ]);
      const slug =
        cached && cached.length
          ? cached[Math.floor(Math.random() * cached.length)].title_slug
          : (await getRandomProblem()).title_slug;
      router.push(`/problems/${slug}`);
    } catch {
      setLoading(false);
    }
  }

  return (
    <button
      type="button"
      onClick={pick}
      disabled={loading}
      className="fixed bottom-20 right-6 md:bottom-8 md:right-8 bg-primary text-on-primary w-14 h-14 rounded-2xl shadow-ambient flex items-center justify-center hover:scale-110 transition-transform active:scale-95 group z-40 disabled:opacity-70"
    >
      <span
        className={cn(
          "material-symbols-outlined",
          loading && "animate-spin",
        )}
      >
        {loading ? "progress_activity" : "shuffle"}
      </span>
      <span className="absolute right-full mr-4 bg-inverse-surface text-inverse-on-surface px-3 py-1 rounded-md shadow-ambient text-body-sm whitespace-nowrap opacity-0 group-hover:opacity-100 transition-opacity pointer-events-none">
        Pick a random problem
      </span>
    </button>
  );
}
