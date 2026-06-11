"use client";

import { cn } from "@/lib/utils";

export function SearchBar({
  value,
  onChange,
  placeholder = "Search problems by title or number...",
  className,
}: {
  value: string;
  onChange: (value: string) => void;
  placeholder?: string;
  className?: string;
}) {
  return (
    <div
      className={cn(
        "flex items-center bg-surface-container-low px-3 py-1.5 rounded border border-outline-variant focus-within:ring-2 focus-within:ring-primary transition-all",
        className,
      )}
    >
      <span className="material-symbols-outlined text-on-surface-variant mr-2">
        search
      </span>
      <input
        type="text"
        value={value}
        onChange={(e) => onChange(e.target.value)}
        placeholder={placeholder}
        className="bg-transparent border-none outline-none text-body-sm font-body-sm w-full text-on-surface placeholder:text-on-surface-variant"
      />
      {value && (
        <button
          type="button"
          onClick={() => onChange("")}
          aria-label="Clear search"
          className="material-symbols-outlined text-on-surface-variant hover:text-on-surface text-[18px]"
        >
          close
        </button>
      )}
    </div>
  );
}
