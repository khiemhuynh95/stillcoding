"use client";

import { useCallback, useEffect, useState } from "react";
import { storageGet, storageSet } from "@/lib/storage";

/**
 * SSR-safe localStorage-backed state. Renders `initialValue` on the server and
 * first client paint, then hydrates from storage in an effect. The returned
 * `hydrated` flag lets callers defer storage-dependent UI to avoid mismatches.
 */
export function useLocalStorage<T>(key: string, initialValue: T) {
  const [value, setValue] = useState<T>(initialValue);
  const [hydrated, setHydrated] = useState(false);

  useEffect(() => {
    setValue(storageGet<T>(key, initialValue));
    setHydrated(true);
    // initialValue intentionally excluded: only re-read when the key changes.
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [key]);

  const set = useCallback(
    (next: T | ((prev: T) => T)) => {
      setValue((prev) => {
        const resolved =
          typeof next === "function" ? (next as (p: T) => T)(prev) : next;
        storageSet(key, resolved);
        return resolved;
      });
    },
    [key],
  );

  return [value, set, hydrated] as const;
}
