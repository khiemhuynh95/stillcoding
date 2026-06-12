// Current humanize batch. Authored by hand, then applied via apply-humanize.mjs.
// HTML uses template literals so quotes/newlines need no escaping.

export default [
  {
    id: "1",
    title: "Find the Two Indices That Add Up",
    tags: [
      { name: "Array", slug: "array" },
      { name: "Hash Table", slug: "hash-table" },
    ],
    content: `<p>You are given an array of whole numbers <code>nums</code> and a single target number <code>target</code>. Find the two positions in the array whose values add up to <code>target</code>, and return those positions.</p>

<p>Every test has exactly one valid pair, and you cannot use the same position twice.</p>

<p>Return the two positions as a list, with the <strong>smaller index first</strong>.</p>

<p>&nbsp;</p>
<p><strong class="example">Example 1:</strong></p>

<pre>
<strong>Input:</strong> nums = [2,7,11,15], target = 9
<strong>Output:</strong> [0,1]
<strong>Explanation:</strong> nums[0] + nums[1] = 2 + 7 = 9, so the answer is [0, 1].
</pre>

<p><strong class="example">Example 2:</strong></p>

<pre>
<strong>Input:</strong> nums = [3,2,4], target = 6
<strong>Output:</strong> [1,2]
</pre>

<p><strong class="example">Example 3:</strong></p>

<pre>
<strong>Input:</strong> nums = [3,3], target = 6
<strong>Output:</strong> [0,1]
</pre>

<p>&nbsp;</p>
<p><strong>Constraints:</strong></p>

<ul>
	<li><code>2 &lt;= nums.length &lt;= 10<sup>4</sup></code></li>
	<li><code>-10<sup>9</sup> &lt;= nums[i] &lt;= 10<sup>9</sup></code></li>
	<li><code>-10<sup>9</sup> &lt;= target &lt;= 10<sup>9</sup></code></li>
	<li><strong>Exactly one valid answer exists.</strong></li>
</ul>

<p>&nbsp;</p>
<p><strong>Follow-up:</strong> Can you design an algorithm that runs faster than <code>O(n<sup>2</sup>)</code> time?</p>`,
  },
  {
    id: "10",
    title: "Match a String Against a Simple Pattern",
    tags: [
      { name: "String", slug: "string" },
      { name: "Dynamic Programming", slug: "dynamic-programming" },
      { name: "Recursion", slug: "recursion" },
    ],
    content: `<p>You are given a text string <code>s</code> and a pattern <code>p</code>. Build a matcher that supports two special characters:</p>

<ul>
	<li><code>'.'</code> matches any single character.</li>
	<li><code>'*'</code> matches <strong>one or more</strong> copies of the character right before it.</li>
</ul>

<p>The match must cover the whole text, not just a part of it. Return <code>true</code> only if the pattern matches all of <code>s</code>, otherwise return <code>false</code>.</p>

<p>&nbsp;</p>
<p><strong class="example">Example 1:</strong></p>

<pre>
<strong>Input:</strong> s = "aa", p = "a"
<strong>Output:</strong> false
<strong>Explanation:</strong> "a" does not match the whole string "aa".
</pre>

<p><strong class="example">Example 2:</strong></p>

<pre>
<strong>Input:</strong> s = "aa", p = "a*"
<strong>Output:</strong> true
<strong>Explanation:</strong> 'a*' means one or more copies of 'a'. Using two copies gives "aa".
</pre>

<p><strong class="example">Example 3:</strong></p>

<pre>
<strong>Input:</strong> s = "ab", p = ".*"
<strong>Output:</strong> true
<strong>Explanation:</strong> '.*' means one or more of any single character, which can cover "ab".
</pre>

<p>&nbsp;</p>
<p><strong>Constraints:</strong></p>

<ul>
	<li><code>1 &lt;= s.length &lt;= 20</code></li>
	<li><code>1 &lt;= p.length &lt;= 20</code></li>
	<li><code>s</code> contains only lowercase English letters.</li>
	<li><code>p</code> contains only lowercase English letters, <code>'.'</code>, and <code>'*'</code>.</li>
	<li>For each <code>'*'</code>, there is a valid character before it to repeat.</li>
</ul>`,
  },
];
