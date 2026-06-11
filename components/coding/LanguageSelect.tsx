"use client";

import { LANGUAGES } from "@/lib/starterTemplates";

export function LanguageSelect({
  value,
  onChange,
}: {
  value: string;
  onChange: (id: string) => void;
}) {
  return (
    <div className="flex items-center gap-1.5 px-2 py-0.5 bg-surface-container-highest rounded-full text-on-surface-variant font-label-md text-label-md">
      <span className="material-symbols-outlined text-[16px]">code</span>
      <select
        value={value}
        onChange={(e) => onChange(e.target.value)}
        aria-label="Select language"
        className="bg-transparent outline-none cursor-pointer text-on-surface pr-1"
      >
        {LANGUAGES.map((l) => (
          <option
            key={l.id}
            value={l.id}
            className="bg-surface-container-highest text-on-surface"
          >
            {l.label}
          </option>
        ))}
      </select>
    </div>
  );
}
