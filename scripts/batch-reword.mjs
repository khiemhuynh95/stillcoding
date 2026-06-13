// Reword-only batch: newbie-friendly humanized statement + rename + curated
// tags. Paid/locked and SQL schema problems get rename+retag only.

export default [
  {
    id: "1031",
    title: "Add an Integer to a Digit Array",
    tags: [
      { name: "Array", slug: "array" },
      { name: "Math", slug: "math" },
    ],
    intro: `<p>The array-form of an integer lists its digits from left to right, so <code>1321</code> is <code>[1,3,2,1]</code>. You are given <code>num</code>, the array-form of an integer, and an integer <code>k</code>. Return the array-form of <code>num + k</code>.</p>

<p>&nbsp;</p>
`,
  },
  {
    id: "99",
    title: "Fix a BST With Two Swapped Nodes",
    tags: [
      { name: "Tree", slug: "tree" },
      { name: "Depth-First Search", slug: "depth-first-search" },
      { name: "Binary Search Tree", slug: "binary-search-tree" },
      { name: "Binary Tree", slug: "binary-tree" },
    ],
    intro: `<p>You are given the <code>root</code> of a binary search tree in which the values of exactly two nodes were swapped by mistake. Restore it to a valid BST without changing the tree's structure.</p>

<p>&nbsp;</p>
`,
  },
  {
    id: "1032",
    title: "Can the Equality Equations Be Satisfied?",
    tags: [
      { name: "Array", slug: "array" },
      { name: "String", slug: "string" },
      { name: "Union-Find", slug: "union-find" },
      { name: "Graph Theory", slug: "graph-theory" },
    ],
    intro: `<p>You are given an array <code>equations</code> of strings, each of the form <code>"a==b"</code> or <code>"a!=b"</code>, where <code>a</code> and <code>b</code> are single lowercase-letter variable names. Return <code>true</code> if you can assign an integer to each variable so that all the equations hold at once.</p>

<p>&nbsp;</p>
`,
  },
  {
    id: "1033",
    title: "Fewest Operations on the Broken Calculator",
    tags: [
      { name: "Math", slug: "math" },
      { name: "Greedy", slug: "greedy" },
    ],
    intro: `<p>A calculator shows the integer <code>startValue</code>. In one operation you may double the displayed number or subtract <code>1</code> from it. Given <code>startValue</code> and <code>target</code>, return the fewest operations needed to make the display show <code>target</code>.</p>

<p>&nbsp;</p>
`,
  },
  {
    id: "1034",
    title: "Count Subarrays With Exactly K Distinct Values",
    tags: [
      { name: "Array", slug: "array" },
      { name: "Hash Table", slug: "hash-table" },
      { name: "Sliding Window", slug: "sliding-window" },
      { name: "Counting", slug: "counting" },
    ],
    intro: `<p>You are given an integer array <code>nums</code> and an integer <code>k</code>. A subarray is good if it contains exactly <code>k</code> distinct integers. Return the number of good contiguous subarrays of <code>nums</code>.</p>

<p>&nbsp;</p>
`,
  },
  {
    id: "1035",
    title: "Are Two Nodes Cousins in the Tree?",
    tags: [
      { name: "Tree", slug: "tree" },
      { name: "Depth-First Search", slug: "depth-first-search" },
      { name: "Breadth-First Search", slug: "breadth-first-search" },
      { name: "Binary Tree", slug: "binary-tree" },
    ],
    intro: `<p>You are given the <code>root</code> of a binary tree with unique values, plus two different values <code>x</code> and <code>y</code>. Two nodes are cousins if they sit at the same depth but have different parents (the root is depth <code>0</code>). Return <code>true</code> if the nodes with values <code>x</code> and <code>y</code> are cousins.</p>

<p>&nbsp;</p>
`,
  },
  {
    id: "1036",
    title: "Minutes Until All Oranges Rot",
    tags: [
      { name: "Array", slug: "array" },
      { name: "Breadth-First Search", slug: "breadth-first-search" },
      { name: "Matrix", slug: "matrix" },
    ],
    intro: `<p>You are given an <code>m x n</code> grid where each cell is <code>0</code> (empty), <code>1</code> (a fresh orange), or <code>2</code> (a rotten orange). Each minute, every fresh orange that is side-adjacent to a rotten one turns rotten. Return the fewest minutes until no fresh orange is left, or <code>-1</code> if some fresh orange can never rot.</p>

<p>&nbsp;</p>
`,
  },
  {
    id: "1037",
    title: "Fewest K-Length Flips to Clear All Zeros",
    tags: [
      { name: "Array", slug: "array" },
      { name: "Bit Manipulation", slug: "bit-manipulation" },
      { name: "Queue", slug: "queue" },
      { name: "Sliding Window", slug: "sliding-window" },
      { name: "Prefix Sum", slug: "prefix-sum" },
    ],
    intro: `<p>You are given a binary array <code>nums</code> and an integer <code>k</code>. A k-bit flip picks a length-<code>k</code> contiguous subarray and flips every bit in it, turning <code>0</code>s to <code>1</code>s and <code>1</code>s to <code>0</code>s. Return the fewest such flips needed so the array has no <code>0</code>, or <code>-1</code> if it is impossible.</p>

<p>&nbsp;</p>
`,
  },
  {
    id: "1038",
    title: "Count Squareful Permutations",
    tags: [
      { name: "Array", slug: "array" },
      { name: "Hash Table", slug: "hash-table" },
      { name: "Math", slug: "math" },
      { name: "Dynamic Programming", slug: "dynamic-programming" },
      { name: "Backtracking", slug: "backtracking" },
      { name: "Bit Manipulation", slug: "bit-manipulation" },
      { name: "Bitmask", slug: "bitmask" },
    ],
    intro: `<p>An array is squareful when the sum of every pair of adjacent elements is a perfect square. You are given an integer array <code>nums</code>. Return how many of its permutations are squareful, counting two permutations as different if they differ at any position.</p>

<p>&nbsp;</p>
`,
  },
  {
    id: "1039",
    title: "Identify the Town Judge",
    tags: [
      { name: "Array", slug: "array" },
      { name: "Hash Table", slug: "hash-table" },
      { name: "Graph Theory", slug: "graph-theory" },
    ],
    intro: `<p>A town has <code>n</code> people labeled <code>1</code> to <code>n</code>. The town judge, if one exists, trusts nobody, is trusted by everyone else, and is the only person meeting both conditions. You are given an array <code>trust</code> where <code>trust[i] = [a, b]</code> means person <code>a</code> trusts person <code>b</code>. Return the label of the town judge, or <code>-1</code> if there is none.</p>

<p>&nbsp;</p>
`,
  },
  {
    id: "1040",
    title: "Insert a Value Into a Maximum Tree",
    tags: [
      { name: "Tree", slug: "tree" },
      { name: "Binary Tree", slug: "binary-tree" },
    ],
    intro: `<p>A maximum tree is built from a list by making its largest value the root, then recursively building the left subtree from the elements before it and the right subtree from the elements after it. You are given the <code>root</code> of such a tree, originally built from a list <code>a</code>, and an integer <code>val</code> appended to the end of <code>a</code> to form <code>b</code>. Return the maximum tree built from <code>b</code>.</p>

<p>&nbsp;</p>
`,
  },
  {
    id: "1041",
    title: "Pawns a Rook Can Capture",
    tags: [
      { name: "Array", slug: "array" },
      { name: "Matrix", slug: "matrix" },
      { name: "Simulation", slug: "simulation" },
    ],
    intro: `<p>You are given an <code>8 x 8</code> chessboard with exactly one white rook <code>'R'</code>, some white bishops <code>'B'</code>, some black pawns <code>'p'</code>, and empty squares <code>'.'</code>. The rook moves any number of squares up, down, left, or right until it hits another piece or the edge, and it captures a pawn if it can reach that pawn's square in one move without a piece blocking the way. Return how many pawns the rook can capture.</p>

<p>&nbsp;</p>
`,
  },
];
