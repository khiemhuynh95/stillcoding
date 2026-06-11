import type { Difficulty } from "@/lib/types";
import { cn } from "@/lib/utils";

const STYLES: Record<Difficulty, string> = {
  Easy: "bg-secondary-container/40 text-on-secondary-container",
  Medium: "bg-tertiary-fixed text-on-tertiary-fixed-variant",
  Hard: "bg-error-container text-on-error-container",
};

export function DifficultyBadge({
  difficulty,
  className,
}: {
  difficulty: Difficulty;
  className?: string;
}) {
  return (
    <span
      className={cn(
        "inline-block px-3 py-1 rounded-full text-label-md font-bold whitespace-nowrap",
        STYLES[difficulty],
        className,
      )}
    >
      {difficulty}
    </span>
  );
}
