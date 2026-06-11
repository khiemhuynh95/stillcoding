/*
 * ─────────────────────────────────────────────────────────────────────────
 * THE ROADMAP — a guided, branching learning path.
 *
 * The LeetCode API has no roadmap/study-plan data, so this structure is
 * curated here (edit freely). Each node sits at a (row, col) on a grid, lists
 * its prerequisite nodes in `deps` (which draw the connecting edges), and holds
 * problem slugs. Slugs resolve through the normal data layer, so they may be
 * LeetCode problems OR your own custom ones (lib/customProblems.ts).
 * Progress is computed from your solved status — nothing else to maintain.
 * ─────────────────────────────────────────────────────────────────────────
 */
export interface RoadmapNode {
  id: string;
  title: string;
  row: number; // vertical level, 0 = top
  col: number; // horizontal slot, 0..ROADMAP_COLS-1
  deps?: string[]; // ids of prerequisite nodes (edges are drawn dep -> this)
  problems: string[]; // problem slugs
}

export const ROADMAP_COLS = 5;

export const ROADMAP: RoadmapNode[] = [
  {
    id: "arrays-hashing",
    title: "Arrays & Hashing",
    row: 0,
    col: 2,
    problems: [
      "two-sum",
      "contains-duplicate",
      "valid-anagram",
      "group-anagrams",
      "top-k-frequent-elements",
      "product-of-array-except-self",
    ],
  },
  {
    id: "two-pointers",
    title: "Two Pointers",
    row: 1,
    col: 1,
    deps: ["arrays-hashing"],
    problems: [
      "valid-palindrome",
      "two-sum-ii-input-array-is-sorted",
      "3sum",
      "container-with-most-water",
    ],
  },
  {
    id: "stack",
    title: "Stack",
    row: 1,
    col: 3,
    deps: ["arrays-hashing"],
    problems: [
      "valid-parentheses",
      "min-stack",
      "evaluate-reverse-polish-notation",
      "daily-temperatures",
    ],
  },
  {
    id: "sliding-window",
    title: "Sliding Window",
    row: 2,
    col: 0,
    deps: ["two-pointers"],
    problems: [
      "best-time-to-buy-and-sell-stock",
      "longest-substring-without-repeating-characters",
      "longest-repeating-character-replacement",
      "permutation-in-string",
    ],
  },
  {
    id: "binary-search",
    title: "Binary Search",
    row: 2,
    col: 1,
    deps: ["two-pointers"],
    problems: [
      "binary-search",
      "search-a-2d-matrix",
      "koko-eating-bananas",
      "find-minimum-in-rotated-sorted-array",
      "search-in-rotated-sorted-array",
    ],
  },
  {
    id: "linked-list",
    title: "Linked List",
    row: 2,
    col: 3,
    deps: ["stack"],
    problems: [
      "reverse-linked-list",
      "merge-two-sorted-lists",
      "linked-list-cycle",
      "reorder-list",
      "remove-nth-node-from-end-of-list",
    ],
  },
  {
    id: "trees",
    title: "Trees",
    row: 3,
    col: 2,
    deps: ["sliding-window", "binary-search", "linked-list"],
    problems: [
      "invert-binary-tree",
      "maximum-depth-of-binary-tree",
      "diameter-of-binary-tree",
      "same-tree",
      "binary-tree-level-order-traversal",
      "validate-binary-search-tree",
    ],
  },
  {
    id: "heap",
    title: "Heap / Priority Queue",
    row: 4,
    col: 1,
    deps: ["trees"],
    problems: [
      "kth-largest-element-in-a-stream",
      "last-stone-weight",
      "k-closest-points-to-origin",
      "kth-largest-element-in-an-array",
      "task-scheduler",
    ],
  },
  {
    id: "backtracking",
    title: "Backtracking",
    row: 4,
    col: 3,
    deps: ["trees"],
    problems: [
      "subsets",
      "combination-sum",
      "permutations",
      "word-search",
      "palindrome-partitioning",
    ],
  },
  {
    id: "graphs",
    title: "Graphs",
    row: 5,
    col: 1,
    deps: ["heap", "backtracking"],
    problems: [
      "number-of-islands",
      "clone-graph",
      "pacific-atlantic-water-flow",
      "course-schedule",
      "rotting-oranges",
    ],
  },
  {
    id: "dynamic-programming",
    title: "1-D Dynamic Programming",
    row: 5,
    col: 3,
    deps: ["backtracking"],
    problems: [
      "climbing-stairs",
      "house-robber",
      "coin-change",
      "longest-increasing-subsequence",
      "word-break",
    ],
  },
];
