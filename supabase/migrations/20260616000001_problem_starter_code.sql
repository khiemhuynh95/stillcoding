-- StillCoding — per-problem starter code
--
-- Adds a `starter_code` jsonb column to `problems` and seeds it with
-- hand-authored, runnable Python starters (real signatures + inline
-- unittest blocks) for the curated study-list problems. The app reads this
-- via rowToDetail -> ProblemDetail.starterCode; the generic scaffold in
-- lib/starterTemplates.ts still covers everything without a seed here.
--
-- The daily sync (functions/sync-problems) only writes the columns it
-- names, so this column is preserved across syncs. Reads are covered by the
-- existing "problems are public read" RLS policy; only the service role
-- writes. Keyed by title_slug; a slug not present in the catalog is a no-op.

alter table public.problems add column if not exists starter_code jsonb;

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def twoSum(self, nums: list[int], target: int) -> list[int]:
        # Return indices of the two numbers that add up to target.
        pass


import unittest


class TestTwoSum(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().twoSum([2, 7, 11, 15], 9), [0, 1])
        self.assertEqual(Solution().twoSum([3, 2, 4], 6), [1, 2])

    def test_duplicate_values(self):
        self.assertEqual(Solution().twoSum([3, 3], 6), [0, 1])

    def test_negatives(self):
        self.assertEqual(Solution().twoSum([-1, -2, -3, -4, -5], -8), [2, 4])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'two-sum';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def maxProfit(self, prices: list[int]) -> int:
        # Max profit from one buy followed by one later sell (0 if none).
        pass


import unittest


class TestMaxProfit(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().maxProfit([7, 1, 5, 3, 6, 4]), 5)
        self.assertEqual(Solution().maxProfit([7, 6, 4, 3, 1]), 0)

    def test_single_day(self):
        self.assertEqual(Solution().maxProfit([1]), 0)

    def test_monotonic_increase(self):
        self.assertEqual(Solution().maxProfit([1, 2, 3, 4, 5]), 4)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'best-time-to-buy-and-sell-stock';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def containsDuplicate(self, nums: list[int]) -> bool:
        # True if any value appears at least twice.
        pass


import unittest


class TestContainsDuplicate(unittest.TestCase):
    def test_examples(self):
        self.assertTrue(Solution().containsDuplicate([1, 2, 3, 1]))
        self.assertFalse(Solution().containsDuplicate([1, 2, 3, 4]))

    def test_single_element(self):
        self.assertFalse(Solution().containsDuplicate([1]))

    def test_all_same(self):
        self.assertTrue(Solution().containsDuplicate([2, 2, 2]))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'contains-duplicate';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def productExceptSelf(self, nums: list[int]) -> list[int]:
        # answer[i] = product of all elements except nums[i] (no division).
        pass


import unittest


class TestProductExceptSelf(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().productExceptSelf([1, 2, 3, 4]), [24, 12, 8, 6])
        self.assertEqual(
            Solution().productExceptSelf([-1, 1, 0, -3, 3]), [0, 0, 9, 0, 0]
        )

    def test_two_elements(self):
        self.assertEqual(Solution().productExceptSelf([2, 3]), [3, 2])

    def test_multiple_zeros(self):
        self.assertEqual(Solution().productExceptSelf([0, 4, 0]), [0, 0, 0])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'product-of-array-except-self';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def maxSubArray(self, nums: list[int]) -> int:
        # Largest sum of any contiguous (non-empty) subarray.
        pass


import unittest


class TestMaxSubArray(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().maxSubArray([-2, 1, -3, 4, -1, 2, 1, -5, 4]), 6)
        self.assertEqual(Solution().maxSubArray([1]), 1)

    def test_all_negative(self):
        self.assertEqual(Solution().maxSubArray([-3, -1, -2]), -1)

    def test_mostly_positive(self):
        self.assertEqual(Solution().maxSubArray([5, 4, -1, 7, 8]), 23)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'maximum-subarray';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def isAnagram(self, s: str, t: str) -> bool:
        # True if t is an anagram of s.
        pass


import unittest


class TestIsAnagram(unittest.TestCase):
    def test_examples(self):
        self.assertTrue(Solution().isAnagram("anagram", "nagaram"))
        self.assertFalse(Solution().isAnagram("rat", "car"))

    def test_different_length(self):
        self.assertFalse(Solution().isAnagram("a", "ab"))

    def test_reordered(self):
        self.assertTrue(Solution().isAnagram("ab", "ba"))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'valid-anagram';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def groupAnagrams(self, strs: list[str]) -> list[list[str]]:
        # Group words that are anagrams of each other (any order).
        pass


import unittest


def _norm(groups):
    # Order-insensitive: the problem allows groups (and items) in any order.
    return sorted(sorted(g) for g in groups)


class TestGroupAnagrams(unittest.TestCase):
    def test_example(self):
        result = Solution().groupAnagrams(["eat", "tea", "tan", "ate", "nat", "bat"])
        self.assertEqual(_norm(result), _norm([["ate", "eat", "tea"], ["nat", "tan"], ["bat"]]))

    def test_empty_string(self):
        self.assertEqual(_norm(Solution().groupAnagrams([""])), _norm([[""]]))

    def test_single_word(self):
        self.assertEqual(_norm(Solution().groupAnagrams(["a"])), _norm([["a"]]))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'group-anagrams';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def topKFrequent(self, nums: list[int], k: int) -> list[int]:
        # The k most frequent elements (any order).
        pass


import unittest


class TestTopKFrequent(unittest.TestCase):
    def test_examples(self):
        # Any order is accepted, so compare as sets.
        self.assertEqual(set(Solution().topKFrequent([1, 1, 1, 2, 2, 3], 2)), {1, 2})
        self.assertEqual(set(Solution().topKFrequent([1], 1)), {1})

    def test_returns_k_elements(self):
        self.assertEqual(len(Solution().topKFrequent([1, 1, 2, 2, 3], 2)), 2)

    def test_single_distinct(self):
        self.assertEqual(set(Solution().topKFrequent([4, 4, 4], 1)), {4})


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'top-k-frequent-elements';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def isPalindrome(self, s: str) -> bool:
        # True if s reads the same forward/backward, ignoring case and
        # non-alphanumeric characters.
        pass


import unittest


class TestIsPalindrome(unittest.TestCase):
    def test_examples(self):
        self.assertTrue(Solution().isPalindrome("A man, a plan, a canal: Panama"))
        self.assertFalse(Solution().isPalindrome("race a car"))

    def test_only_punctuation(self):
        self.assertTrue(Solution().isPalindrome(" "))

    def test_alphanumeric_mismatch(self):
        self.assertFalse(Solution().isPalindrome("0P"))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'valid-palindrome';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def threeSum(self, nums: list[int]) -> list[list[int]]:
        # All unique triplets that sum to 0 (any order).
        pass


import unittest


def _norm(triplets):
    # Order-insensitive within and across triplets.
    return sorted(sorted(t) for t in triplets)


class TestThreeSum(unittest.TestCase):
    def test_example(self):
        result = Solution().threeSum([-1, 0, 1, 2, -1, -4])
        self.assertEqual(_norm(result), _norm([[-1, -1, 2], [-1, 0, 1]]))

    def test_no_triplet(self):
        self.assertEqual(Solution().threeSum([0, 1, 1]), [])

    def test_all_zeros(self):
        self.assertEqual(_norm(Solution().threeSum([0, 0, 0])), _norm([[0, 0, 0]]))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = '3sum';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def maxArea(self, height: list[int]) -> int:
        # Max water area between two lines.
        pass


import unittest


class TestMaxArea(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().maxArea([1, 8, 6, 2, 5, 4, 8, 3, 7]), 49)
        self.assertEqual(Solution().maxArea([1, 1]), 1)

    def test_increasing(self):
        self.assertEqual(Solution().maxArea([1, 2, 3, 4, 5]), 6)

    def test_tall_ends(self):
        self.assertEqual(Solution().maxArea([4, 3, 2, 1, 4]), 16)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'container-with-most-water';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def isValid(self, s: str) -> bool:
        # True if every bracket is closed by the same type, in order.
        pass


import unittest


class TestIsValid(unittest.TestCase):
    def test_examples(self):
        self.assertTrue(Solution().isValid("()"))
        self.assertTrue(Solution().isValid("()[]{}"))
        self.assertFalse(Solution().isValid("(]"))

    def test_nested(self):
        self.assertTrue(Solution().isValid("([])"))
        self.assertFalse(Solution().isValid("([)]"))

    def test_unbalanced(self):
        self.assertFalse(Solution().isValid("("))
        self.assertFalse(Solution().isValid("]"))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'valid-parentheses';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def maxProduct(self, nums: list[int]) -> int:
        # Largest product of any contiguous (non-empty) subarray.
        pass


import unittest


class TestMaxProduct(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().maxProduct([2, 3, -2, 4]), 6)
        self.assertEqual(Solution().maxProduct([-2, 0, -1]), 0)

    def test_two_negatives(self):
        self.assertEqual(Solution().maxProduct([-2, 3, -4]), 24)

    def test_single_negative(self):
        self.assertEqual(Solution().maxProduct([-2]), -2)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'maximum-product-subarray';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def findMin(self, nums: list[int]) -> int:
        # Minimum of a sorted array rotated some number of times.
        pass


import unittest


class TestFindMin(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().findMin([3, 4, 5, 1, 2]), 1)
        self.assertEqual(Solution().findMin([4, 5, 6, 7, 0, 1, 2]), 0)

    def test_not_rotated(self):
        self.assertEqual(Solution().findMin([11, 13, 15, 17]), 11)

    def test_single(self):
        self.assertEqual(Solution().findMin([1]), 1)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'find-minimum-in-rotated-sorted-array';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def search(self, nums: list[int], target: int) -> int:
        # Index of target in a rotated sorted array, or -1.
        pass


import unittest


class TestSearch(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().search([4, 5, 6, 7, 0, 1, 2], 0), 4)
        self.assertEqual(Solution().search([4, 5, 6, 7, 0, 1, 2], 3), -1)

    def test_single_miss(self):
        self.assertEqual(Solution().search([1], 0), -1)

    def test_target_at_pivot(self):
        self.assertEqual(Solution().search([5, 1, 3], 5), 0)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'search-in-rotated-sorted-array';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def getSum(self, a: int, b: int) -> int:
        # Sum of a and b without using + or -.
        pass


import unittest


class TestGetSum(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().getSum(1, 2), 3)
        self.assertEqual(Solution().getSum(2, 3), 5)

    def test_cancels_to_zero(self):
        self.assertEqual(Solution().getSum(-1, 1), 0)

    def test_both_negative(self):
        self.assertEqual(Solution().getSum(-2, -3), -5)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'sum-of-two-integers';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def hammingWeight(self, n: int) -> int:
        # Number of set bits (1s) in the binary representation of n.
        pass


import unittest


class TestHammingWeight(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().hammingWeight(11), 3)
        self.assertEqual(Solution().hammingWeight(128), 1)

    def test_all_ones_byte(self):
        self.assertEqual(Solution().hammingWeight(255), 8)

    def test_zero(self):
        self.assertEqual(Solution().hammingWeight(0), 0)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'number-of-1-bits';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def countBits(self, n: int) -> list[int]:
        # ans[i] = number of set bits in i, for 0..n.
        pass


import unittest


class TestCountBits(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().countBits(2), [0, 1, 1])
        self.assertEqual(Solution().countBits(5), [0, 1, 1, 2, 1, 2])

    def test_zero(self):
        self.assertEqual(Solution().countBits(0), [0])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'counting-bits';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def missingNumber(self, nums: list[int]) -> int:
        # The number in [0, n] missing from nums.
        pass


import unittest


class TestMissingNumber(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().missingNumber([3, 0, 1]), 2)
        self.assertEqual(Solution().missingNumber([0, 1]), 2)

    def test_larger(self):
        self.assertEqual(Solution().missingNumber([9, 6, 4, 2, 3, 5, 7, 0, 1]), 8)

    def test_single(self):
        self.assertEqual(Solution().missingNumber([0]), 1)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'missing-number';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def reverseBits(self, n: int) -> int:
        # Reverse the bits of a 32-bit unsigned integer.
        pass


import unittest


class TestReverseBits(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().reverseBits(43261596), 964176192)
        self.assertEqual(Solution().reverseBits(4294967293), 3221225471)

    def test_zero(self):
        self.assertEqual(Solution().reverseBits(0), 0)

    def test_low_bit(self):
        self.assertEqual(Solution().reverseBits(1), 2147483648)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'reverse-bits';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def climbStairs(self, n: int) -> int:
        # Number of distinct ways to climb n stairs taking 1 or 2 steps.
        pass


import unittest


class TestClimbStairs(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().climbStairs(2), 2)
        self.assertEqual(Solution().climbStairs(3), 3)

    def test_one(self):
        self.assertEqual(Solution().climbStairs(1), 1)

    def test_larger(self):
        self.assertEqual(Solution().climbStairs(5), 8)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'climbing-stairs';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def coinChange(self, coins: list[int], amount: int) -> int:
        # Fewest coins to make amount, or -1 if impossible.
        pass


import unittest


class TestCoinChange(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().coinChange([1, 2, 5], 11), 3)
        self.assertEqual(Solution().coinChange([2], 3), -1)

    def test_zero_amount(self):
        self.assertEqual(Solution().coinChange([1], 0), 0)

    def test_impossible(self):
        self.assertEqual(Solution().coinChange([2, 5, 10], 1), -1)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'coin-change';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def lengthOfLIS(self, nums: list[int]) -> int:
        # Length of the longest strictly increasing subsequence.
        pass


import unittest


class TestLengthOfLIS(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().lengthOfLIS([10, 9, 2, 5, 3, 7, 101, 18]), 4)
        self.assertEqual(Solution().lengthOfLIS([0, 1, 0, 3, 2, 3]), 4)

    def test_all_equal(self):
        self.assertEqual(Solution().lengthOfLIS([7, 7, 7, 7]), 1)

    def test_single(self):
        self.assertEqual(Solution().lengthOfLIS([1]), 1)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'longest-increasing-subsequence';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def longestCommonSubsequence(self, text1: str, text2: str) -> int:
        # Length of the longest subsequence common to both strings.
        pass


import unittest


class TestLCS(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().longestCommonSubsequence("abcde", "ace"), 3)
        self.assertEqual(Solution().longestCommonSubsequence("abc", "abc"), 3)

    def test_no_common(self):
        self.assertEqual(Solution().longestCommonSubsequence("abc", "def"), 0)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'longest-common-subsequence';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def wordBreak(self, s: str, wordDict: list[str]) -> bool:
        # True if s can be segmented into words from wordDict.
        pass


import unittest


class TestWordBreak(unittest.TestCase):
    def test_examples(self):
        self.assertTrue(Solution().wordBreak("leetcode", ["leet", "code"]))
        self.assertTrue(Solution().wordBreak("applepenapple", ["apple", "pen"]))

    def test_cannot_segment(self):
        self.assertFalse(
            Solution().wordBreak("catsandog", ["cats", "dog", "sand", "and", "cat"])
        )


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'word-break';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def combinationSum(self, candidates: list[int], target: int) -> list[list[int]]:
        # All unique combinations summing to target (numbers reusable, any order).
        pass


import unittest


def _norm(combos):
    return sorted(sorted(c) for c in combos)


class TestCombinationSum(unittest.TestCase):
    def test_example_1(self):
        result = Solution().combinationSum([2, 3, 6, 7], 7)
        self.assertEqual(_norm(result), _norm([[2, 2, 3], [7]]))

    def test_example_2(self):
        result = Solution().combinationSum([2, 3, 5], 8)
        self.assertEqual(_norm(result), _norm([[2, 2, 2, 2], [2, 3, 3], [3, 5]]))

    def test_no_combination(self):
        self.assertEqual(Solution().combinationSum([2], 1), [])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'combination-sum';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def rob(self, nums: list[int]) -> int:
        # Max sum with no two adjacent houses robbed.
        pass


import unittest


class TestRob(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().rob([1, 2, 3, 1]), 4)
        self.assertEqual(Solution().rob([2, 7, 9, 3, 1]), 12)

    def test_single(self):
        self.assertEqual(Solution().rob([5]), 5)

    def test_pick_ends(self):
        self.assertEqual(Solution().rob([2, 1, 1, 2]), 4)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'house-robber';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def rob(self, nums: list[int]) -> int:
        # Houses are in a circle: first and last are adjacent.
        pass


import unittest


class TestRobII(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().rob([2, 3, 2]), 3)
        self.assertEqual(Solution().rob([1, 2, 3, 1]), 4)

    def test_three(self):
        self.assertEqual(Solution().rob([1, 2, 3]), 3)

    def test_single(self):
        self.assertEqual(Solution().rob([0]), 0)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'house-robber-ii';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def numDecodings(self, s: str) -> int:
        # Number of ways to decode a digit string (A=1 .. Z=26).
        pass


import unittest


class TestNumDecodings(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().numDecodings("12"), 2)
        self.assertEqual(Solution().numDecodings("226"), 3)

    def test_leading_zero(self):
        self.assertEqual(Solution().numDecodings("06"), 0)

    def test_ten(self):
        self.assertEqual(Solution().numDecodings("10"), 1)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'decode-ways';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def uniquePaths(self, m: int, n: int) -> int:
        # Paths from top-left to bottom-right moving only right/down.
        pass


import unittest


class TestUniquePaths(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().uniquePaths(3, 7), 28)
        self.assertEqual(Solution().uniquePaths(3, 2), 3)

    def test_single_cell(self):
        self.assertEqual(Solution().uniquePaths(1, 1), 1)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'unique-paths';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def canJump(self, nums: list[int]) -> bool:
        # True if you can reach the last index (nums[i] = max jump length).
        pass


import unittest


class TestCanJump(unittest.TestCase):
    def test_examples(self):
        self.assertTrue(Solution().canJump([2, 3, 1, 1, 4]))
        self.assertFalse(Solution().canJump([3, 2, 1, 0, 4]))

    def test_single(self):
        self.assertTrue(Solution().canJump([0]))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'jump-game';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def longestConsecutive(self, nums: list[int]) -> int:
        # Length of the longest run of consecutive integers (O(n)).
        pass


import unittest


class TestLongestConsecutive(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().longestConsecutive([100, 4, 200, 1, 3, 2]), 4)
        self.assertEqual(
            Solution().longestConsecutive([0, 3, 7, 2, 5, 8, 4, 6, 0, 1]), 9
        )

    def test_empty(self):
        self.assertEqual(Solution().longestConsecutive([]), 0)

    def test_single(self):
        self.assertEqual(Solution().longestConsecutive([1]), 1)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'longest-consecutive-sequence';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def lengthOfLongestSubstring(self, s: str) -> int:
        # Length of the longest substring without repeating characters.
        pass


import unittest


class TestLengthOfLongestSubstring(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().lengthOfLongestSubstring("abcabcbb"), 3)
        self.assertEqual(Solution().lengthOfLongestSubstring("bbbbb"), 1)
        self.assertEqual(Solution().lengthOfLongestSubstring("pwwkew"), 3)

    def test_empty(self):
        self.assertEqual(Solution().lengthOfLongestSubstring(""), 0)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'longest-substring-without-repeating-characters';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def characterReplacement(self, s: str, k: int) -> int:
        # Longest substring of one repeated letter after at most k replacements.
        pass


import unittest


class TestCharacterReplacement(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().characterReplacement("ABAB", 2), 4)
        self.assertEqual(Solution().characterReplacement("AABABBA", 1), 4)

    def test_no_replacements(self):
        self.assertEqual(Solution().characterReplacement("A", 0), 1)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'longest-repeating-character-replacement';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def minWindow(self, s: str, t: str) -> str:
        # Smallest substring of s containing all chars of t, or "".
        pass


import unittest


class TestMinWindow(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().minWindow("ADOBECODEBANC", "ABC"), "BANC")
        self.assertEqual(Solution().minWindow("a", "a"), "a")

    def test_impossible(self):
        self.assertEqual(Solution().minWindow("a", "aa"), "")


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'minimum-window-substring';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def longestPalindrome(self, s: str) -> str:
        # Any longest palindromic substring of s.
        pass


import unittest


class TestLongestPalindrome(unittest.TestCase):
    def test_example_multiple_answers(self):
        # "bab" and "aba" are both valid longest answers.
        self.assertIn(Solution().longestPalindrome("babad"), {"bab", "aba"})

    def test_even_length(self):
        self.assertEqual(Solution().longestPalindrome("cbbd"), "bb")

    def test_single(self):
        self.assertEqual(Solution().longestPalindrome("a"), "a")


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'longest-palindromic-substring';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def countSubstrings(self, s: str) -> int:
        # Number of palindromic substrings (by position).
        pass


import unittest


class TestCountSubstrings(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().countSubstrings("abc"), 3)
        self.assertEqual(Solution().countSubstrings("aaa"), 6)

    def test_single(self):
        self.assertEqual(Solution().countSubstrings("a"), 1)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'palindromic-substrings';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Codec:
    def encode(self, strs: list[str]) -> str:
        # Encode a list of strings to a single string.
        pass

    def decode(self, s: str) -> list[str]:
        # Decode the single string back to the original list.
        pass


import unittest


class TestCodec(unittest.TestCase):
    def _round_trip(self, strs):
        codec = Codec()
        self.assertEqual(codec.decode(codec.encode(strs)), strs)

    def test_examples(self):
        self._round_trip(["lint", "code", "love", "you"])
        self._round_trip(["we", "say", ":", "yes"])

    def test_empty_strings(self):
        self._round_trip([""])
        self._round_trip(["", ""])

    def test_delimiter_like_content(self):
        self._round_trip(["he#llo", "2#x"])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'encode-and-decode-strings';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def setZeroes(self, matrix: list[list[int]]) -> None:
        # If a cell is 0, set its entire row and column to 0, in place.
        pass


import unittest


class TestSetZeroes(unittest.TestCase):
    def test_examples(self):
        m = [[1, 1, 1], [1, 0, 1], [1, 1, 1]]
        Solution().setZeroes(m)
        self.assertEqual(m, [[1, 0, 1], [0, 0, 0], [1, 0, 1]])

    def test_zeros_in_corners(self):
        m = [[0, 1, 2, 0], [3, 4, 5, 2], [1, 3, 1, 5]]
        Solution().setZeroes(m)
        self.assertEqual(m, [[0, 0, 0, 0], [0, 4, 5, 0], [0, 3, 1, 0]])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'set-matrix-zeroes';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def spiralOrder(self, matrix: list[list[int]]) -> list[int]:
        # All elements in spiral (clockwise) order.
        pass


import unittest


class TestSpiralOrder(unittest.TestCase):
    def test_square(self):
        self.assertEqual(
            Solution().spiralOrder([[1, 2, 3], [4, 5, 6], [7, 8, 9]]),
            [1, 2, 3, 6, 9, 8, 7, 4, 5],
        )

    def test_rectangle(self):
        self.assertEqual(
            Solution().spiralOrder([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]]),
            [1, 2, 3, 4, 8, 12, 11, 10, 9, 5, 6, 7],
        )

    def test_single_row(self):
        self.assertEqual(Solution().spiralOrder([[1, 2, 3]]), [1, 2, 3])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'spiral-matrix';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def rotate(self, matrix: list[list[int]]) -> None:
        # Rotate the n x n matrix 90 degrees clockwise, in place.
        pass


import unittest


class TestRotate(unittest.TestCase):
    def test_3x3(self):
        m = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
        Solution().rotate(m)
        self.assertEqual(m, [[7, 4, 1], [8, 5, 2], [9, 6, 3]])

    def test_2x2(self):
        m = [[1, 2], [3, 4]]
        Solution().rotate(m)
        self.assertEqual(m, [[3, 1], [4, 2]])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'rotate-image';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def exist(self, board: list[list[str]], word: str) -> bool:
        # True if word can be formed from adjacent (up/down/left/right) cells,
        # each cell used at most once.
        pass


import unittest


class TestExist(unittest.TestCase):
    def _board(self):
        return [["A", "B", "C", "E"], ["S", "F", "C", "S"], ["A", "D", "E", "E"]]

    def test_present(self):
        self.assertTrue(Solution().exist(self._board(), "ABCCED"))
        self.assertTrue(Solution().exist(self._board(), "SEE"))

    def test_absent(self):
        self.assertFalse(Solution().exist(self._board(), "ABCB"))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'word-search';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def insert(
        self, intervals: list[list[int]], newInterval: list[int]
    ) -> list[list[int]]:
        # Insert newInterval into sorted, non-overlapping intervals and merge.
        pass


import unittest


class TestInsert(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().insert([[1, 3], [6, 9]], [2, 5]), [[1, 5], [6, 9]])
        self.assertEqual(
            Solution().insert([[1, 2], [3, 5], [6, 7], [8, 10], [12, 16]], [4, 8]),
            [[1, 2], [3, 10], [12, 16]],
        )

    def test_into_empty(self):
        self.assertEqual(Solution().insert([], [5, 7]), [[5, 7]])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'insert-interval';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def merge(self, intervals: list[list[int]]) -> list[list[int]]:
        # Merge all overlapping intervals.
        pass


import unittest


class TestMerge(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(
            Solution().merge([[1, 3], [2, 6], [8, 10], [15, 18]]),
            [[1, 6], [8, 10], [15, 18]],
        )
        self.assertEqual(Solution().merge([[1, 4], [4, 5]]), [[1, 5]])

    def test_single(self):
        self.assertEqual(Solution().merge([[1, 4]]), [[1, 4]])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'merge-intervals';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def eraseOverlapIntervals(self, intervals: list[list[int]]) -> int:
        # Min number of intervals to remove so the rest don't overlap.
        pass


import unittest


class TestEraseOverlap(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(
            Solution().eraseOverlapIntervals([[1, 2], [2, 3], [3, 4], [1, 3]]), 1
        )
        self.assertEqual(
            Solution().eraseOverlapIntervals([[1, 2], [1, 2], [1, 2]]), 2
        )

    def test_none_overlap(self):
        self.assertEqual(Solution().eraseOverlapIntervals([[1, 2], [2, 3]]), 0)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'non-overlapping-intervals';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def canAttendMeetings(self, intervals: list[list[int]]) -> bool:
        # True if a person can attend all meetings (no overlaps).
        pass


import unittest


class TestCanAttendMeetings(unittest.TestCase):
    def test_examples(self):
        self.assertFalse(Solution().canAttendMeetings([[0, 30], [5, 10], [15, 20]]))
        self.assertTrue(Solution().canAttendMeetings([[7, 10], [2, 4]]))

    def test_empty(self):
        self.assertTrue(Solution().canAttendMeetings([]))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'meeting-rooms';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def minMeetingRooms(self, intervals: list[list[int]]) -> int:
        # Minimum number of conference rooms required.
        pass


import unittest


class TestMinMeetingRooms(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().minMeetingRooms([[0, 30], [5, 10], [15, 20]]), 2)
        self.assertEqual(Solution().minMeetingRooms([[7, 10], [2, 4]]), 1)

    def test_back_to_back(self):
        self.assertEqual(Solution().minMeetingRooms([[1, 5], [5, 10]]), 1)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'meeting-rooms-ii';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def canFinish(
        self, numCourses: int, prerequisites: list[list[int]]
    ) -> bool:
        # True if all courses can be finished (no prerequisite cycle).
        pass


import unittest


class TestCanFinish(unittest.TestCase):
    def test_examples(self):
        self.assertTrue(Solution().canFinish(2, [[1, 0]]))
        self.assertFalse(Solution().canFinish(2, [[1, 0], [0, 1]]))

    def test_no_prerequisites(self):
        self.assertTrue(Solution().canFinish(1, []))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'course-schedule';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def numIslands(self, grid: list[list[str]]) -> int:
        # Count islands of "1" connected horizontally/vertically.
        pass


import unittest


class TestNumIslands(unittest.TestCase):
    def test_one_island(self):
        grid = [
            ["1", "1", "1", "1", "0"],
            ["1", "1", "0", "1", "0"],
            ["1", "1", "0", "0", "0"],
            ["0", "0", "0", "0", "0"],
        ]
        self.assertEqual(Solution().numIslands(grid), 1)

    def test_three_islands(self):
        grid = [
            ["1", "1", "0", "0", "0"],
            ["1", "1", "0", "0", "0"],
            ["0", "0", "1", "0", "0"],
            ["0", "0", "0", "1", "1"],
        ]
        self.assertEqual(Solution().numIslands(grid), 3)

    def test_no_land(self):
        self.assertEqual(Solution().numIslands([["0"]]), 0)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'number-of-islands';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def pacificAtlantic(self, heights: list[list[int]]) -> list[list[int]]:
        # Cells from which water can reach both oceans (any order).
        pass


import unittest


def _as_set(cells):
    return {tuple(c) for c in cells}


class TestPacificAtlantic(unittest.TestCase):
    def test_example(self):
        heights = [
            [1, 2, 2, 3, 5],
            [3, 2, 3, 4, 4],
            [2, 4, 5, 3, 1],
            [6, 7, 1, 4, 5],
            [5, 1, 1, 2, 4],
        ]
        expected = [[0, 4], [1, 3], [1, 4], [2, 2], [3, 0], [3, 1], [4, 0]]
        self.assertEqual(_as_set(Solution().pacificAtlantic(heights)), _as_set(expected))

    def test_single_cell(self):
        self.assertEqual(_as_set(Solution().pacificAtlantic([[1]])), {(0, 0)})


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'pacific-atlantic-water-flow';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def validTree(self, n: int, edges: list[list[int]]) -> bool:
        # True if the n nodes + edges form a valid tree (connected, acyclic).
        pass


import unittest


class TestValidTree(unittest.TestCase):
    def test_examples(self):
        self.assertTrue(Solution().validTree(5, [[0, 1], [0, 2], [0, 3], [1, 4]]))
        self.assertFalse(
            Solution().validTree(5, [[0, 1], [1, 2], [2, 3], [1, 3], [1, 4]])
        )

    def test_single_node(self):
        self.assertTrue(Solution().validTree(1, []))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'graph-valid-tree';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def countComponents(self, n: int, edges: list[list[int]]) -> int:
        # Number of connected components in an undirected graph.
        pass


import unittest


class TestCountComponents(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().countComponents(5, [[0, 1], [1, 2], [3, 4]]), 2)
        self.assertEqual(
            Solution().countComponents(5, [[0, 1], [1, 2], [2, 3], [3, 4]]), 1
        )

    def test_no_edges(self):
        self.assertEqual(Solution().countComponents(4, []), 4)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'number-of-connected-components-in-an-undirected-graph';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def alienOrder(self, words: list[str]) -> str:
        # A letter order consistent with the sorted alien words, or "".
        pass


import unittest


class TestAlienOrder(unittest.TestCase):
    def test_full_order(self):
        # These constraints chain into a single total order.
        self.assertEqual(Solution().alienOrder(["wrt", "wrf", "er", "ett", "rftt"]), "wertf")
        self.assertEqual(Solution().alienOrder(["z", "x"]), "zx")

    def test_invalid_cycle(self):
        self.assertEqual(Solution().alienOrder(["z", "x", "z"]), "")


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'alien-dictionary';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next


class Solution:
    def reverseList(self, head: "ListNode | None") -> "ListNode | None":
        # Reverse a singly linked list and return the new head.
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


class TestReverseList(unittest.TestCase):
    def test_example(self):
        self.assertEqual(to_list(Solution().reverseList(build([1, 2, 3, 4, 5]))), [5, 4, 3, 2, 1])

    def test_empty(self):
        self.assertEqual(to_list(Solution().reverseList(build([]))), [])

    def test_single(self):
        self.assertEqual(to_list(Solution().reverseList(build([1]))), [1])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'reverse-linked-list';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next


class Solution:
    def hasCycle(self, head: "ListNode | None") -> bool:
        # True if the linked list contains a cycle.
        pass


import unittest


def build_cycle(vals, pos):
    nodes = [ListNode(v) for v in vals]
    for i in range(len(nodes) - 1):
        nodes[i].next = nodes[i + 1]
    if pos >= 0 and nodes:
        nodes[-1].next = nodes[pos]
    return nodes[0] if nodes else None


class TestHasCycle(unittest.TestCase):
    def test_has_cycle(self):
        self.assertTrue(Solution().hasCycle(build_cycle([3, 2, 0, -4], 1)))
        self.assertTrue(Solution().hasCycle(build_cycle([1, 2], 0)))

    def test_no_cycle(self):
        self.assertFalse(Solution().hasCycle(build_cycle([1], -1)))

    def test_empty(self):
        self.assertFalse(Solution().hasCycle(None))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'linked-list-cycle';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next


class Solution:
    def mergeTwoLists(
        self, list1: "ListNode | None", list2: "ListNode | None"
    ) -> "ListNode | None":
        # Merge two sorted lists into one sorted list.
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


class TestMergeTwoLists(unittest.TestCase):
    def test_example(self):
        result = Solution().mergeTwoLists(build([1, 2, 4]), build([1, 3, 4]))
        self.assertEqual(to_list(result), [1, 1, 2, 3, 4, 4])

    def test_both_empty(self):
        self.assertEqual(to_list(Solution().mergeTwoLists(build([]), build([]))), [])

    def test_one_empty(self):
        self.assertEqual(to_list(Solution().mergeTwoLists(build([]), build([0]))), [0])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'merge-two-sorted-lists';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next


class Solution:
    def mergeKLists(self, lists: "list[ListNode | None]") -> "ListNode | None":
        # Merge k sorted linked lists into one sorted list.
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


class TestMergeKLists(unittest.TestCase):
    def test_example(self):
        lists = [build([1, 4, 5]), build([1, 3, 4]), build([2, 6])]
        self.assertEqual(to_list(Solution().mergeKLists(lists)), [1, 1, 2, 3, 4, 4, 5, 6])

    def test_empty(self):
        self.assertEqual(to_list(Solution().mergeKLists([])), [])

    def test_list_of_empty(self):
        self.assertEqual(to_list(Solution().mergeKLists([build([])])), [])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'merge-k-sorted-lists';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next


class Solution:
    def removeNthFromEnd(
        self, head: "ListNode | None", n: int
    ) -> "ListNode | None":
        # Remove the nth node from the end and return the head.
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


class TestRemoveNthFromEnd(unittest.TestCase):
    def test_example(self):
        self.assertEqual(to_list(Solution().removeNthFromEnd(build([1, 2, 3, 4, 5]), 2)), [1, 2, 3, 5])

    def test_remove_only_node(self):
        self.assertEqual(to_list(Solution().removeNthFromEnd(build([1]), 1)), [])

    def test_remove_last(self):
        self.assertEqual(to_list(Solution().removeNthFromEnd(build([1, 2]), 1)), [1])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'remove-nth-node-from-end-of-list';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next


class Solution:
    def reorderList(self, head: "ListNode | None") -> None:
        # Reorder L0->L1->...->Ln to L0->Ln->L1->Ln-1->..., in place.
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


class TestReorderList(unittest.TestCase):
    def test_even_length(self):
        head = build([1, 2, 3, 4])
        Solution().reorderList(head)
        self.assertEqual(to_list(head), [1, 4, 2, 3])

    def test_odd_length(self):
        head = build([1, 2, 3, 4, 5])
        Solution().reorderList(head)
        self.assertEqual(to_list(head), [1, 5, 2, 4, 3])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'reorder-list';

update public.problems
set starter_code = jsonb_build_object('python3', $py$from collections import deque


class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right


class Solution:
    def maxDepth(self, root: "TreeNode | None") -> int:
        # Number of nodes on the longest root-to-leaf path.
        pass


import unittest


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


class TestMaxDepth(unittest.TestCase):
    def test_example(self):
        self.assertEqual(Solution().maxDepth(build_tree([3, 9, 20, None, None, 15, 7])), 3)

    def test_empty(self):
        self.assertEqual(Solution().maxDepth(build_tree([])), 0)

    def test_single(self):
        self.assertEqual(Solution().maxDepth(build_tree([1])), 1)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'maximum-depth-of-binary-tree';

update public.problems
set starter_code = jsonb_build_object('python3', $py$from collections import deque


class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right


class Solution:
    def isSameTree(self, p: "TreeNode | None", q: "TreeNode | None") -> bool:
        # True if both trees are structurally identical with equal values.
        pass


import unittest


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


class TestIsSameTree(unittest.TestCase):
    def test_identical(self):
        self.assertTrue(Solution().isSameTree(build_tree([1, 2, 3]), build_tree([1, 2, 3])))

    def test_different_shape(self):
        self.assertFalse(Solution().isSameTree(build_tree([1, 2]), build_tree([1, None, 2])))

    def test_different_values(self):
        self.assertFalse(Solution().isSameTree(build_tree([1, 2, 1]), build_tree([1, 1, 2])))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'same-tree';

update public.problems
set starter_code = jsonb_build_object('python3', $py$from collections import deque


class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right


class Solution:
    def invertTree(self, root: "TreeNode | None") -> "TreeNode | None":
        # Mirror the tree left-to-right.
        pass


import unittest


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


def serialize(root):
    out = []

    def dfs(n):
        if not n:
            out.append("#")
            return
        out.append(n.val)
        dfs(n.left)
        dfs(n.right)

    dfs(root)
    return out


class TestInvertTree(unittest.TestCase):
    def test_example(self):
        result = Solution().invertTree(build_tree([4, 2, 7, 1, 3, 6, 9]))
        self.assertEqual(serialize(result), serialize(build_tree([4, 7, 2, 9, 6, 3, 1])))

    def test_small(self):
        result = Solution().invertTree(build_tree([2, 1, 3]))
        self.assertEqual(serialize(result), serialize(build_tree([2, 3, 1])))

    def test_empty(self):
        self.assertIsNone(Solution().invertTree(build_tree([])))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'invert-binary-tree';

update public.problems
set starter_code = jsonb_build_object('python3', $py$from collections import deque


class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right


class Solution:
    def maxPathSum(self, root: "TreeNode | None") -> int:
        # Max sum of any path (sequence of adjacent nodes, need not pass root).
        pass


import unittest


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


class TestMaxPathSum(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(Solution().maxPathSum(build_tree([1, 2, 3])), 6)
        self.assertEqual(
            Solution().maxPathSum(build_tree([-10, 9, 20, None, None, 15, 7])), 42
        )

    def test_single_negative(self):
        self.assertEqual(Solution().maxPathSum(build_tree([-3])), -3)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'binary-tree-maximum-path-sum';

update public.problems
set starter_code = jsonb_build_object('python3', $py$from collections import deque


class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right


class Solution:
    def levelOrder(self, root: "TreeNode | None") -> list[list[int]]:
        # Node values level by level, left to right.
        pass


import unittest


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


class TestLevelOrder(unittest.TestCase):
    def test_example(self):
        self.assertEqual(
            Solution().levelOrder(build_tree([3, 9, 20, None, None, 15, 7])),
            [[3], [9, 20], [15, 7]],
        )

    def test_empty(self):
        self.assertEqual(Solution().levelOrder(build_tree([])), [])

    def test_single(self):
        self.assertEqual(Solution().levelOrder(build_tree([1])), [[1]])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'binary-tree-level-order-traversal';

update public.problems
set starter_code = jsonb_build_object('python3', $py$from collections import deque


class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right


class Codec:
    def serialize(self, root: "TreeNode | None") -> str:
        # Encode a tree to a single string.
        pass

    def deserialize(self, data: str) -> "TreeNode | None":
        # Decode your string back to the same tree.
        pass


import unittest


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


def shape(root):
    out = []

    def dfs(n):
        if not n:
            out.append("#")
            return
        out.append(n.val)
        dfs(n.left)
        dfs(n.right)

    dfs(root)
    return out


class TestCodec(unittest.TestCase):
    def _round_trip(self, vals):
        tree = build_tree(vals)
        codec = Codec()
        restored = codec.deserialize(codec.serialize(tree))
        self.assertEqual(shape(restored), shape(tree))

    def test_example(self):
        self._round_trip([1, 2, 3, None, None, 4, 5])

    def test_empty(self):
        self._round_trip([])

    def test_single(self):
        self._round_trip([1])


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'serialize-and-deserialize-binary-tree';

update public.problems
set starter_code = jsonb_build_object('python3', $py$from collections import deque


class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right


class Solution:
    def isSubtree(
        self, root: "TreeNode | None", subRoot: "TreeNode | None"
    ) -> bool:
        # True if subRoot is a subtree of root.
        pass


import unittest


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


class TestIsSubtree(unittest.TestCase):
    def test_is_subtree(self):
        self.assertTrue(
            Solution().isSubtree(build_tree([3, 4, 5, 1, 2]), build_tree([4, 1, 2]))
        )

    def test_not_subtree(self):
        root = build_tree([3, 4, 5, 1, 2, None, None, None, None, 0])
        self.assertFalse(Solution().isSubtree(root, build_tree([4, 1, 2])))

    def test_single_node(self):
        self.assertTrue(Solution().isSubtree(build_tree([1]), build_tree([1])))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'subtree-of-another-tree';

update public.problems
set starter_code = jsonb_build_object('python3', $py$from collections import deque


class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right


class Solution:
    def buildTree(self, preorder: list[int], inorder: list[int]) -> "TreeNode | None":
        # Reconstruct the tree from its preorder and inorder traversals.
        pass


import unittest


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


def shape(root):
    out = []

    def dfs(n):
        if not n:
            out.append("#")
            return
        out.append(n.val)
        dfs(n.left)
        dfs(n.right)

    dfs(root)
    return out


class TestBuildTree(unittest.TestCase):
    def test_example(self):
        result = Solution().buildTree([3, 9, 20, 15, 7], [9, 3, 15, 20, 7])
        self.assertEqual(shape(result), shape(build_tree([3, 9, 20, None, None, 15, 7])))

    def test_single(self):
        result = Solution().buildTree([-1], [-1])
        self.assertEqual(shape(result), shape(build_tree([-1])))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'construct-binary-tree-from-preorder-and-inorder-traversal';

update public.problems
set starter_code = jsonb_build_object('python3', $py$from collections import deque


class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right


class Solution:
    def isValidBST(self, root: "TreeNode | None") -> bool:
        # True if the tree is a valid binary search tree.
        pass


import unittest


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


class TestIsValidBST(unittest.TestCase):
    def test_valid(self):
        self.assertTrue(Solution().isValidBST(build_tree([2, 1, 3])))

    def test_invalid(self):
        self.assertFalse(Solution().isValidBST(build_tree([5, 1, 4, None, None, 3, 6])))

    def test_single(self):
        self.assertTrue(Solution().isValidBST(build_tree([1])))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'validate-binary-search-tree';

update public.problems
set starter_code = jsonb_build_object('python3', $py$from collections import deque


class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right


class Solution:
    def kthSmallest(self, root: "TreeNode | None", k: int) -> int:
        # The kth smallest value in the BST (1-indexed).
        pass


import unittest


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


class TestKthSmallest(unittest.TestCase):
    def test_first(self):
        self.assertEqual(Solution().kthSmallest(build_tree([3, 1, 4, None, 2]), 1), 1)

    def test_third(self):
        self.assertEqual(
            Solution().kthSmallest(build_tree([5, 3, 6, 2, 4, None, None, 1]), 3), 3
        )


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'kth-smallest-element-in-a-bst';

update public.problems
set starter_code = jsonb_build_object('python3', $py$from collections import deque


class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right


class Solution:
    def lowestCommonAncestor(
        self, root: "TreeNode", p: "TreeNode", q: "TreeNode"
    ) -> "TreeNode":
        # Lowest node that is an ancestor of both p and q in the BST.
        pass


import unittest


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
    while root:
        if val < root.val:
            root = root.left
        elif val > root.val:
            root = root.right
        else:
            return root
    return None


class TestLCA(unittest.TestCase):
    def setUp(self):
        self.root = build_tree([6, 2, 8, 0, 4, 7, 9, None, None, 3, 5])

    def test_split(self):
        p, q = find(self.root, 2), find(self.root, 8)
        self.assertEqual(Solution().lowestCommonAncestor(self.root, p, q).val, 6)

    def test_ancestor_is_node(self):
        p, q = find(self.root, 2), find(self.root, 4)
        self.assertEqual(Solution().lowestCommonAncestor(self.root, p, q).val, 2)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'lowest-common-ancestor-of-a-binary-search-tree';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Trie:
    def __init__(self):
        # Initialize the data structure.
        pass

    def insert(self, word: str) -> None:
        pass

    def search(self, word: str) -> bool:
        # True if word was inserted.
        pass

    def startsWith(self, prefix: str) -> bool:
        # True if any inserted word starts with prefix.
        pass


import unittest


class TestTrie(unittest.TestCase):
    def test_search_and_prefix(self):
        trie = Trie()
        trie.insert("apple")
        self.assertTrue(trie.search("apple"))
        self.assertFalse(trie.search("app"))
        self.assertTrue(trie.startsWith("app"))

    def test_insert_prefix_word(self):
        trie = Trie()
        trie.insert("apple")
        trie.insert("app")
        self.assertTrue(trie.search("app"))

    def test_missing(self):
        self.assertFalse(Trie().search("x"))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'implement-trie-prefix-tree';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class WordDictionary:
    def __init__(self):
        # Initialize the data structure.
        pass

    def addWord(self, word: str) -> None:
        pass

    def search(self, word: str) -> bool:
        # word may contain '.' which matches any single letter.
        pass


import unittest


class TestWordDictionary(unittest.TestCase):
    def setUp(self):
        self.wd = WordDictionary()
        for w in ("bad", "dad", "mad"):
            self.wd.addWord(w)

    def test_exact(self):
        self.assertFalse(self.wd.search("pad"))
        self.assertTrue(self.wd.search("bad"))

    def test_wildcards(self):
        self.assertTrue(self.wd.search(".ad"))
        self.assertTrue(self.wd.search("b.."))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'design-add-and-search-words-data-structure';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Solution:
    def findWords(self, board: list[list[str]], words: list[str]) -> list[str]:
        # All words from the list that can be formed on the board (any order).
        pass


import unittest


class TestFindWords(unittest.TestCase):
    def test_example(self):
        board = [
            ["o", "a", "a", "n"],
            ["e", "t", "a", "e"],
            ["i", "h", "k", "r"],
            ["i", "f", "l", "v"],
        ]
        result = Solution().findWords(board, ["oath", "pea", "eat", "rain"])
        self.assertEqual(set(result), {"oath", "eat"})

    def test_both_directions(self):
        result = Solution().findWords([["a", "b"]], ["ab", "ba", "aa"])
        self.assertEqual(set(result), {"ab", "ba"})


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'word-search-ii';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class MedianFinder:
    def __init__(self):
        # Initialize the data structure.
        pass

    def addNum(self, num: int) -> None:
        pass

    def findMedian(self) -> float:
        # Median of all numbers added so far.
        pass


import unittest


class TestMedianFinder(unittest.TestCase):
    def test_even_then_odd(self):
        mf = MedianFinder()
        mf.addNum(1)
        mf.addNum(2)
        self.assertAlmostEqual(mf.findMedian(), 1.5)
        mf.addNum(3)
        self.assertAlmostEqual(mf.findMedian(), 2.0)

    def test_single(self):
        mf = MedianFinder()
        mf.addNum(5)
        self.assertAlmostEqual(mf.findMedian(), 5.0)


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'find-median-from-data-stream';

update public.problems
set starter_code = jsonb_build_object('python3', $py$class Node:
    def __init__(self, val=0, neighbors=None):
        self.val = val
        self.neighbors = neighbors if neighbors is not None else []


class Solution:
    def cloneGraph(self, node: "Node | None") -> "Node | None":
        # Return a deep copy of the connected undirected graph.
        pass


import unittest
from collections import deque


def build_graph(adj):
    # adj[i] = neighbor values of node (i + 1); LeetCode's adjacency format.
    if not adj:
        return None
    nodes = {i: Node(i) for i in range(1, len(adj) + 1)}
    for i, nbrs in enumerate(adj, 1):
        nodes[i].neighbors = [nodes[v] for v in nbrs]
    return nodes[1]


def adjacency(node):
    if not node:
        return {}
    seen = {}
    q = deque([node])
    while q:
        n = q.popleft()
        if n.val in seen:
            continue
        seen[n.val] = sorted(x.val for x in n.neighbors)
        for x in n.neighbors:
            if x.val not in seen:
                q.append(x)
    return seen


def node_ids(node):
    if not node:
        return set()
    seen = {}
    q = deque([node])
    while q:
        n = q.popleft()
        if id(n) in seen:
            continue
        seen[id(n)] = n
        for x in n.neighbors:
            q.append(x)
    return set(seen)


class TestCloneGraph(unittest.TestCase):
    def test_deep_copy(self):
        g = build_graph([[2, 4], [1, 3], [2, 4], [1, 3]])
        clone = Solution().cloneGraph(g)
        self.assertEqual(adjacency(clone), adjacency(g))
        # A true deep copy shares no node identities with the original.
        self.assertTrue(node_ids(clone).isdisjoint(node_ids(g)))

    def test_single_node(self):
        clone = Solution().cloneGraph(build_graph([[]]))
        self.assertEqual(adjacency(clone), {1: []})

    def test_empty(self):
        self.assertIsNone(Solution().cloneGraph(None))


if __name__ == "__main__":
    unittest.main(verbosity=2)
$py$)
where title_slug = 'clone-graph';
