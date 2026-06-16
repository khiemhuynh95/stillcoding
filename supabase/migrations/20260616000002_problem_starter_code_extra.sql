-- StillCoding — per-problem starter code (curated extras)
--
-- Same shape as 20260616000001 (Blind 75): seeds problems.starter_code with
-- hand-authored, verified Python starters for the curated study-list problems
-- beyond Blind 75 (NeetCode 150 / Grind 75 / Top 100 Liked). Keyed by
-- title_slug; a slug not in the catalog is a no-op. The column is created by
-- the earlier migration; this only seeds rows.

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def twoSum(self, numbers: list[int], target: int) -> list[int]:
        # Sorted input; return the two 1-indexed positions that sum to target.
        pass

import unittest


class TestTwoSumII(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().twoSum([2, 7, 11, 15], 9), [1, 2])
        self.assertEqual(Solution().twoSum([2, 3, 4], 6), [1, 3])

    def test_negatives(self):
        self.assertEqual(Solution().twoSum([-1, 0], -1), [1, 2])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'two-sum-ii-input-array-is-sorted';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def search(self, nums: list[int], target: int) -> int:
        # Index of target in the sorted array, or -1.
        pass

import unittest


class TestBinarySearch(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().search([-1, 0, 3, 5, 9, 12], 9), 4)
        self.assertEqual(Solution().search([-1, 0, 3, 5, 9, 12], 2), -1)

    def test_single(self):
        self.assertEqual(Solution().search([5], 5), 0)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'binary-search';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def searchInsert(self, nums: list[int], target: int) -> int:
        # Index of target, or where it would be inserted to keep order.
        pass

import unittest


class TestSearchInsert(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().searchInsert([1, 3, 5, 6], 5), 2)
        self.assertEqual(Solution().searchInsert([1, 3, 5, 6], 2), 1)

    def test_ends(self):
        self.assertEqual(Solution().searchInsert([1, 3, 5, 6], 7), 4)
        self.assertEqual(Solution().searchInsert([1, 3, 5, 6], 0), 0)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'search-insert-position';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def searchMatrix(self, matrix: list[list[int]], target: int) -> bool:
        # Each row sorted; each row's first > previous row's last.
        pass

import unittest


class TestSearchMatrix(unittest.TestCase):
    def _m(self):
        return [[1, 3, 5, 7], [10, 11, 16, 20], [23, 30, 34, 60]]

    def test_present(self):
        self.assertTrue(Solution().searchMatrix(self._m(), 3))

    def test_absent(self):
        self.assertFalse(Solution().searchMatrix(self._m(), 13))

    def test_single(self):
        self.assertTrue(Solution().searchMatrix([[1]], 1))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'search-a-2d-matrix';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def minEatingSpeed(self, piles: list[int], h: int) -> int:
        # Smallest bananas/hour to finish all piles within h hours.
        pass

import unittest


class TestKoko(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().minEatingSpeed([3, 6, 7, 11], 8), 4)
        self.assertEqual(Solution().minEatingSpeed([30, 11, 23, 4, 20], 5), 30)

    def test_more_time(self):
        self.assertEqual(Solution().minEatingSpeed([30, 11, 23, 4, 20], 6), 23)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'koko-eating-bananas';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def searchRange(self, nums: list[int], target: int) -> list[int]:
        # First and last index of target, or [-1, -1].
        pass

import unittest


class TestSearchRange(unittest.TestCase):
    def test_found(self):
        self.assertEqual(Solution().searchRange([5, 7, 7, 8, 8, 10], 8), [3, 4])

    def test_missing(self):
        self.assertEqual(Solution().searchRange([5, 7, 7, 8, 8, 10], 6), [-1, -1])

    def test_empty(self):
        self.assertEqual(Solution().searchRange([], 0), [-1, -1])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'find-first-and-last-position-of-element-in-sorted-array';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def singleNumber(self, nums: list[int]) -> int:
        # Every element appears twice except one; find it.
        pass

import unittest


class TestSingleNumber(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().singleNumber([2, 2, 1]), 1)
        self.assertEqual(Solution().singleNumber([4, 1, 2, 1, 2]), 4)

    def test_single(self):
        self.assertEqual(Solution().singleNumber([1]), 1)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'single-number';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def majorityElement(self, nums: list[int]) -> int:
        # The element appearing more than n // 2 times.
        pass

import unittest


class TestMajorityElement(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().majorityElement([3, 2, 3]), 3)
        self.assertEqual(Solution().majorityElement([2, 2, 1, 1, 1, 2, 2]), 2)

    def test_single(self):
        self.assertEqual(Solution().majorityElement([1]), 1)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'majority-element';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def moveZeroes(self, nums: list[int]) -> None:
        # Move all 0s to the end in place, keeping relative order.
        pass

import unittest


class TestMoveZeroes(unittest.TestCase):
    def test_example(self):
        nums = [0, 1, 0, 3, 12]
        Solution().moveZeroes(nums)
        self.assertEqual(nums, [1, 3, 12, 0, 0])

    def test_single_zero(self):
        nums = [0]
        Solution().moveZeroes(nums)
        self.assertEqual(nums, [0])

    def test_no_zeroes(self):
        nums = [1, 2, 3]
        Solution().moveZeroes(nums)
        self.assertEqual(nums, [1, 2, 3])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'move-zeroes';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def plusOne(self, digits: list[int]) -> list[int]:
        # Add one to the integer represented by the digit array.
        pass

import unittest


class TestPlusOne(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().plusOne([1, 2, 3]), [1, 2, 4])
        self.assertEqual(Solution().plusOne([4, 3, 2, 1]), [4, 3, 2, 2])

    def test_carry(self):
        self.assertEqual(Solution().plusOne([9]), [1, 0])
        self.assertEqual(Solution().plusOne([9, 9]), [1, 0, 0])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'plus-one';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def isHappy(self, n: int) -> bool:
        # Repeatedly sum the squares of digits; happy if it reaches 1.
        pass

import unittest


class TestIsHappy(unittest.TestCase):
    def test_happy(self):
        self.assertTrue(Solution().isHappy(19))
        self.assertTrue(Solution().isHappy(1))

    def test_unhappy(self):
        self.assertFalse(Solution().isHappy(2))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'happy-number';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def sortColors(self, nums: list[int]) -> None:
        # Sort 0s, 1s, 2s in place (Dutch national flag).
        pass

import unittest


class TestSortColors(unittest.TestCase):
    def test_example(self):
        nums = [2, 0, 2, 1, 1, 0]
        Solution().sortColors(nums)
        self.assertEqual(nums, [0, 0, 1, 1, 2, 2])

    def test_small(self):
        nums = [2, 0, 1]
        Solution().sortColors(nums)
        self.assertEqual(nums, [0, 1, 2])

    def test_single(self):
        nums = [0]
        Solution().sortColors(nums)
        self.assertEqual(nums, [0])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'sort-colors';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def generate(self, numRows: int) -> list[list[int]]:
        # First numRows of Pascal's triangle.
        pass

import unittest


class TestPascal(unittest.TestCase):
    def test_example(self):
        self.assertEqual(
            Solution().generate(5),
            [[1], [1, 1], [1, 2, 1], [1, 3, 3, 1], [1, 4, 6, 4, 1]],
        )

    def test_one(self):
        self.assertEqual(Solution().generate(1), [[1]])

    def test_two(self):
        self.assertEqual(Solution().generate(2), [[1], [1, 1]])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'pascals-triangle';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def canConstruct(self, ransomNote: str, magazine: str) -> bool:
        # True if ransomNote can be built from magazine's letters.
        pass

import unittest


class TestRansomNote(unittest.TestCase):
    def test_examples(self):
        self.assertFalse(Solution().canConstruct("a", "b"))
        self.assertTrue(Solution().canConstruct("aa", "aab"))

    def test_insufficient(self):
        self.assertFalse(Solution().canConstruct("aa", "ab"))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'ransom-note';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def trap(self, height: list[int]) -> int:
        # Units of water trapped after raining.
        pass

import unittest


class TestTrap(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().trap([0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]), 6)
        self.assertEqual(Solution().trap([4, 2, 0, 3, 2, 5]), 9)

    def test_flat(self):
        self.assertEqual(Solution().trap([1, 1]), 0)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'trapping-rain-water';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def isValidSudoku(self, board: list[list[str]]) -> bool:
        # True if the filled cells violate no Sudoku row/col/box rule.
        pass

import unittest


def _valid():
    return [
        ["5", "3", ".", ".", "7", ".", ".", ".", "."],
        ["6", ".", ".", "1", "9", "5", ".", ".", "."],
        [".", "9", "8", ".", ".", ".", ".", "6", "."],
        ["8", ".", ".", ".", "6", ".", ".", ".", "3"],
        ["4", ".", ".", "8", ".", "3", ".", ".", "1"],
        ["7", ".", ".", ".", "2", ".", ".", ".", "6"],
        [".", "6", ".", ".", ".", ".", "2", "8", "."],
        [".", ".", ".", "4", "1", "9", ".", ".", "5"],
        [".", ".", ".", ".", "8", ".", ".", "7", "9"],
    ]


class TestValidSudoku(unittest.TestCase):
    def test_valid(self):
        self.assertTrue(Solution().isValidSudoku(_valid()))

    def test_invalid_column(self):
        board = _valid()
        board[0][0] = "8"  # conflicts with the 8 at row 3, col 0
        self.assertFalse(Solution().isValidSudoku(board))

    def test_empty_board(self):
        self.assertTrue(Solution().isValidSudoku([["."] * 9 for _ in range(9)]))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'valid-sudoku';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def checkInclusion(self, s1: str, s2: str) -> bool:
        # True if s2 contains a permutation of s1 as a substring.
        pass

import unittest


class TestCheckInclusion(unittest.TestCase):
    def test_examples(self):
        self.assertTrue(Solution().checkInclusion("ab", "eidbaooo"))
        self.assertFalse(Solution().checkInclusion("ab", "eidboaoo"))

    def test_single(self):
        self.assertTrue(Solution().checkInclusion("a", "a"))

    def test_too_long(self):
        self.assertFalse(Solution().checkInclusion("abc", "ccccbbbbaaaa"))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'permutation-in-string';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def findAnagrams(self, s: str, p: str) -> list[int]:
        # Start indices of every anagram of p found in s.
        pass

import unittest


class TestFindAnagrams(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().findAnagrams("cbaebabacd", "abc"), [0, 6])
        self.assertEqual(Solution().findAnagrams("abab", "ab"), [0, 1, 2])

    def test_none(self):
        self.assertEqual(Solution().findAnagrams("a", "aa"), [])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'find-all-anagrams-in-a-string';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def maxSlidingWindow(self, nums: list[int], k: int) -> list[int]:
        # Maximum of each contiguous window of size k.
        pass

import unittest


class TestMaxSlidingWindow(unittest.TestCase):
    def test_example(self):
        self.assertEqual(
            Solution().maxSlidingWindow([1, 3, -1, -3, 5, 3, 6, 7], 3),
            [3, 3, 5, 5, 6, 7],
        )

    def test_single(self):
        self.assertEqual(Solution().maxSlidingWindow([1], 1), [1])

    def test_window_one(self):
        self.assertEqual(Solution().maxSlidingWindow([1, -1], 1), [1, -1])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'sliding-window-maximum';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def generateParenthesis(self, n: int) -> list[str]:
        # All combinations of n well-formed parenthesis pairs (any order).
        pass

import unittest


class TestGenerateParenthesis(unittest.TestCase):
    def test_n3(self):
        self.assertEqual(
            set(Solution().generateParenthesis(3)),
            {"((()))", "(()())", "(())()", "()(())", "()()()"},
        )

    def test_n1(self):
        self.assertEqual(set(Solution().generateParenthesis(1)), {"()"})

    def test_count_n2(self):
        self.assertEqual(set(Solution().generateParenthesis(2)), {"(())", "()()"})


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'generate-parentheses';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def dailyTemperatures(self, temperatures: list[int]) -> list[int]:
        # Days to wait until a warmer temperature (0 if none).
        pass

import unittest


class TestDailyTemperatures(unittest.TestCase):
    def test_example(self):
        self.assertEqual(
            Solution().dailyTemperatures([73, 74, 75, 71, 69, 72, 76, 73]),
            [1, 1, 4, 2, 1, 1, 0, 0],
        )

    def test_increasing(self):
        self.assertEqual(Solution().dailyTemperatures([30, 40, 50, 60]), [1, 1, 1, 0])

    def test_short(self):
        self.assertEqual(Solution().dailyTemperatures([30, 60, 90]), [1, 1, 0])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'daily-temperatures';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def carFleet(self, target: int, position: list[int], speed: list[int]) -> int:
        # Number of car fleets that arrive at the target.
        pass

import unittest


class TestCarFleet(unittest.TestCase):
    def test_example(self):
        self.assertEqual(Solution().carFleet(12, [10, 8, 0, 5, 3], [2, 4, 1, 1, 3]), 3)

    def test_single(self):
        self.assertEqual(Solution().carFleet(10, [3], [3]), 1)

    def test_all_merge(self):
        self.assertEqual(Solution().carFleet(100, [0, 2, 4], [4, 2, 1]), 1)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'car-fleet';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def largestRectangleArea(self, heights: list[int]) -> int:
        # Area of the largest rectangle in the histogram.
        pass

import unittest


class TestLargestRectangle(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().largestRectangleArea([2, 1, 5, 6, 2, 3]), 10)
        self.assertEqual(Solution().largestRectangleArea([2, 4]), 4)

    def test_single(self):
        self.assertEqual(Solution().largestRectangleArea([2]), 2)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'largest-rectangle-in-histogram';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def evalRPN(self, tokens: list[str]) -> int:
        # Evaluate the arithmetic expression in Reverse Polish Notation.
        pass

import unittest


class TestEvalRPN(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().evalRPN(["2", "1", "+", "3", "*"]), 9)
        self.assertEqual(Solution().evalRPN(["4", "13", "5", "/", "+"]), 6)

    def test_long(self):
        tokens = ["10", "6", "9", "3", "+", "-11", "*", "/", "*", "17", "+", "5", "+"]
        self.assertEqual(Solution().evalRPN(tokens), 22)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'evaluate-reverse-polish-notation';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def findDuplicate(self, nums: list[int]) -> int:
        # The one repeated number in [1, n] (n + 1 values).
        pass

import unittest


class TestFindDuplicate(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().findDuplicate([1, 3, 4, 2, 2]), 2)
        self.assertEqual(Solution().findDuplicate([3, 1, 3, 4, 2]), 3)

    def test_all_same(self):
        self.assertEqual(Solution().findDuplicate([2, 2, 2, 2]), 2)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'find-the-duplicate-number';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def minCostClimbingStairs(self, cost: list[int]) -> int:
        # Min cost to reach the top, starting from step 0 or 1.
        pass

import unittest


class TestMinCostClimbing(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().minCostClimbingStairs([10, 15, 20]), 15)
        self.assertEqual(
            Solution().minCostClimbingStairs([1, 100, 1, 1, 1, 100, 1, 1, 100, 1]), 6
        )

    def test_two_zeros(self):
        self.assertEqual(Solution().minCostClimbingStairs([0, 0]), 0)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'min-cost-climbing-stairs';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def canPartition(self, nums: list[int]) -> bool:
        # True if nums can split into two equal-sum subsets.
        pass

import unittest


class TestCanPartition(unittest.TestCase):
    def test_examples(self):
        self.assertTrue(Solution().canPartition([1, 5, 11, 5]))
        self.assertFalse(Solution().canPartition([1, 2, 3, 5]))

    def test_pair(self):
        self.assertTrue(Solution().canPartition([1, 1]))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'partition-equal-subset-sum';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def change(self, amount: int, coins: list[int]) -> int:
        # Number of distinct ways to make amount with the coins.
        pass

import unittest


class TestCoinChangeII(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().change(5, [1, 2, 5]), 4)
        self.assertEqual(Solution().change(3, [2]), 0)

    def test_single_coin(self):
        self.assertEqual(Solution().change(10, [10]), 1)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'coin-change-ii';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def findTargetSumWays(self, nums: list[int], target: int) -> int:
        # Count ways to assign +/- to each number to reach target.
        pass

import unittest


class TestTargetSum(unittest.TestCase):
    def test_example(self):
        self.assertEqual(Solution().findTargetSumWays([1, 1, 1, 1, 1], 3), 5)

    def test_single_reachable(self):
        self.assertEqual(Solution().findTargetSumWays([1], 1), 1)

    def test_single_unreachable(self):
        self.assertEqual(Solution().findTargetSumWays([1], 2), 0)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'target-sum';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def jump(self, nums: list[int]) -> int:
        # Minimum number of jumps to reach the last index.
        pass

import unittest


class TestJumpII(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().jump([2, 3, 1, 1, 4]), 2)
        self.assertEqual(Solution().jump([2, 3, 0, 1, 4]), 2)

    def test_single(self):
        self.assertEqual(Solution().jump([0]), 0)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'jump-game-ii';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def maxProfit(self, prices: list[int]) -> int:
        # Max profit with a 1-day cooldown after each sell.
        pass

import unittest


class TestCooldown(unittest.TestCase):
    def test_example(self):
        self.assertEqual(Solution().maxProfit([1, 2, 3, 0, 2]), 3)

    def test_single(self):
        self.assertEqual(Solution().maxProfit([1]), 0)

    def test_decreasing(self):
        self.assertEqual(Solution().maxProfit([2, 1]), 0)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'best-time-to-buy-and-sell-stock-with-cooldown';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def isInterleave(self, s1: str, s2: str, s3: str) -> bool:
        # True if s3 is formed by interleaving s1 and s2.
        pass

import unittest


class TestInterleave(unittest.TestCase):
    def test_true(self):
        self.assertTrue(Solution().isInterleave("aabcc", "dbbca", "aadbbcbcac"))

    def test_false(self):
        self.assertFalse(Solution().isInterleave("aabcc", "dbbca", "aadbbbaccc"))

    def test_empty(self):
        self.assertTrue(Solution().isInterleave("", "", ""))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'interleaving-string';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def numDistinct(self, s: str, t: str) -> int:
        # Number of distinct subsequences of s that equal t.
        pass

import unittest


class TestNumDistinct(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().numDistinct("rabbbit", "rabbit"), 3)
        self.assertEqual(Solution().numDistinct("babgbag", "bag"), 5)

    def test_empty_target(self):
        self.assertEqual(Solution().numDistinct("", ""), 1)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'distinct-subsequences';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def minDistance(self, word1: str, word2: str) -> int:
        # Min insert/delete/replace operations to turn word1 into word2.
        pass

import unittest


class TestEditDistance(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().minDistance("horse", "ros"), 3)
        self.assertEqual(Solution().minDistance("intention", "execution"), 5)

    def test_empty(self):
        self.assertEqual(Solution().minDistance("", "a"), 1)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'edit-distance';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def maxCoins(self, nums: list[int]) -> int:
        # Max coins from bursting all balloons (nums[i-1]*nums[i]*nums[i+1]).
        pass

import unittest


class TestMaxCoins(unittest.TestCase):
    def test_example(self):
        self.assertEqual(Solution().maxCoins([3, 1, 5, 8]), 167)

    def test_pair(self):
        self.assertEqual(Solution().maxCoins([1, 5]), 10)

    def test_single(self):
        self.assertEqual(Solution().maxCoins([5]), 5)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'burst-balloons';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def isMatch(self, s: str, p: str) -> bool:
        # Match s against pattern p with '.' (any char) and '*' (zero+ of prev).
        pass

import unittest


class TestRegexMatch(unittest.TestCase):
    def test_examples(self):
        self.assertFalse(Solution().isMatch("aa", "a"))
        self.assertTrue(Solution().isMatch("aa", "a*"))
        self.assertTrue(Solution().isMatch("ab", ".*"))

    def test_complex(self):
        self.assertFalse(Solution().isMatch("mississippi", "mis*is*p*."))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'regular-expression-matching';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def canCompleteCircuit(self, gas: list[int], cost: list[int]) -> int:
        # Start index to complete the circuit once, or -1.
        pass

import unittest


class TestGasStation(unittest.TestCase):
    def test_possible(self):
        self.assertEqual(Solution().canCompleteCircuit([1, 2, 3, 4, 5], [3, 4, 5, 1, 2]), 3)

    def test_impossible(self):
        self.assertEqual(Solution().canCompleteCircuit([2, 3, 4], [3, 4, 3]), -1)

    def test_single(self):
        self.assertEqual(Solution().canCompleteCircuit([5], [4]), 0)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'gas-station';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def isNStraightHand(self, hand: list[int], groupSize: int) -> bool:
        # True if the hand can be split into consecutive runs of groupSize.
        pass

import unittest


class TestHandOfStraights(unittest.TestCase):
    def test_true(self):
        self.assertTrue(Solution().isNStraightHand([1, 2, 3, 6, 2, 3, 4, 7, 8], 3))

    def test_false(self):
        self.assertFalse(Solution().isNStraightHand([1, 2, 3, 4, 5], 4))

    def test_pairs(self):
        self.assertTrue(Solution().isNStraightHand([1, 1, 2, 2, 3, 3], 3))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'hand-of-straights';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def partitionLabels(self, s: str) -> list[int]:
        # Partition so each letter appears in at most one part; return sizes.
        pass

import unittest


class TestPartitionLabels(unittest.TestCase):
    def test_example(self):
        self.assertEqual(Solution().partitionLabels("ababcbacadefegdehijhklij"), [9, 7, 8])

    def test_single_part(self):
        self.assertEqual(Solution().partitionLabels("eccbbbbdec"), [10])

    def test_single_char(self):
        self.assertEqual(Solution().partitionLabels("a"), [1])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'partition-labels';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def checkValidString(self, s: str) -> bool:
        # '*' can be '(', ')', or empty; is the string valid?
        pass

import unittest


class TestCheckValidString(unittest.TestCase):
    def test_valid(self):
        self.assertTrue(Solution().checkValidString("()"))
        self.assertTrue(Solution().checkValidString("(*)"))
        self.assertTrue(Solution().checkValidString("(*))"))

    def test_invalid(self):
        self.assertFalse(Solution().checkValidString("(("))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'valid-parenthesis-string';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def myPow(self, x: float, n: int) -> float:
        # Compute x raised to the power n.
        pass

import unittest


class TestMyPow(unittest.TestCase):
    def test_examples(self):
        self.assertAlmostEqual(Solution().myPow(2.0, 10), 1024.0)
        self.assertAlmostEqual(Solution().myPow(2.1, 3), 9.261)

    def test_negative_exponent(self):
        self.assertAlmostEqual(Solution().myPow(2.0, -2), 0.25)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'powx-n';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def multiply(self, num1: str, num2: str) -> str:
        # Product of two non-negative integers given as strings (no int()).
        pass

import unittest


class TestMultiplyStrings(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().multiply("2", "3"), "6")
        self.assertEqual(Solution().multiply("123", "456"), "56088")

    def test_zero(self):
        self.assertEqual(Solution().multiply("0", "52"), "0")


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'multiply-strings';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def reverse(self, x: int) -> int:
        # Reverse digits of x; return 0 on 32-bit signed overflow.
        pass

import unittest


class TestReverseInteger(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().reverse(123), 321)
        self.assertEqual(Solution().reverse(-123), -321)

    def test_trailing_zero(self):
        self.assertEqual(Solution().reverse(120), 21)

    def test_overflow(self):
        self.assertEqual(Solution().reverse(1534236469), 0)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'reverse-integer';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def addBinary(self, a: str, b: str) -> str:
        # Sum of two binary strings, as a binary string.
        pass

import unittest


class TestAddBinary(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().addBinary("11", "1"), "100")
        self.assertEqual(Solution().addBinary("1010", "1011"), "10101")

    def test_zero(self):
        self.assertEqual(Solution().addBinary("0", "0"), "0")


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'add-binary';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def numSquares(self, n: int) -> int:
        # Fewest perfect-square numbers summing to n.
        pass

import unittest


class TestNumSquares(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().numSquares(12), 3)
        self.assertEqual(Solution().numSquares(13), 2)

    def test_one(self):
        self.assertEqual(Solution().numSquares(1), 1)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'perfect-squares';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def subsets(self, nums: list[int]) -> list[list[int]]:
        # All possible subsets (the power set), any order.
        pass

import unittest


def _norm(groups):
    return sorted(sorted(g) for g in groups)


class TestSubsets(unittest.TestCase):
    def test_example(self):
        self.assertEqual(
            _norm(Solution().subsets([1, 2, 3])),
            _norm([[], [1], [2], [3], [1, 2], [1, 3], [2, 3], [1, 2, 3]]),
        )

    def test_single(self):
        self.assertEqual(_norm(Solution().subsets([0])), _norm([[], [0]]))

    def test_count(self):
        self.assertEqual(len(Solution().subsets([1, 2, 3, 4])), 16)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'subsets';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def permute(self, nums: list[int]) -> list[list[int]]:
        # All permutations of the distinct integers, any order.
        pass

import unittest


def _set(perms):
    return {tuple(p) for p in perms}


class TestPermute(unittest.TestCase):
    def test_example(self):
        self.assertEqual(
            _set(Solution().permute([1, 2, 3])),
            {(1, 2, 3), (1, 3, 2), (2, 1, 3), (2, 3, 1), (3, 1, 2), (3, 2, 1)},
        )

    def test_single(self):
        self.assertEqual(_set(Solution().permute([0])), {(0,)})

    def test_count(self):
        self.assertEqual(len(Solution().permute([1, 2, 3, 4])), 24)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'permutations';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def subsetsWithDup(self, nums: list[int]) -> list[list[int]]:
        # All unique subsets when nums may contain duplicates, any order.
        pass

import unittest


def _norm(groups):
    return sorted(sorted(g) for g in groups)


class TestSubsetsWithDup(unittest.TestCase):
    def test_example(self):
        self.assertEqual(
            _norm(Solution().subsetsWithDup([1, 2, 2])),
            _norm([[], [1], [2], [1, 2], [2, 2], [1, 2, 2]]),
        )

    def test_single(self):
        self.assertEqual(_norm(Solution().subsetsWithDup([0])), _norm([[], [0]]))

    def test_all_dup(self):
        self.assertEqual(_norm(Solution().subsetsWithDup([2, 2])), _norm([[], [2], [2, 2]]))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'subsets-ii';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def combinationSum2(self, candidates: list[int], target: int) -> list[list[int]]:
        # Unique combinations summing to target; each number used once.
        pass

import unittest


def _norm(groups):
    return sorted(sorted(g) for g in groups)


class TestCombinationSum2(unittest.TestCase):
    def test_example_1(self):
        self.assertEqual(
            _norm(Solution().combinationSum2([10, 1, 2, 7, 6, 1, 5], 8)),
            _norm([[1, 1, 6], [1, 2, 5], [1, 7], [2, 6]]),
        )

    def test_example_2(self):
        self.assertEqual(
            _norm(Solution().combinationSum2([2, 5, 2, 1, 2], 5)),
            _norm([[1, 2, 2], [5]]),
        )

    def test_none(self):
        self.assertEqual(Solution().combinationSum2([2], 1), [])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'combination-sum-ii';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def partition(self, s: str) -> list[list[str]]:
        # All ways to partition s so every part is a palindrome (any order).
        pass

import unittest


def _set(groups):
    return {tuple(g) for g in groups}


class TestPartition(unittest.TestCase):
    def test_example(self):
        self.assertEqual(
            _set(Solution().partition("aab")),
            {("a", "a", "b"), ("aa", "b")},
        )

    def test_single(self):
        self.assertEqual(_set(Solution().partition("a")), {("a",)})

    def test_all_palindrome(self):
        self.assertEqual(
            _set(Solution().partition("aa")), {("a", "a"), ("aa",)}
        )


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'palindrome-partitioning';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def letterCombinations(self, digits: str) -> list[str]:
        # All letter combos the phone digits could spell (any order).
        pass

import unittest


class TestLetterCombinations(unittest.TestCase):
    def test_example(self):
        self.assertEqual(
            set(Solution().letterCombinations("23")),
            {"ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"},
        )

    def test_empty(self):
        self.assertEqual(Solution().letterCombinations(""), [])

    def test_single_digit(self):
        self.assertEqual(set(Solution().letterCombinations("2")), {"a", "b", "c"})


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'letter-combinations-of-a-phone-number';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def solveNQueens(self, n: int) -> list[list[str]]:
        # All distinct solutions to the n-queens puzzle as boards.
        pass

import unittest


class TestNQueens(unittest.TestCase):
    def test_counts(self):
        self.assertEqual(len(Solution().solveNQueens(4)), 2)
        self.assertEqual(len(Solution().solveNQueens(1)), 1)
        self.assertEqual(len(Solution().solveNQueens(2)), 0)

    def test_valid_board(self):
        for board in Solution().solveNQueens(4):
            self.assertEqual(sum(row.count("Q") for row in board), 4)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'n-queens';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def lastStoneWeight(self, stones: list[int]) -> int:
        # Smash the two heaviest repeatedly; return the last stone's weight.
        pass

import unittest


class TestLastStoneWeight(unittest.TestCase):
    def test_example(self):
        self.assertEqual(Solution().lastStoneWeight([2, 7, 4, 1, 8, 1]), 1)

    def test_single(self):
        self.assertEqual(Solution().lastStoneWeight([1]), 1)

    def test_cancel(self):
        self.assertEqual(Solution().lastStoneWeight([2, 2]), 0)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'last-stone-weight';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def kClosest(self, points: list[list[int]], k: int) -> list[list[int]]:
        # The k points closest to the origin (any order).
        pass

import unittest


def _set(points):
    return {tuple(p) for p in points}


class TestKClosest(unittest.TestCase):
    def test_example_1(self):
        self.assertEqual(_set(Solution().kClosest([[1, 3], [-2, 2]], 1)), {(-2, 2)})

    def test_example_2(self):
        self.assertEqual(
            _set(Solution().kClosest([[3, 3], [5, -1], [-2, 4]], 2)),
            {(3, 3), (-2, 4)},
        )

    def test_all(self):
        self.assertEqual(_set(Solution().kClosest([[1, 1], [2, 2]], 2)), {(1, 1), (2, 2)})


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'k-closest-points-to-origin';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def findKthLargest(self, nums: list[int], k: int) -> int:
        # The kth largest element (kth in sorted-descending order).
        pass

import unittest


class TestFindKthLargest(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().findKthLargest([3, 2, 1, 5, 6, 4], 2), 5)
        self.assertEqual(Solution().findKthLargest([3, 2, 3, 1, 2, 4, 5, 5, 6], 4), 4)

    def test_single(self):
        self.assertEqual(Solution().findKthLargest([1], 1), 1)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'kth-largest-element-in-an-array';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def leastInterval(self, tasks: list[str], n: int) -> int:
        # Min total intervals to run all tasks with cooldown n between repeats.
        pass

import unittest


class TestLeastInterval(unittest.TestCase):
    def test_example(self):
        self.assertEqual(Solution().leastInterval(["A", "A", "A", "B", "B", "B"], 2), 8)

    def test_no_cooldown(self):
        self.assertEqual(Solution().leastInterval(["A", "A", "A", "B", "B", "B"], 0), 6)

    def test_many(self):
        tasks = ["A", "A", "A", "A", "A", "A", "B", "C", "D", "E", "F", "G"]
        self.assertEqual(Solution().leastInterval(tasks, 2), 16)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'task-scheduler';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def myAtoi(self, s: str) -> int:
        # Parse a leading 32-bit signed integer from s (clamped).
        pass

import unittest


class TestMyAtoi(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().myAtoi("42"), 42)
        self.assertEqual(Solution().myAtoi("   -42"), -42)
        self.assertEqual(Solution().myAtoi("4193 with words"), 4193)

    def test_leading_words(self):
        self.assertEqual(Solution().myAtoi("words and 987"), 0)

    def test_clamp(self):
        self.assertEqual(Solution().myAtoi("91234567890123456789"), 2147483647)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'string-to-integer-atoi';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def decodeString(self, s: str) -> str:
        # Decode k[encoded] runs, e.g. 3[a]2[bc] -> aaabcbc.
        pass

import unittest


class TestDecodeString(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().decodeString("3[a]2[bc]"), "aaabcbc")
        self.assertEqual(Solution().decodeString("3[a2[c]]"), "accaccacc")

    def test_mixed(self):
        self.assertEqual(Solution().decodeString("2[abc]3[cd]ef"), "abcabccdcdcdef")


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'decode-string';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def firstMissingPositive(self, nums: list[int]) -> int:
        # Smallest missing positive integer.
        pass

import unittest


class TestFirstMissingPositive(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().firstMissingPositive([1, 2, 0]), 3)
        self.assertEqual(Solution().firstMissingPositive([3, 4, -1, 1]), 2)

    def test_all_high(self):
        self.assertEqual(Solution().firstMissingPositive([7, 8, 9, 11, 12]), 1)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'first-missing-positive';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def maxAreaOfIsland(self, grid: list[list[int]]) -> int:
        # Area of the largest island of 1s (4-directional).
        pass

import unittest


class TestMaxAreaOfIsland(unittest.TestCase):
    def test_example(self):
        grid = [[1, 1, 0, 0], [1, 0, 0, 1], [0, 0, 1, 1]]
        self.assertEqual(Solution().maxAreaOfIsland(grid), 3)

    def test_full(self):
        self.assertEqual(Solution().maxAreaOfIsland([[1, 1], [1, 1]]), 4)

    def test_empty(self):
        self.assertEqual(Solution().maxAreaOfIsland([[0]]), 0)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'max-area-of-island';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def orangesRotting(self, grid: list[list[int]]) -> int:
        # Minutes until no fresh orange (1) remains, or -1 if impossible.
        pass

import unittest


class TestOrangesRotting(unittest.TestCase):
    def test_example(self):
        self.assertEqual(
            Solution().orangesRotting([[2, 1, 1], [1, 1, 0], [0, 1, 1]]), 4
        )

    def test_impossible(self):
        self.assertEqual(
            Solution().orangesRotting([[2, 1, 1], [0, 1, 1], [1, 0, 1]]), -1
        )

    def test_none_fresh(self):
        self.assertEqual(Solution().orangesRotting([[0, 2]]), 0)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'rotting-oranges';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def solve(self, board: list[list[str]]) -> None:
        # Flip every 'O' not connected to a border 'O' into 'X', in place.
        pass

import unittest


class TestSurroundedRegions(unittest.TestCase):
    def test_example(self):
        board = [
            ["X", "X", "X", "X"],
            ["X", "O", "O", "X"],
            ["X", "X", "O", "X"],
            ["X", "O", "X", "X"],
        ]
        Solution().solve(board)
        self.assertEqual(
            board,
            [
                ["X", "X", "X", "X"],
                ["X", "X", "X", "X"],
                ["X", "X", "X", "X"],
                ["X", "O", "X", "X"],
            ],
        )

    def test_single(self):
        board = [["X"]]
        Solution().solve(board)
        self.assertEqual(board, [["X"]])

    def test_border_kept(self):
        board = [["O", "O"], ["O", "O"]]
        Solution().solve(board)
        self.assertEqual(board, [["O", "O"], ["O", "O"]])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'surrounded-regions';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def floodFill(self, image: list[list[int]], sr: int, sc: int, color: int) -> list[list[int]]:
        # Flood fill from (sr, sc) with color; return the image.
        pass

import unittest


class TestFloodFill(unittest.TestCase):
    def test_example(self):
        result = Solution().floodFill([[1, 1, 1], [1, 1, 0], [1, 0, 1]], 1, 1, 2)
        self.assertEqual(result, [[2, 2, 2], [2, 2, 0], [2, 0, 1]])

    def test_no_change(self):
        result = Solution().floodFill([[0, 0, 0], [0, 0, 0]], 0, 0, 0)
        self.assertEqual(result, [[0, 0, 0], [0, 0, 0]])

    def test_single(self):
        self.assertEqual(Solution().floodFill([[0]], 0, 0, 5), [[5]])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'flood-fill';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def updateMatrix(self, mat: list[list[int]]) -> list[list[int]]:
        # Distance of each cell to the nearest 0.
        pass

import unittest


class TestUpdateMatrix(unittest.TestCase):
    def test_zeros_around(self):
        self.assertEqual(
            Solution().updateMatrix([[0, 0, 0], [0, 1, 0], [0, 0, 0]]),
            [[0, 0, 0], [0, 1, 0], [0, 0, 0]],
        )

    def test_example(self):
        self.assertEqual(
            Solution().updateMatrix([[0, 0, 0], [0, 1, 0], [1, 1, 1]]),
            [[0, 0, 0], [0, 1, 0], [1, 2, 1]],
        )

    def test_single(self):
        self.assertEqual(Solution().updateMatrix([[0]]), [[0]])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = '01-matrix';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def wallsAndGates(self, rooms: list[list[int]]) -> None:
        # Fill each empty room (2147483647) with distance to nearest gate (0).
        pass

import unittest

INF = 2147483647


class TestWallsAndGates(unittest.TestCase):
    def test_example(self):
        rooms = [
            [INF, -1, 0, INF],
            [INF, INF, INF, -1],
            [INF, -1, INF, -1],
            [0, -1, INF, INF],
        ]
        Solution().wallsAndGates(rooms)
        self.assertEqual(
            rooms,
            [[3, -1, 0, 1], [2, 2, 1, -1], [1, -1, 2, -1], [0, -1, 3, 4]],
        )

    def test_gate_only(self):
        rooms = [[0]]
        Solution().wallsAndGates(rooms)
        self.assertEqual(rooms, [[0]])

    def test_wall_only(self):
        rooms = [[-1]]
        Solution().wallsAndGates(rooms)
        self.assertEqual(rooms, [[-1]])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'walls-and-gates';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def longestIncreasingPath(self, matrix: list[list[int]]) -> int:
        # Length of the longest strictly increasing path (4-directional).
        pass

import unittest


class TestLongestIncreasingPath(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(
            Solution().longestIncreasingPath([[9, 9, 4], [6, 6, 8], [2, 1, 1]]), 4
        )
        self.assertEqual(
            Solution().longestIncreasingPath([[3, 4, 5], [3, 2, 6], [2, 2, 1]]), 4
        )

    def test_single(self):
        self.assertEqual(Solution().longestIncreasingPath([[1]]), 1)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'longest-increasing-path-in-a-matrix';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def findMedianSortedArrays(self, nums1: list[int], nums2: list[int]) -> float:
        # Median of the two sorted arrays combined.
        pass

import unittest


class TestMedianSortedArrays(unittest.TestCase):
    def test_odd(self):
        self.assertAlmostEqual(Solution().findMedianSortedArrays([1, 3], [2]), 2.0)

    def test_even(self):
        self.assertAlmostEqual(Solution().findMedianSortedArrays([1, 2], [3, 4]), 2.5)

    def test_empty_one(self):
        self.assertAlmostEqual(Solution().findMedianSortedArrays([], [1]), 1.0)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'median-of-two-sorted-arrays';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def rotate(self, nums: list[int], k: int) -> None:
        # Rotate the array right by k steps, in place.
        pass

import unittest


class TestRotateArray(unittest.TestCase):
    def test_example(self):
        nums = [1, 2, 3, 4, 5, 6, 7]
        Solution().rotate(nums, 3)
        self.assertEqual(nums, [5, 6, 7, 1, 2, 3, 4])

    def test_small(self):
        nums = [-1, -100, 3, 99]
        Solution().rotate(nums, 2)
        self.assertEqual(nums, [3, 99, -1, -100])

    def test_no_rotation(self):
        nums = [1, 2]
        Solution().rotate(nums, 0)
        self.assertEqual(nums, [1, 2])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'rotate-array';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def searchMatrix(self, matrix: list[list[int]], target: int) -> bool:
        # Rows and columns each sorted ascending; is target present?
        pass

import unittest


class TestSearchMatrixII(unittest.TestCase):
    def _m(self):
        return [
            [1, 4, 7, 11, 15],
            [2, 5, 8, 12, 19],
            [3, 6, 9, 16, 22],
            [10, 13, 14, 17, 24],
            [18, 21, 23, 26, 30],
        ]

    def test_present(self):
        self.assertTrue(Solution().searchMatrix(self._m(), 5))

    def test_absent(self):
        self.assertFalse(Solution().searchMatrix(self._m(), 20))

    def test_single(self):
        self.assertTrue(Solution().searchMatrix([[1]], 1))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'search-a-2d-matrix-ii';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def longestValidParentheses(self, s: str) -> int:
        # Length of the longest valid (well-formed) parentheses substring.
        pass

import unittest


class TestLongestValidParentheses(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().longestValidParentheses("(()"), 2)
        self.assertEqual(Solution().longestValidParentheses(")()())"), 4)

    def test_empty(self):
        self.assertEqual(Solution().longestValidParentheses(""), 0)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'longest-valid-parentheses';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def minPathSum(self, grid: list[list[int]]) -> int:
        # Min sum path from top-left to bottom-right (move right/down).
        pass

import unittest


class TestMinPathSum(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().minPathSum([[1, 3, 1], [1, 5, 1], [4, 2, 1]]), 7)
        self.assertEqual(Solution().minPathSum([[1, 2, 3], [4, 5, 6]]), 12)

    def test_single(self):
        self.assertEqual(Solution().minPathSum([[5]]), 5)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'minimum-path-sum';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def nextPermutation(self, nums: list[int]) -> None:
        # Rearrange into the next lexicographically greater permutation, in place.
        pass

import unittest


class TestNextPermutation(unittest.TestCase):
    def test_middle(self):
        nums = [1, 2, 3]
        Solution().nextPermutation(nums)
        self.assertEqual(nums, [1, 3, 2])

    def test_wrap(self):
        nums = [3, 2, 1]
        Solution().nextPermutation(nums)
        self.assertEqual(nums, [1, 2, 3])

    def test_with_dup(self):
        nums = [1, 1, 5]
        Solution().nextPermutation(nums)
        self.assertEqual(nums, [1, 5, 1])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'next-permutation';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def longestPalindrome(self, s: str) -> int:
        # Length of the longest palindrome buildable from the letters of s.
        pass

import unittest


class TestLongestPalindromeLength(unittest.TestCase):
    def test_example(self):
        self.assertEqual(Solution().longestPalindrome("abccccdd"), 7)

    def test_single(self):
        self.assertEqual(Solution().longestPalindrome("a"), 1)

    def test_case_sensitive(self):
        self.assertEqual(Solution().longestPalindrome("Aa"), 1)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'longest-palindrome';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def mergeTriplets(self, triplets: list[list[int]], target: list[int]) -> bool:
        # Can we pick triplets and take element-wise max to equal target?
        pass

import unittest


class TestMergeTriplets(unittest.TestCase):
    def test_true(self):
        self.assertTrue(
            Solution().mergeTriplets([[2, 5, 3], [1, 8, 4], [1, 7, 5]], [2, 7, 5])
        )

    def test_false(self):
        self.assertFalse(Solution().mergeTriplets([[3, 4, 5], [4, 5, 6]], [3, 2, 5]))

    def test_true_more(self):
        self.assertTrue(
            Solution().mergeTriplets(
                [[2, 5, 3], [2, 3, 4], [1, 2, 5], [5, 2, 3]], [5, 5, 5]
            )
        )


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'merge-triplets-to-form-target-triplet';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def addTwoNumbers(self, l1: "ListNode | None", l2: "ListNode | None") -> "ListNode | None":
        # Digits are stored in reverse order; return their sum as a list.
        pass

import unittest


def build(vals):
    dummy = ListNode()
    cur = dummy
    for v in vals:
        cur.next = ListNode(v)
        cur = cur.next
    return dummy.next


def to_list(node):
    out = []
    while node:
        out.append(node.val)
        node = node.next
    return out


class TestAddTwoNumbers(unittest.TestCase):
    def test_example(self):
        self.assertEqual(to_list(Solution().addTwoNumbers(build([2, 4, 3]), build([5, 6, 4]))), [7, 0, 8])

    def test_zeros(self):
        self.assertEqual(to_list(Solution().addTwoNumbers(build([0]), build([0]))), [0])

    def test_carry_extends(self):
        self.assertEqual(to_list(Solution().addTwoNumbers(build([9, 9, 9]), build([1]))), [0, 0, 0, 1])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'add-two-numbers';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def middleNode(self, head: "ListNode | None") -> "ListNode | None":
        # Return the middle node (second middle if even length).
        pass

import unittest


def build(vals):
    dummy = ListNode()
    cur = dummy
    for v in vals:
        cur.next = ListNode(v)
        cur = cur.next
    return dummy.next


def to_list(node):
    out = []
    while node:
        out.append(node.val)
        node = node.next
    return out


class TestMiddleNode(unittest.TestCase):
    def test_odd(self):
        self.assertEqual(to_list(Solution().middleNode(build([1, 2, 3, 4, 5]))), [3, 4, 5])

    def test_even(self):
        self.assertEqual(to_list(Solution().middleNode(build([1, 2, 3, 4, 5, 6]))), [4, 5, 6])

    def test_single(self):
        self.assertEqual(to_list(Solution().middleNode(build([1]))), [1])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'middle-of-the-linked-list';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def reverseKGroup(self, head: "ListNode | None", k: int) -> "ListNode | None":
        # Reverse the nodes k at a time; leave a trailing remainder as is.
        pass

import unittest


def build(vals):
    dummy = ListNode()
    cur = dummy
    for v in vals:
        cur.next = ListNode(v)
        cur = cur.next
    return dummy.next


def to_list(node):
    out = []
    while node:
        out.append(node.val)
        node = node.next
    return out


class TestReverseKGroup(unittest.TestCase):
    def test_k2(self):
        self.assertEqual(to_list(Solution().reverseKGroup(build([1, 2, 3, 4, 5]), 2)), [2, 1, 4, 3, 5])

    def test_k3(self):
        self.assertEqual(to_list(Solution().reverseKGroup(build([1, 2, 3, 4, 5]), 3)), [3, 2, 1, 4, 5])

    def test_k1(self):
        self.assertEqual(to_list(Solution().reverseKGroup(build([1, 2, 3, 4, 5]), 1)), [1, 2, 3, 4, 5])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'reverse-nodes-in-k-group';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def swapPairs(self, head: "ListNode | None") -> "ListNode | None":
        # Swap every two adjacent nodes.
        pass

import unittest


def build(vals):
    dummy = ListNode()
    cur = dummy
    for v in vals:
        cur.next = ListNode(v)
        cur = cur.next
    return dummy.next


def to_list(node):
    out = []
    while node:
        out.append(node.val)
        node = node.next
    return out


class TestSwapPairs(unittest.TestCase):
    def test_even(self):
        self.assertEqual(to_list(Solution().swapPairs(build([1, 2, 3, 4]))), [2, 1, 4, 3])

    def test_empty(self):
        self.assertEqual(to_list(Solution().swapPairs(build([]))), [])

    def test_odd(self):
        self.assertEqual(to_list(Solution().swapPairs(build([1, 2, 3]))), [2, 1, 3])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'swap-nodes-in-pairs';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def isPalindrome(self, head: "ListNode | None") -> bool:
        # True if the linked list reads the same forwards and backwards.
        pass

import unittest


def build(vals):
    dummy = ListNode()
    cur = dummy
    for v in vals:
        cur.next = ListNode(v)
        cur = cur.next
    return dummy.next


def to_list(node):
    out = []
    while node:
        out.append(node.val)
        node = node.next
    return out


class TestPalindromeList(unittest.TestCase):
    def test_palindrome(self):
        self.assertTrue(Solution().isPalindrome(build([1, 2, 2, 1])))

    def test_not(self):
        self.assertFalse(Solution().isPalindrome(build([1, 2])))

    def test_single(self):
        self.assertTrue(Solution().isPalindrome(build([1])))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'palindrome-linked-list';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def detectCycle(self, head: "ListNode | None") -> "ListNode | None":
        # Node where the cycle begins, or None if there is no cycle.
        pass

import unittest


def build_cycle(vals, pos):
    nodes = [ListNode(v) for v in vals]
    for i in range(len(nodes) - 1):
        nodes[i].next = nodes[i + 1]
    if pos >= 0 and nodes:
        nodes[-1].next = nodes[pos]
    return nodes[0] if nodes else None


class TestDetectCycle(unittest.TestCase):
    def test_cycle_mid(self):
        self.assertEqual(Solution().detectCycle(build_cycle([3, 2, 0, -4], 1)).val, 2)

    def test_cycle_head(self):
        self.assertEqual(Solution().detectCycle(build_cycle([1, 2], 0)).val, 1)

    def test_no_cycle(self):
        self.assertIsNone(Solution().detectCycle(build_cycle([1], -1)))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'linked-list-cycle-ii';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def getIntersectionNode(self, headA: "ListNode | None", headB: "ListNode | None") -> "ListNode | None":
        # The node where the two lists intersect, or None.
        pass

import unittest


def build(vals):
    dummy = ListNode()
    cur = dummy
    for v in vals:
        cur.next = ListNode(v)
        cur = cur.next
    return dummy.next


def to_list(node):
    out = []
    while node:
        out.append(node.val)
        node = node.next
    return out


class TestGetIntersection(unittest.TestCase):
    def test_intersect(self):
        shared = build([8, 4, 5])
        a = build([4, 1])
        b = build([5, 6, 1])
        for cur in (a, b):
            while cur.next:
                cur = cur.next
            cur.next = shared
        self.assertIs(Solution().getIntersectionNode(a, b), shared)

    def test_intersect_value(self):
        shared = build([2, 4])
        a = build([1])
        a.next = shared
        self.assertEqual(Solution().getIntersectionNode(a, shared).val, 2)

    def test_no_intersection(self):
        self.assertIsNone(Solution().getIntersectionNode(build([1, 2]), build([3, 4])))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'intersection-of-two-linked-lists';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def sortList(self, head: "ListNode | None") -> "ListNode | None":
        # Sort the linked list in ascending order.
        pass

import unittest


def build(vals):
    dummy = ListNode()
    cur = dummy
    for v in vals:
        cur.next = ListNode(v)
        cur = cur.next
    return dummy.next


def to_list(node):
    out = []
    while node:
        out.append(node.val)
        node = node.next
    return out


class TestSortList(unittest.TestCase):
    def test_example(self):
        self.assertEqual(to_list(Solution().sortList(build([4, 2, 1, 3]))), [1, 2, 3, 4])

    def test_negatives(self):
        self.assertEqual(to_list(Solution().sortList(build([-1, 5, 3, 4, 0]))), [-1, 0, 3, 4, 5])

    def test_empty(self):
        self.assertEqual(to_list(Solution().sortList(build([]))), [])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'sort-list';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Node:
    def __init__(self, x, next=None, random=None):
        self.val = int(x)
        self.next = next
        self.random = random

class Solution:
    def copyRandomList(self, head: "Node | None") -> "Node | None":
        # Deep copy a linked list whose nodes also have a random pointer.
        pass

import unittest


def build(arr):
    # arr items are [val, random_index_or_None].
    nodes = [Node(v) for v, _ in arr]
    for i, (v, r) in enumerate(arr):
        nodes[i].next = nodes[i + 1] if i + 1 < len(nodes) else None
        nodes[i].random = nodes[r] if r is not None else None
    return nodes[0] if nodes else None


def serialize(head):
    index = {}
    cur = head
    i = 0
    while cur:
        index[id(cur)] = i
        cur = cur.next
        i += 1
    out = []
    cur = head
    while cur:
        out.append([cur.val, index[id(cur.random)] if cur.random else None])
        cur = cur.next
    return out


def ids(head):
    s = set()
    while head:
        s.add(id(head))
        head = head.next
    return s


class TestCopyRandomList(unittest.TestCase):
    def test_structure(self):
        arr = [[7, None], [13, 0], [11, 4], [10, 2], [1, 0]]
        original = build(arr)
        copy = Solution().copyRandomList(original)
        self.assertEqual(serialize(copy), arr)
        self.assertTrue(ids(copy).isdisjoint(ids(original)))

    def test_self_random(self):
        self.assertEqual(serialize(Solution().copyRandomList(build([[1, 0]]))), [[1, 0]])

    def test_empty(self):
        self.assertIsNone(Solution().copyRandomList(build([])))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'copy-list-with-random-pointer';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def diameterOfBinaryTree(self, root: "TreeNode | None") -> int:
        # Length (in edges) of the longest path between any two nodes.
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


class TestDiameter(unittest.TestCase):
    def test_example(self):
        self.assertEqual(Solution().diameterOfBinaryTree(build_tree([1, 2, 3, 4, 5])), 3)

    def test_two(self):
        self.assertEqual(Solution().diameterOfBinaryTree(build_tree([1, 2])), 1)

    def test_single(self):
        self.assertEqual(Solution().diameterOfBinaryTree(build_tree([1])), 0)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'diameter-of-binary-tree';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def isBalanced(self, root: "TreeNode | None") -> bool:
        # True if every node's subtrees differ in height by at most 1.
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


class TestIsBalanced(unittest.TestCase):
    def test_balanced(self):
        self.assertTrue(Solution().isBalanced(build_tree([3, 9, 20, None, None, 15, 7])))

    def test_unbalanced(self):
        self.assertFalse(
            Solution().isBalanced(build_tree([1, 2, 2, 3, 3, None, None, 4, 4]))
        )

    def test_empty(self):
        self.assertTrue(Solution().isBalanced(build_tree([])))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'balanced-binary-tree';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def rightSideView(self, root: "TreeNode | None") -> list[int]:
        # Values visible from the right, top to bottom.
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


class TestRightSideView(unittest.TestCase):
    def test_example(self):
        self.assertEqual(
            Solution().rightSideView(build_tree([1, 2, 3, None, 5, None, 4])), [1, 3, 4]
        )

    def test_empty(self):
        self.assertEqual(Solution().rightSideView(build_tree([])), [])

    def test_single(self):
        self.assertEqual(Solution().rightSideView(build_tree([1])), [1])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'binary-tree-right-side-view';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def goodNodes(self, root: "TreeNode | None") -> int:
        # A node is good if no node on the path from root has a greater value.
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


class TestGoodNodes(unittest.TestCase):
    def test_example(self):
        self.assertEqual(Solution().goodNodes(build_tree([3, 1, 4, 3, None, 1, 5])), 4)

    def test_left_chain(self):
        self.assertEqual(Solution().goodNodes(build_tree([3, 3, None, 4, 2])), 3)

    def test_single(self):
        self.assertEqual(Solution().goodNodes(build_tree([1])), 1)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'count-good-nodes-in-binary-tree';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def lowestCommonAncestor(self, root: "TreeNode", p: "TreeNode", q: "TreeNode") -> "TreeNode":
        # Lowest node having both p and q as descendants.
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

def find(root, val):
    if not root:
        return None
    if root.val == val:
        return root
    return find(root.left, val) or find(root.right, val)


class TestLCABinary(unittest.TestCase):
    def setUp(self):
        self.root = build_tree([3, 5, 1, 6, 2, 0, 8, None, None, 7, 4])

    def test_split(self):
        lca = Solution().lowestCommonAncestor(self.root, find(self.root, 5), find(self.root, 1))
        self.assertEqual(lca.val, 3)

    def test_ancestor(self):
        lca = Solution().lowestCommonAncestor(self.root, find(self.root, 5), find(self.root, 4))
        self.assertEqual(lca.val, 5)

    def test_deep(self):
        lca = Solution().lowestCommonAncestor(self.root, find(self.root, 7), find(self.root, 4))
        self.assertEqual(lca.val, 2)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'lowest-common-ancestor-of-a-binary-tree';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def isSymmetric(self, root: "TreeNode | None") -> bool:
        # True if the tree is a mirror of itself.
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


class TestIsSymmetric(unittest.TestCase):
    def test_symmetric(self):
        self.assertTrue(Solution().isSymmetric(build_tree([1, 2, 2, 3, 4, 4, 3])))

    def test_asymmetric(self):
        self.assertFalse(Solution().isSymmetric(build_tree([1, 2, 2, None, 3, None, 3])))

    def test_single(self):
        self.assertTrue(Solution().isSymmetric(build_tree([1])))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'symmetric-tree';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def inorderTraversal(self, root: "TreeNode | None") -> list[int]:
        # Node values in inorder (left, root, right).
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


class TestInorder(unittest.TestCase):
    def test_example(self):
        self.assertEqual(Solution().inorderTraversal(build_tree([1, None, 2, 3])), [1, 3, 2])

    def test_empty(self):
        self.assertEqual(Solution().inorderTraversal(build_tree([])), [])

    def test_single(self):
        self.assertEqual(Solution().inorderTraversal(build_tree([1])), [1])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'binary-tree-inorder-traversal';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def sortedArrayToBST(self, nums: list[int]) -> "TreeNode | None":
        # Build a height-balanced BST from the sorted array.
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

def inorder(node):
    return inorder(node.left) + [node.val] + inorder(node.right) if node else []


def height(node):
    return 1 + max(height(node.left), height(node.right)) if node else 0


def balanced(node):
    if not node:
        return True
    return abs(height(node.left) - height(node.right)) <= 1 and balanced(node.left) and balanced(node.right)


class TestSortedArrayToBST(unittest.TestCase):
    def _check(self, nums):
        tree = Solution().sortedArrayToBST(nums)
        self.assertEqual(inorder(tree), nums)
        self.assertTrue(balanced(tree))

    def test_example(self):
        self._check([-10, -3, 0, 5, 9])

    def test_pair(self):
        self._check([1, 3])

    def test_single(self):
        self._check([0])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'convert-sorted-array-to-binary-search-tree';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def flatten(self, root: "TreeNode | None") -> None:
        # Flatten the tree into a right-skewed "linked list" in preorder, in place.
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

def as_right_chain(node):
    vals = []
    while node:
        if node.left is not None:
            raise AssertionError("left pointer not cleared")
        vals.append(node.val)
        node = node.right
    return vals


class TestFlatten(unittest.TestCase):
    def test_example(self):
        root = build_tree([1, 2, 5, 3, 4, None, 6])
        Solution().flatten(root)
        self.assertEqual(as_right_chain(root), [1, 2, 3, 4, 5, 6])

    def test_single(self):
        root = build_tree([0])
        Solution().flatten(root)
        self.assertEqual(as_right_chain(root), [0])

    def test_empty(self):
        self.assertIsNone(Solution().flatten(build_tree([])))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'flatten-binary-tree-to-linked-list';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def pathSum(self, root: "TreeNode | None", targetSum: int) -> int:
        # Count downward paths (any start/end) whose values sum to targetSum.
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


class TestPathSumIII(unittest.TestCase):
    def test_example_1(self):
        root = build_tree([10, 5, -3, 3, 2, None, 11, 3, -2, None, 1])
        self.assertEqual(Solution().pathSum(root, 8), 3)

    def test_example_2(self):
        root = build_tree([5, 4, 8, 11, None, 13, 4, 7, 2, None, None, 5, 1])
        self.assertEqual(Solution().pathSum(root, 22), 3)

    def test_single(self):
        self.assertEqual(Solution().pathSum(build_tree([1]), 1), 1)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'path-sum-iii';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class MinStack:
    def __init__(self):
        pass

    def push(self, val: int) -> None:
        pass

    def pop(self) -> None:
        pass

    def top(self) -> int:
        pass

    def getMin(self) -> int:
        # Retrieve the minimum element in constant time.
        pass

import unittest


class TestMinStack(unittest.TestCase):
    def test_sequence(self):
        s = MinStack()
        s.push(-2)
        s.push(0)
        s.push(-3)
        self.assertEqual(s.getMin(), -3)
        s.pop()
        self.assertEqual(s.top(), 0)
        self.assertEqual(s.getMin(), -2)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'min-stack';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class MyQueue:
    def __init__(self):
        pass

    def push(self, x: int) -> None:
        pass

    def pop(self) -> int:
        pass

    def peek(self) -> int:
        pass

    def empty(self) -> bool:
        pass

import unittest


class TestMyQueue(unittest.TestCase):
    def test_fifo(self):
        q = MyQueue()
        q.push(1)
        q.push(2)
        self.assertEqual(q.peek(), 1)
        self.assertEqual(q.pop(), 1)
        self.assertFalse(q.empty())
        self.assertEqual(q.pop(), 2)
        self.assertTrue(q.empty())


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'implement-queue-using-stacks';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class KthLargest:
    def __init__(self, k: int, nums: list[int]):
        pass

    def add(self, val: int) -> int:
        # Return the kth largest element after adding val.
        pass

import unittest


class TestKthLargest(unittest.TestCase):
    def test_stream(self):
        k = KthLargest(3, [4, 5, 8, 2])
        self.assertEqual(k.add(3), 4)
        self.assertEqual(k.add(5), 5)
        self.assertEqual(k.add(10), 5)
        self.assertEqual(k.add(9), 8)
        self.assertEqual(k.add(4), 8)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'kth-largest-element-in-a-stream';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class TimeMap:
    def __init__(self):
        pass

    def set(self, key: str, value: str, timestamp: int) -> None:
        pass

    def get(self, key: str, timestamp: int) -> str:
        # Value set at the largest timestamp <= the query, or "".
        pass

import unittest


class TestTimeMap(unittest.TestCase):
    def test_get(self):
        t = TimeMap()
        t.set("foo", "bar", 1)
        self.assertEqual(t.get("foo", 1), "bar")
        self.assertEqual(t.get("foo", 3), "bar")
        t.set("foo", "bar2", 4)
        self.assertEqual(t.get("foo", 4), "bar2")
        self.assertEqual(t.get("foo", 5), "bar2")

    def test_before_first(self):
        t = TimeMap()
        t.set("a", "x", 5)
        self.assertEqual(t.get("a", 1), "")

    def test_missing_key(self):
        self.assertEqual(TimeMap().get("nope", 1), "")


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'time-based-key-value-store';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class LRUCache:
    def __init__(self, capacity: int):
        pass

    def get(self, key: int) -> int:
        # Value for key, or -1; marks it most-recently used.
        pass

    def put(self, key: int, value: int) -> None:
        # Insert/update; evict least-recently used if over capacity.
        pass

import unittest


class TestLRUCache(unittest.TestCase):
    def test_eviction(self):
        c = LRUCache(2)
        c.put(1, 1)
        c.put(2, 2)
        self.assertEqual(c.get(1), 1)
        c.put(3, 3)  # evicts key 2
        self.assertEqual(c.get(2), -1)
        c.put(4, 4)  # evicts key 1
        self.assertEqual(c.get(1), -1)
        self.assertEqual(c.get(3), 3)
        self.assertEqual(c.get(4), 4)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'lru-cache';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Twitter:
    def __init__(self):
        pass

    def postTweet(self, userId: int, tweetId: int) -> None:
        pass

    def getNewsFeed(self, userId: int) -> list[int]:
        # 10 most recent tweet ids from the user and those they follow.
        pass

    def follow(self, followerId: int, followeeId: int) -> None:
        pass

    def unfollow(self, followerId: int, followeeId: int) -> None:
        pass

import unittest


class TestTwitter(unittest.TestCase):
    def test_feed(self):
        t = Twitter()
        t.postTweet(1, 5)
        self.assertEqual(t.getNewsFeed(1), [5])
        t.follow(1, 2)
        t.postTweet(2, 6)
        self.assertEqual(t.getNewsFeed(1), [6, 5])
        t.unfollow(1, 2)
        self.assertEqual(t.getNewsFeed(1), [5])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'design-twitter';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class DetectSquares:
    def __init__(self):
        pass

    def add(self, point: list[int]) -> None:
        pass

    def count(self, point: list[int]) -> int:
        # Number of axis-aligned squares with positive area using point as a corner.
        pass

import unittest


class TestDetectSquares(unittest.TestCase):
    def test_counts(self):
        ds = DetectSquares()
        ds.add([3, 10])
        ds.add([11, 2])
        ds.add([3, 2])
        self.assertEqual(ds.count([11, 10]), 1)
        self.assertEqual(ds.count([14, 8]), 0)
        ds.add([11, 2])
        self.assertEqual(ds.count([11, 10]), 2)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'detect-squares';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def findOrder(self, numCourses: int, prerequisites: list[list[int]]) -> list[int]:
        # A valid order to take all courses, or [] if impossible.
        pass

import unittest


def valid_order(order, numCourses, prereqs):
    if len(order) != numCourses or sorted(order) != list(range(numCourses)):
        return False
    pos = {c: i for i, c in enumerate(order)}
    return all(pos[b] < pos[a] for a, b in prereqs)


class TestFindOrder(unittest.TestCase):
    def test_simple(self):
        self.assertTrue(valid_order(Solution().findOrder(2, [[1, 0]]), 2, [[1, 0]]))

    def test_diamond(self):
        pre = [[1, 0], [2, 0], [3, 1], [3, 2]]
        self.assertTrue(valid_order(Solution().findOrder(4, pre), 4, pre))

    def test_cycle(self):
        self.assertEqual(Solution().findOrder(2, [[1, 0], [0, 1]]), [])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'course-schedule-ii';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def findRedundantConnection(self, edges: list[list[int]]) -> list[int]:
        # The edge that can be removed so the graph becomes a tree.
        pass

import unittest


class TestRedundantConnection(unittest.TestCase):
    def test_example_1(self):
        self.assertEqual(Solution().findRedundantConnection([[1, 2], [1, 3], [2, 3]]), [2, 3])

    def test_example_2(self):
        edges = [[1, 2], [2, 3], [3, 4], [1, 4], [1, 5]]
        self.assertEqual(Solution().findRedundantConnection(edges), [1, 4])

    def test_triangle(self):
        self.assertEqual(Solution().findRedundantConnection([[1, 2], [2, 3], [1, 3]]), [1, 3])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'redundant-connection';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def ladderLength(self, beginWord: str, endWord: str, wordList: list[str]) -> int:
        # Length of the shortest transformation sequence, or 0.
        pass

import unittest


class TestWordLadder(unittest.TestCase):
    def test_reachable(self):
        self.assertEqual(
            Solution().ladderLength("hit", "cog", ["hot", "dot", "dog", "lot", "log", "cog"]), 5
        )

    def test_unreachable(self):
        self.assertEqual(
            Solution().ladderLength("hit", "cog", ["hot", "dot", "dog", "lot", "log"]), 0
        )

    def test_short(self):
        self.assertEqual(Solution().ladderLength("a", "c", ["a", "b", "c"]), 2)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'word-ladder';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def findItinerary(self, tickets: list[list[str]]) -> list[str]:
        # Reconstruct the itinerary from JFK; prefer the lexically smaller airport.
        pass

import unittest


class TestFindItinerary(unittest.TestCase):
    def test_example_1(self):
        tickets = [["MUC", "LHR"], ["JFK", "MUC"], ["SFO", "SJC"], ["LHR", "SFO"]]
        self.assertEqual(Solution().findItinerary(tickets), ["JFK", "MUC", "LHR", "SFO", "SJC"])

    def test_example_2(self):
        tickets = [["JFK", "SFO"], ["JFK", "ATL"], ["SFO", "ATL"], ["ATL", "JFK"], ["ATL", "SFO"]]
        self.assertEqual(
            Solution().findItinerary(tickets), ["JFK", "ATL", "JFK", "SFO", "ATL", "SFO"]
        )

    def test_round_trip(self):
        self.assertEqual(Solution().findItinerary([["JFK", "A"], ["A", "JFK"]]), ["JFK", "A", "JFK"])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'reconstruct-itinerary';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def minCostConnectPoints(self, points: list[list[int]]) -> int:
        # Min cost to connect all points (Manhattan-distance edges).
        pass

import unittest


class TestMinCostConnect(unittest.TestCase):
    def test_example(self):
        self.assertEqual(
            Solution().minCostConnectPoints([[0, 0], [2, 2], [3, 10], [5, 2], [7, 0]]), 20
        )

    def test_three(self):
        self.assertEqual(Solution().minCostConnectPoints([[3, 12], [-2, 5], [-4, 1]]), 18)

    def test_single(self):
        self.assertEqual(Solution().minCostConnectPoints([[0, 0]]), 0)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'min-cost-to-connect-all-points';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def networkDelayTime(self, times: list[list[int]], n: int, k: int) -> int:
        # Time for all n nodes to receive a signal from k, or -1.
        pass

import unittest


class TestNetworkDelay(unittest.TestCase):
    def test_example(self):
        self.assertEqual(Solution().networkDelayTime([[2, 1, 1], [2, 3, 1], [3, 4, 1]], 4, 2), 2)

    def test_single_edge(self):
        self.assertEqual(Solution().networkDelayTime([[1, 2, 1]], 2, 1), 1)

    def test_unreachable(self):
        self.assertEqual(Solution().networkDelayTime([[1, 2, 1]], 2, 2), -1)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'network-delay-time';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def swimInWater(self, grid: list[list[int]]) -> int:
        # Least time to swim from top-left to bottom-right.
        pass

import unittest


class TestSwimInWater(unittest.TestCase):
    def test_small(self):
        self.assertEqual(Solution().swimInWater([[0, 2], [1, 3]]), 3)

    def test_large(self):
        grid = [
            [0, 1, 2, 3, 4],
            [24, 23, 22, 21, 5],
            [12, 13, 14, 15, 16],
            [11, 17, 18, 19, 20],
            [10, 9, 8, 7, 6],
        ]
        self.assertEqual(Solution().swimInWater(grid), 16)

    def test_single(self):
        self.assertEqual(Solution().swimInWater([[0]]), 0)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'swim-in-rising-water';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def findCheapestPrice(self, n: int, flights: list[list[int]], src: int, dst: int, k: int) -> int:
        # Cheapest price from src to dst using at most k stops, or -1.
        pass

import unittest


class TestCheapestFlights(unittest.TestCase):
    def test_one_stop(self):
        flights = [[0, 1, 100], [1, 2, 100], [2, 0, 100], [1, 3, 600], [2, 3, 200]]
        self.assertEqual(Solution().findCheapestPrice(4, flights, 0, 3, 1), 700)

    def test_via_stop(self):
        flights = [[0, 1, 100], [1, 2, 100], [0, 2, 500]]
        self.assertEqual(Solution().findCheapestPrice(3, flights, 0, 2, 1), 200)

    def test_no_stop(self):
        flights = [[0, 1, 100], [1, 2, 100], [0, 2, 500]]
        self.assertEqual(Solution().findCheapestPrice(3, flights, 0, 2, 0), 500)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'cheapest-flights-within-k-stops';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def minInterval(self, intervals: list[list[int]], queries: list[int]) -> list[int]:
        # For each query, size of the smallest interval covering it, or -1.
        pass

import unittest


class TestMinInterval(unittest.TestCase):
    def test_example_1(self):
        self.assertEqual(
            Solution().minInterval([[1, 4], [2, 4], [3, 6], [4, 4]], [2, 3, 4, 5]),
            [3, 3, 1, 4],
        )

    def test_example_2(self):
        self.assertEqual(
            Solution().minInterval([[2, 3], [2, 5], [1, 8], [20, 25]], [2, 19, 5, 22]),
            [2, -1, 4, 6],
        )

    def test_single(self):
        self.assertEqual(Solution().minInterval([[1, 1]], [1, 2]), [1, -1])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'minimum-interval-to-include-each-query';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def accountsMerge(self, accounts: list[list[str]]) -> list[list[str]]:
        # Merge accounts sharing any email; each result is name + sorted emails.
        pass

import unittest


def _norm(accs):
    return sorted([acc[0]] + sorted(acc[1:]) for acc in accs)


class TestAccountsMerge(unittest.TestCase):
    def test_example(self):
        accounts = [
            ["John", "johnsmith@mail.com", "john_newyork@mail.com"],
            ["John", "johnsmith@mail.com", "john00@mail.com"],
            ["Mary", "mary@mail.com"],
            ["John", "johnnybravo@mail.com"],
        ]
        expected = [
            ["John", "john00@mail.com", "john_newyork@mail.com", "johnsmith@mail.com"],
            ["John", "johnnybravo@mail.com"],
            ["Mary", "mary@mail.com"],
        ]
        self.assertEqual(_norm(Solution().accountsMerge(accounts)), _norm(expected))

    def test_no_merge(self):
        accounts = [["A", "a@x.com"], ["B", "b@x.com"]]
        self.assertEqual(
            _norm(Solution().accountsMerge(accounts)), _norm([["A", "a@x.com"], ["B", "b@x.com"]])
        )

    def test_single(self):
        self.assertEqual(
            _norm(Solution().accountsMerge([["A", "a@x.com", "c@x.com"]])),
            _norm([["A", "a@x.com", "c@x.com"]]),
        )


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'accounts-merge';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def findMinHeightTrees(self, n: int, edges: list[list[int]]) -> list[int]:
        # Roots that give a minimum-height tree (1 or 2 of them), any order.
        pass

import unittest


class TestMinHeightTrees(unittest.TestCase):
    def test_one_center(self):
        self.assertEqual(set(Solution().findMinHeightTrees(4, [[1, 0], [1, 2], [1, 3]])), {1})

    def test_two_centers(self):
        edges = [[3, 0], [3, 1], [3, 2], [3, 4], [5, 4]]
        self.assertEqual(set(Solution().findMinHeightTrees(6, edges)), {3, 4})

    def test_single_node(self):
        self.assertEqual(set(Solution().findMinHeightTrees(1, [])), {0})


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'minimum-height-trees';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def calculate(self, s: str) -> int:
        # Evaluate an expression with + - ( ) and spaces.
        pass

import unittest


class TestBasicCalculator(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().calculate("1 + 1"), 2)
        self.assertEqual(Solution().calculate(" 2-1 + 2 "), 3)

    def test_nested(self):
        self.assertEqual(Solution().calculate("(1+(4+5+2)-3)+(6+8)"), 23)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'basic-calculator';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def jobScheduling(self, startTime: list[int], endTime: list[int], profit: list[int]) -> int:
        # Max profit from non-overlapping jobs.
        pass

import unittest


class TestJobScheduling(unittest.TestCase):
    def test_example_1(self):
        self.assertEqual(Solution().jobScheduling([1, 2, 3, 3], [3, 4, 5, 6], [50, 10, 40, 70]), 120)

    def test_example_2(self):
        self.assertEqual(
            Solution().jobScheduling([1, 2, 3, 4, 6], [3, 5, 10, 6, 9], [20, 20, 100, 70, 60]), 150
        )

    def test_overlap(self):
        self.assertEqual(Solution().jobScheduling([1, 1, 1], [2, 3, 4], [5, 6, 4]), 6)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'maximum-profit-in-job-scheduling';

update public.problems
set starter_code = jsonb_build_object('python3', $py$# On the platform a global isBadVersion(version) -> bool is provided. This
# local stand-in lets the bundled tests configure the first bad version.
_first_bad = 1


def isBadVersion(version: int) -> bool:
    return version >= _first_bad


def _set_first_bad(v: int) -> None:
    global _first_bad
    _first_bad = v

class Solution:
    def firstBadVersion(self, n: int) -> int:
        # Find the first bad version in 1..n using as few isBadVersion calls as possible.
        pass

import unittest


class TestFirstBadVersion(unittest.TestCase):
    def test_example(self):
        _set_first_bad(4)
        self.assertEqual(Solution().firstBadVersion(5), 4)

    def test_first(self):
        _set_first_bad(1)
        self.assertEqual(Solution().firstBadVersion(1), 1)

    def test_last(self):
        _set_first_bad(3)
        self.assertEqual(Solution().firstBadVersion(3), 3)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'first-bad-version';
