-- StillCoding — custom problem C4 (DB-backed)
--
-- Adds "Decode the Scrambled Sentence" as a `source='custom'` row, the same
-- way C1/C2/C3 were seeded in 20260618000002_custom_problems.sql. The app
-- reads it from the catalog like any other problem.
--
-- Safe across the daily sync: it upserts by `id` and never deletes, and the
-- "custom-<slug>" id never collides with a LeetCode id, so this row survives.
-- RLS keeps it anon read-only. Idempotent: re-running updates the row in place.

insert into public.problems
  (id, frontend_id, title, title_slug, url, difficulty, paid_only,
   has_solution, has_video_solution, source, question_id, content,
   hints, topic_tags, category_title, starter_code, detail_synced_at)
values (
  'custom-decode-scrambled-sentence', 'C4', 'Decode the Scrambled Sentence', 'decode-scrambled-sentence', '',
  'Medium', false, false, false, 'custom', 'custom-decode-scrambled-sentence',
  $cp$<p>You are given a scrambled sentence <code>s</code> and a dictionary of valid <code>words</code>.</p>
<p>The words in <code>s</code> are separated by single spaces. Each token in <code>s</code> is a scrambled version of one dictionary word: the first and last characters stay where they are, and only the characters between them are reordered. So a token has the same first character, the same last character, and the same letters as its source word. (A word of length 3 or less is never changed, since it has at most one interior character to move.)</p>
<p>Replace every token with its source word, keep the original word order, and return the decoded sentence.</p>
<p>For each token, exactly one dictionary word has the same first character, last character, and letters, so the source word is always unique.</p>
<p><strong>Example 1:</strong></p>
<pre>Input: s = "hlleo wrlod my nmae is kihem", words = ["hello", "world", "name", "my", "is", "khiem"]
Output: "hello world my name is khiem"
Explanation: "hlleo" comes from "hello" (h...o, interior {e,l,l} reordered), "nmae" from "name", and so on. "my" and "is" have length 2, so they can't change.</pre>
<p><strong>Example 2:</strong></p>
<pre>Input: s = "ltsien snelit", words = ["listen", "silent"]
Output: "listen silent"
Explanation: Both words use the same letters, so sorting the letters alone is ambiguous. The fixed first and last characters break the tie: "ltsien" is l...n, "snelit" is s...t.</pre>
<p><strong>Example 3:</strong></p>
<pre>Input: s = "tset a tset", words = ["test", "a"]
Output: "test a test"
Explanation: A dictionary word can be used more than once, and "a" has length 1 so it never changes.</pre>
<p><strong>Constraints:</strong></p>
<ul>
<li><code>1 &lt;= words.length &lt;= 10<sup>4</sup></code></li>
<li><code>1 &lt;= words[i].length &lt;= 20</code></li>
<li><code>s</code> has no leading or trailing spaces and exactly one space between tokens.</li>
<li><code>s</code> and every word contain only lowercase letters.</li>
<li><code>words</code> contains no duplicates.</li>
<li>Each token keeps its source word's first and last character and permutes only the interior.</li>
</ul>$cp$,
  $h$["A token has the same letters as its source word, but sorting the letters alone collides for mutual anagrams like \"listen\" and \"silent\".", "Add the first and last characters to the key: (first, last, sorted letters). Build a map from that key to the word, then each token is a single lookup."]$h$::jsonb,
  $tt$[{"name": "Hash Table", "slug": "hash-table"}, {"name": "String", "slug": "string"}, {"name": "Sorting", "slug": "sorting"}]$tt$::jsonb,
  'Custom',
  $sc${"python3":"from typing import List\n\n\nclass Solution:\n    def decodeSentence(self, s: str, words: List[str]) -> str:\n        # Write your solution here\n        pass\n\n\n# Implement the method above, then press Run.\nimport unittest\n\n\nclass TestDecodeSentence(unittest.TestCase):\n    def test_examples(self):\n        # Straight from the problem statement.\n        self.assertEqual(\n            Solution().decodeSentence(\n                \"hlleo wrlod my nmae is kihem\",\n                [\"hello\", \"world\", \"name\", \"my\", \"is\", \"khiem\"],\n            ),\n            \"hello world my name is khiem\",\n        )\n\n    def test_mutual_anagrams(self):\n        # Same letters; the fixed first/last characters tell them apart.\n        self.assertEqual(\n            Solution().decodeSentence(\"ltsien snelit\", [\"listen\", \"silent\"]),\n            \"listen silent\",\n        )\n\n    def test_repeats_and_short_words(self):\n        # A word may be reused; length-1 \"a\" never changes.\n        self.assertEqual(\n            Solution().decodeSentence(\"tset a tset\", [\"test\", \"a\"]),\n            \"test a test\",\n        )\n\n    def test_single_token(self):\n        # interior of \"code\" reordered to \"cdoe\".\n        self.assertEqual(Solution().decodeSentence(\"cdoe\", [\"code\"]), \"code\")\n\n\nif __name__ == \"__main__\":\n    unittest.main(verbosity=2)\n","java":"import java.util.*;\n\nclass Solution {\n    // Replace each token in s with its dictionary source word; return the sentence.\n    String decodeSentence(String s, String[] words) {\n        // Write your solution here\n        return \"\";\n    }\n}\n\n// Implement the method above, then press Run.\nclass Main {\n    static int ran = 0, failed = 0;\n    static StringBuilder dots = new StringBuilder();\n    static List<String> fails = new ArrayList<>();\n\n    static void runTest(String name, Runnable r) {\n        ran++;\n        try { r.run(); dots.append('.'); }\n        catch (AssertionError e) { failed++; dots.append('F'); fails.add(\"FAIL: \" + name + \": \" + e.getMessage()); }\n        catch (Throwable t) { failed++; dots.append('E'); fails.add(\"ERROR: \" + name + \": \" + t); }\n    }\n\n    static void assertEq(Object got, Object want) {\n        if (!Objects.equals(got, want)) throw new AssertionError(\"expected \" + want + \" but got \" + got);\n    }\n\n    public static void main(String[] args) {\n        runTest(\"test_examples\", () -> {\n            assertEq(new Solution().decodeSentence(\"hlleo wrlod my nmae is kihem\",\n                new String[]{\"hello\", \"world\", \"name\", \"my\", \"is\", \"khiem\"}),\n                \"hello world my name is khiem\");\n        });\n        runTest(\"test_mutual_anagrams\", () -> {\n            assertEq(new Solution().decodeSentence(\"ltsien snelit\",\n                new String[]{\"listen\", \"silent\"}), \"listen silent\");\n        });\n        runTest(\"test_repeats_and_short_words\", () -> {\n            assertEq(new Solution().decodeSentence(\"tset a tset\",\n                new String[]{\"test\", \"a\"}), \"test a test\");\n        });\n        runTest(\"test_single_token\", () -> {\n            assertEq(new Solution().decodeSentence(\"cdoe\",\n                new String[]{\"code\"}), \"code\");\n        });\n        report();\n    }\n\n    static void report() {\n        System.err.println(dots.toString());\n        for (String f : fails) System.err.println(f);\n        System.err.println(\"----------------------------------------------------------------------\");\n        System.err.println(\"Ran \" + ran + \" test\" + (ran == 1 ? \"\" : \"s\"));\n        System.err.println();\n        System.err.println(failed == 0 ? \"OK\" : \"FAILED (failures=\" + failed + \")\");\n    }\n}\n","javascript":"/**\n * @param {string} s\n * @param {string[]} words\n * @return {string}\n */\nvar decodeSentence = function (s, words) {\n  // Write your solution here\n};\n\n// Implement the function above, then press Run.\n(function () {\n  let ran = 0, failed = 0;\n  const dots = [], fails = [];\n\n  function fail(msg) { const e = new Error(msg); e.__assert = true; throw e; }\n  function runTest(name, fn) {\n    ran++;\n    try { fn(); dots.push(\".\"); }\n    catch (e) { failed++; dots.push(e && e.__assert ? \"F\" : \"E\"); fails.push((e && e.__assert ? \"FAIL: \" : \"ERROR: \") + name + \": \" + (e && e.message ? e.message : e)); }\n  }\n  function assertEq(got, want) { if (got !== want) fail(\"expected \" + want + \" but got \" + got); }\n\n  runTest(\"test_examples\", function () {\n    assertEq(decodeSentence(\"hlleo wrlod my nmae is kihem\", [\"hello\", \"world\", \"name\", \"my\", \"is\", \"khiem\"]), \"hello world my name is khiem\");\n  });\n  runTest(\"test_mutual_anagrams\", function () {\n    assertEq(decodeSentence(\"ltsien snelit\", [\"listen\", \"silent\"]), \"listen silent\");\n  });\n  runTest(\"test_repeats_and_short_words\", function () {\n    assertEq(decodeSentence(\"tset a tset\", [\"test\", \"a\"]), \"test a test\");\n  });\n  runTest(\"test_single_token\", function () {\n    assertEq(decodeSentence(\"cdoe\", [\"code\"]), \"code\");\n  });\n\n  console.error(dots.join(\"\"));\n  fails.forEach((f) => console.error(f));\n  console.error(\"----------------------------------------------------------------------\");\n  console.error(\"Ran \" + ran + \" test\" + (ran === 1 ? \"\" : \"s\"));\n  console.error(\"\");\n  console.error(failed === 0 ? \"OK\" : \"FAILED (failures=\" + failed + \")\");\n})();\n"}$sc$::jsonb,
  now()
)
on conflict (id) do update set
  frontend_id = excluded.frontend_id, title = excluded.title,
  title_slug = excluded.title_slug, difficulty = excluded.difficulty,
  source = 'custom', question_id = excluded.question_id,
  content = excluded.content, hints = excluded.hints,
  topic_tags = excluded.topic_tags, category_title = excluded.category_title,
  starter_code = excluded.starter_code,
  detail_synced_at = excluded.detail_synced_at;
