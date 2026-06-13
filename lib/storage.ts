/** SSR-safe, namespaced localStorage helpers. All keys are prefixed. */

const PREFIX = "devstudio:";

export function storageGet<T>(key: string, fallback: T): T {
  if (typeof window === "undefined") return fallback;
  try {
    const raw = window.localStorage.getItem(PREFIX + key);
    if (raw == null) return fallback;
    return JSON.parse(raw) as T;
  } catch {
    return fallback;
  }
}

export function storageSet<T>(key: string, value: T): void {
  if (typeof window === "undefined") return;
  try {
    window.localStorage.setItem(PREFIX + key, JSON.stringify(value));
  } catch {
    /* quota exceeded or storage disabled — ignore */
  }
}

export function storageRemove(key: string): void {
  if (typeof window === "undefined") return;
  try {
    window.localStorage.removeItem(PREFIX + key);
  } catch {
    /* ignore */
  }
}

/** Storage key builders, kept in one place so they stay consistent. */
export const storageKeys = {
  filters: "filters",
  solved: "solved",
  lang: "lang",
  theme: "theme",
  lists: "lists",
  draft: (slug: string, lang: string) => `draft:${slug}:${lang}`,
} as const;
