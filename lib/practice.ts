/*
 * ─────────────────────────────────────────────────────────────────────────
 * PREPRACTICE — per-topic syntax review.
 *
 * For each Roadmap topic, a read-only "cheat sheet" the user can skim before
 * solving: the core syntax, data structures, and idioms they'll reach for.
 * Keyed by RoadmapNode.id (see lib/roadmap.ts), so a topic with no entry here
 * simply has no practice page yet.
 *
 * Each section carries snippets keyed by language id (see lib/starterTemplates
 * LANGUAGES). The practice page shows the snippet for the editor's currently
 * selected language and falls back to `python3` (always authored) when a
 * language hasn't been written yet — add languages by filling in `snippets`.
 * ─────────────────────────────────────────────────────────────────────────
 */
import { DEFAULT_LANGUAGE } from "@/lib/starterTemplates";

export interface PracticeSection {
  title: string;
  note?: string; // one-line context shown above the code
  /** code per language id; `python3` is always present. */
  snippets: Partial<Record<string, string>> & { python3: string };
}

export interface TopicPractice {
  summary: string;
  sections: PracticeSection[];
}

export const PRACTICE: Record<string, TopicPractice> = {
  "arrays-hashing": {
    summary:
      "Lists for ordered data, dicts/sets for O(1) lookup. Most array problems come down to one well-chosen hash map.",
    sections: [
      {
        title: "List basics",
        note: "Create, index, slice, and iterate.",
        snippets: {
          python3: `nums = [3, 1, 4]
nums.append(1)          # add to end
nums[0], nums[-1]       # first, last
nums[1:3]               # slice -> [1, 4]
for i, x in enumerate(nums):
    print(i, x)`,
          javascript: `const nums = [3, 1, 4];
nums.push(1);              // add to end
nums[0], nums.at(-1);      // first, last
nums.slice(1, 3);          // -> [1, 4]
nums.forEach((x, i) => {
  console.log(i, x);
});`,
        },
      },
      {
        title: "Hash map (dict / object)",
        note: "Key → value lookup in O(1). The workhorse of this topic.",
        snippets: {
          python3: `seen = {}
seen["a"] = 1
seen.get("b", 0)        # default if missing
if "a" in seen: ...
for key, val in seen.items():
    print(key, val)`,
          javascript: `const seen = new Map();
seen.set("a", 1);
seen.get("b") ?? 0;       // default if missing
if (seen.has("a")) { /* ... */ }
for (const [key, val] of seen) {
  console.log(key, val);
}`,
        },
      },
      {
        title: "Set for membership",
        note: "Track what you've seen with O(1) add / contains.",
        snippets: {
          python3: `seen = set()
seen.add(4)
4 in seen               # True
len(seen)`,
          javascript: `const seen = new Set();
seen.add(4);
seen.has(4);            // true
seen.size;`,
        },
      },
      {
        title: "Counting frequencies",
        note: "Counter (or a dict) tallies occurrences in one pass.",
        snippets: {
          python3: `from collections import Counter
freq = Counter("aabbc")     # {'a':2,'b':2,'c':1}
freq.most_common(1)         # [('a', 2)]

# manual:
d = {}
for x in nums:
    d[x] = d.get(x, 0) + 1`,
          javascript: `const freq = new Map();
for (const ch of "aabbc") {
  freq.set(ch, (freq.get(ch) ?? 0) + 1);
}
// freq: a->2, b->2, c->1`,
        },
      },
    ],
  },

  "two-pointers": {
    summary:
      "Two indices moving through a sorted array (or from both ends) replace a nested loop, turning O(n²) into O(n).",
    sections: [
      {
        title: "Converging pointers",
        note: "Start at both ends, move inward based on a comparison.",
        snippets: {
          python3: `l, r = 0, len(nums) - 1
while l < r:
    total = nums[l] + nums[r]
    if total == target:
        return [l, r]
    elif total < target:
        l += 1
    else:
        r -= 1`,
          javascript: `let l = 0, r = nums.length - 1;
while (l < r) {
  const total = nums[l] + nums[r];
  if (total === target) return [l, r];
  else if (total < target) l++;
  else r--;
}`,
        },
      },
      {
        title: "Same-direction (fast / slow)",
        note: "One pointer writes, the other scans — e.g. in-place filtering.",
        snippets: {
          python3: `slow = 0
for fast in range(len(nums)):
    if nums[fast] != 0:
        nums[slow] = nums[fast]
        slow += 1`,
          javascript: `let slow = 0;
for (let fast = 0; fast < nums.length; fast++) {
  if (nums[fast] !== 0) {
    nums[slow++] = nums[fast];
  }
}`,
        },
      },
      {
        title: "Skip duplicates",
        note: "Common in 3Sum-style problems on a sorted array.",
        snippets: {
          python3: `i = 0
while i < len(nums):
    if i > 0 and nums[i] == nums[i - 1]:
        i += 1
        continue
    # ... process nums[i]
    i += 1`,
          javascript: `for (let i = 0; i < nums.length; i++) {
  if (i > 0 && nums[i] === nums[i - 1]) continue;
  // ... process nums[i]
}`,
        },
      },
    ],
  },

  stack: {
    summary:
      "A LIFO list: push to the end, pop from the end. Great for matching pairs and 'next greater' scans.",
    sections: [
      {
        title: "Stack via a list",
        note: "push, pop, and peek — all O(1) at the end.",
        snippets: {
          python3: `stack = []
stack.append(1)      # push
stack.append(2)
stack[-1]            # peek -> 2
stack.pop()          # pop  -> 2
len(stack) == 0      # is empty?`,
          javascript: `const stack = [];
stack.push(1);          // push
stack.push(2);
stack[stack.length - 1]; // peek -> 2
stack.pop();            // pop  -> 2
stack.length === 0;     // is empty?`,
        },
      },
      {
        title: "Matching pairs",
        note: "Push openers, pop and check on each closer.",
        snippets: {
          python3: `pairs = {")": "(", "]": "[", "}": "{"}
stack = []
for c in s:
    if c in pairs:
        if not stack or stack.pop() != pairs[c]:
            return False
    else:
        stack.append(c)
return not stack`,
          javascript: `const pairs = { ")": "(", "]": "[", "}": "{" };
const stack = [];
for (const c of s) {
  if (c in pairs) {
    if (stack.pop() !== pairs[c]) return false;
  } else {
    stack.push(c);
  }
}
return stack.length === 0;`,
        },
      },
      {
        title: "Monotonic stack",
        note: "Keep indices increasing/decreasing for 'next greater' queries.",
        snippets: {
          python3: `stack = []  # indices, values decreasing
res = [0] * len(nums)
for i, x in enumerate(nums):
    while stack and nums[stack[-1]] < x:
        j = stack.pop()
        res[j] = i - j      # distance to next greater
    stack.append(i)`,
          javascript: `const stack = []; // indices, values decreasing
const res = new Array(nums.length).fill(0);
for (let i = 0; i < nums.length; i++) {
  while (stack.length && nums[stack.at(-1)] < nums[i]) {
    const j = stack.pop();
    res[j] = i - j;
  }
  stack.push(i);
}`,
        },
      },
    ],
  },

  "sliding-window": {
    summary:
      "A window [l, r] expands and contracts over a sequence so each element is visited at most twice — O(n) instead of recomputing subarrays.",
    sections: [
      {
        title: "Variable-size window",
        note: "Grow right; shrink left while a constraint is violated.",
        snippets: {
          python3: `l = 0
window = {}
best = 0
for r, c in enumerate(s):
    window[c] = window.get(c, 0) + 1
    while window[c] > 1:          # invalid -> shrink
        window[s[l]] -= 1
        l += 1
    best = max(best, r - l + 1)`,
          javascript: `let l = 0, best = 0;
const window = new Map();
for (let r = 0; r < s.length; r++) {
  const c = s[r];
  window.set(c, (window.get(c) ?? 0) + 1);
  while (window.get(c) > 1) {        // invalid -> shrink
    window.set(s[l], window.get(s[l]) - 1);
    l++;
  }
  best = Math.max(best, r - l + 1);
}`,
        },
      },
      {
        title: "Fixed-size window",
        note: "Slide a window of length k, adding one and dropping one.",
        snippets: {
          python3: `k = 3
total = sum(nums[:k])
best = total
for r in range(k, len(nums)):
    total += nums[r] - nums[r - k]
    best = max(best, total)`,
          javascript: `const k = 3;
let total = 0;
for (let i = 0; i < k; i++) total += nums[i];
let best = total;
for (let r = k; r < nums.length; r++) {
  total += nums[r] - nums[r - k];
  best = Math.max(best, total);
}`,
        },
      },
    ],
  },

  "binary-search": {
    summary:
      "Halve the search space each step on sorted (or monotonic) data — O(log n). The danger is always the boundary conditions.",
    sections: [
      {
        title: "Classic search",
        note: "Inclusive [lo, hi]; loop while lo <= hi.",
        snippets: {
          python3: `lo, hi = 0, len(nums) - 1
while lo <= hi:
    mid = (lo + hi) // 2
    if nums[mid] == target:
        return mid
    elif nums[mid] < target:
        lo = mid + 1
    else:
        hi = mid - 1
return -1`,
          javascript: `let lo = 0, hi = nums.length - 1;
while (lo <= hi) {
  const mid = (lo + hi) >> 1;
  if (nums[mid] === target) return mid;
  else if (nums[mid] < target) lo = mid + 1;
  else hi = mid - 1;
}
return -1;`,
        },
      },
      {
        title: "Leftmost boundary",
        note: "Find the first index where a condition becomes true.",
        snippets: {
          python3: `lo, hi = 0, len(nums)      # half-open [lo, hi)
while lo < hi:
    mid = (lo + hi) // 2
    if nums[mid] < target:
        lo = mid + 1
    else:
        hi = mid
return lo                  # first index >= target`,
          javascript: `let lo = 0, hi = nums.length;   // half-open
while (lo < hi) {
  const mid = (lo + hi) >> 1;
  if (nums[mid] < target) lo = mid + 1;
  else hi = mid;
}
return lo;                      // first index >= target`,
        },
      },
      {
        title: "Built-in bisect (Python)",
        note: "The standard library already does the boundary math.",
        snippets: {
          python3: `from bisect import bisect_left, bisect_right
bisect_left(nums, x)    # first index >= x
bisect_right(nums, x)   # first index >  x`,
          javascript: `// JS has no built-in; implement the boundary
// search above, or use a sorted structure lib.`,
        },
      },
    ],
  },

  "linked-list": {
    summary:
      "Nodes linked by next pointers. A dummy head and careful pointer rewiring handle most insert/remove/reverse problems.",
    sections: [
      {
        title: "Node and traversal",
        note: "Walk the list until you fall off the end.",
        snippets: {
          python3: `class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

cur = head
while cur:
    print(cur.val)
    cur = cur.next`,
          javascript: `class ListNode {
  constructor(val = 0, next = null) {
    this.val = val;
    this.next = next;
  }
}

let cur = head;
while (cur) {
  console.log(cur.val);
  cur = cur.next;
}`,
        },
      },
      {
        title: "Reverse in place",
        note: "Three pointers: remember next, flip, advance.",
        snippets: {
          python3: `prev = None
cur = head
while cur:
    nxt = cur.next
    cur.next = prev
    prev = cur
    cur = nxt
return prev   # new head`,
          javascript: `let prev = null, cur = head;
while (cur) {
  const nxt = cur.next;
  cur.next = prev;
  prev = cur;
  cur = nxt;
}
return prev;   // new head`,
        },
      },
      {
        title: "Dummy head",
        note: "A sentinel node avoids special-casing the real head.",
        snippets: {
          python3: `dummy = ListNode(0, head)
prev = dummy
# ... rewire prev.next as needed ...
return dummy.next`,
          javascript: `const dummy = new ListNode(0, head);
let prev = dummy;
// ... rewire prev.next as needed ...
return dummy.next;`,
        },
      },
      {
        title: "Fast / slow pointers",
        note: "Detect cycles or find the middle in one pass.",
        snippets: {
          python3: `slow = fast = head
while fast and fast.next:
    slow = slow.next
    fast = fast.next.next
    if slow is fast:
        return True   # cycle
# slow is now the middle`,
          javascript: `let slow = head, fast = head;
while (fast && fast.next) {
  slow = slow.next;
  fast = fast.next.next;
  if (slow === fast) return true;  // cycle
}
// slow is now the middle`,
        },
      },
    ],
  },

  trees: {
    summary:
      "Binary trees are recursive by nature: solve a node in terms of its children. DFS for depth, a queue (BFS) for levels.",
    sections: [
      {
        title: "Node definition",
        snippets: {
          python3: `class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right`,
          javascript: `class TreeNode {
  constructor(val = 0, left = null, right = null) {
    this.val = val;
    this.left = left;
    this.right = right;
  }
}`,
        },
      },
      {
        title: "DFS (recursion)",
        note: "Base case on null; combine the two subtree results.",
        snippets: {
          python3: `def max_depth(node):
    if not node:
        return 0
    return 1 + max(max_depth(node.left),
                   max_depth(node.right))`,
          javascript: `function maxDepth(node) {
  if (!node) return 0;
  return 1 + Math.max(maxDepth(node.left),
                      maxDepth(node.right));
}`,
        },
      },
      {
        title: "BFS (level order)",
        note: "A queue processes the tree one level at a time.",
        snippets: {
          python3: `from collections import deque
q = deque([root])
while q:
    for _ in range(len(q)):   # one level
        node = q.popleft()
        if node.left:  q.append(node.left)
        if node.right: q.append(node.right)`,
          javascript: `let q = [root];
while (q.length) {
  const next = [];
  for (const node of q) {       // one level
    if (node.left) next.push(node.left);
    if (node.right) next.push(node.right);
  }
  q = next;
}`,
        },
      },
    ],
  },

  heap: {
    summary:
      "A heap keeps the smallest (or largest) item reachable in O(1) and inserts/removes in O(log n) — ideal for 'top k' and streaming-min problems.",
    sections: [
      {
        title: "Min-heap basics",
        note: "Python's heapq is a min-heap over a plain list.",
        snippets: {
          python3: `import heapq
h = []
heapq.heappush(h, 3)
heapq.heappush(h, 1)
h[0]                 # peek smallest -> 1
heapq.heappop(h)     # remove smallest -> 1
heapq.heapify(nums)  # O(n) build in place`,
          javascript: `// JS has no built-in heap — use a library
// (e.g. @datastructures-js/priority-queue)
// or implement push/pop with bubble up/down.
const pq = new MinPriorityQueue();
pq.enqueue(3);
pq.front().element;   // peek
pq.dequeue();         // remove min`,
        },
      },
      {
        title: "Max-heap trick",
        note: "Negate values to get max-heap behaviour from a min-heap.",
        snippets: {
          python3: `import heapq
h = []
for x in nums:
    heapq.heappush(h, -x)   # push negatives
largest = -heapq.heappop(h) # negate back`,
          javascript: `// With a generic PQ, pass a comparator:
const pq = new MaxPriorityQueue();
pq.enqueue(5);
pq.dequeue().element;   // largest`,
        },
      },
      {
        title: "Top-k with a bounded heap",
        note: "Keep a heap of size k; pop the smallest when it overflows.",
        snippets: {
          python3: `import heapq
h = []
for x in nums:
    heapq.heappush(h, x)
    if len(h) > k:
        heapq.heappop(h)   # drop smallest
# h holds the k largest; h[0] is the kth largest`,
          javascript: `const pq = new MinPriorityQueue();
for (const x of nums) {
  pq.enqueue(x);
  if (pq.size() > k) pq.dequeue();
}
// pq holds the k largest`,
        },
      },
    ],
  },

  backtracking: {
    summary:
      "Build a candidate incrementally, recurse, then undo the choice ('backtrack'). Every subset/permutation/combination problem is this template.",
    sections: [
      {
        title: "Core template",
        note: "Choose → recurse → un-choose.",
        snippets: {
          python3: `res = []
def backtrack(start, path):
    res.append(path[:])          # record a solution
    for i in range(start, len(nums)):
        path.append(nums[i])     # choose
        backtrack(i + 1, path)   # explore
        path.pop()               # un-choose
backtrack(0, [])`,
          javascript: `const res = [];
function backtrack(start, path) {
  res.push([...path]);            // record
  for (let i = start; i < nums.length; i++) {
    path.push(nums[i]);           // choose
    backtrack(i + 1, path);       // explore
    path.pop();                   // un-choose
  }
}
backtrack(0, []);`,
        },
      },
      {
        title: "Permutations (used set)",
        note: "Track which elements are already in the current path.",
        snippets: {
          python3: `res, used = [], [False] * len(nums)
def backtrack(path):
    if len(path) == len(nums):
        res.append(path[:])
        return
    for i in range(len(nums)):
        if used[i]:
            continue
        used[i] = True
        path.append(nums[i])
        backtrack(path)
        path.pop()
        used[i] = False`,
          javascript: `const res = [], used = Array(nums.length).fill(false);
function backtrack(path) {
  if (path.length === nums.length) {
    res.push([...path]);
    return;
  }
  for (let i = 0; i < nums.length; i++) {
    if (used[i]) continue;
    used[i] = true;
    path.push(nums[i]);
    backtrack(path);
    path.pop();
    used[i] = false;
  }
}`,
        },
      },
    ],
  },

  graphs: {
    summary:
      "Model the graph as an adjacency list, then DFS (recursion/stack) or BFS (queue) — remembering to mark visited nodes so you don't loop forever.",
    sections: [
      {
        title: "Build an adjacency list",
        note: "Map each node to its neighbours.",
        snippets: {
          python3: `from collections import defaultdict
adj = defaultdict(list)
for u, v in edges:
    adj[u].append(v)
    adj[v].append(u)   # omit for directed`,
          javascript: `const adj = new Map();
for (const [u, v] of edges) {
  if (!adj.has(u)) adj.set(u, []);
  if (!adj.has(v)) adj.set(v, []);
  adj.get(u).push(v);
  adj.get(v).push(u);   // omit for directed
}`,
        },
      },
      {
        title: "DFS with visited set",
        snippets: {
          python3: `visited = set()
def dfs(node):
    if node in visited:
        return
    visited.add(node)
    for nei in adj[node]:
        dfs(nei)`,
          javascript: `const visited = new Set();
function dfs(node) {
  if (visited.has(node)) return;
  visited.add(node);
  for (const nei of adj.get(node) ?? []) {
    dfs(nei);
  }
}`,
        },
      },
      {
        title: "BFS / grid traversal",
        note: "Queue from a start; expand in 4 directions on a grid.",
        snippets: {
          python3: `from collections import deque
q = deque([(0, 0)])
seen = {(0, 0)}
while q:
    r, c = q.popleft()
    for dr, dc in ((1,0),(-1,0),(0,1),(0,-1)):
        nr, nc = r + dr, c + dc
        if (nr, nc) not in seen and in_bounds(nr, nc):
            seen.add((nr, nc))
            q.append((nr, nc))`,
          javascript: `let q = [[0, 0]];
const seen = new Set(["0,0"]);
while (q.length) {
  const next = [];
  for (const [r, c] of q) {
    for (const [dr, dc] of [[1,0],[-1,0],[0,1],[0,-1]]) {
      const nr = r + dr, nc = c + dc, key = nr + "," + nc;
      if (!seen.has(key) && inBounds(nr, nc)) {
        seen.add(key);
        next.push([nr, nc]);
      }
    }
  }
  q = next;
}`,
        },
      },
    ],
  },

  "dynamic-programming": {
    summary:
      "Break a problem into overlapping subproblems and cache each answer once. Start from the recurrence, then turn it into a table (bottom-up) or a memo (top-down).",
    sections: [
      {
        title: "Bottom-up table",
        note: "Fill a dp array from the base cases forward.",
        snippets: {
          python3: `dp = [0] * (n + 1)
dp[1] = 1
for i in range(2, n + 1):
    dp[i] = dp[i - 1] + dp[i - 2]
return dp[n]`,
          javascript: `const dp = new Array(n + 1).fill(0);
dp[1] = 1;
for (let i = 2; i <= n; i++) {
  dp[i] = dp[i - 1] + dp[i - 2];
}
return dp[n];`,
        },
      },
      {
        title: "Rolling variables",
        note: "When dp[i] only needs the last few states, drop the array.",
        snippets: {
          python3: `prev, cur = 0, 1
for _ in range(n):
    prev, cur = cur, prev + cur
return prev`,
          javascript: `let prev = 0, cur = 1;
for (let i = 0; i < n; i++) {
  [prev, cur] = [cur, prev + cur];
}
return prev;`,
        },
      },
      {
        title: "Top-down memoization",
        note: "Recurse, but cache each subproblem's result.",
        snippets: {
          python3: `from functools import lru_cache
@lru_cache(None)
def solve(i):
    if i <= 1:
        return i
    return solve(i - 1) + solve(i - 2)`,
          javascript: `const memo = new Map();
function solve(i) {
  if (i <= 1) return i;
  if (memo.has(i)) return memo.get(i);
  const res = solve(i - 1) + solve(i - 2);
  memo.set(i, res);
  return res;
}`,
        },
      },
    ],
  },
};

export function getPractice(topicId: string): TopicPractice | undefined {
  return PRACTICE[topicId];
}

/**
 * Resolve the snippet to show for a section in the chosen language, falling
 * back to the always-present `python3` authoring when that language is missing.
 */
export function resolveSnippet(
  section: PracticeSection,
  langId: string,
): { code: string; isFallback: boolean } {
  const code = section.snippets[langId];
  if (code != null) return { code, isFallback: false };
  return { code: section.snippets[DEFAULT_LANGUAGE], isFallback: true };
}
