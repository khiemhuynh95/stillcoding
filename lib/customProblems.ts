import type {
  Difficulty,
  ProblemDetail,
  ProblemSummary,
  Tag,
} from "./types";
import { slugify } from "./utils";

/*
 * ─────────────────────────────────────────────────────────────────────────
 * ADD YOUR OWN PROBLEMS HERE.
 *
 * Each entry below is merged with the LeetCode API and shown in the app with
 * no other changes. `title_slug` must be unique (it's the URL: /problems/<slug>)
 * and should not collide with a LeetCode slug. `content` is HTML rendered in
 * the description pane. `starterCode` is optional per-language boilerplate —
 * keys are the language ids from lib/starterTemplates.ts
 * (python3, javascript, typescript, java, cpp, go).
 * ─────────────────────────────────────────────────────────────────────────
 */
export interface CustomProblem {
  frontend_id: string; // shown before the title, e.g. "C1"
  title: string;
  title_slug: string; // unique; becomes /problems/<title_slug>
  difficulty: Difficulty;
  tags: string[]; // tag names, e.g. ["Array", "Hash Table"]
  content: string; // HTML description (examples/constraints inline)
  hints?: string[];
  starterCode?: Record<string, string>;
}

export const CUSTOM_PROBLEMS: CustomProblem[] = [
  {
    frontend_id: "C1",
    title: "Add Digits Until One",
    title_slug: "add-digits-until-one",
    difficulty: "Easy",
    tags: ["Math"],
    content: `<p>Given a non-negative integer <code>n</code>, repeatedly add all its digits until the result has only a single digit, and return that digit.</p>
<p><strong>Example 1:</strong></p>
<pre>Input: n = 38
Output: 2
Explanation: 3 + 8 = 11, then 1 + 1 = 2. Since 2 has only one digit, return it.</pre>
<p><strong>Example 2:</strong></p>
<pre>Input: n = 0
Output: 0</pre>
<p><strong>Constraints:</strong></p>
<ul><li><code>0 &lt;= n &lt;= 2<sup>31</sup> - 1</code></li></ul>`,
    hints: [
      "A simple loop that sums the digits and repeats works in O(log n).",
      "There is also a constant-time formula using properties of 9 (the digital root).",
    ],
    starterCode: {
      python3: `class Solution:
    def addDigits(self, n: int) -> int:
        # Write your solution here
        pass
`,
      javascript: `/**
 * @param {number} n
 * @return {number}
 */
var addDigits = function (n) {
  // Write your solution here
};
`,
      typescript: `function addDigits(n: number): number {
  // Write your solution here
  return 0;
}
`,
    },
  },
  {
    frontend_id: "C2",
    title: "Balanced Brackets",
    title_slug: "balanced-brackets",
    difficulty: "Medium",
    tags: ["String", "Stack"],
    content: `<p>Given a string <code>s</code> containing only the characters <code>()[]{}</code>, determine whether the brackets are balanced — every opening bracket is closed by the same type, in the correct order.</p>
<p><strong>Example 1:</strong></p>
<pre>Input: s = "{[()]}"
Output: true</pre>
<p><strong>Example 2:</strong></p>
<pre>Input: s = "([)]"
Output: false</pre>
<p><strong>Constraints:</strong></p>
<ul>
<li><code>1 &lt;= s.length &lt;= 10<sup>4</sup></code></li>
<li><code>s</code> consists only of <code>()[]{}</code>.</li>
</ul>`,
    hints: ["Push opening brackets onto a stack; on a closing bracket, pop and compare."],
    starterCode: {
      python3: `class Solution:
    def isBalanced(self, s: str) -> bool:
        # Write your solution here
        pass
`,
      javascript: `/**
 * @param {string} s
 * @return {boolean}
 */
var isBalanced = function (s) {
  // Write your solution here
};
`,
    },
  },
];

const customId = (slug: string) => `custom-${slug}`;

export function customToSummary(p: CustomProblem): ProblemSummary {
  return {
    id: customId(p.title_slug),
    frontend_id: p.frontend_id,
    title: p.title,
    title_slug: p.title_slug,
    url: "",
    difficulty: p.difficulty,
    paid_only: false,
    has_solution: false,
    has_video_solution: false,
    source: "custom",
  };
}

export function customToDetail(p: CustomProblem): ProblemDetail {
  return {
    questionId: customId(p.title_slug),
    questionFrontendId: p.frontend_id,
    title: p.title,
    content: p.content,
    likes: 0,
    dislikes: 0,
    stats: "",
    similarQuestions: "",
    categoryTitle: "Custom",
    hints: p.hints ?? [],
    topicTags: p.tags.map((name) => ({ name, slug: slugify(name) })),
    companyTags: null,
    difficulty: p.difficulty,
    isPaidOnly: false,
    solution: null,
    hasSolution: false,
    hasVideoSolution: false,
    url: "",
    titleSlug: p.title_slug,
    parsedStats: null,
    source: "custom",
    starterCode: p.starterCode,
  };
}

/** All custom problems as list-row summaries. */
export function customSummaries(): ProblemSummary[] {
  return CUSTOM_PROBLEMS.map(customToSummary);
}

/** Look up a custom problem by its slug, if any. */
export function findCustomBySlug(slug: string): CustomProblem | undefined {
  return CUSTOM_PROBLEMS.find((p) => p.title_slug === slug);
}

/** Custom problems whose tags match a tag slug (for tag filtering). */
export function customMatchingTag(tagSlug: string): ProblemSummary[] {
  return CUSTOM_PROBLEMS.filter((p) =>
    p.tags.some((t) => slugify(t) === tagSlug),
  ).map(customToSummary);
}

/** Fold custom tag counts into the API's tag list (for the sidebar). */
export function mergeTagCounts(apiTags: Tag[]): Tag[] {
  const counts = new Map<string, { name: string; count: number }>();
  for (const p of CUSTOM_PROBLEMS) {
    for (const name of p.tags) {
      const slug = slugify(name);
      const cur = counts.get(slug) ?? { name, count: 0 };
      cur.count += 1;
      counts.set(slug, cur);
    }
  }
  const merged = apiTags.map((t) =>
    counts.has(t.slug)
      ? { ...t, problem_count: t.problem_count + counts.get(t.slug)!.count }
      : t,
  );
  for (const [slug, { name, count }] of counts) {
    if (!merged.some((t) => t.slug === slug)) {
      merged.push({ name, slug, problem_count: count });
    }
  }
  return merged.sort((a, b) => b.problem_count - a.problem_count);
}
