"use client";

import { useEffect, useRef, useState } from "react";
import { useBrownNoise } from "@/hooks/useBrownNoise";
import { cn } from "@/lib/utils";

/**
 * Editor-header control for brown-noise focus audio. Mounted only on the coding
 * page, so playback stops automatically when the user navigates away (the hook
 * tears down its audio graph on unmount). The popover exposes a volume slider
 * and an auto-play preference that persists across sessions.
 */
export function BrownNoise() {
  const { playing, toggle, volume, setVolume, tone, setTone, autoPlay, setAutoPlay } =
    useBrownNoise();
  const [open, setOpen] = useState(false);
  const ref = useRef<HTMLDivElement>(null);

  // Close on outside click or Escape.
  useEffect(() => {
    if (!open) return;
    const onClick = (e: MouseEvent) => {
      if (ref.current && !ref.current.contains(e.target as Node)) {
        setOpen(false);
      }
    };
    const onKey = (e: KeyboardEvent) => {
      if (e.key === "Escape") setOpen(false);
    };
    document.addEventListener("mousedown", onClick);
    document.addEventListener("keydown", onKey);
    return () => {
      document.removeEventListener("mousedown", onClick);
      document.removeEventListener("keydown", onKey);
    };
  }, [open]);

  const pct = Math.round(volume * 100);

  return (
    <div className="relative" ref={ref}>
      <div
        className={cn(
          "flex items-center rounded border transition-colors",
          playing
            ? "border-primary text-primary bg-primary-tint"
            : "border-outline-variant text-on-surface-variant",
        )}
      >
        <button
          type="button"
          onClick={toggle}
          title={playing ? "Pause brown noise" : "Play brown noise"}
          className="flex items-center gap-1 pl-3 pr-2 py-1.5 font-label-md text-label-md hover:text-on-surface"
        >
          <span className="material-symbols-outlined text-[18px]">
            {playing ? "graphic_eq" : "noise_aware"}
          </span>
          <span className="hidden sm:inline">
            {playing ? "Noise on" : "Noise"}
          </span>
        </button>
        <button
          type="button"
          onClick={() => setOpen((o) => !o)}
          title="Brown noise settings"
          aria-label="Brown noise settings"
          className="px-1.5 py-1.5 border-l border-current/20 hover:text-on-surface"
        >
          <span className="material-symbols-outlined text-[18px]">
            {open ? "expand_less" : "expand_more"}
          </span>
        </button>
      </div>

      {open && (
        <div className="absolute right-0 mt-2 w-64 bg-surface-container-lowest border border-outline-variant rounded-lg shadow-lg z-50 overflow-hidden">
          <div className="px-3 py-2 border-b border-outline-variant">
            <span className="text-label-md font-label-md text-on-surface-variant uppercase tracking-wider">
              Brown noise
            </span>
          </div>

          <div className="p-3 flex flex-col gap-3">
            <label className="flex flex-col gap-1.5">
              <span className="flex items-center justify-between text-body-sm text-on-surface">
                <span>Volume</span>
                <span className="tabular-nums text-on-surface-variant">
                  {pct}%
                </span>
              </span>
              <input
                type="range"
                min={0}
                max={100}
                value={pct}
                onChange={(e) => setVolume(Number(e.target.value) / 100)}
                className="w-full accent-primary cursor-pointer"
              />
            </label>

            <label className="flex flex-col gap-1.5">
              <span className="flex items-center justify-between text-body-sm text-on-surface">
                <span>Tone</span>
                <span className="tabular-nums text-on-surface-variant">
                  {tone <= 333 ? "Dark" : tone >= 666 ? "Bright" : "Calm"}
                </span>
              </span>
              <input
                type="range"
                min={200}
                max={800}
                step={10}
                value={tone}
                onChange={(e) => setTone(Number(e.target.value))}
                className="w-full accent-primary cursor-pointer"
              />
            </label>

            <label className="flex items-center gap-3 cursor-pointer">
              <input
                type="checkbox"
                checked={autoPlay}
                onChange={(e) => setAutoPlay(e.target.checked)}
                className="w-4 h-4 rounded-sm accent-primary cursor-pointer shrink-0"
              />
              <span className="flex-1 text-body-md text-on-surface">
                Auto-play on the editor
              </span>
            </label>
          </div>
        </div>
      )}
    </div>
  );
}
