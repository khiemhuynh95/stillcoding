// Curated "Popular Topics" shown in the browse sidebar.
//
// This list is intentionally STATIC (not fetched from the DB / API) so the
// sidebar renders instantly and always shows the same, predictable set. Each
// `slug` must be a real LeetCode topic-tag slug, because selecting one drives
// `getProblemsByTag(slug)` — a slug the catalog doesn't know simply returns no
// problems. The order here is the display order; it roughly tracks LeetCode's
// own most-common topics. To edit: add/remove/reorder entries here.

export interface Topic {
  name: string;
  slug: string;
}

export const POPULAR_TOPICS: Topic[] = [
  { name: "Array", slug: "array" },
  { name: "String", slug: "string" },
  { name: "Hash Table", slug: "hash-table" },
  { name: "Dynamic Programming", slug: "dynamic-programming" },
  { name: "Math", slug: "math" },
  { name: "Sorting", slug: "sorting" },
  { name: "Greedy", slug: "greedy" },
  { name: "Two Pointers", slug: "two-pointers" },
  { name: "Sliding Window", slug: "sliding-window" },
  { name: "Binary Search", slug: "binary-search" },
  { name: "Depth-First Search", slug: "depth-first-search" },
  { name: "Breadth-First Search", slug: "breadth-first-search" },
  { name: "Backtracking", slug: "backtracking" },
  { name: "Tree", slug: "tree" },
  { name: "Binary Tree", slug: "binary-tree" },
  { name: "Graph", slug: "graph" },
  { name: "Heap (Priority Queue)", slug: "heap-priority-queue" },
  { name: "Stack", slug: "stack" },
  { name: "Monotonic Stack", slug: "monotonic-stack" },
  { name: "Linked List", slug: "linked-list" },
  { name: "Matrix", slug: "matrix" },
  { name: "Bit Manipulation", slug: "bit-manipulation" },
  { name: "Prefix Sum", slug: "prefix-sum" },
  { name: "Trie", slug: "trie" },
  { name: "Union Find", slug: "union-find" },
  { name: "Recursion", slug: "recursion" },
  { name: "Divide and Conquer", slug: "divide-and-conquer" },
  { name: "Design", slug: "design" },
];
