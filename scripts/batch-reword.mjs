// Reword-only batch: newbie-friendly humanized statement + rename + curated
// tags. No change to what the problem asks; examples/constraints kept verbatim.

export default [
  {
    id: "100",
    title: "Are Two Binary Trees Identical?",
    tags: [
      { name: "Tree", slug: "tree" },
      { name: "Depth-First Search", slug: "depth-first-search" },
      { name: "Breadth-First Search", slug: "breadth-first-search" },
      { name: "Binary Tree", slug: "binary-tree" },
    ],
    intro: `<p>You are given the roots of two binary trees, <code>p</code> and <code>q</code>. Check whether the two trees are the same and return <code>true</code> or <code>false</code>.</p>

<p>Two trees count as the same when they have the same shape and every matching pair of nodes holds the same value.</p>

<p>&nbsp;</p>
`,
  },
  {
    id: "1042",
    title: "Cheapest Way to Merge Stone Piles",
    tags: [
      { name: "Array", slug: "array" },
      { name: "Dynamic Programming", slug: "dynamic-programming" },
      { name: "Prefix Sum", slug: "prefix-sum" },
    ],
    intro: `<p>You have <code>n</code> piles of stones lined up in a row. The <code>i<sup>th</sup></code> pile holds <code>stones[i]</code> stones.</p>

<p>In one move you pick exactly <code>k</code> <strong>neighbouring</strong> piles and merge them into a single pile. That move costs the total number of stones in those <code>k</code> piles.</p>

<p>Return the smallest total cost to bring every pile together into one pile. If that is impossible, return <code>-1</code>.</p>

<p>&nbsp;</p>
`,
  },
  {
    id: "1043",
    title: "Lamp Grid Illumination Queries",
    tags: [
      { name: "Array", slug: "array" },
      { name: "Hash Table", slug: "hash-table" },
    ],
    intro: `<p>You have an <code>n x n</code> <code>grid</code>. Every cell holds a lamp, and all lamps start <strong>off</strong>.</p>

<p>You are given a list <code>lamps</code>, where <code>lamps[i] = [row<sub>i</sub>, col<sub>i</sub>]</code> turns the lamp at that cell <strong>on</strong>. The same cell may appear more than once, which still just means that lamp is on. A lamp that is on lights up its own cell and every other cell in the same <strong>row, column, or diagonal</strong>.</p>

<p>You are also given a list <code>queries</code>. For each <code>queries[j] = [row<sub>j</sub>, col<sub>j</sub>]</code>, first decide whether that cell is lit. After answering, turn <strong>off</strong> the lamp at that cell and the lamps in its <strong>8 surrounding cells</strong> (any cell that shares a side or a corner with it).</p>

<p>Return an array <code>ans</code> where <code>ans[j]</code> is <code>1</code> if the queried cell was lit, or <code>0</code> if it was not.</p>

<p>&nbsp;</p>
`,
  },
  {
    id: "1044",
    title: "Letters Common to Every Word",
    tags: [
      { name: "Array", slug: "array" },
      { name: "Hash Table", slug: "hash-table" },
      { name: "String", slug: "string" },
    ],
    intro: `<p>You are given a string array <code>words</code>. Return every character that appears in <strong>all</strong> of the strings, and keep duplicates: if a character is common to all words and shows up at least twice in each one, include it that many times. You may return the characters in any order.</p>

<p>&nbsp;</p>
`,
  },
  {
    id: "1045",
    title: "Is the String Built Only From abc?",
    tags: [
      { name: "String", slug: "string" },
      { name: "Stack", slug: "stack" },
    ],
    intro: `<p>You are given a string <code>s</code>. Decide whether it is <strong>valid</strong>.</p>

<p>Start from an empty string <code>t = ""</code>. You may insert the block <code>"abc"</code> into <code>t</code> at any position, as many times as you like. Each insertion turns <code>t</code> into <code>t<sub>left</sub> + "abc" + t<sub>right</sub></code>, where <code>t == t<sub>left</sub> + t<sub>right</sub></code> and either side may be empty. The string <code>s</code> is valid when some sequence of these inserts builds exactly <code>s</code>.</p>

<p>Return <code>true</code> if <code>s</code> is valid, otherwise return <code>false</code>.</p>

<p>&nbsp;</p>
`,
  },
  {
    id: "1046",
    title: "Longest Run of Ones After K Flips",
    tags: [
      { name: "Array", slug: "array" },
      { name: "Binary Search", slug: "binary-search" },
      { name: "Sliding Window", slug: "sliding-window" },
      { name: "Prefix Sum", slug: "prefix-sum" },
    ],
    intro: `<p>You are given a binary array <code>nums</code> (only <code>0</code>s and <code>1</code>s) and an integer <code>k</code>. You may flip at most <code>k</code> of the zeros into ones.</p>

<p>Return the length of the longest stretch of consecutive <code>1</code>s you can end up with.</p>

<p>&nbsp;</p>
`,
  },
  {
    id: "1047",
    title: "Biggest Array Sum After K Sign Flips",
    tags: [
      { name: "Array", slug: "array" },
      { name: "Greedy", slug: "greedy" },
      { name: "Sorting", slug: "sorting" },
    ],
    intro: `<p>You are given an integer array <code>nums</code> and an integer <code>k</code>. One operation means: pick an index <code>i</code> and replace <code>nums[i]</code> with <code>-nums[i]</code>.</p>

<p>You must apply this operation exactly <code>k</code> times, and you are allowed to pick the same index more than once. Return the largest array sum you can reach afterwards.</p>

<p>&nbsp;</p>
`,
  },
  {
    id: "1048",
    title: "Clumsy Factorial Calculation",
    tags: [
      { name: "Math", slug: "math" },
      { name: "Stack", slug: "stack" },
      { name: "Simulation", slug: "simulation" },
    ],
    intro: `<p>The <strong>factorial</strong> of a positive integer <code>n</code> is the product of all positive integers from <code>1</code> up to <code>n</code>. For example, <code>factorial(10) = 10 * 9 * 8 * 7 * 6 * 5 * 4 * 3 * 2 * 1</code>.</p>

<p>To build a <strong>clumsy factorial</strong>, write the numbers from <code>n</code> down to <code>1</code> and, instead of multiplying them all, cycle through four operations in this fixed order: multiply <code>'*'</code>, divide <code>'/'</code>, add <code>'+'</code>, then subtract <code>'-'</code>. For example, <code>clumsy(10) = 10 * 9 / 8 + 7 - 6 * 5 / 4 + 3 - 2 * 1</code>.</p>

<p>Evaluate it with normal math precedence: do all multiplications and divisions first, left to right, then the additions and subtractions. Division is floor division, so <code>10 * 9 / 8 = 90 / 8 = 11</code>.</p>

<p>Given an integer <code>n</code>, return its clumsy factorial.</p>

<p>&nbsp;</p>
`,
  },
];
