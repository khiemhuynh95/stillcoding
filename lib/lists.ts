/*
 * ─────────────────────────────────────────────────────────────────────────
 * PROBLEM LISTS — curated study sets + the plumbing for user-made ones.
 *
 * Two kinds of list exist in the app:
 *   • Preset lists (below): well-known curated sets, defined in code like the
 *     roadmap. Each is just an ordered array of problem `title_slug`s. Slugs
 *     resolve through the normal data layer, so a slug that isn't in the
 *     catalog (e.g. a premium problem the API never returns) is simply skipped
 *     when the list is shown — nothing breaks. Edit these freely.
 *   • User lists: created in the browser and stored in localStorage. See
 *     hooks/useLists.ts. They share the `ProblemList` shape (preset:false).
 *
 * A list is referenced everywhere by its `id`. Preset ids are stable strings
 * ("blind-75"); user ids are prefixed "user:".
 * ─────────────────────────────────────────────────────────────────────────
 */

export interface ProblemList {
  id: string;
  name: string;
  description?: string;
  /** Ordered problem title_slugs. */
  slugs: string[];
  /** true for the built-in curated lists, false for user-created ones. */
  preset: boolean;
}

export const USER_LIST_PREFIX = "user:";

export function isUserListId(id: string): boolean {
  return id.startsWith(USER_LIST_PREFIX);
}

// ── Blind 75 ────────────────────────────────────────────────────────────
const BLIND_75: string[] = [
  // Array
  "two-sum",
  "best-time-to-buy-and-sell-stock",
  "contains-duplicate",
  "product-of-array-except-self",
  "maximum-subarray",
  "maximum-product-subarray",
  "find-minimum-in-rotated-sorted-array",
  "search-in-rotated-sorted-array",
  "3sum",
  "container-with-most-water",
  // Binary
  "sum-of-two-integers",
  "number-of-1-bits",
  "counting-bits",
  "missing-number",
  "reverse-bits",
  // Dynamic Programming
  "climbing-stairs",
  "coin-change",
  "longest-increasing-subsequence",
  "longest-common-subsequence",
  "word-break",
  "combination-sum",
  "house-robber",
  "house-robber-ii",
  "decode-ways",
  "unique-paths",
  "jump-game",
  // Graph
  "clone-graph",
  "course-schedule",
  "pacific-atlantic-water-flow",
  "number-of-islands",
  "longest-consecutive-sequence",
  "alien-dictionary",
  "graph-valid-tree",
  "number-of-connected-components-in-an-undirected-graph",
  // Interval
  "insert-interval",
  "merge-intervals",
  "non-overlapping-intervals",
  "meeting-rooms",
  "meeting-rooms-ii",
  // Linked List
  "reverse-linked-list",
  "linked-list-cycle",
  "merge-two-sorted-lists",
  "merge-k-sorted-lists",
  "remove-nth-node-from-end-of-list",
  "reorder-list",
  // Matrix
  "set-matrix-zeroes",
  "spiral-matrix",
  "rotate-image",
  "word-search",
  // String
  "longest-substring-without-repeating-characters",
  "longest-repeating-character-replacement",
  "minimum-window-substring",
  "valid-anagram",
  "group-anagrams",
  "valid-parentheses",
  "valid-palindrome",
  "longest-palindromic-substring",
  "palindromic-substrings",
  "encode-and-decode-strings",
  // Tree
  "maximum-depth-of-binary-tree",
  "same-tree",
  "invert-binary-tree",
  "binary-tree-maximum-path-sum",
  "binary-tree-level-order-traversal",
  "serialize-and-deserialize-binary-tree",
  "subtree-of-another-tree",
  "construct-binary-tree-from-preorder-and-inorder-traversal",
  "validate-binary-search-tree",
  "kth-smallest-element-in-a-bst",
  "lowest-common-ancestor-of-a-binary-search-tree",
  "implement-trie-prefix-tree",
  "design-add-and-search-words-data-structure",
  "word-search-ii",
  // Heap
  "top-k-frequent-elements",
  "find-median-from-data-stream",
];

// ── NeetCode 150 ────────────────────────────────────────────────────────
const NEETCODE_150: string[] = [
  // Arrays & Hashing
  "contains-duplicate",
  "valid-anagram",
  "two-sum",
  "group-anagrams",
  "top-k-frequent-elements",
  "encode-and-decode-strings",
  "product-of-array-except-self",
  "valid-sudoku",
  "longest-consecutive-sequence",
  // Two Pointers
  "valid-palindrome",
  "two-sum-ii-input-array-is-sorted",
  "3sum",
  "container-with-most-water",
  "trapping-rain-water",
  // Sliding Window
  "best-time-to-buy-and-sell-stock",
  "longest-substring-without-repeating-characters",
  "longest-repeating-character-replacement",
  "permutation-in-string",
  "minimum-window-substring",
  "sliding-window-maximum",
  // Stack
  "valid-parentheses",
  "min-stack",
  "evaluate-reverse-polish-notation",
  "generate-parentheses",
  "daily-temperatures",
  "car-fleet",
  "largest-rectangle-in-histogram",
  // Binary Search
  "binary-search",
  "search-a-2d-matrix",
  "koko-eating-bananas",
  "find-minimum-in-rotated-sorted-array",
  "search-in-rotated-sorted-array",
  "time-based-key-value-store",
  "median-of-two-sorted-arrays",
  // Linked List
  "reverse-linked-list",
  "merge-two-sorted-lists",
  "reorder-list",
  "remove-nth-node-from-end-of-list",
  "copy-list-with-random-pointer",
  "add-two-numbers",
  "linked-list-cycle",
  "find-the-duplicate-number",
  "lru-cache",
  "merge-k-sorted-lists",
  "reverse-nodes-in-k-group",
  // Trees
  "invert-binary-tree",
  "maximum-depth-of-binary-tree",
  "diameter-of-binary-tree",
  "balanced-binary-tree",
  "same-tree",
  "subtree-of-another-tree",
  "lowest-common-ancestor-of-a-binary-search-tree",
  "binary-tree-level-order-traversal",
  "binary-tree-right-side-view",
  "count-good-nodes-in-binary-tree",
  "validate-binary-search-tree",
  "kth-smallest-element-in-a-bst",
  "construct-binary-tree-from-preorder-and-inorder-traversal",
  "binary-tree-maximum-path-sum",
  "serialize-and-deserialize-binary-tree",
  // Tries
  "implement-trie-prefix-tree",
  "design-add-and-search-words-data-structure",
  "word-search-ii",
  // Heap / Priority Queue
  "kth-largest-element-in-a-stream",
  "last-stone-weight",
  "k-closest-points-to-origin",
  "kth-largest-element-in-an-array",
  "task-scheduler",
  "design-twitter",
  "find-median-from-data-stream",
  // Backtracking
  "subsets",
  "combination-sum",
  "permutations",
  "subsets-ii",
  "combination-sum-ii",
  "word-search",
  "palindrome-partitioning",
  "letter-combinations-of-a-phone-number",
  "n-queens",
  // Graphs
  "number-of-islands",
  "max-area-of-island",
  "clone-graph",
  "walls-and-gates",
  "rotting-oranges",
  "pacific-atlantic-water-flow",
  "surrounded-regions",
  "course-schedule",
  "course-schedule-ii",
  "graph-valid-tree",
  "number-of-connected-components-in-an-undirected-graph",
  "redundant-connection",
  "word-ladder",
  // Advanced Graphs
  "reconstruct-itinerary",
  "min-cost-to-connect-all-points",
  "network-delay-time",
  "swim-in-rising-water",
  "alien-dictionary",
  "cheapest-flights-within-k-stops",
  // 1-D DP
  "climbing-stairs",
  "min-cost-climbing-stairs",
  "house-robber",
  "house-robber-ii",
  "longest-palindromic-substring",
  "palindromic-substrings",
  "decode-ways",
  "coin-change",
  "maximum-product-subarray",
  "word-break",
  "longest-increasing-subsequence",
  "partition-equal-subset-sum",
  // 2-D DP
  "unique-paths",
  "longest-common-subsequence",
  "best-time-to-buy-and-sell-stock-with-cooldown",
  "coin-change-ii",
  "target-sum",
  "interleaving-string",
  "longest-increasing-path-in-a-matrix",
  "distinct-subsequences",
  "edit-distance",
  "burst-balloons",
  "regular-expression-matching",
  // Greedy
  "maximum-subarray",
  "jump-game",
  "jump-game-ii",
  "gas-station",
  "hand-of-straights",
  "merge-triplets-to-form-target-triplet",
  "partition-labels",
  "valid-parenthesis-string",
  // Intervals
  "insert-interval",
  "merge-intervals",
  "non-overlapping-intervals",
  "meeting-rooms",
  "meeting-rooms-ii",
  "minimum-interval-to-include-each-query",
  // Math & Geometry
  "rotate-image",
  "spiral-matrix",
  "set-matrix-zeroes",
  "happy-number",
  "plus-one",
  "powx-n",
  "multiply-strings",
  "detect-squares",
  // Bit Manipulation
  "single-number",
  "number-of-1-bits",
  "counting-bits",
  "reverse-bits",
  "missing-number",
  "sum-of-two-integers",
  "reverse-integer",
];

// ── Grind 75 (techinterviewhandbook) ────────────────────────────────────
const GRIND_75: string[] = [
  "two-sum",
  "valid-parentheses",
  "merge-two-sorted-lists",
  "best-time-to-buy-and-sell-stock",
  "valid-palindrome",
  "invert-binary-tree",
  "valid-anagram",
  "binary-search",
  "flood-fill",
  "lowest-common-ancestor-of-a-binary-search-tree",
  "balanced-binary-tree",
  "linked-list-cycle",
  "implement-queue-using-stacks",
  "first-bad-version",
  "ransom-note",
  "climbing-stairs",
  "longest-palindrome",
  "reverse-linked-list",
  "majority-element",
  "add-binary",
  "diameter-of-binary-tree",
  "middle-of-the-linked-list",
  "maximum-depth-of-binary-tree",
  "contains-duplicate",
  "maximum-subarray",
  "insert-interval",
  "01-matrix",
  "k-closest-points-to-origin",
  "longest-substring-without-repeating-characters",
  "3sum",
  "binary-tree-level-order-traversal",
  "clone-graph",
  "evaluate-reverse-polish-notation",
  "course-schedule",
  "implement-trie-prefix-tree",
  "coin-change",
  "product-of-array-except-self",
  "min-stack",
  "validate-binary-search-tree",
  "number-of-islands",
  "rotting-oranges",
  "search-in-rotated-sorted-array",
  "combination-sum",
  "permutations",
  "merge-intervals",
  "lowest-common-ancestor-of-a-binary-tree",
  "time-based-key-value-store",
  "accounts-merge",
  "sort-colors",
  "word-break",
  "partition-equal-subset-sum",
  "string-to-integer-atoi",
  "spiral-matrix",
  "subsets",
  "binary-tree-right-side-view",
  "longest-palindromic-substring",
  "unique-paths",
  "construct-binary-tree-from-preorder-and-inorder-traversal",
  "container-with-most-water",
  "letter-combinations-of-a-phone-number",
  "word-search",
  "find-all-anagrams-in-a-string",
  "minimum-height-trees",
  "task-scheduler",
  "lru-cache",
  "kth-smallest-element-in-a-bst",
  "minimum-window-substring",
  "serialize-and-deserialize-binary-tree",
  "trapping-rain-water",
  "find-median-from-data-stream",
  "word-ladder",
  "basic-calculator",
  "maximum-profit-in-job-scheduling",
  "merge-k-sorted-lists",
  "largest-rectangle-in-histogram",
];

// ── LeetCode Top 100 Liked ──────────────────────────────────────────────
const TOP_100_LIKED: string[] = [
  // Hashing
  "two-sum",
  "group-anagrams",
  "longest-consecutive-sequence",
  // Two Pointers
  "move-zeroes",
  "container-with-most-water",
  "3sum",
  "trapping-rain-water",
  // Sliding Window
  "longest-substring-without-repeating-characters",
  "find-all-anagrams-in-a-string",
  // Substring
  "minimum-window-substring",
  "sliding-window-maximum",
  // Array
  "maximum-subarray",
  "merge-intervals",
  "rotate-array",
  "product-of-array-except-self",
  "first-missing-positive",
  // Matrix
  "set-matrix-zeroes",
  "spiral-matrix",
  "rotate-image",
  "search-a-2d-matrix-ii",
  // Linked List
  "intersection-of-two-linked-lists",
  "reverse-linked-list",
  "palindrome-linked-list",
  "linked-list-cycle",
  "linked-list-cycle-ii",
  "merge-two-sorted-lists",
  "add-two-numbers",
  "remove-nth-node-from-end-of-list",
  "swap-nodes-in-pairs",
  "reverse-nodes-in-k-group",
  "copy-list-with-random-pointer",
  "sort-list",
  "merge-k-sorted-lists",
  "lru-cache",
  // Binary Tree
  "maximum-depth-of-binary-tree",
  "invert-binary-tree",
  "symmetric-tree",
  "binary-tree-inorder-traversal",
  "diameter-of-binary-tree",
  "binary-tree-level-order-traversal",
  "convert-sorted-array-to-binary-search-tree",
  "validate-binary-search-tree",
  "kth-smallest-element-in-a-bst",
  "binary-tree-right-side-view",
  "flatten-binary-tree-to-linked-list",
  "construct-binary-tree-from-preorder-and-inorder-traversal",
  "path-sum-iii",
  "lowest-common-ancestor-of-a-binary-tree",
  "binary-tree-maximum-path-sum",
  // Graph
  "number-of-islands",
  "rotting-oranges",
  "course-schedule",
  "implement-trie-prefix-tree",
  // Backtracking
  "permutations",
  "subsets",
  "letter-combinations-of-a-phone-number",
  "combination-sum",
  "generate-parentheses",
  "word-search",
  "palindrome-partitioning",
  "n-queens",
  // Binary Search
  "search-insert-position",
  "search-a-2d-matrix",
  "find-first-and-last-position-of-element-in-sorted-array",
  "search-in-rotated-sorted-array",
  "find-minimum-in-rotated-sorted-array",
  "median-of-two-sorted-arrays",
  // Stack
  "valid-parentheses",
  "min-stack",
  "decode-string",
  "daily-temperatures",
  "largest-rectangle-in-histogram",
  // Heap
  "kth-largest-element-in-an-array",
  "top-k-frequent-elements",
  "find-median-from-data-stream",
  // Greedy
  "best-time-to-buy-and-sell-stock",
  "jump-game",
  "jump-game-ii",
  "partition-labels",
  // DP
  "climbing-stairs",
  "pascals-triangle",
  "house-robber",
  "perfect-squares",
  "coin-change",
  "word-break",
  "longest-increasing-subsequence",
  "maximum-product-subarray",
  "partition-equal-subset-sum",
  "longest-valid-parentheses",
  // Multidimensional DP
  "unique-paths",
  "minimum-path-sum",
  "longest-palindromic-substring",
  "longest-common-subsequence",
  "edit-distance",
  // Technique
  "single-number",
  "majority-element",
  "sort-colors",
  "next-permutation",
  "find-the-duplicate-number",
];

// ── Custom (StillCoding's own C-series problems) ────────────────────────
// Every hand-authored "C#" problem (source='custom' DB rows), in C1..C4 order.
// Add each new custom problem's title_slug here. DB-only, so these resolve only
// when Supabase is configured.
const CUSTOM_PROBLEMS: string[] = [
  "add-digits-until-one", // C1
  "balanced-brackets", // C2
  "cloud-gaming-membership-billing", // C3
  "decode-scrambled-sentence", // C4
];

export const PRESET_LISTS: ProblemList[] = [
  {
    id: "blind-75",
    name: "Blind 75",
    description: "The classic 75 problems covering every core pattern.",
    slugs: BLIND_75,
    preset: true,
  },
  {
    id: "neetcode-150",
    name: "NeetCode 150",
    description: "150 problems grouped by pattern — a Blind 75 superset.",
    slugs: NEETCODE_150,
    preset: true,
  },
  {
    id: "grind-75",
    name: "Grind 75",
    description: "A modern Blind 75 successor, ordered by week.",
    slugs: GRIND_75,
    preset: true,
  },
  {
    id: "top-100-liked",
    name: "Top 100 Liked",
    description: "LeetCode's 100 most-liked questions.",
    slugs: TOP_100_LIKED,
    preset: true,
  },
  {
    id: "custom",
    name: "Custom",
    description: "StillCoding's own hand-authored problems (the C-series).",
    slugs: CUSTOM_PROBLEMS,
    preset: true,
  },
];

/** Look up a preset list by id (user lists live in localStorage instead). */
export function findPresetList(id: string): ProblemList | undefined {
  return PRESET_LISTS.find((l) => l.id === id);
}
