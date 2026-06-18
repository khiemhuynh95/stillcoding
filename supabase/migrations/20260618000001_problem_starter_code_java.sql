-- StillCoding — per-problem Java starter code (curated study lists)
--
-- Adds a `java` key to problems.starter_code for the curated study-list
-- universe (Blind 75 / NeetCode 150 / Grind 75 / Top 100 Liked). Each value is
-- a real `class Solution` Java signature (from LeetCode's codeSnippets) plus a
-- generated `Main` harness that runs the same example cases as the verified
-- python3 starter and prints a unittest-style report to stderr (so the app's
-- pass/fail badge + console coloring work unchanged). The buffer runs server-
-- side via Wandbox (hooks/useRunJava.ts); each harness was compile-checked +
-- run on Wandbox before seeding.
--
-- jsonb `||` merges the java key and preserves existing python3/sql keys. The
-- daily sync only writes the columns it names, so starter_code is preserved.
-- Keyed by title_slug; a slug absent from the catalog is a no-op.

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int[] twoSum(int[] nums, int target) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().twoSum(new int[]{2, 7, 11, 15}, 9), new int[]{0, 1});
            assertEq(new Solution().twoSum(new int[]{3, 2, 4}, 6), new int[]{1, 2});
        });
        runTest("test_duplicate_values", () -> {
            assertEq(new Solution().twoSum(new int[]{3, 3}, 6), new int[]{0, 1});
        });
        runTest("test_negatives", () -> {
            assertEq(new Solution().twoSum(new int[]{-1, -2, -3, -4, -5}, -8), new int[]{2, 4});
        });
        report();
    }
}$java$)
where title_slug = 'two-sum';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int maxProfit(int[] prices) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().maxProfit(new int[]{7, 1, 5, 3, 6, 4}), 5);
            assertEq(new Solution().maxProfit(new int[]{7, 6, 4, 3, 1}), 0);
        });
        runTest("test_single_day", () -> {
            assertEq(new Solution().maxProfit(new int[]{1}), 0);
        });
        runTest("test_monotonic_increase", () -> {
            assertEq(new Solution().maxProfit(new int[]{1, 2, 3, 4, 5}), 4);
        });
        report();
    }
}$java$)
where title_slug = 'best-time-to-buy-and-sell-stock';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public boolean containsDuplicate(int[] nums) {
        return false;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().containsDuplicate(new int[]{1, 2, 3, 1}), true);
            assertEq(new Solution().containsDuplicate(new int[]{1, 2, 3, 4}), false);
        });
        runTest("test_single_element", () -> {
            assertEq(new Solution().containsDuplicate(new int[]{1}), false);
        });
        runTest("test_all_same", () -> {
            assertEq(new Solution().containsDuplicate(new int[]{2, 2, 2}), true);
        });
        report();
    }
}$java$)
where title_slug = 'contains-duplicate';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int[] productExceptSelf(int[] nums) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().productExceptSelf(new int[]{1, 2, 3, 4}), new int[]{24, 12, 8, 6});
            assertEq(new Solution().productExceptSelf(new int[]{-1, 1, 0, -3, 3}), new int[]{0, 0, 9, 0, 0});
        });
        runTest("test_two_elements", () -> {
            assertEq(new Solution().productExceptSelf(new int[]{2, 3}), new int[]{3, 2});
        });
        runTest("test_multiple_zeros", () -> {
            assertEq(new Solution().productExceptSelf(new int[]{0, 4, 0}), new int[]{0, 0, 0});
        });
        report();
    }
}$java$)
where title_slug = 'product-of-array-except-self';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int maxSubArray(int[] nums) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().maxSubArray(new int[]{-2, 1, -3, 4, -1, 2, 1, -5, 4}), 6);
            assertEq(new Solution().maxSubArray(new int[]{1}), 1);
        });
        runTest("test_all_negative", () -> {
            assertEq(new Solution().maxSubArray(new int[]{-3, -1, -2}), -1);
        });
        runTest("test_mostly_positive", () -> {
            assertEq(new Solution().maxSubArray(new int[]{5, 4, -1, 7, 8}), 23);
        });
        report();
    }
}$java$)
where title_slug = 'maximum-subarray';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int maxProduct(int[] nums) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().maxProduct(new int[]{2, 3, -2, 4}), 6);
            assertEq(new Solution().maxProduct(new int[]{-2, 0, -1}), 0);
        });
        runTest("test_two_negatives", () -> {
            assertEq(new Solution().maxProduct(new int[]{-2, 3, -4}), 24);
        });
        runTest("test_single_negative", () -> {
            assertEq(new Solution().maxProduct(new int[]{-2}), -2);
        });
        report();
    }
}$java$)
where title_slug = 'maximum-product-subarray';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int findMin(int[] nums) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().findMin(new int[]{3, 4, 5, 1, 2}), 1);
            assertEq(new Solution().findMin(new int[]{4, 5, 6, 7, 0, 1, 2}), 0);
        });
        runTest("test_not_rotated", () -> {
            assertEq(new Solution().findMin(new int[]{11, 13, 15, 17}), 11);
        });
        runTest("test_single", () -> {
            assertEq(new Solution().findMin(new int[]{1}), 1);
        });
        report();
    }
}$java$)
where title_slug = 'find-minimum-in-rotated-sorted-array';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int search(int[] nums, int target) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().search(new int[]{4, 5, 6, 7, 0, 1, 2}, 0), 4);
            assertEq(new Solution().search(new int[]{4, 5, 6, 7, 0, 1, 2}, 3), -1);
        });
        runTest("test_single_miss", () -> {
            assertEq(new Solution().search(new int[]{1}, 0), -1);
        });
        runTest("test_target_at_pivot", () -> {
            assertEq(new Solution().search(new int[]{5, 1, 3}, 5), 0);
        });
        report();
    }
}$java$)
where title_slug = 'search-in-rotated-sorted-array';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public List<List<Integer>> threeSum(int[] nums) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            assertEq(norm(new Solution().threeSum(new int[]{-1, 0, 1, 2, -1, -4})), norm(Arrays.asList(Arrays.asList(-1, -1, 2), Arrays.asList(-1, 0, 1))));
        });
        runTest("test_no_triplet", () -> {
            assertEq(new Solution().threeSum(new int[]{0, 1, 1}), new ArrayList<>());
        });
        runTest("test_all_zeros", () -> {
            assertEq(norm(new Solution().threeSum(new int[]{0, 0, 0})), norm(Arrays.asList(Arrays.asList(0, 0, 0))));
        });
        report();
    }
}$java$)
where title_slug = '3sum';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int maxArea(int[] height) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().maxArea(new int[]{1, 8, 6, 2, 5, 4, 8, 3, 7}), 49);
            assertEq(new Solution().maxArea(new int[]{1, 1}), 1);
        });
        runTest("test_increasing", () -> {
            assertEq(new Solution().maxArea(new int[]{1, 2, 3, 4, 5}), 6);
        });
        runTest("test_tall_ends", () -> {
            assertEq(new Solution().maxArea(new int[]{4, 3, 2, 1, 4}), 16);
        });
        report();
    }
}$java$)
where title_slug = 'container-with-most-water';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int getSum(int a, int b) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().getSum(1, 2), 3);
            assertEq(new Solution().getSum(2, 3), 5);
        });
        runTest("test_cancels_to_zero", () -> {
            assertEq(new Solution().getSum(-1, 1), 0);
        });
        runTest("test_both_negative", () -> {
            assertEq(new Solution().getSum(-2, -3), -5);
        });
        report();
    }
}$java$)
where title_slug = 'sum-of-two-integers';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int hammingWeight(int n) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().hammingWeight(11), 3);
            assertEq(new Solution().hammingWeight(128), 1);
        });
        runTest("test_all_ones_byte", () -> {
            assertEq(new Solution().hammingWeight(255), 8);
        });
        runTest("test_zero", () -> {
            assertEq(new Solution().hammingWeight(0), 0);
        });
        report();
    }
}$java$)
where title_slug = 'number-of-1-bits';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int[] countBits(int n) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().countBits(2), new int[]{0, 1, 1});
            assertEq(new Solution().countBits(5), new int[]{0, 1, 1, 2, 1, 2});
        });
        runTest("test_zero", () -> {
            assertEq(new Solution().countBits(0), new int[]{0});
        });
        report();
    }
}$java$)
where title_slug = 'counting-bits';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int missingNumber(int[] nums) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().missingNumber(new int[]{3, 0, 1}), 2);
            assertEq(new Solution().missingNumber(new int[]{0, 1}), 2);
        });
        runTest("test_larger", () -> {
            assertEq(new Solution().missingNumber(new int[]{9, 6, 4, 2, 3, 5, 7, 0, 1}), 8);
        });
        runTest("test_single", () -> {
            assertEq(new Solution().missingNumber(new int[]{0}), 1);
        });
        report();
    }
}$java$)
where title_slug = 'missing-number';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int reverseBits(int n) {
        return 0;
        
    }
}

class Main {
    public static void main(String[] args) {
        // Write and run your own tests here.
    }
}$java$)
where title_slug = 'reverse-bits';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int climbStairs(int n) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().climbStairs(2), 2);
            assertEq(new Solution().climbStairs(3), 3);
        });
        runTest("test_one", () -> {
            assertEq(new Solution().climbStairs(1), 1);
        });
        runTest("test_larger", () -> {
            assertEq(new Solution().climbStairs(5), 8);
        });
        report();
    }
}$java$)
where title_slug = 'climbing-stairs';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int coinChange(int[] coins, int amount) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().coinChange(new int[]{1, 2, 5}, 11), 3);
            assertEq(new Solution().coinChange(new int[]{2}, 3), -1);
        });
        runTest("test_zero_amount", () -> {
            assertEq(new Solution().coinChange(new int[]{1}, 0), 0);
        });
        runTest("test_impossible", () -> {
            assertEq(new Solution().coinChange(new int[]{2, 5, 10}, 1), -1);
        });
        report();
    }
}$java$)
where title_slug = 'coin-change';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int lengthOfLIS(int[] nums) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().lengthOfLIS(new int[]{10, 9, 2, 5, 3, 7, 101, 18}), 4);
            assertEq(new Solution().lengthOfLIS(new int[]{0, 1, 0, 3, 2, 3}), 4);
        });
        runTest("test_all_equal", () -> {
            assertEq(new Solution().lengthOfLIS(new int[]{7, 7, 7, 7}), 1);
        });
        runTest("test_single", () -> {
            assertEq(new Solution().lengthOfLIS(new int[]{1}), 1);
        });
        report();
    }
}$java$)
where title_slug = 'longest-increasing-subsequence';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int longestCommonSubsequence(String text1, String text2) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().longestCommonSubsequence("abcde", "ace"), 3);
            assertEq(new Solution().longestCommonSubsequence("abc", "abc"), 3);
        });
        runTest("test_no_common", () -> {
            assertEq(new Solution().longestCommonSubsequence("abc", "def"), 0);
        });
        report();
    }
}$java$)
where title_slug = 'longest-common-subsequence';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public boolean wordBreak(String s, List<String> wordDict) {
        return false;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().wordBreak("leetcode", Arrays.asList("leet", "code")), true);
            assertEq(new Solution().wordBreak("applepenapple", Arrays.asList("apple", "pen")), true);
        });
        runTest("test_cannot_segment", () -> {
            assertEq(new Solution().wordBreak("catsandog", Arrays.asList("cats", "dog", "sand", "and", "cat")), false);
        });
        report();
    }
}$java$)
where title_slug = 'word-break';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public List<List<Integer>> combinationSum(int[] candidates, int target) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_example_1", () -> {
            assertEq(norm(new Solution().combinationSum(new int[]{2, 3, 6, 7}, 7)), norm(Arrays.asList(Arrays.asList(2, 2, 3), Arrays.asList(7))));
        });
        runTest("test_example_2", () -> {
            assertEq(norm(new Solution().combinationSum(new int[]{2, 3, 5}, 8)), norm(Arrays.asList(Arrays.asList(2, 2, 2, 2), Arrays.asList(2, 3, 3), Arrays.asList(3, 5))));
        });
        runTest("test_no_combination", () -> {
            assertEq(new Solution().combinationSum(new int[]{2}, 1), new ArrayList<>());
        });
        report();
    }
}$java$)
where title_slug = 'combination-sum';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int rob(int[] nums) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().rob(new int[]{1, 2, 3, 1}), 4);
            assertEq(new Solution().rob(new int[]{2, 7, 9, 3, 1}), 12);
        });
        runTest("test_single", () -> {
            assertEq(new Solution().rob(new int[]{5}), 5);
        });
        runTest("test_pick_ends", () -> {
            assertEq(new Solution().rob(new int[]{2, 1, 1, 2}), 4);
        });
        report();
    }
}$java$)
where title_slug = 'house-robber';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int rob(int[] nums) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().rob(new int[]{2, 3, 2}), 3);
            assertEq(new Solution().rob(new int[]{1, 2, 3, 1}), 4);
        });
        runTest("test_three", () -> {
            assertEq(new Solution().rob(new int[]{1, 2, 3}), 3);
        });
        runTest("test_single", () -> {
            assertEq(new Solution().rob(new int[]{0}), 0);
        });
        report();
    }
}$java$)
where title_slug = 'house-robber-ii';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int numDecodings(String s) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().numDecodings("12"), 2);
            assertEq(new Solution().numDecodings("226"), 3);
        });
        runTest("test_leading_zero", () -> {
            assertEq(new Solution().numDecodings("06"), 0);
        });
        runTest("test_ten", () -> {
            assertEq(new Solution().numDecodings("10"), 1);
        });
        report();
    }
}$java$)
where title_slug = 'decode-ways';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int uniquePaths(int m, int n) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().uniquePaths(3, 7), 28);
            assertEq(new Solution().uniquePaths(3, 2), 3);
        });
        runTest("test_single_cell", () -> {
            assertEq(new Solution().uniquePaths(1, 1), 1);
        });
        report();
    }
}$java$)
where title_slug = 'unique-paths';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public boolean canJump(int[] nums) {
        return false;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().canJump(new int[]{2, 3, 1, 1, 4}), true);
            assertEq(new Solution().canJump(new int[]{3, 2, 1, 0, 4}), false);
        });
        runTest("test_single", () -> {
            assertEq(new Solution().canJump(new int[]{0}), true);
        });
        report();
    }
}$java$)
where title_slug = 'jump-game';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public boolean canFinish(int numCourses, int[][] prerequisites) {
        return false;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().canFinish(2, new int[][]{new int[]{1, 0}}), true);
            assertEq(new Solution().canFinish(2, new int[][]{new int[]{1, 0}, new int[]{0, 1}}), false);
        });
        runTest("test_no_prerequisites", () -> {
            assertEq(new Solution().canFinish(1, new int[][]{}), true);
        });
        report();
    }
}$java$)
where title_slug = 'course-schedule';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public List<List<Integer>> pacificAtlantic(int[][] heights) {
        return null;
        
    }
}

class Main {
    public static void main(String[] args) {
        // Write and run your own tests here.
    }
}$java$)
where title_slug = 'pacific-atlantic-water-flow';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int numIslands(char[][] grid) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_one_island", () -> {
            assertEq(new Solution().numIslands(new char[][]{new char[]{'1', '1', '1', '1', '0'}, new char[]{'1', '1', '0', '1', '0'}, new char[]{'1', '1', '0', '0', '0'}, new char[]{'0', '0', '0', '0', '0'}}), 1);
        });
        runTest("test_three_islands", () -> {
            assertEq(new Solution().numIslands(new char[][]{new char[]{'1', '1', '0', '0', '0'}, new char[]{'1', '1', '0', '0', '0'}, new char[]{'0', '0', '1', '0', '0'}, new char[]{'0', '0', '0', '1', '1'}}), 3);
        });
        runTest("test_no_land", () -> {
            assertEq(new Solution().numIslands(new char[][]{new char[]{'0'}}), 0);
        });
        report();
    }
}$java$)
where title_slug = 'number-of-islands';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int longestConsecutive(int[] nums) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().longestConsecutive(new int[]{100, 4, 200, 1, 3, 2}), 4);
            assertEq(new Solution().longestConsecutive(new int[]{0, 3, 7, 2, 5, 8, 4, 6, 0, 1}), 9);
        });
        runTest("test_empty", () -> {
            assertEq(new Solution().longestConsecutive(new int[]{}), 0);
        });
        runTest("test_single", () -> {
            assertEq(new Solution().longestConsecutive(new int[]{1}), 1);
        });
        report();
    }
}$java$)
where title_slug = 'longest-consecutive-sequence';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public String alienOrder(String[] words) {
        return null;
    }
}


class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_full_order", () -> {
            assertEq(new Solution().alienOrder(new String[]{"wrt", "wrf", "er", "ett", "rftt"}), "wertf");
            assertEq(new Solution().alienOrder(new String[]{"z", "x"}), "zx");
        });
        runTest("test_invalid_cycle", () -> {
            assertEq(new Solution().alienOrder(new String[]{"z", "x", "z"}), "");
        });
        report();
    }
}$java$)
where title_slug = 'alien-dictionary';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public boolean validTree(int n, int[][] edges) {
        return false;
    }
}


class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().validTree(5, new int[][]{new int[]{0, 1}, new int[]{0, 2}, new int[]{0, 3}, new int[]{1, 4}}), true);
            assertEq(new Solution().validTree(5, new int[][]{new int[]{0, 1}, new int[]{1, 2}, new int[]{2, 3}, new int[]{1, 3}, new int[]{1, 4}}), false);
        });
        runTest("test_single_node", () -> {
            assertEq(new Solution().validTree(1, new int[][]{}), true);
        });
        report();
    }
}$java$)
where title_slug = 'graph-valid-tree';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int countComponents(int n, int[][] edges) {
        return 0;
    }
}


class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().countComponents(5, new int[][]{new int[]{0, 1}, new int[]{1, 2}, new int[]{3, 4}}), 2);
            assertEq(new Solution().countComponents(5, new int[][]{new int[]{0, 1}, new int[]{1, 2}, new int[]{2, 3}, new int[]{3, 4}}), 1);
        });
        runTest("test_no_edges", () -> {
            assertEq(new Solution().countComponents(4, new int[][]{}), 4);
        });
        report();
    }
}$java$)
where title_slug = 'number-of-connected-components-in-an-undirected-graph';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int[][] insert(int[][] intervals, int[] newInterval) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().insert(new int[][]{new int[]{1, 3}, new int[]{6, 9}}, new int[]{2, 5}), new int[][]{new int[]{1, 5}, new int[]{6, 9}});
            assertEq(new Solution().insert(new int[][]{new int[]{1, 2}, new int[]{3, 5}, new int[]{6, 7}, new int[]{8, 10}, new int[]{12, 16}}, new int[]{4, 8}), new int[][]{new int[]{1, 2}, new int[]{3, 10}, new int[]{12, 16}});
        });
        runTest("test_into_empty", () -> {
            assertEq(new Solution().insert(new int[][]{}, new int[]{5, 7}), new int[][]{new int[]{5, 7}});
        });
        report();
    }
}$java$)
where title_slug = 'insert-interval';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int[][] merge(int[][] intervals) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().merge(new int[][]{new int[]{1, 3}, new int[]{2, 6}, new int[]{8, 10}, new int[]{15, 18}}), new int[][]{new int[]{1, 6}, new int[]{8, 10}, new int[]{15, 18}});
            assertEq(new Solution().merge(new int[][]{new int[]{1, 4}, new int[]{4, 5}}), new int[][]{new int[]{1, 5}});
        });
        runTest("test_single", () -> {
            assertEq(new Solution().merge(new int[][]{new int[]{1, 4}}), new int[][]{new int[]{1, 4}});
        });
        report();
    }
}$java$)
where title_slug = 'merge-intervals';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int eraseOverlapIntervals(int[][] intervals) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().eraseOverlapIntervals(new int[][]{new int[]{1, 2}, new int[]{2, 3}, new int[]{3, 4}, new int[]{1, 3}}), 1);
            assertEq(new Solution().eraseOverlapIntervals(new int[][]{new int[]{1, 2}, new int[]{1, 2}, new int[]{1, 2}}), 2);
        });
        runTest("test_none_overlap", () -> {
            assertEq(new Solution().eraseOverlapIntervals(new int[][]{new int[]{1, 2}, new int[]{2, 3}}), 0);
        });
        report();
    }
}$java$)
where title_slug = 'non-overlapping-intervals';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public boolean canAttendMeetings(int[][] intervals) {
        return false;
    }
}


class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().canAttendMeetings(new int[][]{new int[]{0, 30}, new int[]{5, 10}, new int[]{15, 20}}), false);
            assertEq(new Solution().canAttendMeetings(new int[][]{new int[]{7, 10}, new int[]{2, 4}}), true);
        });
        runTest("test_empty", () -> {
            assertEq(new Solution().canAttendMeetings(new int[][]{}), true);
        });
        report();
    }
}$java$)
where title_slug = 'meeting-rooms';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int minMeetingRooms(int[][] intervals) {
        return 0;
    }
}


class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().minMeetingRooms(new int[][]{new int[]{0, 30}, new int[]{5, 10}, new int[]{15, 20}}), 2);
            assertEq(new Solution().minMeetingRooms(new int[][]{new int[]{7, 10}, new int[]{2, 4}}), 1);
        });
        runTest("test_back_to_back", () -> {
            assertEq(new Solution().minMeetingRooms(new int[][]{new int[]{1, 5}, new int[]{5, 10}}), 1);
        });
        report();
    }
}$java$)
where title_slug = 'meeting-rooms-ii';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class ListNode {
    int val; ListNode next;
    ListNode() {}
    ListNode(int val) { this.val = val; }
    ListNode(int val, ListNode next) { this.val = val; this.next = next; }
}

/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode() {}
 *     ListNode(int val) { this.val = val; }
 *     ListNode(int val, ListNode next) { this.val = val; this.next = next; }
 * }
 */
class Solution {
    public ListNode reverseList(ListNode head) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    static ListNode buildList(int[] a) {
        ListNode dummy = new ListNode(), cur = dummy;
        for (int v : a) { cur.next = new ListNode(v); cur = cur.next; }
        return dummy.next;
    }
    static List<Integer> toList(ListNode n) {
        List<Integer> out = new ArrayList<>();
        while (n != null) { out.add(n.val); n = n.next; }
        return out;
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            assertEq(toList(new Solution().reverseList(buildList(new int[]{1, 2, 3, 4, 5}))), Arrays.asList(5, 4, 3, 2, 1));
        });
        runTest("test_empty", () -> {
            assertEq(toList(new Solution().reverseList(buildList(new int[]{}))), new ArrayList<>());
        });
        runTest("test_single", () -> {
            assertEq(toList(new Solution().reverseList(buildList(new int[]{1}))), Arrays.asList(1));
        });
        report();
    }
}$java$)
where title_slug = 'reverse-linked-list';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class ListNode {
    int val; ListNode next;
    ListNode() {}
    ListNode(int val) { this.val = val; }
    ListNode(int val, ListNode next) { this.val = val; this.next = next; }
}

/**
 * Definition for singly-linked list.
 * class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) {
 *         val = x;
 *         next = null;
 *     }
 * }
 */
class Solution {
    public boolean hasCycle(ListNode head) {
        return false;
        
    }
}

class Main {
    public static void main(String[] args) {
        // Write and run your own tests here.
    }
}$java$)
where title_slug = 'linked-list-cycle';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class ListNode {
    int val; ListNode next;
    ListNode() {}
    ListNode(int val) { this.val = val; }
    ListNode(int val, ListNode next) { this.val = val; this.next = next; }
}

/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode() {}
 *     ListNode(int val) { this.val = val; }
 *     ListNode(int val, ListNode next) { this.val = val; this.next = next; }
 * }
 */
class Solution {
    public ListNode mergeTwoLists(ListNode list1, ListNode list2) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    static ListNode buildList(int[] a) {
        ListNode dummy = new ListNode(), cur = dummy;
        for (int v : a) { cur.next = new ListNode(v); cur = cur.next; }
        return dummy.next;
    }
    static List<Integer> toList(ListNode n) {
        List<Integer> out = new ArrayList<>();
        while (n != null) { out.add(n.val); n = n.next; }
        return out;
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            assertEq(toList(new Solution().mergeTwoLists(buildList(new int[]{1, 2, 4}), buildList(new int[]{1, 3, 4}))), Arrays.asList(1, 1, 2, 3, 4, 4));
        });
        runTest("test_both_empty", () -> {
            assertEq(toList(new Solution().mergeTwoLists(buildList(new int[]{}), buildList(new int[]{}))), new ArrayList<>());
        });
        runTest("test_one_empty", () -> {
            assertEq(toList(new Solution().mergeTwoLists(buildList(new int[]{}), buildList(new int[]{0}))), Arrays.asList(0));
        });
        report();
    }
}$java$)
where title_slug = 'merge-two-sorted-lists';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class ListNode {
    int val; ListNode next;
    ListNode() {}
    ListNode(int val) { this.val = val; }
    ListNode(int val, ListNode next) { this.val = val; this.next = next; }
}

/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode() {}
 *     ListNode(int val) { this.val = val; }
 *     ListNode(int val, ListNode next) { this.val = val; this.next = next; }
 * }
 */
class Solution {
    public ListNode mergeKLists(ListNode[] lists) {
        return null;
        
    }
}

class Main {
    public static void main(String[] args) {
        // Write and run your own tests here.
    }
}$java$)
where title_slug = 'merge-k-sorted-lists';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class ListNode {
    int val; ListNode next;
    ListNode() {}
    ListNode(int val) { this.val = val; }
    ListNode(int val, ListNode next) { this.val = val; this.next = next; }
}

/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode() {}
 *     ListNode(int val) { this.val = val; }
 *     ListNode(int val, ListNode next) { this.val = val; this.next = next; }
 * }
 */
class Solution {
    public ListNode removeNthFromEnd(ListNode head, int n) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    static ListNode buildList(int[] a) {
        ListNode dummy = new ListNode(), cur = dummy;
        for (int v : a) { cur.next = new ListNode(v); cur = cur.next; }
        return dummy.next;
    }
    static List<Integer> toList(ListNode n) {
        List<Integer> out = new ArrayList<>();
        while (n != null) { out.add(n.val); n = n.next; }
        return out;
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            assertEq(toList(new Solution().removeNthFromEnd(buildList(new int[]{1, 2, 3, 4, 5}), 2)), Arrays.asList(1, 2, 3, 5));
        });
        runTest("test_remove_only_node", () -> {
            assertEq(toList(new Solution().removeNthFromEnd(buildList(new int[]{1}), 1)), new ArrayList<>());
        });
        runTest("test_remove_last", () -> {
            assertEq(toList(new Solution().removeNthFromEnd(buildList(new int[]{1, 2}), 1)), Arrays.asList(1));
        });
        report();
    }
}$java$)
where title_slug = 'remove-nth-node-from-end-of-list';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class ListNode {
    int val; ListNode next;
    ListNode() {}
    ListNode(int val) { this.val = val; }
    ListNode(int val, ListNode next) { this.val = val; this.next = next; }
}

/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode() {}
 *     ListNode(int val) { this.val = val; }
 *     ListNode(int val, ListNode next) { this.val = val; this.next = next; }
 * }
 */
class Solution {
    public void reorderList(ListNode head) {
        
    }
}

class Main {
    public static void main(String[] args) {
        // Write and run your own tests here.
    }
}$java$)
where title_slug = 'reorder-list';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public void setZeroes(int[][] matrix) {
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            int[][] m = new int[][]{new int[]{1, 1, 1}, new int[]{1, 0, 1}, new int[]{1, 1, 1}};
            new Solution().setZeroes(m);
            assertEq(m, new int[][]{new int[]{1, 0, 1}, new int[]{0, 0, 0}, new int[]{1, 0, 1}});
        });
        runTest("test_zeros_in_corners", () -> {
            int[][] m = new int[][]{new int[]{0, 1, 2, 0}, new int[]{3, 4, 5, 2}, new int[]{1, 3, 1, 5}};
            new Solution().setZeroes(m);
            assertEq(m, new int[][]{new int[]{0, 0, 0, 0}, new int[]{0, 4, 5, 0}, new int[]{0, 3, 1, 0}});
        });
        report();
    }
}$java$)
where title_slug = 'set-matrix-zeroes';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public List<Integer> spiralOrder(int[][] matrix) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_square", () -> {
            assertEq(new Solution().spiralOrder(new int[][]{new int[]{1, 2, 3}, new int[]{4, 5, 6}, new int[]{7, 8, 9}}), Arrays.asList(1, 2, 3, 6, 9, 8, 7, 4, 5));
        });
        runTest("test_rectangle", () -> {
            assertEq(new Solution().spiralOrder(new int[][]{new int[]{1, 2, 3, 4}, new int[]{5, 6, 7, 8}, new int[]{9, 10, 11, 12}}), Arrays.asList(1, 2, 3, 4, 8, 12, 11, 10, 9, 5, 6, 7));
        });
        runTest("test_single_row", () -> {
            assertEq(new Solution().spiralOrder(new int[][]{new int[]{1, 2, 3}}), Arrays.asList(1, 2, 3));
        });
        report();
    }
}$java$)
where title_slug = 'spiral-matrix';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public void rotate(int[][] matrix) {
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_3x3", () -> {
            int[][] m = new int[][]{new int[]{1, 2, 3}, new int[]{4, 5, 6}, new int[]{7, 8, 9}};
            new Solution().rotate(m);
            assertEq(m, new int[][]{new int[]{7, 4, 1}, new int[]{8, 5, 2}, new int[]{9, 6, 3}});
        });
        runTest("test_2x2", () -> {
            int[][] m = new int[][]{new int[]{1, 2}, new int[]{3, 4}};
            new Solution().rotate(m);
            assertEq(m, new int[][]{new int[]{3, 1}, new int[]{4, 2}});
        });
        report();
    }
}$java$)
where title_slug = 'rotate-image';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public boolean exist(char[][] board, String word) {
        return false;
        
    }
}

class Main {
    public static void main(String[] args) {
        // Write and run your own tests here.
    }
}$java$)
where title_slug = 'word-search';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int lengthOfLongestSubstring(String s) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().lengthOfLongestSubstring("abcabcbb"), 3);
            assertEq(new Solution().lengthOfLongestSubstring("bbbbb"), 1);
            assertEq(new Solution().lengthOfLongestSubstring("pwwkew"), 3);
        });
        runTest("test_empty", () -> {
            assertEq(new Solution().lengthOfLongestSubstring(""), 0);
        });
        report();
    }
}$java$)
where title_slug = 'longest-substring-without-repeating-characters';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int characterReplacement(String s, int k) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().characterReplacement("ABAB", 2), 4);
            assertEq(new Solution().characterReplacement("AABABBA", 1), 4);
        });
        runTest("test_no_replacements", () -> {
            assertEq(new Solution().characterReplacement("A", 0), 1);
        });
        report();
    }
}$java$)
where title_slug = 'longest-repeating-character-replacement';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public String minWindow(String s, String t) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().minWindow("ADOBECODEBANC", "ABC"), "BANC");
            assertEq(new Solution().minWindow("a", "a"), "a");
        });
        runTest("test_impossible", () -> {
            assertEq(new Solution().minWindow("a", "aa"), "");
        });
        report();
    }
}$java$)
where title_slug = 'minimum-window-substring';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public boolean isAnagram(String s, String t) {
        return false;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().isAnagram("anagram", "nagaram"), true);
            assertEq(new Solution().isAnagram("rat", "car"), false);
        });
        runTest("test_different_length", () -> {
            assertEq(new Solution().isAnagram("a", "ab"), false);
        });
        runTest("test_reordered", () -> {
            assertEq(new Solution().isAnagram("ab", "ba"), true);
        });
        report();
    }
}$java$)
where title_slug = 'valid-anagram';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public List<List<String>> groupAnagrams(String[] strs) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            assertEq(norm(new Solution().groupAnagrams(new String[]{"eat", "tea", "tan", "ate", "nat", "bat"})), norm(Arrays.asList(Arrays.asList("ate", "eat", "tea"), Arrays.asList("nat", "tan"), Arrays.asList("bat"))));
        });
        runTest("test_empty_string", () -> {
            assertEq(norm(new Solution().groupAnagrams(new String[]{""})), norm(Arrays.asList(Arrays.asList(""))));
        });
        runTest("test_single_word", () -> {
            assertEq(norm(new Solution().groupAnagrams(new String[]{"a"})), norm(Arrays.asList(Arrays.asList("a"))));
        });
        report();
    }
}$java$)
where title_slug = 'group-anagrams';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public boolean isValid(String s) {
        return false;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().isValid("()"), true);
            assertEq(new Solution().isValid("()[]{}"), true);
            assertEq(new Solution().isValid("(]"), false);
        });
        runTest("test_nested", () -> {
            assertEq(new Solution().isValid("([])"), true);
            assertEq(new Solution().isValid("([)]"), false);
        });
        runTest("test_unbalanced", () -> {
            assertEq(new Solution().isValid("("), false);
            assertEq(new Solution().isValid("]"), false);
        });
        report();
    }
}$java$)
where title_slug = 'valid-parentheses';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public boolean isPalindrome(String s) {
        return false;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().isPalindrome("A man, a plan, a canal: Panama"), true);
            assertEq(new Solution().isPalindrome("race a car"), false);
        });
        runTest("test_only_punctuation", () -> {
            assertEq(new Solution().isPalindrome(" "), true);
        });
        runTest("test_alphanumeric_mismatch", () -> {
            assertEq(new Solution().isPalindrome("0P"), false);
        });
        report();
    }
}$java$)
where title_slug = 'valid-palindrome';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public String longestPalindrome(String s) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_even_length", () -> {
            assertEq(new Solution().longestPalindrome("cbbd"), "bb");
        });
        runTest("test_single", () -> {
            assertEq(new Solution().longestPalindrome("a"), "a");
        });
        report();
    }
}$java$)
where title_slug = 'longest-palindromic-substring';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int countSubstrings(String s) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().countSubstrings("abc"), 3);
            assertEq(new Solution().countSubstrings("aaa"), 6);
        });
        runTest("test_single", () -> {
            assertEq(new Solution().countSubstrings("a"), 1);
        });
        report();
    }
}$java$)
where title_slug = 'palindromic-substrings';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Codec {
    public Codec() {
    }
    public String encode(String[] strs) {
        return null;
    }
    public String[] decode(String s) {
        return null;
    }
}


class Main {
    public static void main(String[] args) {
        // Write and run your own tests here.
    }
}$java$)
where title_slug = 'encode-and-decode-strings';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class TreeNode {
    int val; TreeNode left, right;
    TreeNode() {}
    TreeNode(int val) { this.val = val; }
    TreeNode(int val, TreeNode left, TreeNode right) { this.val = val; this.left = left; this.right = right; }
}

/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {
    public int maxDepth(TreeNode root) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    static TreeNode buildTree(Integer[] a) {
        if (a.length == 0 || a[0] == null) return null;
        TreeNode root = new TreeNode(a[0]);
        Deque<TreeNode> q = new ArrayDeque<>(); q.add(root);
        int i = 1;
        while (!q.isEmpty() && i < a.length) {
            TreeNode node = q.poll();
            if (i < a.length && a[i] != null) { node.left = new TreeNode(a[i]); q.add(node.left); }
            i++;
            if (i < a.length && a[i] != null) { node.right = new TreeNode(a[i]); q.add(node.right); }
            i++;
        }
        return root;
    }

    static List<Object> serialize(TreeNode n) { List<Object> out = new ArrayList<>(); ser(n, out); return out; }
    static void ser(TreeNode n, List<Object> out) {
        if (n == null) { out.add("#"); return; }
        out.add(n.val); ser(n.left, out); ser(n.right, out);
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            assertEq(new Solution().maxDepth(buildTree(new Integer[]{3, 9, 20, null, null, 15, 7})), 3);
        });
        runTest("test_empty", () -> {
            assertEq(new Solution().maxDepth(buildTree(new Integer[]{})), 0);
        });
        runTest("test_single", () -> {
            assertEq(new Solution().maxDepth(buildTree(new Integer[]{1})), 1);
        });
        report();
    }
}$java$)
where title_slug = 'maximum-depth-of-binary-tree';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class TreeNode {
    int val; TreeNode left, right;
    TreeNode() {}
    TreeNode(int val) { this.val = val; }
    TreeNode(int val, TreeNode left, TreeNode right) { this.val = val; this.left = left; this.right = right; }
}

/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {
    public boolean isSameTree(TreeNode p, TreeNode q) {
        return false;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    static TreeNode buildTree(Integer[] a) {
        if (a.length == 0 || a[0] == null) return null;
        TreeNode root = new TreeNode(a[0]);
        Deque<TreeNode> q = new ArrayDeque<>(); q.add(root);
        int i = 1;
        while (!q.isEmpty() && i < a.length) {
            TreeNode node = q.poll();
            if (i < a.length && a[i] != null) { node.left = new TreeNode(a[i]); q.add(node.left); }
            i++;
            if (i < a.length && a[i] != null) { node.right = new TreeNode(a[i]); q.add(node.right); }
            i++;
        }
        return root;
    }

    static List<Object> serialize(TreeNode n) { List<Object> out = new ArrayList<>(); ser(n, out); return out; }
    static void ser(TreeNode n, List<Object> out) {
        if (n == null) { out.add("#"); return; }
        out.add(n.val); ser(n.left, out); ser(n.right, out);
    }

    public static void main(String[] args) {
        runTest("test_identical", () -> {
            assertEq(new Solution().isSameTree(buildTree(new Integer[]{1, 2, 3}), buildTree(new Integer[]{1, 2, 3})), true);
        });
        runTest("test_different_shape", () -> {
            assertEq(new Solution().isSameTree(buildTree(new Integer[]{1, 2}), buildTree(new Integer[]{1, null, 2})), false);
        });
        runTest("test_different_values", () -> {
            assertEq(new Solution().isSameTree(buildTree(new Integer[]{1, 2, 1}), buildTree(new Integer[]{1, 1, 2})), false);
        });
        report();
    }
}$java$)
where title_slug = 'same-tree';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class TreeNode {
    int val; TreeNode left, right;
    TreeNode() {}
    TreeNode(int val) { this.val = val; }
    TreeNode(int val, TreeNode left, TreeNode right) { this.val = val; this.left = left; this.right = right; }
}

/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {
    public TreeNode invertTree(TreeNode root) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    static TreeNode buildTree(Integer[] a) {
        if (a.length == 0 || a[0] == null) return null;
        TreeNode root = new TreeNode(a[0]);
        Deque<TreeNode> q = new ArrayDeque<>(); q.add(root);
        int i = 1;
        while (!q.isEmpty() && i < a.length) {
            TreeNode node = q.poll();
            if (i < a.length && a[i] != null) { node.left = new TreeNode(a[i]); q.add(node.left); }
            i++;
            if (i < a.length && a[i] != null) { node.right = new TreeNode(a[i]); q.add(node.right); }
            i++;
        }
        return root;
    }

    static List<Object> serialize(TreeNode n) { List<Object> out = new ArrayList<>(); ser(n, out); return out; }
    static void ser(TreeNode n, List<Object> out) {
        if (n == null) { out.add("#"); return; }
        out.add(n.val); ser(n.left, out); ser(n.right, out);
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            assertEq(serialize(new Solution().invertTree(buildTree(new Integer[]{4, 2, 7, 1, 3, 6, 9}))), serialize(buildTree(new Integer[]{4, 7, 2, 9, 6, 3, 1})));
        });
        runTest("test_small", () -> {
            assertEq(serialize(new Solution().invertTree(buildTree(new Integer[]{2, 1, 3}))), serialize(buildTree(new Integer[]{2, 3, 1})));
        });
        runTest("test_empty", () -> {
            assertEq(new Solution().invertTree(buildTree(new Integer[]{})), (Object) null);
        });
        report();
    }
}$java$)
where title_slug = 'invert-binary-tree';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class TreeNode {
    int val; TreeNode left, right;
    TreeNode() {}
    TreeNode(int val) { this.val = val; }
    TreeNode(int val, TreeNode left, TreeNode right) { this.val = val; this.left = left; this.right = right; }
}

/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {
    public int maxPathSum(TreeNode root) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    static TreeNode buildTree(Integer[] a) {
        if (a.length == 0 || a[0] == null) return null;
        TreeNode root = new TreeNode(a[0]);
        Deque<TreeNode> q = new ArrayDeque<>(); q.add(root);
        int i = 1;
        while (!q.isEmpty() && i < a.length) {
            TreeNode node = q.poll();
            if (i < a.length && a[i] != null) { node.left = new TreeNode(a[i]); q.add(node.left); }
            i++;
            if (i < a.length && a[i] != null) { node.right = new TreeNode(a[i]); q.add(node.right); }
            i++;
        }
        return root;
    }

    static List<Object> serialize(TreeNode n) { List<Object> out = new ArrayList<>(); ser(n, out); return out; }
    static void ser(TreeNode n, List<Object> out) {
        if (n == null) { out.add("#"); return; }
        out.add(n.val); ser(n.left, out); ser(n.right, out);
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().maxPathSum(buildTree(new Integer[]{1, 2, 3})), 6);
            assertEq(new Solution().maxPathSum(buildTree(new Integer[]{-10, 9, 20, null, null, 15, 7})), 42);
        });
        runTest("test_single_negative", () -> {
            assertEq(new Solution().maxPathSum(buildTree(new Integer[]{-3})), -3);
        });
        report();
    }
}$java$)
where title_slug = 'binary-tree-maximum-path-sum';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class TreeNode {
    int val; TreeNode left, right;
    TreeNode() {}
    TreeNode(int val) { this.val = val; }
    TreeNode(int val, TreeNode left, TreeNode right) { this.val = val; this.left = left; this.right = right; }
}

/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {
    public List<List<Integer>> levelOrder(TreeNode root) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    static TreeNode buildTree(Integer[] a) {
        if (a.length == 0 || a[0] == null) return null;
        TreeNode root = new TreeNode(a[0]);
        Deque<TreeNode> q = new ArrayDeque<>(); q.add(root);
        int i = 1;
        while (!q.isEmpty() && i < a.length) {
            TreeNode node = q.poll();
            if (i < a.length && a[i] != null) { node.left = new TreeNode(a[i]); q.add(node.left); }
            i++;
            if (i < a.length && a[i] != null) { node.right = new TreeNode(a[i]); q.add(node.right); }
            i++;
        }
        return root;
    }

    static List<Object> serialize(TreeNode n) { List<Object> out = new ArrayList<>(); ser(n, out); return out; }
    static void ser(TreeNode n, List<Object> out) {
        if (n == null) { out.add("#"); return; }
        out.add(n.val); ser(n.left, out); ser(n.right, out);
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            assertEq(new Solution().levelOrder(buildTree(new Integer[]{3, 9, 20, null, null, 15, 7})), Arrays.asList(Arrays.asList(3), Arrays.asList(9, 20), Arrays.asList(15, 7)));
        });
        runTest("test_empty", () -> {
            assertEq(new Solution().levelOrder(buildTree(new Integer[]{})), new ArrayList<>());
        });
        runTest("test_single", () -> {
            assertEq(new Solution().levelOrder(buildTree(new Integer[]{1})), Arrays.asList(Arrays.asList(1)));
        });
        report();
    }
}$java$)
where title_slug = 'binary-tree-level-order-traversal';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class TreeNode {
    int val; TreeNode left, right;
    TreeNode() {}
    TreeNode(int val) { this.val = val; }
    TreeNode(int val, TreeNode left, TreeNode right) { this.val = val; this.left = left; this.right = right; }
}

/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */
class Codec {

    // Encodes a tree to a single string.
    public String serialize(TreeNode root) {
        return null;
        
    }

    // Decodes your encoded data to tree.
    public TreeNode deserialize(String data) {
        return null;
        
    }
}

// Your Codec object will be instantiated and called as such:
// Codec ser = new Codec();
// Codec deser = new Codec();
// TreeNode ans = deser.deserialize(ser.serialize(root));

class Main {
    public static void main(String[] args) {
        // Write and run your own tests here.
    }
}$java$)
where title_slug = 'serialize-and-deserialize-binary-tree';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class TreeNode {
    int val; TreeNode left, right;
    TreeNode() {}
    TreeNode(int val) { this.val = val; }
    TreeNode(int val, TreeNode left, TreeNode right) { this.val = val; this.left = left; this.right = right; }
}

/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {
    public boolean isSubtree(TreeNode root, TreeNode subRoot) {
        return false;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    static TreeNode buildTree(Integer[] a) {
        if (a.length == 0 || a[0] == null) return null;
        TreeNode root = new TreeNode(a[0]);
        Deque<TreeNode> q = new ArrayDeque<>(); q.add(root);
        int i = 1;
        while (!q.isEmpty() && i < a.length) {
            TreeNode node = q.poll();
            if (i < a.length && a[i] != null) { node.left = new TreeNode(a[i]); q.add(node.left); }
            i++;
            if (i < a.length && a[i] != null) { node.right = new TreeNode(a[i]); q.add(node.right); }
            i++;
        }
        return root;
    }

    static List<Object> serialize(TreeNode n) { List<Object> out = new ArrayList<>(); ser(n, out); return out; }
    static void ser(TreeNode n, List<Object> out) {
        if (n == null) { out.add("#"); return; }
        out.add(n.val); ser(n.left, out); ser(n.right, out);
    }

    public static void main(String[] args) {
        runTest("test_is_subtree", () -> {
            assertEq(new Solution().isSubtree(buildTree(new Integer[]{3, 4, 5, 1, 2}), buildTree(new Integer[]{4, 1, 2})), true);
        });
        runTest("test_not_subtree", () -> {
            assertEq(new Solution().isSubtree(buildTree(new Integer[]{3, 4, 5, 1, 2, null, null, null, null, 0}), buildTree(new Integer[]{4, 1, 2})), false);
        });
        runTest("test_single_node", () -> {
            assertEq(new Solution().isSubtree(buildTree(new Integer[]{1}), buildTree(new Integer[]{1})), true);
        });
        report();
    }
}$java$)
where title_slug = 'subtree-of-another-tree';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class TreeNode {
    int val; TreeNode left, right;
    TreeNode() {}
    TreeNode(int val) { this.val = val; }
    TreeNode(int val, TreeNode left, TreeNode right) { this.val = val; this.left = left; this.right = right; }
}

/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {
    public TreeNode buildTree(int[] preorder, int[] inorder) {
        return null;
        
    }
}

class Main {
    public static void main(String[] args) {
        // Write and run your own tests here.
    }
}$java$)
where title_slug = 'construct-binary-tree-from-preorder-and-inorder-traversal';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class TreeNode {
    int val; TreeNode left, right;
    TreeNode() {}
    TreeNode(int val) { this.val = val; }
    TreeNode(int val, TreeNode left, TreeNode right) { this.val = val; this.left = left; this.right = right; }
}

/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {
    public boolean isValidBST(TreeNode root) {
        return false;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    static TreeNode buildTree(Integer[] a) {
        if (a.length == 0 || a[0] == null) return null;
        TreeNode root = new TreeNode(a[0]);
        Deque<TreeNode> q = new ArrayDeque<>(); q.add(root);
        int i = 1;
        while (!q.isEmpty() && i < a.length) {
            TreeNode node = q.poll();
            if (i < a.length && a[i] != null) { node.left = new TreeNode(a[i]); q.add(node.left); }
            i++;
            if (i < a.length && a[i] != null) { node.right = new TreeNode(a[i]); q.add(node.right); }
            i++;
        }
        return root;
    }

    static List<Object> serialize(TreeNode n) { List<Object> out = new ArrayList<>(); ser(n, out); return out; }
    static void ser(TreeNode n, List<Object> out) {
        if (n == null) { out.add("#"); return; }
        out.add(n.val); ser(n.left, out); ser(n.right, out);
    }

    public static void main(String[] args) {
        runTest("test_valid", () -> {
            assertEq(new Solution().isValidBST(buildTree(new Integer[]{2, 1, 3})), true);
        });
        runTest("test_invalid", () -> {
            assertEq(new Solution().isValidBST(buildTree(new Integer[]{5, 1, 4, null, null, 3, 6})), false);
        });
        runTest("test_single", () -> {
            assertEq(new Solution().isValidBST(buildTree(new Integer[]{1})), true);
        });
        report();
    }
}$java$)
where title_slug = 'validate-binary-search-tree';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class TreeNode {
    int val; TreeNode left, right;
    TreeNode() {}
    TreeNode(int val) { this.val = val; }
    TreeNode(int val, TreeNode left, TreeNode right) { this.val = val; this.left = left; this.right = right; }
}

/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {
    public int kthSmallest(TreeNode root, int k) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    static TreeNode buildTree(Integer[] a) {
        if (a.length == 0 || a[0] == null) return null;
        TreeNode root = new TreeNode(a[0]);
        Deque<TreeNode> q = new ArrayDeque<>(); q.add(root);
        int i = 1;
        while (!q.isEmpty() && i < a.length) {
            TreeNode node = q.poll();
            if (i < a.length && a[i] != null) { node.left = new TreeNode(a[i]); q.add(node.left); }
            i++;
            if (i < a.length && a[i] != null) { node.right = new TreeNode(a[i]); q.add(node.right); }
            i++;
        }
        return root;
    }

    static List<Object> serialize(TreeNode n) { List<Object> out = new ArrayList<>(); ser(n, out); return out; }
    static void ser(TreeNode n, List<Object> out) {
        if (n == null) { out.add("#"); return; }
        out.add(n.val); ser(n.left, out); ser(n.right, out);
    }

    public static void main(String[] args) {
        runTest("test_first", () -> {
            assertEq(new Solution().kthSmallest(buildTree(new Integer[]{3, 1, 4, null, 2}), 1), 1);
        });
        runTest("test_third", () -> {
            assertEq(new Solution().kthSmallest(buildTree(new Integer[]{5, 3, 6, 2, 4, null, null, 1}), 3), 3);
        });
        report();
    }
}$java$)
where title_slug = 'kth-smallest-element-in-a-bst';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class TreeNode {
    int val; TreeNode left, right;
    TreeNode() {}
    TreeNode(int val) { this.val = val; }
    TreeNode(int val, TreeNode left, TreeNode right) { this.val = val; this.left = left; this.right = right; }
}

/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */

class Solution {
    public TreeNode lowestCommonAncestor(TreeNode root, TreeNode p, TreeNode q) {
        return null;
        
    }
}

class Main {
    public static void main(String[] args) {
        // Write and run your own tests here.
    }
}$java$)
where title_slug = 'lowest-common-ancestor-of-a-binary-search-tree';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Trie {

    public Trie() {
        
    }
    
    public void insert(String word) {
        
    }
    
    public boolean search(String word) {
        return false;
        
    }
    
    public boolean startsWith(String prefix) {
        return false;
        
    }
}

/**
 * Your Trie object will be instantiated and called as such:
 * Trie obj = new Trie();
 * obj.insert(word);
 * boolean param_2 = obj.search(word);
 * boolean param_3 = obj.startsWith(prefix);
 */

class Main {
    public static void main(String[] args) {
        // Write and run your own tests here.
    }
}$java$)
where title_slug = 'implement-trie-prefix-tree';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class WordDictionary {

    public WordDictionary() {
        
    }
    
    public void addWord(String word) {
        
    }
    
    public boolean search(String word) {
        return false;
        
    }
}

/**
 * Your WordDictionary object will be instantiated and called as such:
 * WordDictionary obj = new WordDictionary();
 * obj.addWord(word);
 * boolean param_2 = obj.search(word);
 */

class Main {
    public static void main(String[] args) {
        // Write and run your own tests here.
    }
}$java$)
where title_slug = 'design-add-and-search-words-data-structure';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public List<String> findWords(char[][] board, String[] words) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            assertEq(toSet(new Solution().findWords(new char[][]{new char[]{'o', 'a', 'a', 'n'}, new char[]{'e', 't', 'a', 'e'}, new char[]{'i', 'h', 'k', 'r'}, new char[]{'i', 'f', 'l', 'v'}}, new String[]{"oath", "pea", "eat", "rain"})), toSet(new String[]{"oath", "eat"}));
        });
        runTest("test_both_directions", () -> {
            assertEq(toSet(new Solution().findWords(new char[][]{new char[]{'a', 'b'}}, new String[]{"ab", "ba", "aa"})), toSet(new String[]{"ab", "ba"}));
        });
        report();
    }
}$java$)
where title_slug = 'word-search-ii';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int[] topKFrequent(int[] nums, int k) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(toSet(new Solution().topKFrequent(new int[]{1, 1, 1, 2, 2, 3}, 2)), toSet(new int[]{1, 2}));
            assertEq(toSet(new Solution().topKFrequent(new int[]{1}, 1)), toSet(new int[]{1}));
        });
        runTest("test_returns_k_elements", () -> {
            assertEq(len(new Solution().topKFrequent(new int[]{1, 1, 2, 2, 3}, 2)), 2);
        });
        runTest("test_single_distinct", () -> {
            assertEq(toSet(new Solution().topKFrequent(new int[]{4, 4, 4}, 1)), toSet(new int[]{4}));
        });
        report();
    }
}$java$)
where title_slug = 'top-k-frequent-elements';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class MedianFinder {

    public MedianFinder() {
        
    }
    
    public void addNum(int num) {
        
    }
    
    public double findMedian() {
        return 0;
        
    }
}

/**
 * Your MedianFinder object will be instantiated and called as such:
 * MedianFinder obj = new MedianFinder();
 * obj.addNum(num);
 * double param_2 = obj.findMedian();
 */

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_even_then_odd", () -> {
            MedianFinder mf = new MedianFinder();
            mf.addNum(1);
            mf.addNum(2);
            mf.addNum(3);
        });
        runTest("test_single", () -> {
            MedianFinder mf = new MedianFinder();
            mf.addNum(5);
        });
        report();
    }
}$java$)
where title_slug = 'find-median-from-data-stream';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public boolean isValidSudoku(char[][] board) {
        return false;
        
    }
}

class Main {
    public static void main(String[] args) {
        // Write and run your own tests here.
    }
}$java$)
where title_slug = 'valid-sudoku';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int[] twoSum(int[] numbers, int target) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().twoSum(new int[]{2, 7, 11, 15}, 9), new int[]{1, 2});
            assertEq(new Solution().twoSum(new int[]{2, 3, 4}, 6), new int[]{1, 3});
        });
        runTest("test_negatives", () -> {
            assertEq(new Solution().twoSum(new int[]{-1, 0}, -1), new int[]{1, 2});
        });
        report();
    }
}$java$)
where title_slug = 'two-sum-ii-input-array-is-sorted';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int trap(int[] height) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().trap(new int[]{0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1}), 6);
            assertEq(new Solution().trap(new int[]{4, 2, 0, 3, 2, 5}), 9);
        });
        runTest("test_flat", () -> {
            assertEq(new Solution().trap(new int[]{1, 1}), 0);
        });
        report();
    }
}$java$)
where title_slug = 'trapping-rain-water';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public boolean checkInclusion(String s1, String s2) {
        return false;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().checkInclusion("ab", "eidbaooo"), true);
            assertEq(new Solution().checkInclusion("ab", "eidboaoo"), false);
        });
        runTest("test_single", () -> {
            assertEq(new Solution().checkInclusion("a", "a"), true);
        });
        runTest("test_too_long", () -> {
            assertEq(new Solution().checkInclusion("abc", "ccccbbbbaaaa"), false);
        });
        report();
    }
}$java$)
where title_slug = 'permutation-in-string';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int[] maxSlidingWindow(int[] nums, int k) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            assertEq(new Solution().maxSlidingWindow(new int[]{1, 3, -1, -3, 5, 3, 6, 7}, 3), new int[]{3, 3, 5, 5, 6, 7});
        });
        runTest("test_single", () -> {
            assertEq(new Solution().maxSlidingWindow(new int[]{1}, 1), new int[]{1});
        });
        runTest("test_window_one", () -> {
            assertEq(new Solution().maxSlidingWindow(new int[]{1, -1}, 1), new int[]{1, -1});
        });
        report();
    }
}$java$)
where title_slug = 'sliding-window-maximum';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class MinStack {

    public MinStack() {
        
    }
    
    public void push(int value) {
        
    }
    
    public void pop() {
        
    }
    
    public int top() {
        return 0;
        
    }
    
    public int getMin() {
        return 0;
        
    }
}

/**
 * Your MinStack object will be instantiated and called as such:
 * MinStack obj = new MinStack();
 * obj.push(value);
 * obj.pop();
 * int param_3 = obj.top();
 * int param_4 = obj.getMin();
 */

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_sequence", () -> {
            MinStack s = new MinStack();
            s.push(-2);
            s.push(0);
            s.push(-3);
            assertEq(s.getMin(), -3);
            s.pop();
            assertEq(s.top(), 0);
            assertEq(s.getMin(), -2);
        });
        report();
    }
}$java$)
where title_slug = 'min-stack';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int evalRPN(String[] tokens) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().evalRPN(new String[]{"2", "1", "+", "3", "*"}), 9);
            assertEq(new Solution().evalRPN(new String[]{"4", "13", "5", "/", "+"}), 6);
        });
        runTest("test_long", () -> {
            assertEq(new Solution().evalRPN(new String[]{"10", "6", "9", "3", "+", "-11", "*", "/", "*", "17", "+", "5", "+"}), 22);
        });
        report();
    }
}$java$)
where title_slug = 'evaluate-reverse-polish-notation';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public List<String> generateParenthesis(int n) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_n3", () -> {
            assertEq(toSet(new Solution().generateParenthesis(3)), toSet(new String[]{"((()))", "()()()", "()(())", "(())()", "(()())"}));
        });
        runTest("test_n1", () -> {
            assertEq(toSet(new Solution().generateParenthesis(1)), toSet(new String[]{"()"}));
        });
        runTest("test_count_n2", () -> {
            assertEq(toSet(new Solution().generateParenthesis(2)), toSet(new String[]{"(())", "()()"}));
        });
        report();
    }
}$java$)
where title_slug = 'generate-parentheses';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int[] dailyTemperatures(int[] temperatures) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            assertEq(new Solution().dailyTemperatures(new int[]{73, 74, 75, 71, 69, 72, 76, 73}), new int[]{1, 1, 4, 2, 1, 1, 0, 0});
        });
        runTest("test_increasing", () -> {
            assertEq(new Solution().dailyTemperatures(new int[]{30, 40, 50, 60}), new int[]{1, 1, 1, 0});
        });
        runTest("test_short", () -> {
            assertEq(new Solution().dailyTemperatures(new int[]{30, 60, 90}), new int[]{1, 1, 0});
        });
        report();
    }
}$java$)
where title_slug = 'daily-temperatures';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int carFleet(int target, int[] position, int[] speed) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            assertEq(new Solution().carFleet(12, new int[]{10, 8, 0, 5, 3}, new int[]{2, 4, 1, 1, 3}), 3);
        });
        runTest("test_single", () -> {
            assertEq(new Solution().carFleet(10, new int[]{3}, new int[]{3}), 1);
        });
        runTest("test_all_merge", () -> {
            assertEq(new Solution().carFleet(100, new int[]{0, 2, 4}, new int[]{4, 2, 1}), 1);
        });
        report();
    }
}$java$)
where title_slug = 'car-fleet';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int largestRectangleArea(int[] heights) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().largestRectangleArea(new int[]{2, 1, 5, 6, 2, 3}), 10);
            assertEq(new Solution().largestRectangleArea(new int[]{2, 4}), 4);
        });
        runTest("test_single", () -> {
            assertEq(new Solution().largestRectangleArea(new int[]{2}), 2);
        });
        report();
    }
}$java$)
where title_slug = 'largest-rectangle-in-histogram';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int search(int[] nums, int target) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().search(new int[]{-1, 0, 3, 5, 9, 12}, 9), 4);
            assertEq(new Solution().search(new int[]{-1, 0, 3, 5, 9, 12}, 2), -1);
        });
        runTest("test_single", () -> {
            assertEq(new Solution().search(new int[]{5}, 5), 0);
        });
        report();
    }
}$java$)
where title_slug = 'binary-search';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public boolean searchMatrix(int[][] matrix, int target) {
        return false;
        
    }
}

class Main {
    public static void main(String[] args) {
        // Write and run your own tests here.
    }
}$java$)
where title_slug = 'search-a-2d-matrix';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int minEatingSpeed(int[] piles, int h) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().minEatingSpeed(new int[]{3, 6, 7, 11}, 8), 4);
            assertEq(new Solution().minEatingSpeed(new int[]{30, 11, 23, 4, 20}, 5), 30);
        });
        runTest("test_more_time", () -> {
            assertEq(new Solution().minEatingSpeed(new int[]{30, 11, 23, 4, 20}, 6), 23);
        });
        report();
    }
}$java$)
where title_slug = 'koko-eating-bananas';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class TimeMap {

    public TimeMap() {
        
    }
    
    public void set(String key, String value, int timestamp) {
        
    }
    
    public String get(String key, int timestamp) {
        return null;
        
    }
}

/**
 * Your TimeMap object will be instantiated and called as such:
 * TimeMap obj = new TimeMap();
 * obj.set(key,value,timestamp);
 * String param_2 = obj.get(key,timestamp);
 */

class Main {
    public static void main(String[] args) {
        // Write and run your own tests here.
    }
}$java$)
where title_slug = 'time-based-key-value-store';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public double findMedianSortedArrays(int[] nums1, int[] nums2) {
        return 0;
        
    }
}

class Main {
    public static void main(String[] args) {
        // Write and run your own tests here.
    }
}$java$)
where title_slug = 'median-of-two-sorted-arrays';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class ListNode {
    int val; ListNode next;
    ListNode() {}
    ListNode(int val) { this.val = val; }
    ListNode(int val, ListNode next) { this.val = val; this.next = next; }
}

/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode() {}
 *     ListNode(int val) { this.val = val; }
 *     ListNode(int val, ListNode next) { this.val = val; this.next = next; }
 * }
 */
class Solution {
    public ListNode addTwoNumbers(ListNode l1, ListNode l2) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    static ListNode buildList(int[] a) {
        ListNode dummy = new ListNode(), cur = dummy;
        for (int v : a) { cur.next = new ListNode(v); cur = cur.next; }
        return dummy.next;
    }
    static List<Integer> toList(ListNode n) {
        List<Integer> out = new ArrayList<>();
        while (n != null) { out.add(n.val); n = n.next; }
        return out;
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            assertEq(toList(new Solution().addTwoNumbers(buildList(new int[]{2, 4, 3}), buildList(new int[]{5, 6, 4}))), Arrays.asList(7, 0, 8));
        });
        runTest("test_zeros", () -> {
            assertEq(toList(new Solution().addTwoNumbers(buildList(new int[]{0}), buildList(new int[]{0}))), Arrays.asList(0));
        });
        runTest("test_carry_extends", () -> {
            assertEq(toList(new Solution().addTwoNumbers(buildList(new int[]{9, 9, 9}), buildList(new int[]{1}))), Arrays.asList(0, 0, 0, 1));
        });
        report();
    }
}$java$)
where title_slug = 'add-two-numbers';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int findDuplicate(int[] nums) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().findDuplicate(new int[]{1, 3, 4, 2, 2}), 2);
            assertEq(new Solution().findDuplicate(new int[]{3, 1, 3, 4, 2}), 3);
        });
        runTest("test_all_same", () -> {
            assertEq(new Solution().findDuplicate(new int[]{2, 2, 2, 2}), 2);
        });
        report();
    }
}$java$)
where title_slug = 'find-the-duplicate-number';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class LRUCache {

    public LRUCache(int capacity) {
        
    }
    
    public int get(int key) {
        return 0;
        
    }
    
    public void put(int key, int value) {
        
    }
}

/**
 * Your LRUCache object will be instantiated and called as such:
 * LRUCache obj = new LRUCache(capacity);
 * int param_1 = obj.get(key);
 * obj.put(key,value);
 */

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_eviction", () -> {
            LRUCache c = new LRUCache(2);
            c.put(1, 1);
            c.put(2, 2);
            assertEq(c.get(1), 1);
            c.put(3, 3);
            assertEq(c.get(2), -1);
            c.put(4, 4);
            assertEq(c.get(1), -1);
            assertEq(c.get(3), 3);
            assertEq(c.get(4), 4);
        });
        report();
    }
}$java$)
where title_slug = 'lru-cache';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class ListNode {
    int val; ListNode next;
    ListNode() {}
    ListNode(int val) { this.val = val; }
    ListNode(int val, ListNode next) { this.val = val; this.next = next; }
}

/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode() {}
 *     ListNode(int val) { this.val = val; }
 *     ListNode(int val, ListNode next) { this.val = val; this.next = next; }
 * }
 */
class Solution {
    public ListNode reverseKGroup(ListNode head, int k) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    static ListNode buildList(int[] a) {
        ListNode dummy = new ListNode(), cur = dummy;
        for (int v : a) { cur.next = new ListNode(v); cur = cur.next; }
        return dummy.next;
    }
    static List<Integer> toList(ListNode n) {
        List<Integer> out = new ArrayList<>();
        while (n != null) { out.add(n.val); n = n.next; }
        return out;
    }

    public static void main(String[] args) {
        runTest("test_k2", () -> {
            assertEq(toList(new Solution().reverseKGroup(buildList(new int[]{1, 2, 3, 4, 5}), 2)), Arrays.asList(2, 1, 4, 3, 5));
        });
        runTest("test_k3", () -> {
            assertEq(toList(new Solution().reverseKGroup(buildList(new int[]{1, 2, 3, 4, 5}), 3)), Arrays.asList(3, 2, 1, 4, 5));
        });
        runTest("test_k1", () -> {
            assertEq(toList(new Solution().reverseKGroup(buildList(new int[]{1, 2, 3, 4, 5}), 1)), Arrays.asList(1, 2, 3, 4, 5));
        });
        report();
    }
}$java$)
where title_slug = 'reverse-nodes-in-k-group';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class TreeNode {
    int val; TreeNode left, right;
    TreeNode() {}
    TreeNode(int val) { this.val = val; }
    TreeNode(int val, TreeNode left, TreeNode right) { this.val = val; this.left = left; this.right = right; }
}

/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {
    public int diameterOfBinaryTree(TreeNode root) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    static TreeNode buildTree(Integer[] a) {
        if (a.length == 0 || a[0] == null) return null;
        TreeNode root = new TreeNode(a[0]);
        Deque<TreeNode> q = new ArrayDeque<>(); q.add(root);
        int i = 1;
        while (!q.isEmpty() && i < a.length) {
            TreeNode node = q.poll();
            if (i < a.length && a[i] != null) { node.left = new TreeNode(a[i]); q.add(node.left); }
            i++;
            if (i < a.length && a[i] != null) { node.right = new TreeNode(a[i]); q.add(node.right); }
            i++;
        }
        return root;
    }

    static List<Object> serialize(TreeNode n) { List<Object> out = new ArrayList<>(); ser(n, out); return out; }
    static void ser(TreeNode n, List<Object> out) {
        if (n == null) { out.add("#"); return; }
        out.add(n.val); ser(n.left, out); ser(n.right, out);
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            assertEq(new Solution().diameterOfBinaryTree(buildTree(new Integer[]{1, 2, 3, 4, 5})), 3);
        });
        runTest("test_two", () -> {
            assertEq(new Solution().diameterOfBinaryTree(buildTree(new Integer[]{1, 2})), 1);
        });
        runTest("test_single", () -> {
            assertEq(new Solution().diameterOfBinaryTree(buildTree(new Integer[]{1})), 0);
        });
        report();
    }
}$java$)
where title_slug = 'diameter-of-binary-tree';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class TreeNode {
    int val; TreeNode left, right;
    TreeNode() {}
    TreeNode(int val) { this.val = val; }
    TreeNode(int val, TreeNode left, TreeNode right) { this.val = val; this.left = left; this.right = right; }
}

/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {
    public boolean isBalanced(TreeNode root) {
        return false;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    static TreeNode buildTree(Integer[] a) {
        if (a.length == 0 || a[0] == null) return null;
        TreeNode root = new TreeNode(a[0]);
        Deque<TreeNode> q = new ArrayDeque<>(); q.add(root);
        int i = 1;
        while (!q.isEmpty() && i < a.length) {
            TreeNode node = q.poll();
            if (i < a.length && a[i] != null) { node.left = new TreeNode(a[i]); q.add(node.left); }
            i++;
            if (i < a.length && a[i] != null) { node.right = new TreeNode(a[i]); q.add(node.right); }
            i++;
        }
        return root;
    }

    static List<Object> serialize(TreeNode n) { List<Object> out = new ArrayList<>(); ser(n, out); return out; }
    static void ser(TreeNode n, List<Object> out) {
        if (n == null) { out.add("#"); return; }
        out.add(n.val); ser(n.left, out); ser(n.right, out);
    }

    public static void main(String[] args) {
        runTest("test_balanced", () -> {
            assertEq(new Solution().isBalanced(buildTree(new Integer[]{3, 9, 20, null, null, 15, 7})), true);
        });
        runTest("test_unbalanced", () -> {
            assertEq(new Solution().isBalanced(buildTree(new Integer[]{1, 2, 2, 3, 3, null, null, 4, 4})), false);
        });
        runTest("test_empty", () -> {
            assertEq(new Solution().isBalanced(buildTree(new Integer[]{})), true);
        });
        report();
    }
}$java$)
where title_slug = 'balanced-binary-tree';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class TreeNode {
    int val; TreeNode left, right;
    TreeNode() {}
    TreeNode(int val) { this.val = val; }
    TreeNode(int val, TreeNode left, TreeNode right) { this.val = val; this.left = left; this.right = right; }
}

/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {
    public List<Integer> rightSideView(TreeNode root) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    static TreeNode buildTree(Integer[] a) {
        if (a.length == 0 || a[0] == null) return null;
        TreeNode root = new TreeNode(a[0]);
        Deque<TreeNode> q = new ArrayDeque<>(); q.add(root);
        int i = 1;
        while (!q.isEmpty() && i < a.length) {
            TreeNode node = q.poll();
            if (i < a.length && a[i] != null) { node.left = new TreeNode(a[i]); q.add(node.left); }
            i++;
            if (i < a.length && a[i] != null) { node.right = new TreeNode(a[i]); q.add(node.right); }
            i++;
        }
        return root;
    }

    static List<Object> serialize(TreeNode n) { List<Object> out = new ArrayList<>(); ser(n, out); return out; }
    static void ser(TreeNode n, List<Object> out) {
        if (n == null) { out.add("#"); return; }
        out.add(n.val); ser(n.left, out); ser(n.right, out);
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            assertEq(new Solution().rightSideView(buildTree(new Integer[]{1, 2, 3, null, 5, null, 4})), Arrays.asList(1, 3, 4));
        });
        runTest("test_empty", () -> {
            assertEq(new Solution().rightSideView(buildTree(new Integer[]{})), new ArrayList<>());
        });
        runTest("test_single", () -> {
            assertEq(new Solution().rightSideView(buildTree(new Integer[]{1})), Arrays.asList(1));
        });
        report();
    }
}$java$)
where title_slug = 'binary-tree-right-side-view';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class TreeNode {
    int val; TreeNode left, right;
    TreeNode() {}
    TreeNode(int val) { this.val = val; }
    TreeNode(int val, TreeNode left, TreeNode right) { this.val = val; this.left = left; this.right = right; }
}

/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {
    public int goodNodes(TreeNode root) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    static TreeNode buildTree(Integer[] a) {
        if (a.length == 0 || a[0] == null) return null;
        TreeNode root = new TreeNode(a[0]);
        Deque<TreeNode> q = new ArrayDeque<>(); q.add(root);
        int i = 1;
        while (!q.isEmpty() && i < a.length) {
            TreeNode node = q.poll();
            if (i < a.length && a[i] != null) { node.left = new TreeNode(a[i]); q.add(node.left); }
            i++;
            if (i < a.length && a[i] != null) { node.right = new TreeNode(a[i]); q.add(node.right); }
            i++;
        }
        return root;
    }

    static List<Object> serialize(TreeNode n) { List<Object> out = new ArrayList<>(); ser(n, out); return out; }
    static void ser(TreeNode n, List<Object> out) {
        if (n == null) { out.add("#"); return; }
        out.add(n.val); ser(n.left, out); ser(n.right, out);
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            assertEq(new Solution().goodNodes(buildTree(new Integer[]{3, 1, 4, 3, null, 1, 5})), 4);
        });
        runTest("test_left_chain", () -> {
            assertEq(new Solution().goodNodes(buildTree(new Integer[]{3, 3, null, 4, 2})), 3);
        });
        runTest("test_single", () -> {
            assertEq(new Solution().goodNodes(buildTree(new Integer[]{1})), 1);
        });
        report();
    }
}$java$)
where title_slug = 'count-good-nodes-in-binary-tree';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class KthLargest {

    public KthLargest(int k, int[] nums) {
        
    }
    
    public int add(int val) {
        return 0;
        
    }
}

/**
 * Your KthLargest object will be instantiated and called as such:
 * KthLargest obj = new KthLargest(k, nums);
 * int param_1 = obj.add(val);
 */

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_stream", () -> {
            KthLargest k = new KthLargest(3, new int[]{4, 5, 8, 2});
            assertEq(k.add(3), 4);
            assertEq(k.add(5), 5);
            assertEq(k.add(10), 5);
            assertEq(k.add(9), 8);
            assertEq(k.add(4), 8);
        });
        report();
    }
}$java$)
where title_slug = 'kth-largest-element-in-a-stream';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int lastStoneWeight(int[] stones) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            assertEq(new Solution().lastStoneWeight(new int[]{2, 7, 4, 1, 8, 1}), 1);
        });
        runTest("test_single", () -> {
            assertEq(new Solution().lastStoneWeight(new int[]{1}), 1);
        });
        runTest("test_cancel", () -> {
            assertEq(new Solution().lastStoneWeight(new int[]{2, 2}), 0);
        });
        report();
    }
}$java$)
where title_slug = 'last-stone-weight';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int[][] kClosest(int[][] points, int k) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_example_1", () -> {
            assertEq(normOuter(new Solution().kClosest(new int[][]{new int[]{1, 3}, new int[]{-2, 2}}, 1)), normOuter(Arrays.asList(Arrays.asList(-2, 2))));
        });
        runTest("test_example_2", () -> {
            assertEq(normOuter(new Solution().kClosest(new int[][]{new int[]{3, 3}, new int[]{5, -1}, new int[]{-2, 4}}, 2)), normOuter(Arrays.asList(Arrays.asList(3, 3), Arrays.asList(-2, 4))));
        });
        runTest("test_all", () -> {
            assertEq(normOuter(new Solution().kClosest(new int[][]{new int[]{1, 1}, new int[]{2, 2}}, 2)), normOuter(Arrays.asList(Arrays.asList(1, 1), Arrays.asList(2, 2))));
        });
        report();
    }
}$java$)
where title_slug = 'k-closest-points-to-origin';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int findKthLargest(int[] nums, int k) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().findKthLargest(new int[]{3, 2, 1, 5, 6, 4}, 2), 5);
            assertEq(new Solution().findKthLargest(new int[]{3, 2, 3, 1, 2, 4, 5, 5, 6}, 4), 4);
        });
        runTest("test_single", () -> {
            assertEq(new Solution().findKthLargest(new int[]{1}, 1), 1);
        });
        report();
    }
}$java$)
where title_slug = 'kth-largest-element-in-an-array';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int leastInterval(char[] tasks, int n) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            assertEq(new Solution().leastInterval(new char[]{'A', 'A', 'A', 'B', 'B', 'B'}, 2), 8);
        });
        runTest("test_no_cooldown", () -> {
            assertEq(new Solution().leastInterval(new char[]{'A', 'A', 'A', 'B', 'B', 'B'}, 0), 6);
        });
        runTest("test_many", () -> {
            assertEq(new Solution().leastInterval(new char[]{'A', 'A', 'A', 'A', 'A', 'A', 'B', 'C', 'D', 'E', 'F', 'G'}, 2), 16);
        });
        report();
    }
}$java$)
where title_slug = 'task-scheduler';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Twitter {

    public Twitter() {
        
    }
    
    public void postTweet(int userId, int tweetId) {
        
    }
    
    public List<Integer> getNewsFeed(int userId) {
        return null;
        
    }
    
    public void follow(int followerId, int followeeId) {
        
    }
    
    public void unfollow(int followerId, int followeeId) {
        
    }
}

/**
 * Your Twitter object will be instantiated and called as such:
 * Twitter obj = new Twitter();
 * obj.postTweet(userId,tweetId);
 * List<Integer> param_2 = obj.getNewsFeed(userId);
 * obj.follow(followerId,followeeId);
 * obj.unfollow(followerId,followeeId);
 */

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_feed", () -> {
            Twitter t = new Twitter();
            t.postTweet(1, 5);
            assertEq(t.getNewsFeed(1), Arrays.asList(5));
            t.follow(1, 2);
            t.postTweet(2, 6);
            assertEq(t.getNewsFeed(1), Arrays.asList(6, 5));
            t.unfollow(1, 2);
            assertEq(t.getNewsFeed(1), Arrays.asList(5));
        });
        report();
    }
}$java$)
where title_slug = 'design-twitter';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public List<List<Integer>> subsets(int[] nums) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            assertEq(norm(new Solution().subsets(new int[]{1, 2, 3})), norm(Arrays.asList(new ArrayList<>(), Arrays.asList(1), Arrays.asList(2), Arrays.asList(3), Arrays.asList(1, 2), Arrays.asList(1, 3), Arrays.asList(2, 3), Arrays.asList(1, 2, 3))));
        });
        runTest("test_single", () -> {
            assertEq(norm(new Solution().subsets(new int[]{0})), norm(Arrays.asList(new ArrayList<>(), Arrays.asList(0))));
        });
        runTest("test_count", () -> {
            assertEq(len(new Solution().subsets(new int[]{1, 2, 3, 4})), 16);
        });
        report();
    }
}$java$)
where title_slug = 'subsets';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public List<List<Integer>> permute(int[] nums) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            assertEq(normOuter(new Solution().permute(new int[]{1, 2, 3})), normOuter(Arrays.asList(Arrays.asList(1, 3, 2), Arrays.asList(1, 2, 3), Arrays.asList(2, 1, 3), Arrays.asList(3, 2, 1), Arrays.asList(3, 1, 2), Arrays.asList(2, 3, 1))));
        });
        runTest("test_single", () -> {
            assertEq(normOuter(new Solution().permute(new int[]{0})), normOuter(Arrays.asList(Arrays.asList(0))));
        });
        runTest("test_count", () -> {
            assertEq(len(new Solution().permute(new int[]{1, 2, 3, 4})), 24);
        });
        report();
    }
}$java$)
where title_slug = 'permutations';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public List<List<Integer>> subsetsWithDup(int[] nums) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            assertEq(norm(new Solution().subsetsWithDup(new int[]{1, 2, 2})), norm(Arrays.asList(new ArrayList<>(), Arrays.asList(1), Arrays.asList(2), Arrays.asList(1, 2), Arrays.asList(2, 2), Arrays.asList(1, 2, 2))));
        });
        runTest("test_single", () -> {
            assertEq(norm(new Solution().subsetsWithDup(new int[]{0})), norm(Arrays.asList(new ArrayList<>(), Arrays.asList(0))));
        });
        runTest("test_all_dup", () -> {
            assertEq(norm(new Solution().subsetsWithDup(new int[]{2, 2})), norm(Arrays.asList(new ArrayList<>(), Arrays.asList(2), Arrays.asList(2, 2))));
        });
        report();
    }
}$java$)
where title_slug = 'subsets-ii';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public List<List<Integer>> combinationSum2(int[] candidates, int target) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_example_1", () -> {
            assertEq(norm(new Solution().combinationSum2(new int[]{10, 1, 2, 7, 6, 1, 5}, 8)), norm(Arrays.asList(Arrays.asList(1, 1, 6), Arrays.asList(1, 2, 5), Arrays.asList(1, 7), Arrays.asList(2, 6))));
        });
        runTest("test_example_2", () -> {
            assertEq(norm(new Solution().combinationSum2(new int[]{2, 5, 2, 1, 2}, 5)), norm(Arrays.asList(Arrays.asList(1, 2, 2), Arrays.asList(5))));
        });
        runTest("test_none", () -> {
            assertEq(new Solution().combinationSum2(new int[]{2}, 1), new ArrayList<>());
        });
        report();
    }
}$java$)
where title_slug = 'combination-sum-ii';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public List<List<String>> partition(String s) {
        return null;
        
    }
}

class Main {
    public static void main(String[] args) {
        // Write and run your own tests here.
    }
}$java$)
where title_slug = 'palindrome-partitioning';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public List<String> letterCombinations(String digits) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            assertEq(toSet(new Solution().letterCombinations("23")), toSet(new String[]{"bd", "ae", "be", "ad", "af", "bf", "cd", "cf", "ce"}));
        });
        runTest("test_empty", () -> {
            assertEq(new Solution().letterCombinations(""), new ArrayList<>());
        });
        runTest("test_single_digit", () -> {
            assertEq(toSet(new Solution().letterCombinations("2")), toSet(new String[]{"b", "a", "c"}));
        });
        report();
    }
}$java$)
where title_slug = 'letter-combinations-of-a-phone-number';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public List<List<String>> solveNQueens(int n) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_counts", () -> {
            assertEq(len(new Solution().solveNQueens(4)), 2);
            assertEq(len(new Solution().solveNQueens(1)), 1);
            assertEq(len(new Solution().solveNQueens(2)), 0);
        });
        report();
    }
}$java$)
where title_slug = 'n-queens';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int maxAreaOfIsland(int[][] grid) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            assertEq(new Solution().maxAreaOfIsland(new int[][]{new int[]{1, 1, 0, 0}, new int[]{1, 0, 0, 1}, new int[]{0, 0, 1, 1}}), 3);
        });
        runTest("test_full", () -> {
            assertEq(new Solution().maxAreaOfIsland(new int[][]{new int[]{1, 1}, new int[]{1, 1}}), 4);
        });
        runTest("test_empty", () -> {
            assertEq(new Solution().maxAreaOfIsland(new int[][]{new int[]{0}}), 0);
        });
        report();
    }
}$java$)
where title_slug = 'max-area-of-island';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public void wallsAndGates(int[][] rooms) {
    }
}


class Main {
    public static void main(String[] args) {
        // Write and run your own tests here.
    }
}$java$)
where title_slug = 'walls-and-gates';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int orangesRotting(int[][] grid) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            assertEq(new Solution().orangesRotting(new int[][]{new int[]{2, 1, 1}, new int[]{1, 1, 0}, new int[]{0, 1, 1}}), 4);
        });
        runTest("test_impossible", () -> {
            assertEq(new Solution().orangesRotting(new int[][]{new int[]{2, 1, 1}, new int[]{0, 1, 1}, new int[]{1, 0, 1}}), -1);
        });
        runTest("test_none_fresh", () -> {
            assertEq(new Solution().orangesRotting(new int[][]{new int[]{0, 2}}), 0);
        });
        report();
    }
}$java$)
where title_slug = 'rotting-oranges';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public void solve(char[][] board) {
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            char[][] board = new char[][]{new char[]{'X', 'X', 'X', 'X'}, new char[]{'X', 'O', 'O', 'X'}, new char[]{'X', 'X', 'O', 'X'}, new char[]{'X', 'O', 'X', 'X'}};
            new Solution().solve(board);
            assertEq(board, new char[][]{new char[]{'X', 'X', 'X', 'X'}, new char[]{'X', 'X', 'X', 'X'}, new char[]{'X', 'X', 'X', 'X'}, new char[]{'X', 'O', 'X', 'X'}});
        });
        runTest("test_single", () -> {
            char[][] board = new char[][]{new char[]{'X'}};
            new Solution().solve(board);
            assertEq(board, new char[][]{new char[]{'X'}});
        });
        runTest("test_border_kept", () -> {
            char[][] board = new char[][]{new char[]{'O', 'O'}, new char[]{'O', 'O'}};
            new Solution().solve(board);
            assertEq(board, new char[][]{new char[]{'O', 'O'}, new char[]{'O', 'O'}});
        });
        report();
    }
}$java$)
where title_slug = 'surrounded-regions';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int[] findOrder(int numCourses, int[][] prerequisites) {
        return null;
        
    }
}

class Main {
    public static void main(String[] args) {
        // Write and run your own tests here.
    }
}$java$)
where title_slug = 'course-schedule-ii';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int[] findRedundantConnection(int[][] edges) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_example_1", () -> {
            assertEq(new Solution().findRedundantConnection(new int[][]{new int[]{1, 2}, new int[]{1, 3}, new int[]{2, 3}}), new int[]{2, 3});
        });
        runTest("test_example_2", () -> {
            assertEq(new Solution().findRedundantConnection(new int[][]{new int[]{1, 2}, new int[]{2, 3}, new int[]{3, 4}, new int[]{1, 4}, new int[]{1, 5}}), new int[]{1, 4});
        });
        runTest("test_triangle", () -> {
            assertEq(new Solution().findRedundantConnection(new int[][]{new int[]{1, 2}, new int[]{2, 3}, new int[]{1, 3}}), new int[]{1, 3});
        });
        report();
    }
}$java$)
where title_slug = 'redundant-connection';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int ladderLength(String beginWord, String endWord, List<String> wordList) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_reachable", () -> {
            assertEq(new Solution().ladderLength("hit", "cog", Arrays.asList("hot", "dot", "dog", "lot", "log", "cog")), 5);
        });
        runTest("test_unreachable", () -> {
            assertEq(new Solution().ladderLength("hit", "cog", Arrays.asList("hot", "dot", "dog", "lot", "log")), 0);
        });
        runTest("test_short", () -> {
            assertEq(new Solution().ladderLength("a", "c", Arrays.asList("a", "b", "c")), 2);
        });
        report();
    }
}$java$)
where title_slug = 'word-ladder';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public List<String> findItinerary(List<List<String>> tickets) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_example_1", () -> {
            assertEq(new Solution().findItinerary(Arrays.asList(Arrays.asList("MUC", "LHR"), Arrays.asList("JFK", "MUC"), Arrays.asList("SFO", "SJC"), Arrays.asList("LHR", "SFO"))), Arrays.asList("JFK", "MUC", "LHR", "SFO", "SJC"));
        });
        runTest("test_example_2", () -> {
            assertEq(new Solution().findItinerary(Arrays.asList(Arrays.asList("JFK", "SFO"), Arrays.asList("JFK", "ATL"), Arrays.asList("SFO", "ATL"), Arrays.asList("ATL", "JFK"), Arrays.asList("ATL", "SFO"))), Arrays.asList("JFK", "ATL", "JFK", "SFO", "ATL", "SFO"));
        });
        runTest("test_round_trip", () -> {
            assertEq(new Solution().findItinerary(Arrays.asList(Arrays.asList("JFK", "A"), Arrays.asList("A", "JFK"))), Arrays.asList("JFK", "A", "JFK"));
        });
        report();
    }
}$java$)
where title_slug = 'reconstruct-itinerary';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int minCostConnectPoints(int[][] points) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            assertEq(new Solution().minCostConnectPoints(new int[][]{new int[]{0, 0}, new int[]{2, 2}, new int[]{3, 10}, new int[]{5, 2}, new int[]{7, 0}}), 20);
        });
        runTest("test_three", () -> {
            assertEq(new Solution().minCostConnectPoints(new int[][]{new int[]{3, 12}, new int[]{-2, 5}, new int[]{-4, 1}}), 18);
        });
        runTest("test_single", () -> {
            assertEq(new Solution().minCostConnectPoints(new int[][]{new int[]{0, 0}}), 0);
        });
        report();
    }
}$java$)
where title_slug = 'min-cost-to-connect-all-points';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int networkDelayTime(int[][] times, int n, int k) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            assertEq(new Solution().networkDelayTime(new int[][]{new int[]{2, 1, 1}, new int[]{2, 3, 1}, new int[]{3, 4, 1}}, 4, 2), 2);
        });
        runTest("test_single_edge", () -> {
            assertEq(new Solution().networkDelayTime(new int[][]{new int[]{1, 2, 1}}, 2, 1), 1);
        });
        runTest("test_unreachable", () -> {
            assertEq(new Solution().networkDelayTime(new int[][]{new int[]{1, 2, 1}}, 2, 2), -1);
        });
        report();
    }
}$java$)
where title_slug = 'network-delay-time';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int swimInWater(int[][] grid) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_small", () -> {
            assertEq(new Solution().swimInWater(new int[][]{new int[]{0, 2}, new int[]{1, 3}}), 3);
        });
        runTest("test_large", () -> {
            assertEq(new Solution().swimInWater(new int[][]{new int[]{0, 1, 2, 3, 4}, new int[]{24, 23, 22, 21, 5}, new int[]{12, 13, 14, 15, 16}, new int[]{11, 17, 18, 19, 20}, new int[]{10, 9, 8, 7, 6}}), 16);
        });
        runTest("test_single", () -> {
            assertEq(new Solution().swimInWater(new int[][]{new int[]{0}}), 0);
        });
        report();
    }
}$java$)
where title_slug = 'swim-in-rising-water';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int findCheapestPrice(int n, int[][] flights, int src, int dst, int k) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_one_stop", () -> {
            assertEq(new Solution().findCheapestPrice(4, new int[][]{new int[]{0, 1, 100}, new int[]{1, 2, 100}, new int[]{2, 0, 100}, new int[]{1, 3, 600}, new int[]{2, 3, 200}}, 0, 3, 1), 700);
        });
        runTest("test_via_stop", () -> {
            assertEq(new Solution().findCheapestPrice(3, new int[][]{new int[]{0, 1, 100}, new int[]{1, 2, 100}, new int[]{0, 2, 500}}, 0, 2, 1), 200);
        });
        runTest("test_no_stop", () -> {
            assertEq(new Solution().findCheapestPrice(3, new int[][]{new int[]{0, 1, 100}, new int[]{1, 2, 100}, new int[]{0, 2, 500}}, 0, 2, 0), 500);
        });
        report();
    }
}$java$)
where title_slug = 'cheapest-flights-within-k-stops';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int minCostClimbingStairs(int[] cost) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().minCostClimbingStairs(new int[]{10, 15, 20}), 15);
            assertEq(new Solution().minCostClimbingStairs(new int[]{1, 100, 1, 1, 1, 100, 1, 1, 100, 1}), 6);
        });
        runTest("test_two_zeros", () -> {
            assertEq(new Solution().minCostClimbingStairs(new int[]{0, 0}), 0);
        });
        report();
    }
}$java$)
where title_slug = 'min-cost-climbing-stairs';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public boolean canPartition(int[] nums) {
        return false;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().canPartition(new int[]{1, 5, 11, 5}), true);
            assertEq(new Solution().canPartition(new int[]{1, 2, 3, 5}), false);
        });
        runTest("test_pair", () -> {
            assertEq(new Solution().canPartition(new int[]{1, 1}), true);
        });
        report();
    }
}$java$)
where title_slug = 'partition-equal-subset-sum';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int maxProfit(int[] prices) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            assertEq(new Solution().maxProfit(new int[]{1, 2, 3, 0, 2}), 3);
        });
        runTest("test_single", () -> {
            assertEq(new Solution().maxProfit(new int[]{1}), 0);
        });
        runTest("test_decreasing", () -> {
            assertEq(new Solution().maxProfit(new int[]{2, 1}), 0);
        });
        report();
    }
}$java$)
where title_slug = 'best-time-to-buy-and-sell-stock-with-cooldown';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int change(int amount, int[] coins) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().change(5, new int[]{1, 2, 5}), 4);
            assertEq(new Solution().change(3, new int[]{2}), 0);
        });
        runTest("test_single_coin", () -> {
            assertEq(new Solution().change(10, new int[]{10}), 1);
        });
        report();
    }
}$java$)
where title_slug = 'coin-change-ii';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int findTargetSumWays(int[] nums, int target) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            assertEq(new Solution().findTargetSumWays(new int[]{1, 1, 1, 1, 1}, 3), 5);
        });
        runTest("test_single_reachable", () -> {
            assertEq(new Solution().findTargetSumWays(new int[]{1}, 1), 1);
        });
        runTest("test_single_unreachable", () -> {
            assertEq(new Solution().findTargetSumWays(new int[]{1}, 2), 0);
        });
        report();
    }
}$java$)
where title_slug = 'target-sum';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public boolean isInterleave(String s1, String s2, String s3) {
        return false;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_true", () -> {
            assertEq(new Solution().isInterleave("aabcc", "dbbca", "aadbbcbcac"), true);
        });
        runTest("test_false", () -> {
            assertEq(new Solution().isInterleave("aabcc", "dbbca", "aadbbbaccc"), false);
        });
        runTest("test_empty", () -> {
            assertEq(new Solution().isInterleave("", "", ""), true);
        });
        report();
    }
}$java$)
where title_slug = 'interleaving-string';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int longestIncreasingPath(int[][] matrix) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().longestIncreasingPath(new int[][]{new int[]{9, 9, 4}, new int[]{6, 6, 8}, new int[]{2, 1, 1}}), 4);
            assertEq(new Solution().longestIncreasingPath(new int[][]{new int[]{3, 4, 5}, new int[]{3, 2, 6}, new int[]{2, 2, 1}}), 4);
        });
        runTest("test_single", () -> {
            assertEq(new Solution().longestIncreasingPath(new int[][]{new int[]{1}}), 1);
        });
        report();
    }
}$java$)
where title_slug = 'longest-increasing-path-in-a-matrix';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int numDistinct(String s, String t) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().numDistinct("rabbbit", "rabbit"), 3);
            assertEq(new Solution().numDistinct("babgbag", "bag"), 5);
        });
        runTest("test_empty_target", () -> {
            assertEq(new Solution().numDistinct("", ""), 1);
        });
        report();
    }
}$java$)
where title_slug = 'distinct-subsequences';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int minDistance(String word1, String word2) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().minDistance("horse", "ros"), 3);
            assertEq(new Solution().minDistance("intention", "execution"), 5);
        });
        runTest("test_empty", () -> {
            assertEq(new Solution().minDistance("", "a"), 1);
        });
        report();
    }
}$java$)
where title_slug = 'edit-distance';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int maxCoins(int[] nums) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            assertEq(new Solution().maxCoins(new int[]{3, 1, 5, 8}), 167);
        });
        runTest("test_pair", () -> {
            assertEq(new Solution().maxCoins(new int[]{1, 5}), 10);
        });
        runTest("test_single", () -> {
            assertEq(new Solution().maxCoins(new int[]{5}), 5);
        });
        report();
    }
}$java$)
where title_slug = 'burst-balloons';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public boolean isMatch(String s, String p) {
        return false;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().isMatch("aa", "a"), false);
            assertEq(new Solution().isMatch("aa", "a*"), true);
            assertEq(new Solution().isMatch("ab", ".*"), true);
        });
        runTest("test_complex", () -> {
            assertEq(new Solution().isMatch("mississippi", "mis*is*p*."), false);
        });
        report();
    }
}$java$)
where title_slug = 'regular-expression-matching';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int jump(int[] nums) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().jump(new int[]{2, 3, 1, 1, 4}), 2);
            assertEq(new Solution().jump(new int[]{2, 3, 0, 1, 4}), 2);
        });
        runTest("test_single", () -> {
            assertEq(new Solution().jump(new int[]{0}), 0);
        });
        report();
    }
}$java$)
where title_slug = 'jump-game-ii';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int canCompleteCircuit(int[] gas, int[] cost) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_possible", () -> {
            assertEq(new Solution().canCompleteCircuit(new int[]{1, 2, 3, 4, 5}, new int[]{3, 4, 5, 1, 2}), 3);
        });
        runTest("test_impossible", () -> {
            assertEq(new Solution().canCompleteCircuit(new int[]{2, 3, 4}, new int[]{3, 4, 3}), -1);
        });
        runTest("test_single", () -> {
            assertEq(new Solution().canCompleteCircuit(new int[]{5}, new int[]{4}), 0);
        });
        report();
    }
}$java$)
where title_slug = 'gas-station';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public boolean isNStraightHand(int[] hand, int groupSize) {
        return false;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_true", () -> {
            assertEq(new Solution().isNStraightHand(new int[]{1, 2, 3, 6, 2, 3, 4, 7, 8}, 3), true);
        });
        runTest("test_false", () -> {
            assertEq(new Solution().isNStraightHand(new int[]{1, 2, 3, 4, 5}, 4), false);
        });
        runTest("test_pairs", () -> {
            assertEq(new Solution().isNStraightHand(new int[]{1, 1, 2, 2, 3, 3}, 3), true);
        });
        report();
    }
}$java$)
where title_slug = 'hand-of-straights';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public boolean mergeTriplets(int[][] triplets, int[] target) {
        return false;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_true", () -> {
            assertEq(new Solution().mergeTriplets(new int[][]{new int[]{2, 5, 3}, new int[]{1, 8, 4}, new int[]{1, 7, 5}}, new int[]{2, 7, 5}), true);
        });
        runTest("test_false", () -> {
            assertEq(new Solution().mergeTriplets(new int[][]{new int[]{3, 4, 5}, new int[]{4, 5, 6}}, new int[]{3, 2, 5}), false);
        });
        runTest("test_true_more", () -> {
            assertEq(new Solution().mergeTriplets(new int[][]{new int[]{2, 5, 3}, new int[]{2, 3, 4}, new int[]{1, 2, 5}, new int[]{5, 2, 3}}, new int[]{5, 5, 5}), true);
        });
        report();
    }
}$java$)
where title_slug = 'merge-triplets-to-form-target-triplet';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public List<Integer> partitionLabels(String s) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            assertEq(new Solution().partitionLabels("ababcbacadefegdehijhklij"), Arrays.asList(9, 7, 8));
        });
        runTest("test_single_part", () -> {
            assertEq(new Solution().partitionLabels("eccbbbbdec"), Arrays.asList(10));
        });
        runTest("test_single_char", () -> {
            assertEq(new Solution().partitionLabels("a"), Arrays.asList(1));
        });
        report();
    }
}$java$)
where title_slug = 'partition-labels';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public boolean checkValidString(String s) {
        return false;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_valid", () -> {
            assertEq(new Solution().checkValidString("()"), true);
            assertEq(new Solution().checkValidString("(*)"), true);
            assertEq(new Solution().checkValidString("(*))"), true);
        });
        runTest("test_invalid", () -> {
            assertEq(new Solution().checkValidString("(("), false);
        });
        report();
    }
}$java$)
where title_slug = 'valid-parenthesis-string';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int[] minInterval(int[][] intervals, int[] queries) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_example_1", () -> {
            assertEq(new Solution().minInterval(new int[][]{new int[]{1, 4}, new int[]{2, 4}, new int[]{3, 6}, new int[]{4, 4}}, new int[]{2, 3, 4, 5}), new int[]{3, 3, 1, 4});
        });
        runTest("test_example_2", () -> {
            assertEq(new Solution().minInterval(new int[][]{new int[]{2, 3}, new int[]{2, 5}, new int[]{1, 8}, new int[]{20, 25}}, new int[]{2, 19, 5, 22}), new int[]{2, -1, 4, 6});
        });
        runTest("test_single", () -> {
            assertEq(new Solution().minInterval(new int[][]{new int[]{1, 1}}, new int[]{1, 2}), new int[]{1, -1});
        });
        report();
    }
}$java$)
where title_slug = 'minimum-interval-to-include-each-query';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public boolean isHappy(int n) {
        return false;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_happy", () -> {
            assertEq(new Solution().isHappy(19), true);
            assertEq(new Solution().isHappy(1), true);
        });
        runTest("test_unhappy", () -> {
            assertEq(new Solution().isHappy(2), false);
        });
        report();
    }
}$java$)
where title_slug = 'happy-number';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int[] plusOne(int[] digits) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().plusOne(new int[]{1, 2, 3}), new int[]{1, 2, 4});
            assertEq(new Solution().plusOne(new int[]{4, 3, 2, 1}), new int[]{4, 3, 2, 2});
        });
        runTest("test_carry", () -> {
            assertEq(new Solution().plusOne(new int[]{9}), new int[]{1, 0});
            assertEq(new Solution().plusOne(new int[]{9, 9}), new int[]{1, 0, 0});
        });
        report();
    }
}$java$)
where title_slug = 'plus-one';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public double myPow(double x, int n) {
        return 0;
        
    }
}

class Main {
    public static void main(String[] args) {
        // Write and run your own tests here.
    }
}$java$)
where title_slug = 'powx-n';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public String multiply(String num1, String num2) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().multiply("2", "3"), "6");
            assertEq(new Solution().multiply("123", "456"), "56088");
        });
        runTest("test_zero", () -> {
            assertEq(new Solution().multiply("0", "52"), "0");
        });
        report();
    }
}$java$)
where title_slug = 'multiply-strings';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class DetectSquares {

    public DetectSquares() {
        
    }
    
    public void add(int[] point) {
        
    }
    
    public int count(int[] point) {
        return 0;
        
    }
}

/**
 * Your DetectSquares object will be instantiated and called as such:
 * DetectSquares obj = new DetectSquares();
 * obj.add(point);
 * int param_2 = obj.count(point);
 */

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_counts", () -> {
            DetectSquares ds = new DetectSquares();
            ds.add(new int[]{3, 10});
            ds.add(new int[]{11, 2});
            ds.add(new int[]{3, 2});
            assertEq(ds.count(new int[]{11, 10}), 1);
            assertEq(ds.count(new int[]{14, 8}), 0);
            ds.add(new int[]{11, 2});
            assertEq(ds.count(new int[]{11, 10}), 2);
        });
        report();
    }
}$java$)
where title_slug = 'detect-squares';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int singleNumber(int[] nums) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().singleNumber(new int[]{2, 2, 1}), 1);
            assertEq(new Solution().singleNumber(new int[]{4, 1, 2, 1, 2}), 4);
        });
        runTest("test_single", () -> {
            assertEq(new Solution().singleNumber(new int[]{1}), 1);
        });
        report();
    }
}$java$)
where title_slug = 'single-number';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int reverse(int x) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().reverse(123), 321);
            assertEq(new Solution().reverse(-123), -321);
        });
        runTest("test_trailing_zero", () -> {
            assertEq(new Solution().reverse(120), 21);
        });
        runTest("test_overflow", () -> {
            assertEq(new Solution().reverse(1534236469), 0);
        });
        report();
    }
}$java$)
where title_slug = 'reverse-integer';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int[][] floodFill(int[][] image, int sr, int sc, int color) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            assertEq(new Solution().floodFill(new int[][]{new int[]{1, 1, 1}, new int[]{1, 1, 0}, new int[]{1, 0, 1}}, 1, 1, 2), new int[][]{new int[]{2, 2, 2}, new int[]{2, 2, 0}, new int[]{2, 0, 1}});
        });
        runTest("test_no_change", () -> {
            assertEq(new Solution().floodFill(new int[][]{new int[]{0, 0, 0}, new int[]{0, 0, 0}}, 0, 0, 0), new int[][]{new int[]{0, 0, 0}, new int[]{0, 0, 0}});
        });
        runTest("test_single", () -> {
            assertEq(new Solution().floodFill(new int[][]{new int[]{0}}, 0, 0, 5), new int[][]{new int[]{5}});
        });
        report();
    }
}$java$)
where title_slug = 'flood-fill';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class MyQueue {

    public MyQueue() {
        
    }
    
    public void push(int x) {
        
    }
    
    public int pop() {
        return 0;
        
    }
    
    public int peek() {
        return 0;
        
    }
    
    public boolean empty() {
        return false;
        
    }
}

/**
 * Your MyQueue object will be instantiated and called as such:
 * MyQueue obj = new MyQueue();
 * obj.push(x);
 * int param_2 = obj.pop();
 * int param_3 = obj.peek();
 * boolean param_4 = obj.empty();
 */

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_fifo", () -> {
            MyQueue q = new MyQueue();
            q.push(1);
            q.push(2);
            assertEq(q.peek(), 1);
            assertEq(q.pop(), 1);
            assertEq(q.empty(), false);
            assertEq(q.pop(), 2);
            assertEq(q.empty(), true);
        });
        report();
    }
}$java$)
where title_slug = 'implement-queue-using-stacks';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public boolean canConstruct(String ransomNote, String magazine) {
        return false;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().canConstruct("a", "b"), false);
            assertEq(new Solution().canConstruct("aa", "aab"), true);
        });
        runTest("test_insufficient", () -> {
            assertEq(new Solution().canConstruct("aa", "ab"), false);
        });
        report();
    }
}$java$)
where title_slug = 'ransom-note';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int longestPalindrome(String s) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            assertEq(new Solution().longestPalindrome("abccccdd"), 7);
        });
        runTest("test_single", () -> {
            assertEq(new Solution().longestPalindrome("a"), 1);
        });
        runTest("test_case_sensitive", () -> {
            assertEq(new Solution().longestPalindrome("Aa"), 1);
        });
        report();
    }
}$java$)
where title_slug = 'longest-palindrome';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int majorityElement(int[] nums) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().majorityElement(new int[]{3, 2, 3}), 3);
            assertEq(new Solution().majorityElement(new int[]{2, 2, 1, 1, 1, 2, 2}), 2);
        });
        runTest("test_single", () -> {
            assertEq(new Solution().majorityElement(new int[]{1}), 1);
        });
        report();
    }
}$java$)
where title_slug = 'majority-element';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public String addBinary(String a, String b) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().addBinary("11", "1"), "100");
            assertEq(new Solution().addBinary("1010", "1011"), "10101");
        });
        runTest("test_zero", () -> {
            assertEq(new Solution().addBinary("0", "0"), "0");
        });
        report();
    }
}$java$)
where title_slug = 'add-binary';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class ListNode {
    int val; ListNode next;
    ListNode() {}
    ListNode(int val) { this.val = val; }
    ListNode(int val, ListNode next) { this.val = val; this.next = next; }
}

/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode() {}
 *     ListNode(int val) { this.val = val; }
 *     ListNode(int val, ListNode next) { this.val = val; this.next = next; }
 * }
 */
class Solution {
    public ListNode middleNode(ListNode head) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    static ListNode buildList(int[] a) {
        ListNode dummy = new ListNode(), cur = dummy;
        for (int v : a) { cur.next = new ListNode(v); cur = cur.next; }
        return dummy.next;
    }
    static List<Integer> toList(ListNode n) {
        List<Integer> out = new ArrayList<>();
        while (n != null) { out.add(n.val); n = n.next; }
        return out;
    }

    public static void main(String[] args) {
        runTest("test_odd", () -> {
            assertEq(toList(new Solution().middleNode(buildList(new int[]{1, 2, 3, 4, 5}))), Arrays.asList(3, 4, 5));
        });
        runTest("test_even", () -> {
            assertEq(toList(new Solution().middleNode(buildList(new int[]{1, 2, 3, 4, 5, 6}))), Arrays.asList(4, 5, 6));
        });
        runTest("test_single", () -> {
            assertEq(toList(new Solution().middleNode(buildList(new int[]{1}))), Arrays.asList(1));
        });
        report();
    }
}$java$)
where title_slug = 'middle-of-the-linked-list';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int[][] updateMatrix(int[][] mat) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_zeros_around", () -> {
            assertEq(new Solution().updateMatrix(new int[][]{new int[]{0, 0, 0}, new int[]{0, 1, 0}, new int[]{0, 0, 0}}), new int[][]{new int[]{0, 0, 0}, new int[]{0, 1, 0}, new int[]{0, 0, 0}});
        });
        runTest("test_example", () -> {
            assertEq(new Solution().updateMatrix(new int[][]{new int[]{0, 0, 0}, new int[]{0, 1, 0}, new int[]{1, 1, 1}}), new int[][]{new int[]{0, 0, 0}, new int[]{0, 1, 0}, new int[]{1, 2, 1}});
        });
        runTest("test_single", () -> {
            assertEq(new Solution().updateMatrix(new int[][]{new int[]{0}}), new int[][]{new int[]{0}});
        });
        report();
    }
}$java$)
where title_slug = '01-matrix';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class TreeNode {
    int val; TreeNode left, right;
    TreeNode() {}
    TreeNode(int val) { this.val = val; }
    TreeNode(int val, TreeNode left, TreeNode right) { this.val = val; this.left = left; this.right = right; }
}

/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */
class Solution {
    public TreeNode lowestCommonAncestor(TreeNode root, TreeNode p, TreeNode q) {
        return null;
        
    }
}

class Main {
    public static void main(String[] args) {
        // Write and run your own tests here.
    }
}$java$)
where title_slug = 'lowest-common-ancestor-of-a-binary-tree';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public List<List<String>> accountsMerge(List<List<String>> accounts) {
        return null;
        
    }
}

class Main {
    public static void main(String[] args) {
        // Write and run your own tests here.
    }
}$java$)
where title_slug = 'accounts-merge';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public void sortColors(int[] nums) {
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            int[] nums = new int[]{2, 0, 2, 1, 1, 0};
            new Solution().sortColors(nums);
            assertEq(nums, new int[]{0, 0, 1, 1, 2, 2});
        });
        runTest("test_small", () -> {
            int[] nums = new int[]{2, 0, 1};
            new Solution().sortColors(nums);
            assertEq(nums, new int[]{0, 1, 2});
        });
        runTest("test_single", () -> {
            int[] nums = new int[]{0};
            new Solution().sortColors(nums);
            assertEq(nums, new int[]{0});
        });
        report();
    }
}$java$)
where title_slug = 'sort-colors';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int myAtoi(String s) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().myAtoi("42"), 42);
            assertEq(new Solution().myAtoi("   -42"), -42);
            assertEq(new Solution().myAtoi("4193 with words"), 4193);
        });
        runTest("test_leading_words", () -> {
            assertEq(new Solution().myAtoi("words and 987"), 0);
        });
        runTest("test_clamp", () -> {
            assertEq(new Solution().myAtoi("91234567890123456789"), 2147483647);
        });
        report();
    }
}$java$)
where title_slug = 'string-to-integer-atoi';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public List<Integer> findAnagrams(String s, String p) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().findAnagrams("cbaebabacd", "abc"), Arrays.asList(0, 6));
            assertEq(new Solution().findAnagrams("abab", "ab"), Arrays.asList(0, 1, 2));
        });
        runTest("test_none", () -> {
            assertEq(new Solution().findAnagrams("a", "aa"), new ArrayList<>());
        });
        report();
    }
}$java$)
where title_slug = 'find-all-anagrams-in-a-string';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public List<Integer> findMinHeightTrees(int n, int[][] edges) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_one_center", () -> {
            assertEq(toSet(new Solution().findMinHeightTrees(4, new int[][]{new int[]{1, 0}, new int[]{1, 2}, new int[]{1, 3}})), toSet(new int[]{1}));
        });
        runTest("test_two_centers", () -> {
            assertEq(toSet(new Solution().findMinHeightTrees(6, new int[][]{new int[]{3, 0}, new int[]{3, 1}, new int[]{3, 2}, new int[]{3, 4}, new int[]{5, 4}})), toSet(new int[]{3, 4}));
        });
        runTest("test_single_node", () -> {
            assertEq(toSet(new Solution().findMinHeightTrees(1, new int[][]{})), toSet(new int[]{0}));
        });
        report();
    }
}$java$)
where title_slug = 'minimum-height-trees';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int calculate(String s) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().calculate("1 + 1"), 2);
            assertEq(new Solution().calculate(" 2-1 + 2 "), 3);
        });
        runTest("test_nested", () -> {
            assertEq(new Solution().calculate("(1+(4+5+2)-3)+(6+8)"), 23);
        });
        report();
    }
}$java$)
where title_slug = 'basic-calculator';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int jobScheduling(int[] startTime, int[] endTime, int[] profit) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_example_1", () -> {
            assertEq(new Solution().jobScheduling(new int[]{1, 2, 3, 3}, new int[]{3, 4, 5, 6}, new int[]{50, 10, 40, 70}), 120);
        });
        runTest("test_example_2", () -> {
            assertEq(new Solution().jobScheduling(new int[]{1, 2, 3, 4, 6}, new int[]{3, 5, 10, 6, 9}, new int[]{20, 20, 100, 70, 60}), 150);
        });
        runTest("test_overlap", () -> {
            assertEq(new Solution().jobScheduling(new int[]{1, 1, 1}, new int[]{2, 3, 4}, new int[]{5, 6, 4}), 6);
        });
        report();
    }
}$java$)
where title_slug = 'maximum-profit-in-job-scheduling';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public void moveZeroes(int[] nums) {
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            int[] nums = new int[]{0, 1, 0, 3, 12};
            new Solution().moveZeroes(nums);
            assertEq(nums, new int[]{1, 3, 12, 0, 0});
        });
        runTest("test_single_zero", () -> {
            int[] nums = new int[]{0};
            new Solution().moveZeroes(nums);
            assertEq(nums, new int[]{0});
        });
        runTest("test_no_zeroes", () -> {
            int[] nums = new int[]{1, 2, 3};
            new Solution().moveZeroes(nums);
            assertEq(nums, new int[]{1, 2, 3});
        });
        report();
    }
}$java$)
where title_slug = 'move-zeroes';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public void rotate(int[] nums, int k) {
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            int[] nums = new int[]{1, 2, 3, 4, 5, 6, 7};
            new Solution().rotate(nums, 3);
            assertEq(nums, new int[]{5, 6, 7, 1, 2, 3, 4});
        });
        runTest("test_small", () -> {
            int[] nums = new int[]{-1, -100, 3, 99};
            new Solution().rotate(nums, 2);
            assertEq(nums, new int[]{3, 99, -1, -100});
        });
        runTest("test_no_rotation", () -> {
            int[] nums = new int[]{1, 2};
            new Solution().rotate(nums, 0);
            assertEq(nums, new int[]{1, 2});
        });
        report();
    }
}$java$)
where title_slug = 'rotate-array';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int firstMissingPositive(int[] nums) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().firstMissingPositive(new int[]{1, 2, 0}), 3);
            assertEq(new Solution().firstMissingPositive(new int[]{3, 4, -1, 1}), 2);
        });
        runTest("test_all_high", () -> {
            assertEq(new Solution().firstMissingPositive(new int[]{7, 8, 9, 11, 12}), 1);
        });
        report();
    }
}$java$)
where title_slug = 'first-missing-positive';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public boolean searchMatrix(int[][] matrix, int target) {
        return false;
        
    }
}

class Main {
    public static void main(String[] args) {
        // Write and run your own tests here.
    }
}$java$)
where title_slug = 'search-a-2d-matrix-ii';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class ListNode {
    int val; ListNode next;
    ListNode() {}
    ListNode(int val) { this.val = val; }
    ListNode(int val, ListNode next) { this.val = val; this.next = next; }
}

/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) {
 *         val = x;
 *         next = null;
 *     }
 * }
 */
class Solution {
    public ListNode getIntersectionNode(ListNode headA, ListNode headB) {
        return null;
        
    }
}

class Main {
    public static void main(String[] args) {
        // Write and run your own tests here.
    }
}$java$)
where title_slug = 'intersection-of-two-linked-lists';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class ListNode {
    int val; ListNode next;
    ListNode() {}
    ListNode(int val) { this.val = val; }
    ListNode(int val, ListNode next) { this.val = val; this.next = next; }
}

/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode() {}
 *     ListNode(int val) { this.val = val; }
 *     ListNode(int val, ListNode next) { this.val = val; this.next = next; }
 * }
 */
class Solution {
    public boolean isPalindrome(ListNode head) {
        return false;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    static ListNode buildList(int[] a) {
        ListNode dummy = new ListNode(), cur = dummy;
        for (int v : a) { cur.next = new ListNode(v); cur = cur.next; }
        return dummy.next;
    }
    static List<Integer> toList(ListNode n) {
        List<Integer> out = new ArrayList<>();
        while (n != null) { out.add(n.val); n = n.next; }
        return out;
    }

    public static void main(String[] args) {
        runTest("test_palindrome", () -> {
            assertEq(new Solution().isPalindrome(buildList(new int[]{1, 2, 2, 1})), true);
        });
        runTest("test_not", () -> {
            assertEq(new Solution().isPalindrome(buildList(new int[]{1, 2})), false);
        });
        runTest("test_single", () -> {
            assertEq(new Solution().isPalindrome(buildList(new int[]{1})), true);
        });
        report();
    }
}$java$)
where title_slug = 'palindrome-linked-list';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class ListNode {
    int val; ListNode next;
    ListNode() {}
    ListNode(int val) { this.val = val; }
    ListNode(int val, ListNode next) { this.val = val; this.next = next; }
}

/**
 * Definition for singly-linked list.
 * class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) {
 *         val = x;
 *         next = null;
 *     }
 * }
 */
class Solution {
    public ListNode detectCycle(ListNode head) {
        return null;
        
    }
}

class Main {
    public static void main(String[] args) {
        // Write and run your own tests here.
    }
}$java$)
where title_slug = 'linked-list-cycle-ii';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class ListNode {
    int val; ListNode next;
    ListNode() {}
    ListNode(int val) { this.val = val; }
    ListNode(int val, ListNode next) { this.val = val; this.next = next; }
}

/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode() {}
 *     ListNode(int val) { this.val = val; }
 *     ListNode(int val, ListNode next) { this.val = val; this.next = next; }
 * }
 */
class Solution {
    public ListNode swapPairs(ListNode head) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    static ListNode buildList(int[] a) {
        ListNode dummy = new ListNode(), cur = dummy;
        for (int v : a) { cur.next = new ListNode(v); cur = cur.next; }
        return dummy.next;
    }
    static List<Integer> toList(ListNode n) {
        List<Integer> out = new ArrayList<>();
        while (n != null) { out.add(n.val); n = n.next; }
        return out;
    }

    public static void main(String[] args) {
        runTest("test_even", () -> {
            assertEq(toList(new Solution().swapPairs(buildList(new int[]{1, 2, 3, 4}))), Arrays.asList(2, 1, 4, 3));
        });
        runTest("test_empty", () -> {
            assertEq(toList(new Solution().swapPairs(buildList(new int[]{}))), new ArrayList<>());
        });
        runTest("test_odd", () -> {
            assertEq(toList(new Solution().swapPairs(buildList(new int[]{1, 2, 3}))), Arrays.asList(2, 1, 3));
        });
        report();
    }
}$java$)
where title_slug = 'swap-nodes-in-pairs';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class ListNode {
    int val; ListNode next;
    ListNode() {}
    ListNode(int val) { this.val = val; }
    ListNode(int val, ListNode next) { this.val = val; this.next = next; }
}

/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode() {}
 *     ListNode(int val) { this.val = val; }
 *     ListNode(int val, ListNode next) { this.val = val; this.next = next; }
 * }
 */
class Solution {
    public ListNode sortList(ListNode head) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    static ListNode buildList(int[] a) {
        ListNode dummy = new ListNode(), cur = dummy;
        for (int v : a) { cur.next = new ListNode(v); cur = cur.next; }
        return dummy.next;
    }
    static List<Integer> toList(ListNode n) {
        List<Integer> out = new ArrayList<>();
        while (n != null) { out.add(n.val); n = n.next; }
        return out;
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            assertEq(toList(new Solution().sortList(buildList(new int[]{4, 2, 1, 3}))), Arrays.asList(1, 2, 3, 4));
        });
        runTest("test_negatives", () -> {
            assertEq(toList(new Solution().sortList(buildList(new int[]{-1, 5, 3, 4, 0}))), Arrays.asList(-1, 0, 3, 4, 5));
        });
        runTest("test_empty", () -> {
            assertEq(toList(new Solution().sortList(buildList(new int[]{}))), new ArrayList<>());
        });
        report();
    }
}$java$)
where title_slug = 'sort-list';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class TreeNode {
    int val; TreeNode left, right;
    TreeNode() {}
    TreeNode(int val) { this.val = val; }
    TreeNode(int val, TreeNode left, TreeNode right) { this.val = val; this.left = left; this.right = right; }
}

/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {
    public boolean isSymmetric(TreeNode root) {
        return false;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    static TreeNode buildTree(Integer[] a) {
        if (a.length == 0 || a[0] == null) return null;
        TreeNode root = new TreeNode(a[0]);
        Deque<TreeNode> q = new ArrayDeque<>(); q.add(root);
        int i = 1;
        while (!q.isEmpty() && i < a.length) {
            TreeNode node = q.poll();
            if (i < a.length && a[i] != null) { node.left = new TreeNode(a[i]); q.add(node.left); }
            i++;
            if (i < a.length && a[i] != null) { node.right = new TreeNode(a[i]); q.add(node.right); }
            i++;
        }
        return root;
    }

    static List<Object> serialize(TreeNode n) { List<Object> out = new ArrayList<>(); ser(n, out); return out; }
    static void ser(TreeNode n, List<Object> out) {
        if (n == null) { out.add("#"); return; }
        out.add(n.val); ser(n.left, out); ser(n.right, out);
    }

    public static void main(String[] args) {
        runTest("test_symmetric", () -> {
            assertEq(new Solution().isSymmetric(buildTree(new Integer[]{1, 2, 2, 3, 4, 4, 3})), true);
        });
        runTest("test_asymmetric", () -> {
            assertEq(new Solution().isSymmetric(buildTree(new Integer[]{1, 2, 2, null, 3, null, 3})), false);
        });
        runTest("test_single", () -> {
            assertEq(new Solution().isSymmetric(buildTree(new Integer[]{1})), true);
        });
        report();
    }
}$java$)
where title_slug = 'symmetric-tree';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class TreeNode {
    int val; TreeNode left, right;
    TreeNode() {}
    TreeNode(int val) { this.val = val; }
    TreeNode(int val, TreeNode left, TreeNode right) { this.val = val; this.left = left; this.right = right; }
}

/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {
    public List<Integer> inorderTraversal(TreeNode root) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    static TreeNode buildTree(Integer[] a) {
        if (a.length == 0 || a[0] == null) return null;
        TreeNode root = new TreeNode(a[0]);
        Deque<TreeNode> q = new ArrayDeque<>(); q.add(root);
        int i = 1;
        while (!q.isEmpty() && i < a.length) {
            TreeNode node = q.poll();
            if (i < a.length && a[i] != null) { node.left = new TreeNode(a[i]); q.add(node.left); }
            i++;
            if (i < a.length && a[i] != null) { node.right = new TreeNode(a[i]); q.add(node.right); }
            i++;
        }
        return root;
    }

    static List<Object> serialize(TreeNode n) { List<Object> out = new ArrayList<>(); ser(n, out); return out; }
    static void ser(TreeNode n, List<Object> out) {
        if (n == null) { out.add("#"); return; }
        out.add(n.val); ser(n.left, out); ser(n.right, out);
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            assertEq(new Solution().inorderTraversal(buildTree(new Integer[]{1, null, 2, 3})), Arrays.asList(1, 3, 2));
        });
        runTest("test_empty", () -> {
            assertEq(new Solution().inorderTraversal(buildTree(new Integer[]{})), new ArrayList<>());
        });
        runTest("test_single", () -> {
            assertEq(new Solution().inorderTraversal(buildTree(new Integer[]{1})), Arrays.asList(1));
        });
        report();
    }
}$java$)
where title_slug = 'binary-tree-inorder-traversal';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class TreeNode {
    int val; TreeNode left, right;
    TreeNode() {}
    TreeNode(int val) { this.val = val; }
    TreeNode(int val, TreeNode left, TreeNode right) { this.val = val; this.left = left; this.right = right; }
}

/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {
    public TreeNode sortedArrayToBST(int[] nums) {
        return null;
        
    }
}

class Main {
    public static void main(String[] args) {
        // Write and run your own tests here.
    }
}$java$)
where title_slug = 'convert-sorted-array-to-binary-search-tree';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class TreeNode {
    int val; TreeNode left, right;
    TreeNode() {}
    TreeNode(int val) { this.val = val; }
    TreeNode(int val, TreeNode left, TreeNode right) { this.val = val; this.left = left; this.right = right; }
}

/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {
    public void flatten(TreeNode root) {
        
    }
}

class Main {
    public static void main(String[] args) {
        // Write and run your own tests here.
    }
}$java$)
where title_slug = 'flatten-binary-tree-to-linked-list';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class TreeNode {
    int val; TreeNode left, right;
    TreeNode() {}
    TreeNode(int val) { this.val = val; }
    TreeNode(int val, TreeNode left, TreeNode right) { this.val = val; this.left = left; this.right = right; }
}

/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {
    public int pathSum(TreeNode root, int targetSum) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    static TreeNode buildTree(Integer[] a) {
        if (a.length == 0 || a[0] == null) return null;
        TreeNode root = new TreeNode(a[0]);
        Deque<TreeNode> q = new ArrayDeque<>(); q.add(root);
        int i = 1;
        while (!q.isEmpty() && i < a.length) {
            TreeNode node = q.poll();
            if (i < a.length && a[i] != null) { node.left = new TreeNode(a[i]); q.add(node.left); }
            i++;
            if (i < a.length && a[i] != null) { node.right = new TreeNode(a[i]); q.add(node.right); }
            i++;
        }
        return root;
    }

    static List<Object> serialize(TreeNode n) { List<Object> out = new ArrayList<>(); ser(n, out); return out; }
    static void ser(TreeNode n, List<Object> out) {
        if (n == null) { out.add("#"); return; }
        out.add(n.val); ser(n.left, out); ser(n.right, out);
    }

    public static void main(String[] args) {
        runTest("test_example_1", () -> {
            assertEq(new Solution().pathSum(buildTree(new Integer[]{10, 5, -3, 3, 2, null, 11, 3, -2, null, 1}), 8), 3);
        });
        runTest("test_example_2", () -> {
            assertEq(new Solution().pathSum(buildTree(new Integer[]{5, 4, 8, 11, null, 13, 4, 7, 2, null, null, 5, 1}), 22), 3);
        });
        runTest("test_single", () -> {
            assertEq(new Solution().pathSum(buildTree(new Integer[]{1}), 1), 1);
        });
        report();
    }
}$java$)
where title_slug = 'path-sum-iii';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int searchInsert(int[] nums, int target) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().searchInsert(new int[]{1, 3, 5, 6}, 5), 2);
            assertEq(new Solution().searchInsert(new int[]{1, 3, 5, 6}, 2), 1);
        });
        runTest("test_ends", () -> {
            assertEq(new Solution().searchInsert(new int[]{1, 3, 5, 6}, 7), 4);
            assertEq(new Solution().searchInsert(new int[]{1, 3, 5, 6}, 0), 0);
        });
        report();
    }
}$java$)
where title_slug = 'search-insert-position';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int[] searchRange(int[] nums, int target) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_found", () -> {
            assertEq(new Solution().searchRange(new int[]{5, 7, 7, 8, 8, 10}, 8), new int[]{3, 4});
        });
        runTest("test_missing", () -> {
            assertEq(new Solution().searchRange(new int[]{5, 7, 7, 8, 8, 10}, 6), new int[]{-1, -1});
        });
        runTest("test_empty", () -> {
            assertEq(new Solution().searchRange(new int[]{}, 0), new int[]{-1, -1});
        });
        report();
    }
}$java$)
where title_slug = 'find-first-and-last-position-of-element-in-sorted-array';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public String decodeString(String s) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().decodeString("3[a]2[bc]"), "aaabcbc");
            assertEq(new Solution().decodeString("3[a2[c]]"), "accaccacc");
        });
        runTest("test_mixed", () -> {
            assertEq(new Solution().decodeString("2[abc]3[cd]ef"), "abcabccdcdcdef");
        });
        report();
    }
}$java$)
where title_slug = 'decode-string';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public List<List<Integer>> generate(int numRows) {
        return null;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_example", () -> {
            assertEq(new Solution().generate(5), Arrays.asList(Arrays.asList(1), Arrays.asList(1, 1), Arrays.asList(1, 2, 1), Arrays.asList(1, 3, 3, 1), Arrays.asList(1, 4, 6, 4, 1)));
        });
        runTest("test_one", () -> {
            assertEq(new Solution().generate(1), Arrays.asList(Arrays.asList(1)));
        });
        runTest("test_two", () -> {
            assertEq(new Solution().generate(2), Arrays.asList(Arrays.asList(1), Arrays.asList(1, 1)));
        });
        report();
    }
}$java$)
where title_slug = 'pascals-triangle';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int numSquares(int n) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().numSquares(12), 3);
            assertEq(new Solution().numSquares(13), 2);
        });
        runTest("test_one", () -> {
            assertEq(new Solution().numSquares(1), 1);
        });
        report();
    }
}$java$)
where title_slug = 'perfect-squares';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int longestValidParentheses(String s) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().longestValidParentheses("(()"), 2);
            assertEq(new Solution().longestValidParentheses(")()())"), 4);
        });
        runTest("test_empty", () -> {
            assertEq(new Solution().longestValidParentheses(""), 0);
        });
        report();
    }
}$java$)
where title_slug = 'longest-valid-parentheses';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public int minPathSum(int[][] grid) {
        return 0;
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_examples", () -> {
            assertEq(new Solution().minPathSum(new int[][]{new int[]{1, 3, 1}, new int[]{1, 5, 1}, new int[]{4, 2, 1}}), 7);
            assertEq(new Solution().minPathSum(new int[][]{new int[]{1, 2, 3}, new int[]{4, 5, 6}}), 12);
        });
        runTest("test_single", () -> {
            assertEq(new Solution().minPathSum(new int[][]{new int[]{5}}), 5);
        });
        report();
    }
}$java$)
where title_slug = 'minimum-path-sum';

update public.problems
set starter_code = coalesce(starter_code, '{}'::jsonb) || jsonb_build_object('java', $java$import java.util.*;

class Solution {
    public void nextPermutation(int[] nums) {
        
    }
}

class Main {
    static int ran = 0, failed = 0;
    static StringBuilder dots = new StringBuilder();
    static List<String> fails = new ArrayList<>();

    static void runTest(String name, Runnable r) {
        ran++;
        try { r.run(); dots.append('.'); }
        catch (AssertionError e) { failed++; dots.append('F'); fails.add("FAIL: " + name + ": " + e.getMessage()); }
        catch (Throwable t) { failed++; dots.append('E'); fails.add("ERROR: " + name + ": " + t); }
    }

    static void assertEq(Object got, Object want) {
        if (!eq(got, want)) throw new AssertionError("expected " + show(want) + " but got " + show(got));
    }

    @SuppressWarnings("unchecked")
    static List<Object> norm(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (List<Object>) o) {
            List<Object> g = new ArrayList<>((List<Object>) inner);
            g.sort(Comparator.comparing(String::valueOf));
            outer.add(g);
        }
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static boolean eq(Object a, Object b) {
        if (a == null || b == null) return a == b;
        if (a instanceof int[] && b instanceof int[]) return Arrays.equals((int[]) a, (int[]) b);
        if (a instanceof long[] && b instanceof long[]) return Arrays.equals((long[]) a, (long[]) b);
        if (a instanceof double[] && b instanceof double[]) return Arrays.equals((double[]) a, (double[]) b);
        if (a instanceof boolean[] && b instanceof boolean[]) return Arrays.equals((boolean[]) a, (boolean[]) b);
        if (a instanceof char[] && b instanceof char[]) return Arrays.equals((char[]) a, (char[]) b);
        if (a instanceof Object[] && b instanceof Object[]) return Arrays.deepEquals((Object[]) a, (Object[]) b);
        if (a instanceof int[][] && b instanceof int[][]) return Arrays.deepEquals((int[][]) a, (int[][]) b);
        if (a instanceof char[][] && b instanceof char[][]) return Arrays.deepEquals((char[][]) a, (char[][]) b);
        return a.equals(b);
    }

    static int len(Object o) {
        if (o instanceof int[]) return ((int[]) o).length;
        if (o instanceof char[]) return ((char[]) o).length;
        if (o instanceof Object[]) return ((Object[]) o).length;
        return ((Collection<?>) o).size();
    }

    static List<Integer> box(int[] a) { List<Integer> l = new ArrayList<>(); for (int x : a) l.add(x); return l; }

    @SuppressWarnings("unchecked")
    static Set<Object> toSet(Object o) {
        if (o instanceof int[]) { Set<Object> s = new HashSet<>(); for (int x : (int[]) o) s.add(x); return s; }
        return new HashSet<>((Collection<Object>) o);
    }

    @SuppressWarnings("unchecked")
    static List<Object> srt(Object o) {
        List<Object> l = (o instanceof int[]) ? new ArrayList<>(box((int[]) o)) : new ArrayList<>((Collection<Object>) o);
        l.sort(Comparator.comparing(String::valueOf));
        return l;
    }

    @SuppressWarnings("unchecked")
    static List<Object> normOuter(Object o) {
        List<Object> outer = new ArrayList<>();
        for (Object inner : (Collection<Object>) o) outer.add(new ArrayList<>((Collection<Object>) inner));
        outer.sort(Comparator.comparing(String::valueOf));
        return outer;
    }

    static String show(Object o) {
        if (o == null) return "null";
        if (o instanceof int[]) return Arrays.toString((int[]) o);
        if (o instanceof char[]) return Arrays.toString((char[]) o);
        if (o instanceof Object[]) return Arrays.deepToString((Object[]) o);
        if (o instanceof int[][]) return Arrays.deepToString((int[][]) o);
        if (o instanceof char[][]) return Arrays.deepToString((char[][]) o);
        return o.toString();
    }

    static void report() {
        System.err.println(dots.toString());
        for (String f : fails) System.err.println(f);
        System.err.println("----------------------------------------------------------------------");
        System.err.println("Ran " + ran + " test" + (ran == 1 ? "" : "s"));
        System.err.println();
        System.err.println(failed == 0 ? "OK" : "FAILED (failures=" + failed + ")");
    }

    public static void main(String[] args) {
        runTest("test_middle", () -> {
            int[] nums = new int[]{1, 2, 3};
            new Solution().nextPermutation(nums);
            assertEq(nums, new int[]{1, 3, 2});
        });
        runTest("test_wrap", () -> {
            int[] nums = new int[]{3, 2, 1};
            new Solution().nextPermutation(nums);
            assertEq(nums, new int[]{1, 2, 3});
        });
        runTest("test_with_dup", () -> {
            int[] nums = new int[]{1, 1, 5};
            new Solution().nextPermutation(nums);
            assertEq(nums, new int[]{1, 5, 1});
        });
        report();
    }
}$java$)
where title_slug = 'next-permutation';

