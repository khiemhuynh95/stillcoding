"use client";

import { useCallback } from "react";
import { useLocalStorage } from "./useLocalStorage";
import { storageKeys } from "@/lib/storage";
import { USER_LIST_PREFIX, type ProblemList } from "@/lib/lists";

/** A user-created list, stored in localStorage. Shares ProblemList's shape. */
export interface UserList extends ProblemList {
  preset: false;
  createdAt: number;
}

function newId(): string {
  return `${USER_LIST_PREFIX}${Date.now().toString(36)}${Math.random()
    .toString(36)
    .slice(2, 6)}`;
}

/**
 * The user's own problem lists (CRUD), persisted to localStorage. Preset lists
 * live in lib/lists.ts and are not managed here.
 */
export function useLists() {
  const [lists, setLists, hydrated] = useLocalStorage<UserList[]>(
    storageKeys.lists,
    [],
  );

  const createList = useCallback(
    (name: string): string => {
      const id = newId();
      const list: UserList = {
        id,
        name: name.trim() || "Untitled list",
        slugs: [],
        preset: false,
        createdAt: Date.now(),
      };
      setLists((prev) => [...prev, list]);
      return id;
    },
    [setLists],
  );

  const renameList = useCallback(
    (id: string, name: string) => {
      setLists((prev) =>
        prev.map((l) =>
          l.id === id ? { ...l, name: name.trim() || l.name } : l,
        ),
      );
    },
    [setLists],
  );

  const deleteList = useCallback(
    (id: string) => {
      setLists((prev) => prev.filter((l) => l.id !== id));
    },
    [setLists],
  );

  /** Add or remove a problem slug from a list (toggles by default). */
  const toggleProblem = useCallback(
    (id: string, slug: string, include?: boolean) => {
      setLists((prev) =>
        prev.map((l) => {
          if (l.id !== id) return l;
          const has = l.slugs.includes(slug);
          const want = include ?? !has;
          if (want === has) return l;
          return {
            ...l,
            slugs: want
              ? [...l.slugs, slug]
              : l.slugs.filter((s) => s !== slug),
          };
        }),
      );
    },
    [setLists],
  );

  return {
    lists,
    hydrated,
    createList,
    renameList,
    deleteList,
    toggleProblem,
  };
}
