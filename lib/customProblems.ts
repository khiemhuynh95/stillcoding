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
 *
 * Running code is Python-only (in-browser via Pyodide) and just executes the
 * editor buffer. There is no separate grader — if you want a problem to be
 * runnable with example checks, put a small `unittest` block (or plain prints)
 * straight in `starterCode.python3` so it shows in the editor; the solver edits
 * and runs their own test cases from there.
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


# Implement the method above, then press Run.
import unittest


class TestAddDigits(unittest.TestCase):
    def test_examples(self):
        # Straight from the problem statement.
        self.assertEqual(Solution().addDigits(38), 2)
        self.assertEqual(Solution().addDigits(0), 0)

    def test_single_digit_returns_itself(self):
        # Anything already one digit is returned unchanged.
        for n in range(10):
            self.assertEqual(Solution().addDigits(n), n)

    def test_multiples_of_nine(self):
        # The digital root of any positive multiple of 9 is 9.
        self.assertEqual(Solution().addDigits(9), 9)
        self.assertEqual(Solution().addDigits(18), 9)
        self.assertEqual(Solution().addDigits(99), 9)

    def test_larger_values(self):
        self.assertEqual(Solution().addDigits(10), 1)
        self.assertEqual(Solution().addDigits(199), 1)        # 19 -> 10 -> 1
        self.assertEqual(Solution().addDigits(123456789), 9)  # sum 45 -> 9


if __name__ == "__main__":
    unittest.main(verbosity=2)
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


# Implement the method above, then press Run.
import unittest


class TestBalancedBrackets(unittest.TestCase):
    def test_examples(self):
        # Straight from the problem statement.
        self.assertTrue(Solution().isBalanced("{[()]}"))
        self.assertFalse(Solution().isBalanced("([)]"))

    def test_simple_pairs(self):
        self.assertTrue(Solution().isBalanced("()"))
        self.assertTrue(Solution().isBalanced("[]"))
        self.assertTrue(Solution().isBalanced("{}"))

    def test_unbalanced(self):
        self.assertFalse(Solution().isBalanced("("))    # opened, never closed
        self.assertFalse(Solution().isBalanced(")"))    # closes nothing
        self.assertFalse(Solution().isBalanced("(]"))   # closed by wrong type

    def test_nested_and_sequential(self):
        self.assertTrue(Solution().isBalanced("()[]{}"))
        self.assertTrue(Solution().isBalanced("{[]()}"))
        self.assertTrue(Solution().isBalanced("((()))"))
        self.assertFalse(Solution().isBalanced("(()"))  # one left open


if __name__ == "__main__":
    unittest.main(verbosity=2)
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
  {
    frontend_id: "C3",
    title: "Cloud Gaming — Membership & Billing",
    title_slug: "cloud-gaming-membership-billing",
    difficulty: "Medium",
    tags: ["Design", "Simulation"],
    content: `<p>You're building the billing system for a cloud gaming service. Members stream game sessions, and depending on their membership tier they get a number of free sessions before they start paying an hourly rate. This is a multi-part <em>build &amp; debug</em> exercise — implement the methods and fix the planted bug, then run the bundled <code>unittest</code> suite.</p>
<p><strong>Data model</strong></p>
<ul>
<li><code>MemberType</code> : FREE, PLUS, MAX. Only PLUS and MAX are <em>paid</em> memberships.</li>
<li><code>Session</code> : <code>session_id</code>, <code>start_time</code>, <code>end_time</code> (start/end are ints, in minutes).</li>
<li><code>Member</code> : <code>id</code>, <code>member_type</code>, and a list of <code>Session</code> objects.</li>
<li><code>MemberShip</code> : holds a list of <code>Member</code>s.</li>
</ul>
<p><strong>Task 1 — Bug fix.</strong> <code>count_paid_members()</code> should count members on a paid tier (PLUS or MAX), but it returns the wrong number. Find and fix the bug.</p>
<p><strong>Task 2 — Average duration.</strong> Implement <code>get_avg_durations()</code>: return a map (member id → average session duration in minutes). For a session, duration = <code>end_time - start_time</code>. A member with no sessions maps to <code>None</code>.</p>
<p><strong>Task 3 — Due payments.</strong> Implement <code>get_due_payments()</code> returning <code>{member_id: amount_due}</code>. Billing rules:</p>
<ul>
<li>FREE : first 1 session free, then $10/hour</li>
<li>PLUS : first 3 sessions free, then $8/hour</li>
<li>MAX&nbsp; : first 6 sessions free, then $10/hour</li>
</ul>
<p>Sessions beyond the free quota are charged at the tier's hourly rate. Each charged session's duration is rounded <strong>up</strong> to the next whole hour before billing (e.g. 90 minutes → 2 hours). The first N sessions in a member's list are the free ones.</p>`,
    hints: [
      "Task 1: the loop only matches one of the two paid tiers — both PLUS and MAX should count.",
      "Task 3: use math.ceil(duration_minutes / 60) for the billed hours, and skip the first N (free) sessions per tier.",
    ],
    starterCode: {
      python3: `from enum import Enum


class MemberType(Enum):
    FREE = 1
    PLUS = 2
    MAX = 3


class Session:
    def __init__(self, session_id, start_time, end_time):
        self.session_id = session_id
        self.start_time = start_time
        self.end_time = end_time

    def get_duration(self):
        return self.end_time - self.start_time


class Member:
    def __init__(self, member_id, member_type, sessions=None):
        self.id = member_id
        self.member_type = member_type
        self.sessions = list(sessions) if sessions else []

    def add_session(self, session):
        self.sessions.append(session)


class MemberShip:
    def __init__(self, members=None):
        self.members = list(members) if members else []

    def add_member(self, member):
        self.members.append(member)

    # ---- Task 1 --------------------------------------------------------
    def count_paid_members(self):
        count = 0
        for member in self.members:
            if member.member_type == MemberType.PLUS:
                count += 1
        return count

    # ---- Task 2 --------------------------------------------------------
    def get_avg_durations(self):
        pass

    # ---- Task 3 --------------------------------------------------------
    def get_due_payments(self):
        pass


# Implement the methods and fix the bug above, then press Run.
import unittest


class TestMembership(unittest.TestCase):
    def setUp(self):
        m1 = Member(1, MemberType.FREE, [
            Session(1, 0, 30),       # 30
            Session(2, 60, 120),     # 60
            Session(3, 180, 300),    # 120
        ])
        m2 = Member(2, MemberType.PLUS, [
            Session(4, 0, 60),       # 60
            Session(5, 120, 180),    # 60
            Session(6, 240, 300),    # 60
            Session(7, 360, 450),    # 90
        ])
        m3 = Member(3, MemberType.MAX, [
            Session(8, 0, 45),       # 45
            Session(9, 60, 135),     # 75
        ])
        m4 = Member(4, MemberType.FREE)
        self.membership = MemberShip([m1, m2, m3, m4])

    def test_count_paid_members(self):
        self.assertEqual(self.membership.count_paid_members(), 2)

    def test_avg_durations(self):
        avg = self.membership.get_avg_durations()
        self.assertAlmostEqual(avg[1], 70.0)
        self.assertAlmostEqual(avg[2], 67.5)
        self.assertAlmostEqual(avg[3], 60.0)
        self.assertIsNone(avg[4])

    def test_due_payments(self):
        due = self.membership.get_due_payments()
        self.assertAlmostEqual(due[1], 30.0)
        self.assertAlmostEqual(due[2], 16.0)
        self.assertAlmostEqual(due[3], 0.0)
        self.assertAlmostEqual(due[4], 0.0)


if __name__ == "__main__":
    unittest.main(verbosity=2)
`,
      java: `import java.util.*;

enum MemberType { FREE, PLUS, MAX }

class Session {
    int sessionId, startTime, endTime;

    Session(int sessionId, int startTime, int endTime) {
        this.sessionId = sessionId;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    int getDuration() {
        return endTime - startTime;
    }
}

class Member {
    int id;
    MemberType memberType;
    List<Session> sessions;

    Member(int id, MemberType memberType, List<Session> sessions) {
        this.id = id;
        this.memberType = memberType;
        this.sessions = sessions != null ? new ArrayList<>(sessions) : new ArrayList<>();
    }

    Member(int id, MemberType memberType) {
        this(id, memberType, null);
    }

    void addSession(Session session) {
        sessions.add(session);
    }
}

class MemberShip {
    List<Member> members;

    MemberShip(List<Member> members) {
        this.members = members != null ? new ArrayList<>(members) : new ArrayList<>();
    }

    MemberShip() {
        this(null);
    }

    void addMember(Member member) {
        members.add(member);
    }

    // ---- Task 1 (has a bug) --------------------------------------------
    int countPaidMembers() {
        int count = 0;
        for (Member member : members) {
            if (member.memberType == MemberType.PLUS) {
                count++;
            }
        }
        return count;
    }

    // ---- Task 2 --------------------------------------------------------
    // Return { memberId: averageSessionDurationMinutes }; null for no sessions.
    Map<Integer, Double> getAvgDurations() {
        return null;
    }

    // ---- Task 3 --------------------------------------------------------
    // Return { memberId: amountDue }.
    Map<Integer, Double> getDuePayments() {
        return null;
    }
}

// Implement the methods and fix the bug above, then press Run.
class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static MemberShip build() {
        Member m1 = new Member(1, MemberType.FREE, Arrays.asList(
            new Session(1, 0, 30), new Session(2, 60, 120), new Session(3, 180, 300)));
        Member m2 = new Member(2, MemberType.PLUS, Arrays.asList(
            new Session(4, 0, 60), new Session(5, 120, 180),
            new Session(6, 240, 300), new Session(7, 360, 450)));
        Member m3 = new Member(3, MemberType.MAX, Arrays.asList(
            new Session(8, 0, 45), new Session(9, 60, 135)));
        Member m4 = new Member(4, MemberType.FREE);
        return new MemberShip(Arrays.asList(m1, m2, m3, m4));
    }

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!Objects.equals(got, want)) throw new AssertionError("expected " + want + " but got " + got);
    }

    static void assertClose(Double got, double want) {
        if (got == null || Math.abs(got - want) > 1e-6) throw new AssertionError("expected " + want + " but got " + got);
    }

    static void assertNull(Object got) {
        if (got != null) throw new AssertionError("expected null but got " + got);
    }

    public static void main(String[] args) {
        runTest("test_count_paid_members", () -> {
            assertEq(build().countPaidMembers(), 2);
        });
        runTest("test_avg_durations", () -> {
            Map<Integer, Double> avg = build().getAvgDurations();
            assertClose(avg.get(1), 70.0);
            assertClose(avg.get(2), 67.5);
            assertClose(avg.get(3), 60.0);
            assertNull(avg.get(4));
        });
        runTest("test_due_payments", () -> {
            Map<Integer, Double> due = build().getDuePayments();
            assertClose(due.get(1), 30.0);
            assertClose(due.get(2), 16.0);
            assertClose(due.get(3), 0.0);
            assertClose(due.get(4), 0.0);
        });
        report();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }
}
`,
      javascript: `const MemberType = { FREE: "FREE", PLUS: "PLUS", MAX: "MAX" };

class Session {
  constructor(sessionId, startTime, endTime) {
    this.sessionId = sessionId;
    this.startTime = startTime;
    this.endTime = endTime;
  }
  getDuration() {
    return this.endTime - this.startTime;
  }
}

class Member {
  constructor(id, memberType, sessions) {
    this.id = id;
    this.memberType = memberType;
    this.sessions = sessions ? sessions.slice() : [];
  }
  addSession(session) {
    this.sessions.push(session);
  }
}

class MemberShip {
  constructor(members) {
    this.members = members ? members.slice() : [];
  }
  addMember(member) {
    this.members.push(member);
  }

  // ---- Task 1 (has a bug) ----------------------------------------------
  countPaidMembers() {
    let count = 0;
    for (const member of this.members) {
      if (member.memberType === MemberType.PLUS) {
        count++;
      }
    }
    return count;
  }

  // ---- Task 2 ----------------------------------------------------------
  // Return { memberId: averageSessionDurationMinutes }; null for no sessions.
  getAvgDurations() {}

  // ---- Task 3 ----------------------------------------------------------
  // Return { memberId: amountDue }.
  getDuePayments() {}
}

// Implement the methods and fix the bug above, then press Run.
(function () {
  let ran = 0, failed = 0;
  const dots = [], fails = [];

  function build() {
    const m1 = new Member(1, MemberType.FREE, [new Session(1, 0, 30), new Session(2, 60, 120), new Session(3, 180, 300)]);
    const m2 = new Member(2, MemberType.PLUS, [new Session(4, 0, 60), new Session(5, 120, 180), new Session(6, 240, 300), new Session(7, 360, 450)]);
    const m3 = new Member(3, MemberType.MAX, [new Session(8, 0, 45), new Session(9, 60, 135)]);
    const m4 = new Member(4, MemberType.FREE);
    return new MemberShip([m1, m2, m3, m4]);
  }

  function fail(msg) { const e = new Error(msg); e.__assert = true; throw e; }
  function runTest(name, fn) {
    ran++;
    try { fn(); dots.push("."); }
    catch (e) { failed++; dots.push(e && e.__assert ? "F" : "E"); fails.push((e && e.__assert ? "FAIL: " : "ERROR: ") + name + ": " + (e && e.message ? e.message : e)); }
  }
  function assertEq(got, want) { if (got !== want) fail("expected " + want + " but got " + got); }
  function assertClose(got, want) { if (got == null || Math.abs(got - want) > 1e-6) fail("expected " + want + " but got " + got); }
  function assertNull(got) { if (got != null) fail("expected null but got " + got); }

  runTest("test_count_paid_members", function () {
    assertEq(build().countPaidMembers(), 2);
  });
  runTest("test_avg_durations", function () {
    const avg = build().getAvgDurations();
    assertClose(avg[1], 70.0);
    assertClose(avg[2], 67.5);
    assertClose(avg[3], 60.0);
    assertNull(avg[4]);
  });
  runTest("test_due_payments", function () {
    const due = build().getDuePayments();
    assertClose(due[1], 30.0);
    assertClose(due[2], 16.0);
    assertClose(due[3], 0.0);
    assertClose(due[4], 0.0);
  });

  console.error(dots.join(""));
  fails.forEach((f) => console.error(f));
  console.error("----------------------------------------------------------------------");
  console.error("Ran " + ran + " test" + (ran === 1 ? "" : "s"));
  console.error("");
  console.error(failed === 0 ? "OK" : "FAILED (failures=" + failed + ")");
})();
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
