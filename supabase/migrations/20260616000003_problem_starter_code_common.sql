-- StillCoding — per-problem starter code (common catalog extras)
--
-- Same shape as the curated seeds: hand-authored, verified Python starters
-- for widely-known catalog problems outside the study lists. Keyed by
-- title_slug; a slug not in the catalog is a no-op. Column created earlier.

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def removeDuplicates(self, nums: list[int]) -> int:
        # Remove duplicates in place; return the new length k (first k unique).
        pass

import unittest


class TestRemoveDuplicates(unittest.TestCase):
    def test_example(self):
        nums = [1, 1, 2]
        k = Solution().removeDuplicates(nums)
        self.assertEqual(k, 2)
        self.assertEqual(nums[:k], [1, 2])

    def test_longer(self):
        nums = [0, 0, 1, 1, 1, 2, 2, 3, 3, 4]
        k = Solution().removeDuplicates(nums)
        self.assertEqual(nums[:k], [0, 1, 2, 3, 4])

    def test_single(self):
        nums = [1]
        self.assertEqual(Solution().removeDuplicates(nums), 1)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'remove-duplicates-from-sorted-array';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def removeElement(self, nums: list[int], val: int) -> int:
        # Remove all occurrences of val in place; return the new length.
        pass

import unittest


class TestRemoveElement(unittest.TestCase):
    def test_example(self):
        nums = [3, 2, 2, 3]
        k = Solution().removeElement(nums, 3)
        self.assertEqual(k, 2)
        self.assertEqual(sorted(nums[:k]), [2, 2])

    def test_mixed(self):
        nums = [0, 1, 2, 2, 3, 0, 4, 2]
        k = Solution().removeElement(nums, 2)
        self.assertEqual(sorted(nums[:k]), [0, 0, 1, 3, 4])

    def test_none_removed(self):
        nums = [1]
        self.assertEqual(Solution().removeElement(nums, 2), 1)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'remove-element';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def merge(self, nums1: list[int], m: int, nums2: list[int], n: int) -> None:
        # Merge nums2 into nums1 (length m+n, last n slots are 0), in place, sorted.
        pass

import unittest


class TestMergeSorted(unittest.TestCase):
    def test_example(self):
        nums1 = [1, 2, 3, 0, 0, 0]
        Solution().merge(nums1, 3, [2, 5, 6], 3)
        self.assertEqual(nums1, [1, 2, 2, 3, 5, 6])

    def test_empty_second(self):
        nums1 = [1]
        Solution().merge(nums1, 1, [], 0)
        self.assertEqual(nums1, [1])

    def test_empty_first(self):
        nums1 = [0]
        Solution().merge(nums1, 0, [1], 1)
        self.assertEqual(nums1, [1])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'merge-sorted-array';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def fizzBuzz(self, n: int) -> list[str]:
        # "Fizz"/"Buzz"/"FizzBuzz" for multiples of 3/5/both, else the number.
        pass

import unittest


class TestFizzBuzz(unittest.TestCase):
    def test_three(self):
        self.assertEqual(Solution().fizzBuzz(3), ["1", "2", "Fizz"])

    def test_five(self):
        self.assertEqual(Solution().fizzBuzz(5), ["1", "2", "Fizz", "4", "Buzz"])

    def test_fifteen(self):
        self.assertEqual(Solution().fizzBuzz(15)[-1], "FizzBuzz")


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'fizz-buzz';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def romanToInt(self, s: str) -> int:
        # Convert a Roman numeral to an integer.
        pass

import unittest


class TestRomanToInt(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().romanToInt("III"), 3)
        self.assertEqual(Solution().romanToInt("LVIII"), 58)

    def test_subtractive(self):
        self.assertEqual(Solution().romanToInt("MCMXCIV"), 1994)

    def test_four(self):
        self.assertEqual(Solution().romanToInt("IV"), 4)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'roman-to-integer';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def longestCommonPrefix(self, strs: list[str]) -> str:
        # Longest common prefix among all strings, or "".
        pass

import unittest


class TestLongestCommonPrefix(unittest.TestCase):
    def test_common(self):
        self.assertEqual(Solution().longestCommonPrefix(["flower", "flow", "flight"]), "fl")

    def test_none(self):
        self.assertEqual(Solution().longestCommonPrefix(["dog", "racecar", "car"]), "")

    def test_single(self):
        self.assertEqual(Solution().longestCommonPrefix(["a"]), "a")


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'longest-common-prefix';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def lengthOfLastWord(self, s: str) -> int:
        # Length of the last word in the string.
        pass

import unittest


class TestLengthOfLastWord(unittest.TestCase):
    def test_example(self):
        self.assertEqual(Solution().lengthOfLastWord("Hello World"), 5)

    def test_trailing_spaces(self):
        self.assertEqual(Solution().lengthOfLastWord("   fly me   to   the moon  "), 4)

    def test_single(self):
        self.assertEqual(Solution().lengthOfLastWord("a"), 1)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'length-of-last-word';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def reverseString(self, s: list[str]) -> None:
        # Reverse the list of characters in place.
        pass

import unittest


class TestReverseString(unittest.TestCase):
    def test_example(self):
        s = ["h", "e", "l", "l", "o"]
        Solution().reverseString(s)
        self.assertEqual(s, ["o", "l", "l", "e", "h"])

    def test_even(self):
        s = ["H", "a", "n", "n", "a", "h"]
        Solution().reverseString(s)
        self.assertEqual(s, ["h", "a", "n", "n", "a", "H"])

    def test_single(self):
        s = ["a"]
        Solution().reverseString(s)
        self.assertEqual(s, ["a"])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'reverse-string';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def reverseWords(self, s: str) -> str:
        # Reverse word order; collapse extra spaces.
        pass

import unittest


class TestReverseWords(unittest.TestCase):
    def test_example(self):
        self.assertEqual(Solution().reverseWords("the sky is blue"), "blue is sky the")

    def test_trim(self):
        self.assertEqual(Solution().reverseWords("  hello world  "), "world hello")

    def test_multiple_spaces(self):
        self.assertEqual(Solution().reverseWords("a good   example"), "example good a")


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'reverse-words-in-a-string';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def firstUniqChar(self, s: str) -> int:
        # Index of the first non-repeating character, or -1.
        pass

import unittest


class TestFirstUniqChar(unittest.TestCase):
    def test_example(self):
        self.assertEqual(Solution().firstUniqChar("leetcode"), 0)

    def test_later(self):
        self.assertEqual(Solution().firstUniqChar("loveleetcode"), 2)

    def test_none(self):
        self.assertEqual(Solution().firstUniqChar("aabb"), -1)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'first-unique-character-in-a-string';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def isIsomorphic(self, s: str, t: str) -> bool:
        # True if characters in s can be consistently mapped to t (bijection).
        pass

import unittest


class TestIsIsomorphic(unittest.TestCase):
    def test_true(self):
        self.assertTrue(Solution().isIsomorphic("egg", "add"))

    def test_false(self):
        self.assertFalse(Solution().isIsomorphic("foo", "bar"))

    def test_paper(self):
        self.assertTrue(Solution().isIsomorphic("paper", "title"))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'isomorphic-strings';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def wordPattern(self, pattern: str, s: str) -> bool:
        # True if s follows the same bijection structure as pattern.
        pass

import unittest


class TestWordPattern(unittest.TestCase):
    def test_true(self):
        self.assertTrue(Solution().wordPattern("abba", "dog cat cat dog"))

    def test_false(self):
        self.assertFalse(Solution().wordPattern("abba", "dog cat cat fish"))

    def test_length_mismatch(self):
        self.assertFalse(Solution().wordPattern("aaaa", "dog cat cat dog"))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'word-pattern';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def intersection(self, nums1: list[int], nums2: list[int]) -> list[int]:
        # Unique values present in both arrays (any order).
        pass

import unittest


class TestIntersection(unittest.TestCase):
    def test_example(self):
        self.assertEqual(set(Solution().intersection([1, 2, 2, 1], [2, 2])), {2})

    def test_multiple(self):
        self.assertEqual(set(Solution().intersection([4, 9, 5], [9, 4, 9, 8, 4])), {9, 4})

    def test_disjoint(self):
        self.assertEqual(set(Solution().intersection([1, 2], [3, 4])), set())


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'intersection-of-two-arrays';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def intersect(self, nums1: list[int], nums2: list[int]) -> list[int]:
        # Intersection including multiplicity (any order).
        pass

import unittest


class TestIntersectII(unittest.TestCase):
    def test_example(self):
        self.assertEqual(sorted(Solution().intersect([1, 2, 2, 1], [2, 2])), [2, 2])

    def test_multiple(self):
        self.assertEqual(sorted(Solution().intersect([4, 9, 5], [9, 4, 9, 8, 4])), [4, 9])

    def test_disjoint(self):
        self.assertEqual(Solution().intersect([1, 2], [3, 4]), [])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'intersection-of-two-arrays-ii';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def isPowerOfTwo(self, n: int) -> bool:
        # True if n is a power of two.
        pass

import unittest


class TestPowerOfTwo(unittest.TestCase):
    def test_powers(self):
        self.assertTrue(Solution().isPowerOfTwo(1))
        self.assertTrue(Solution().isPowerOfTwo(16))

    def test_non_powers(self):
        self.assertFalse(Solution().isPowerOfTwo(3))
        self.assertFalse(Solution().isPowerOfTwo(0))

    def test_negative(self):
        self.assertFalse(Solution().isPowerOfTwo(-2))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'power-of-two';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def fib(self, n: int) -> int:
        # The nth Fibonacci number (F(0)=0, F(1)=1).
        pass

import unittest


class TestFib(unittest.TestCase):
    def test_base(self):
        self.assertEqual(Solution().fib(0), 0)
        self.assertEqual(Solution().fib(1), 1)

    def test_examples(self):
        self.assertEqual(Solution().fib(2), 1)
        self.assertEqual(Solution().fib(3), 2)
        self.assertEqual(Solution().fib(4), 3)

    def test_larger(self):
        self.assertEqual(Solution().fib(10), 55)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'fibonacci-number';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def tribonacci(self, n: int) -> int:
        # T(0)=0, T(1)=T(2)=1, T(n)=T(n-1)+T(n-2)+T(n-3).
        pass

import unittest


class TestTribonacci(unittest.TestCase):
    def test_base(self):
        self.assertEqual(Solution().tribonacci(0), 0)
        self.assertEqual(Solution().tribonacci(1), 1)
        self.assertEqual(Solution().tribonacci(2), 1)

    def test_examples(self):
        self.assertEqual(Solution().tribonacci(4), 4)
        self.assertEqual(Solution().tribonacci(25), 1389537)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'n-th-tribonacci-number';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def pivotIndex(self, nums: list[int]) -> int:
        # Leftmost index where left sum == right sum, or -1.
        pass

import unittest


class TestPivotIndex(unittest.TestCase):
    def test_example(self):
        self.assertEqual(Solution().pivotIndex([1, 7, 3, 6, 5, 6]), 3)

    def test_none(self):
        self.assertEqual(Solution().pivotIndex([1, 2, 3]), -1)

    def test_leftmost(self):
        self.assertEqual(Solution().pivotIndex([2, 1, -1]), 0)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'find-pivot-index';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def runningSum(self, nums: list[int]) -> list[int]:
        # Cumulative running sum.
        pass

import unittest


class TestRunningSum(unittest.TestCase):
    def test_example(self):
        self.assertEqual(Solution().runningSum([1, 2, 3, 4]), [1, 3, 6, 10])

    def test_ones(self):
        self.assertEqual(Solution().runningSum([1, 1, 1, 1, 1]), [1, 2, 3, 4, 5])

    def test_single(self):
        self.assertEqual(Solution().runningSum([3]), [3])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'running-sum-of-1d-array';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def sortedSquares(self, nums: list[int]) -> list[int]:
        # Squares of each number, sorted ascending.
        pass

import unittest


class TestSortedSquares(unittest.TestCase):
    def test_example(self):
        self.assertEqual(Solution().sortedSquares([-4, -1, 0, 3, 10]), [0, 1, 9, 16, 100])

    def test_negatives(self):
        self.assertEqual(Solution().sortedSquares([-7, -3, 2, 3, 11]), [4, 9, 9, 49, 121])

    def test_single(self):
        self.assertEqual(Solution().sortedSquares([-2]), [4])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'squares-of-a-sorted-array';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def maxProfit(self, prices: list[int]) -> int:
        # Max profit with unlimited buy/sell (one share at a time).
        pass

import unittest


class TestMaxProfitII(unittest.TestCase):
    def test_example(self):
        self.assertEqual(Solution().maxProfit([7, 1, 5, 3, 6, 4]), 7)

    def test_monotonic(self):
        self.assertEqual(Solution().maxProfit([1, 2, 3, 4, 5]), 4)

    def test_decreasing(self):
        self.assertEqual(Solution().maxProfit([7, 6, 4, 3, 1]), 0)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'best-time-to-buy-and-sell-stock-ii';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def addStrings(self, num1: str, num2: str) -> str:
        # Sum of two non-negative integers given as strings (no int()).
        pass

import unittest


class TestAddStrings(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().addStrings("11", "123"), "134")
        self.assertEqual(Solution().addStrings("456", "77"), "533")

    def test_zero(self):
        self.assertEqual(Solution().addStrings("0", "0"), "0")

    def test_carry(self):
        self.assertEqual(Solution().addStrings("99", "1"), "100")


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'add-strings';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def minDepth(self, root: "TreeNode | None") -> int:
        # Nodes along the shortest root-to-leaf path.
        pass

import unittest


from collections import deque


def build_tree(vals):
    if not vals or vals[0] is None:
        return None
    root = TreeNode(vals[0])
    q = deque([root])
    i = 1
    while q and i < len(vals):
        node = q.popleft()
        if i < len(vals) and vals[i] is not None:
            node.left = TreeNode(vals[i])
            q.append(node.left)
        i += 1
        if i < len(vals) and vals[i] is not None:
            node.right = TreeNode(vals[i])
            q.append(node.right)
        i += 1
    return root


class TestMinDepth(unittest.TestCase):
    def test_example(self):
        self.assertEqual(Solution().minDepth(build_tree([3, 9, 20, None, None, 15, 7])), 2)

    def test_skewed(self):
        self.assertEqual(Solution().minDepth(build_tree([2, None, 3, None, 4, None, 5, None, 6])), 5)

    def test_empty(self):
        self.assertEqual(Solution().minDepth(build_tree([])), 0)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'minimum-depth-of-binary-tree';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def hasPathSum(self, root: "TreeNode | None", targetSum: int) -> bool:
        # True if some root-to-leaf path sums to targetSum.
        pass

import unittest


from collections import deque


def build_tree(vals):
    if not vals or vals[0] is None:
        return None
    root = TreeNode(vals[0])
    q = deque([root])
    i = 1
    while q and i < len(vals):
        node = q.popleft()
        if i < len(vals) and vals[i] is not None:
            node.left = TreeNode(vals[i])
            q.append(node.left)
        i += 1
        if i < len(vals) and vals[i] is not None:
            node.right = TreeNode(vals[i])
            q.append(node.right)
        i += 1
    return root


class TestHasPathSum(unittest.TestCase):
    def test_true(self):
        root = build_tree([5, 4, 8, 11, None, 13, 4, 7, 2, None, None, None, 1])
        self.assertTrue(Solution().hasPathSum(root, 22))

    def test_false(self):
        self.assertFalse(Solution().hasPathSum(build_tree([1, 2, 3]), 5))

    def test_empty(self):
        self.assertFalse(Solution().hasPathSum(build_tree([]), 0))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'path-sum';
