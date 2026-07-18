"use client";

import { useEffect, useMemo, useState } from "react";
import { DifficultyBadge } from "@/components/browse/DifficultyBadge";
import { ProblemPicker } from "@/components/course/ProblemPicker";
import { useProblems } from "@/hooks/useProblems";
import { useWeekMutations } from "@/hooks/useCourses";
import type { CourseWeek } from "@/lib/types";

/** One week's admin editor: rename/delete, add/remove/reorder problems. */
export function WeekEditor({
  week,
  courseId,
}: {
  week: CourseWeek;
  courseId: string;
}) {
  const { data: problems } = useProblems(null);
  const { rename, remove, setMaterial, addProblem, removeProblem, reorder } =
    useWeekMutations(courseId);

  const [title, setTitle] = useState(week.title);
  const [materialOpen, setMaterialOpen] = useState(false);
  const [material, setMaterialDraft] = useState(week.material);

  // Resync the draft when the saved value refreshes (post-save invalidation).
  useEffect(() => setMaterialDraft(week.material), [week.material]);

  const problemsBySlug = useMemo(() => {
    const map = new Map(problems?.map((p) => [p.title_slug, p]) ?? []);
    return map;
  }, [problems]);

  const excludeSlugs = useMemo(
    () => new Set(week.problems.map((p) => p.titleSlug)),
    [week.problems],
  );

  const move = (index: number, delta: -1 | 1) => {
    const ids = week.problems.map((p) => p.id);
    const target = index + delta;
    if (target < 0 || target >= ids.length) return;
    [ids[index], ids[target]] = [ids[target], ids[index]];
    reorder.mutate(ids);
  };

  return (
    <section className="bg-surface-container-lowest border border-outline-variant rounded-lg p-4 flex flex-col gap-3">
      <div className="flex items-center gap-2 group">
        <input
          type="text"
          value={title}
          onChange={(e) => setTitle(e.target.value)}
          onKeyDown={(e) => {
            if (e.key === "Enter") {
              e.preventDefault();
              e.currentTarget.blur(); // commit via onBlur
            } else if (e.key === "Escape") {
              setTitle(week.title);
              e.currentTarget.blur();
            }
          }}
          onBlur={() => {
            const next = title.trim();
            if (next && next !== week.title) {
              rename.mutate({ weekId: week.id, title: next });
            } else {
              setTitle(week.title);
            }
          }}
          title="Click to rename — Enter saves, Esc cancels"
          className="flex-1 min-w-0 bg-transparent border-b border-transparent hover:border-outline-variant focus:border-primary text-body-md font-bold text-on-surface outline-none transition-colors"
          aria-label="Week title"
        />
        <span
          className="material-symbols-outlined text-[16px] text-on-surface-variant/50 group-focus-within:text-primary pointer-events-none"
          aria-hidden
        >
          edit
        </span>
        <button
          type="button"
          onClick={() => {
            if (
              window.confirm(
                `Delete "${week.title}" and its ${week.problems.length} problem(s)?`,
              )
            ) {
              remove.mutate(week.id);
            }
          }}
          className="material-symbols-outlined text-[20px] text-on-surface-variant hover:text-error transition-colors"
          aria-label={`Delete ${week.title}`}
        >
          delete
        </button>
      </div>

      {week.problems.length > 0 && (
        <div className="border border-outline-variant rounded divide-y divide-outline-variant overflow-hidden">
          {week.problems.map((ref, index) => {
            const problem = problemsBySlug.get(ref.titleSlug);
            return (
              <div key={ref.id} className="flex items-center gap-2 px-3 py-2">
                <div className="flex flex-col shrink-0">
                  <button
                    type="button"
                    onClick={() => move(index, -1)}
                    disabled={index === 0}
                    className="material-symbols-outlined text-[16px] leading-none text-on-surface-variant hover:text-on-surface disabled:opacity-20"
                    aria-label="Move up"
                  >
                    keyboard_arrow_up
                  </button>
                  <button
                    type="button"
                    onClick={() => move(index, 1)}
                    disabled={index === week.problems.length - 1}
                    className="material-symbols-outlined text-[16px] leading-none text-on-surface-variant hover:text-on-surface disabled:opacity-20"
                    aria-label="Move down"
                  >
                    keyboard_arrow_down
                  </button>
                </div>
                <span className="w-10 shrink-0 text-body-sm tabular-nums text-on-surface-variant">
                  {problem?.frontend_id ?? "?"}
                </span>
                <span className="flex-1 truncate text-body-sm text-on-surface">
                  {problem?.title ?? ref.titleSlug}
                </span>
                {problem && (
                  <DifficultyBadge
                    difficulty={problem.difficulty}
                    className="hidden sm:inline-block scale-90"
                  />
                )}
                <button
                  type="button"
                  onClick={() => removeProblem.mutate(ref.id)}
                  className="material-symbols-outlined text-[18px] text-on-surface-variant hover:text-error transition-colors"
                  aria-label={`Remove ${problem?.title ?? ref.titleSlug}`}
                >
                  close
                </button>
              </div>
            );
          })}
        </div>
      )}

      <ProblemPicker
        excludeSlugs={excludeSlugs}
        disabled={addProblem.isPending}
        onPick={(titleSlug) =>
          addProblem.mutate({
            weekId: week.id,
            titleSlug,
            position: week.problems.length,
          })
        }
      />

      <div className="flex flex-col gap-2">
        <button
          type="button"
          onClick={() => setMaterialOpen((open) => !open)}
          className="flex items-center gap-1.5 self-start text-label-md font-label-md text-on-surface-variant hover:text-on-surface transition-colors"
          aria-expanded={materialOpen}
        >
          <span className="material-symbols-outlined text-[16px]" aria-hidden>
            menu_book
          </span>
          Study material
          <span className="text-on-surface-variant/60">
            {week.material.trim() ? "· added" : "· empty"}
          </span>
          <span
            className="material-symbols-outlined text-[16px]"
            aria-hidden
          >
            {materialOpen ? "expand_less" : "expand_more"}
          </span>
        </button>
        {materialOpen && (
          <>
            <textarea
              value={material}
              onChange={(e) => setMaterialDraft(e.target.value)}
              rows={8}
              placeholder="Markdown supported — headings, lists, links, code blocks…"
              className="w-full bg-surface-container border border-outline-variant rounded px-3 py-2 text-body-sm font-mono text-on-surface placeholder:text-on-surface-variant/60 outline-none focus:ring-2 focus:ring-primary resize-y"
              aria-label={`Study material for ${week.title}`}
            />
            <div className="flex items-center gap-3">
              <button
                type="button"
                onClick={() =>
                  setMaterial.mutate({
                    weekId: week.id,
                    material: material.trim(),
                  })
                }
                disabled={
                  setMaterial.isPending || material.trim() === week.material
                }
                className="self-start px-4 py-1.5 rounded-full bg-primary text-on-primary text-label-md font-label-md disabled:opacity-40 transition-opacity"
              >
                {setMaterial.isPending ? "Saving…" : "Save material"}
              </button>
              <span className="text-body-sm text-on-surface-variant">
                Shown to members as a &ldquo;Study material&rdquo; link on the
                week. Clear and save to remove.
              </span>
            </div>
          </>
        )}
      </div>
    </section>
  );
}
