/**
 * The leetcode-api does not expose per-problem starter code (function
 * signatures), so we ship generic, language-appropriate scaffolds. The problem
 * title is added as a leading comment for context.
 */

export interface LanguageDef {
  id: string; // stable key used in storage
  label: string; // shown in the language selector
  monaco: string; // Monaco editor language id
}

export const LANGUAGES: LanguageDef[] = [
  { id: "python3", label: "Python 3", monaco: "python" },
  { id: "javascript", label: "JavaScript", monaco: "javascript" },
  { id: "typescript", label: "TypeScript", monaco: "typescript" },
  { id: "java", label: "Java", monaco: "java" },
  { id: "cpp", label: "C++", monaco: "cpp" },
  { id: "go", label: "Go", monaco: "go" },
  { id: "sql", label: "SQL", monaco: "sql" },
];

export const DEFAULT_LANGUAGE = "python3";

export function languageById(id: string): LanguageDef {
  return LANGUAGES.find((l) => l.id === id) ?? LANGUAGES[0];
}

const TEMPLATES: Record<string, string> = {
  python3: `class Solution:
    def solve(self):
        # Write your solution here
        pass
`,
  javascript: `/**
 * @param {*} input
 * @return {*}
 */
var solve = function (input) {
  // Write your solution here
};
`,
  typescript: `function solve(input: unknown): unknown {
  // Write your solution here
  return null;
}
`,
  java: `class Solution {
    public void solve() {
        // Write your solution here
    }
}
`,
  cpp: `class Solution {
public:
    void solve() {
        // Write your solution here
    }
};
`,
  go: `func solve() {
    // Write your solution here
}
`,
  sql: `-- Write your query here
SELECT *
FROM table_name;
`,
};

const LINE_COMMENT: Record<string, string> = {
  python3: "#",
  sql: "--",
};

export function getStarterTemplate(langId: string, title?: string): string {
  const body = TEMPLATES[langId] ?? TEMPLATES[DEFAULT_LANGUAGE];
  if (!title) return body;
  const prefix = LINE_COMMENT[langId] ?? "//";
  return `${prefix} ${title}\n${body}`;
}
