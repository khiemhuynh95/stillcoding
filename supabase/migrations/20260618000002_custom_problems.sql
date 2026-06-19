-- StillCoding — custom problems (DB-backed)
--
-- Moves the in-code custom problems (C1/C2/C3) into the catalog table as
-- `source='custom'` rows, so the app reads them from the DB like any other
-- problem (lib/customProblems.ts and its merge in lib/leetcode.ts are removed).
-- Add future custom problems as another such row.
--
-- Safe across the daily sync: it upserts LeetCode rows by `id` and never
-- deletes, and these custom ids ("custom-<slug>") never collide with LeetCode
-- ids, so custom rows are left untouched. RLS keeps them anon read-only.
-- Idempotent: re-running updates the row in place.

insert into public.problems
  (id, frontend_id, title, title_slug, url, difficulty, paid_only,
   has_solution, has_video_solution, source, question_id, content,
   hints, topic_tags, category_title, starter_code, detail_synced_at)
values (
  'custom-add-digits-until-one', 'C1', 'Add Digits Until One', 'add-digits-until-one', '',
  'Easy', false, false, false, 'custom', 'custom-add-digits-until-one',
  $cp$<p>Given a non-negative integer <code>n</code>, repeatedly add all its digits until the result has only a single digit, and return that digit.</p>
<p><strong>Example 1:</strong></p>
<pre>Input: n = 38
Output: 2
Explanation: 3 + 8 = 11, then 1 + 1 = 2. Since 2 has only one digit, return it.</pre>
<p><strong>Example 2:</strong></p>
<pre>Input: n = 0
Output: 0</pre>
<p><strong>Constraints:</strong></p>
<ul><li><code>0 &lt;= n &lt;= 2<sup>31</sup> - 1</code></li></ul>$cp$,
  $h$["A simple loop that sums the digits and repeats works in O(log n).", "There is also a constant-time formula using properties of 9 (the digital root)."]$h$::jsonb,
  $tt$[{"name": "Math", "slug": "math"}]$tt$::jsonb,
  'Custom',
  $sc${"python3": "class Solution:\n    def addDigits(self, n: int) -> int:\n        # Write your solution here\n        pass\n\n\n# Implement the method above, then press Run.\nimport unittest\n\n\nclass TestAddDigits(unittest.TestCase):\n    def test_examples(self):\n        # Straight from the problem statement.\n        self.assertEqual(Solution().addDigits(38), 2)\n        self.assertEqual(Solution().addDigits(0), 0)\n\n    def test_single_digit_returns_itself(self):\n        # Anything already one digit is returned unchanged.\n        for n in range(10):\n            self.assertEqual(Solution().addDigits(n), n)\n\n    def test_multiples_of_nine(self):\n        # The digital root of any positive multiple of 9 is 9.\n        self.assertEqual(Solution().addDigits(9), 9)\n        self.assertEqual(Solution().addDigits(18), 9)\n        self.assertEqual(Solution().addDigits(99), 9)\n\n    def test_larger_values(self):\n        self.assertEqual(Solution().addDigits(10), 1)\n        self.assertEqual(Solution().addDigits(199), 1)        # 19 -> 10 -> 1\n        self.assertEqual(Solution().addDigits(123456789), 9)  # sum 45 -> 9\n\n\nif __name__ == \"__main__\":\n    unittest.main(verbosity=2)\n", "javascript": "/**\n * @param {number} n\n * @return {number}\n */\nvar addDigits = function (n) {\n  // Write your solution here\n};\n", "typescript": "function addDigits(n: number): number {\n  // Write your solution here\n  return 0;\n}\n"}$sc$::jsonb,
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

insert into public.problems
  (id, frontend_id, title, title_slug, url, difficulty, paid_only,
   has_solution, has_video_solution, source, question_id, content,
   hints, topic_tags, category_title, starter_code, detail_synced_at)
values (
  'custom-balanced-brackets', 'C2', 'Balanced Brackets', 'balanced-brackets', '',
  'Medium', false, false, false, 'custom', 'custom-balanced-brackets',
  $cp$<p>Given a string <code>s</code> containing only the characters <code>()[]{}</code>, determine whether the brackets are balanced — every opening bracket is closed by the same type, in the correct order.</p>
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
</ul>$cp$,
  $h$["Push opening brackets onto a stack; on a closing bracket, pop and compare."]$h$::jsonb,
  $tt$[{"name": "String", "slug": "string"}, {"name": "Stack", "slug": "stack"}]$tt$::jsonb,
  'Custom',
  $sc${"python3": "class Solution:\n    def isBalanced(self, s: str) -> bool:\n        # Write your solution here\n        pass\n\n\n# Implement the method above, then press Run.\nimport unittest\n\n\nclass TestBalancedBrackets(unittest.TestCase):\n    def test_examples(self):\n        # Straight from the problem statement.\n        self.assertTrue(Solution().isBalanced(\"{[()]}\"))\n        self.assertFalse(Solution().isBalanced(\"([)]\"))\n\n    def test_simple_pairs(self):\n        self.assertTrue(Solution().isBalanced(\"()\"))\n        self.assertTrue(Solution().isBalanced(\"[]\"))\n        self.assertTrue(Solution().isBalanced(\"{}\"))\n\n    def test_unbalanced(self):\n        self.assertFalse(Solution().isBalanced(\"(\"))    # opened, never closed\n        self.assertFalse(Solution().isBalanced(\")\"))    # closes nothing\n        self.assertFalse(Solution().isBalanced(\"(]\"))   # closed by wrong type\n\n    def test_nested_and_sequential(self):\n        self.assertTrue(Solution().isBalanced(\"()[]{}\"))\n        self.assertTrue(Solution().isBalanced(\"{[]()}\"))\n        self.assertTrue(Solution().isBalanced(\"((()))\"))\n        self.assertFalse(Solution().isBalanced(\"(()\"))  # one left open\n\n\nif __name__ == \"__main__\":\n    unittest.main(verbosity=2)\n", "javascript": "/**\n * @param {string} s\n * @return {boolean}\n */\nvar isBalanced = function (s) {\n  // Write your solution here\n};\n"}$sc$::jsonb,
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

insert into public.problems
  (id, frontend_id, title, title_slug, url, difficulty, paid_only,
   has_solution, has_video_solution, source, question_id, content,
   hints, topic_tags, category_title, starter_code, detail_synced_at)
values (
  'custom-cloud-gaming-membership-billing', 'C3', 'Cloud Gaming — Membership & Billing', 'cloud-gaming-membership-billing', '',
  'Medium', false, false, false, 'custom', 'custom-cloud-gaming-membership-billing',
  $cp$<p>You're building the billing system for a cloud gaming service. Members stream game sessions, and depending on their membership tier they get a number of free sessions before they start paying an hourly rate. This is a multi-part <em>build &amp; debug</em> exercise — implement the methods and fix the planted bug, then run the bundled <code>unittest</code> suite.</p>
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
<p>Sessions beyond the free quota are charged at the tier's hourly rate. Each charged session's duration is rounded <strong>up</strong> to the next whole hour before billing (e.g. 90 minutes → 2 hours). The first N sessions in a member's list are the free ones.</p>$cp$,
  $h$["Task 1: the loop only matches one of the two paid tiers \u2014 both PLUS and MAX should count.", "Task 3: use math.ceil(duration_minutes / 60) for the billed hours, and skip the first N (free) sessions per tier."]$h$::jsonb,
  $tt$[{"name": "Design", "slug": "design"}, {"name": "Simulation", "slug": "simulation"}]$tt$::jsonb,
  'Custom',
  $sc${"python3": "from enum import Enum\n\n\nclass MemberType(Enum):\n    FREE = 1\n    PLUS = 2\n    MAX = 3\n\n\nclass Session:\n    def __init__(self, session_id, start_time, end_time):\n        self.session_id = session_id\n        self.start_time = start_time\n        self.end_time = end_time\n\n    def get_duration(self):\n        return self.end_time - self.start_time\n\n\nclass Member:\n    def __init__(self, member_id, member_type, sessions=None):\n        self.id = member_id\n        self.member_type = member_type\n        self.sessions = list(sessions) if sessions else []\n\n    def add_session(self, session):\n        self.sessions.append(session)\n\n\nclass MemberShip:\n    def __init__(self, members=None):\n        self.members = list(members) if members else []\n\n    def add_member(self, member):\n        self.members.append(member)\n\n    # ---- Task 1 --------------------------------------------------------\n    def count_paid_members(self):\n        count = 0\n        for member in self.members:\n            if member.member_type == MemberType.PLUS:\n                count += 1\n        return count\n\n    # ---- Task 2 --------------------------------------------------------\n    def get_avg_durations(self):\n        pass\n\n    # ---- Task 3 --------------------------------------------------------\n    def get_due_payments(self):\n        pass\n\n\n# Implement the methods and fix the bug above, then press Run.\nimport unittest\n\n\nclass TestMembership(unittest.TestCase):\n    def setUp(self):\n        m1 = Member(1, MemberType.FREE, [\n            Session(1, 0, 30),       # 30\n            Session(2, 60, 120),     # 60\n            Session(3, 180, 300),    # 120\n        ])\n        m2 = Member(2, MemberType.PLUS, [\n            Session(4, 0, 60),       # 60\n            Session(5, 120, 180),    # 60\n            Session(6, 240, 300),    # 60\n            Session(7, 360, 450),    # 90\n        ])\n        m3 = Member(3, MemberType.MAX, [\n            Session(8, 0, 45),       # 45\n            Session(9, 60, 135),     # 75\n        ])\n        m4 = Member(4, MemberType.FREE)\n        self.membership = MemberShip([m1, m2, m3, m4])\n\n    def test_count_paid_members(self):\n        self.assertEqual(self.membership.count_paid_members(), 2)\n\n    def test_avg_durations(self):\n        avg = self.membership.get_avg_durations()\n        self.assertAlmostEqual(avg[1], 70.0)\n        self.assertAlmostEqual(avg[2], 67.5)\n        self.assertAlmostEqual(avg[3], 60.0)\n        self.assertIsNone(avg[4])\n\n    def test_due_payments(self):\n        due = self.membership.get_due_payments()\n        self.assertAlmostEqual(due[1], 30.0)\n        self.assertAlmostEqual(due[2], 16.0)\n        self.assertAlmostEqual(due[3], 0.0)\n        self.assertAlmostEqual(due[4], 0.0)\n\n\nif __name__ == \"__main__\":\n    unittest.main(verbosity=2)\n", "java": "import java.util.*;\n\nenum MemberType { FREE, PLUS, MAX }\n\nclass Session {\n    int sessionId, startTime, endTime;\n\n    Session(int sessionId, int startTime, int endTime) {\n        this.sessionId = sessionId;\n        this.startTime = startTime;\n        this.endTime = endTime;\n    }\n\n    int getDuration() {\n        return endTime - startTime;\n    }\n}\n\nclass Member {\n    int id;\n    MemberType memberType;\n    List<Session> sessions;\n\n    Member(int id, MemberType memberType, List<Session> sessions) {\n        this.id = id;\n        this.memberType = memberType;\n        this.sessions = sessions != null ? new ArrayList<>(sessions) : new ArrayList<>();\n    }\n\n    Member(int id, MemberType memberType) {\n        this(id, memberType, null);\n    }\n\n    void addSession(Session session) {\n        sessions.add(session);\n    }\n}\n\nclass MemberShip {\n    List<Member> members;\n\n    MemberShip(List<Member> members) {\n        this.members = members != null ? new ArrayList<>(members) : new ArrayList<>();\n    }\n\n    MemberShip() {\n        this(null);\n    }\n\n    void addMember(Member member) {\n        members.add(member);\n    }\n\n    // ---- Task 1 (has a bug) --------------------------------------------\n    int countPaidMembers() {\n        int count = 0;\n        for (Member member : members) {\n            if (member.memberType == MemberType.PLUS) {\n                count++;\n            }\n        }\n        return count;\n    }\n\n    // ---- Task 2 --------------------------------------------------------\n    // Return { memberId: averageSessionDurationMinutes }; null for no sessions.\n    Map<Integer, Double> getAvgDurations() {\n        return null;\n    }\n\n    // ---- Task 3 --------------------------------------------------------\n    // Return { memberId: amountDue }.\n    Map<Integer, Double> getDuePayments() {\n        return null;\n    }\n}\n\n// Implement the methods and fix the bug above, then press Run.\nclass Main {\n    static int ran = 0, failed = 0;\n    static StringBuilder dots = new StringBuilder();\n    static List<String> fails = new ArrayList<>();\n\n    static MemberShip build() {\n        Member m1 = new Member(1, MemberType.FREE, Arrays.asList(\n            new Session(1, 0, 30), new Session(2, 60, 120), new Session(3, 180, 300)));\n        Member m2 = new Member(2, MemberType.PLUS, Arrays.asList(\n            new Session(4, 0, 60), new Session(5, 120, 180),\n            new Session(6, 240, 300), new Session(7, 360, 450)));\n        Member m3 = new Member(3, MemberType.MAX, Arrays.asList(\n            new Session(8, 0, 45), new Session(9, 60, 135)));\n        Member m4 = new Member(4, MemberType.FREE);\n        return new MemberShip(Arrays.asList(m1, m2, m3, m4));\n    }\n\n    static void runTest(String name, Runnable r) {\n        ran++;\n        try { r.run(); dots.append('.'); }\n        catch (AssertionError e) { failed++; dots.append('F'); fails.add(\"FAIL: \" + name + \": \" + e.getMessage()); }\n        catch (Throwable t) { failed++; dots.append('E'); fails.add(\"ERROR: \" + name + \": \" + t); }\n    }\n\n    static void assertEq(Object got, Object want) {\n        if (!Objects.equals(got, want)) throw new AssertionError(\"expected \" + want + \" but got \" + got);\n    }\n\n    static void assertClose(Double got, double want) {\n        if (got == null || Math.abs(got - want) > 1e-6) throw new AssertionError(\"expected \" + want + \" but got \" + got);\n    }\n\n    static void assertNull(Object got) {\n        if (got != null) throw new AssertionError(\"expected null but got \" + got);\n    }\n\n    public static void main(String[] args) {\n        runTest(\"test_count_paid_members\", () -> {\n            assertEq(build().countPaidMembers(), 2);\n        });\n        runTest(\"test_avg_durations\", () -> {\n            Map<Integer, Double> avg = build().getAvgDurations();\n            assertClose(avg.get(1), 70.0);\n            assertClose(avg.get(2), 67.5);\n            assertClose(avg.get(3), 60.0);\n            assertNull(avg.get(4));\n        });\n        runTest(\"test_due_payments\", () -> {\n            Map<Integer, Double> due = build().getDuePayments();\n            assertClose(due.get(1), 30.0);\n            assertClose(due.get(2), 16.0);\n            assertClose(due.get(3), 0.0);\n            assertClose(due.get(4), 0.0);\n        });\n        report();\n    }\n\n    static void report() {\n        System.err.println(dots.toString());\n        for (String f : fails) System.err.println(f);\n        System.err.println(\"----------------------------------------------------------------------\");\n        System.err.println(\"Ran \" + ran + \" test\" + (ran == 1 ? \"\" : \"s\"));\n        System.err.println();\n        System.err.println(failed == 0 ? \"OK\" : \"FAILED (failures=\" + failed + \")\");\n    }\n}\n", "javascript": "const MemberType = { FREE: \"FREE\", PLUS: \"PLUS\", MAX: \"MAX\" };\n\nclass Session {\n  constructor(sessionId, startTime, endTime) {\n    this.sessionId = sessionId;\n    this.startTime = startTime;\n    this.endTime = endTime;\n  }\n  getDuration() {\n    return this.endTime - this.startTime;\n  }\n}\n\nclass Member {\n  constructor(id, memberType, sessions) {\n    this.id = id;\n    this.memberType = memberType;\n    this.sessions = sessions ? sessions.slice() : [];\n  }\n  addSession(session) {\n    this.sessions.push(session);\n  }\n}\n\nclass MemberShip {\n  constructor(members) {\n    this.members = members ? members.slice() : [];\n  }\n  addMember(member) {\n    this.members.push(member);\n  }\n\n  // ---- Task 1 (has a bug) ----------------------------------------------\n  countPaidMembers() {\n    let count = 0;\n    for (const member of this.members) {\n      if (member.memberType === MemberType.PLUS) {\n        count++;\n      }\n    }\n    return count;\n  }\n\n  // ---- Task 2 ----------------------------------------------------------\n  // Return { memberId: averageSessionDurationMinutes }; null for no sessions.\n  getAvgDurations() {}\n\n  // ---- Task 3 ----------------------------------------------------------\n  // Return { memberId: amountDue }.\n  getDuePayments() {}\n}\n\n// Implement the methods and fix the bug above, then press Run.\n(function () {\n  let ran = 0, failed = 0;\n  const dots = [], fails = [];\n\n  function build() {\n    const m1 = new Member(1, MemberType.FREE, [new Session(1, 0, 30), new Session(2, 60, 120), new Session(3, 180, 300)]);\n    const m2 = new Member(2, MemberType.PLUS, [new Session(4, 0, 60), new Session(5, 120, 180), new Session(6, 240, 300), new Session(7, 360, 450)]);\n    const m3 = new Member(3, MemberType.MAX, [new Session(8, 0, 45), new Session(9, 60, 135)]);\n    const m4 = new Member(4, MemberType.FREE);\n    return new MemberShip([m1, m2, m3, m4]);\n  }\n\n  function fail(msg) { const e = new Error(msg); e.__assert = true; throw e; }\n  function runTest(name, fn) {\n    ran++;\n    try { fn(); dots.push(\".\"); }\n    catch (e) { failed++; dots.push(e && e.__assert ? \"F\" : \"E\"); fails.push((e && e.__assert ? \"FAIL: \" : \"ERROR: \") + name + \": \" + (e && e.message ? e.message : e)); }\n  }\n  function assertEq(got, want) { if (got !== want) fail(\"expected \" + want + \" but got \" + got); }\n  function assertClose(got, want) { if (got == null || Math.abs(got - want) > 1e-6) fail(\"expected \" + want + \" but got \" + got); }\n  function assertNull(got) { if (got != null) fail(\"expected null but got \" + got); }\n\n  runTest(\"test_count_paid_members\", function () {\n    assertEq(build().countPaidMembers(), 2);\n  });\n  runTest(\"test_avg_durations\", function () {\n    const avg = build().getAvgDurations();\n    assertClose(avg[1], 70.0);\n    assertClose(avg[2], 67.5);\n    assertClose(avg[3], 60.0);\n    assertNull(avg[4]);\n  });\n  runTest(\"test_due_payments\", function () {\n    const due = build().getDuePayments();\n    assertClose(due[1], 30.0);\n    assertClose(due[2], 16.0);\n    assertClose(due[3], 0.0);\n    assertClose(due[4], 0.0);\n  });\n\n  console.error(dots.join(\"\"));\n  fails.forEach((f) => console.error(f));\n  console.error(\"----------------------------------------------------------------------\");\n  console.error(\"Ran \" + ran + \" test\" + (ran === 1 ? \"\" : \"s\"));\n  console.error(\"\");\n  console.error(failed === 0 ? \"OK\" : \"FAILED (failures=\" + failed + \")\");\n})();\n"}$sc$::jsonb,
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

