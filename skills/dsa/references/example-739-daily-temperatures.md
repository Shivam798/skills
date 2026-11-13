# **739. Daily Temperatures**

> **Pattern:** **Monotonic Stack (Next Greater Element)**

---

## **1️⃣ Say it, then drop it — Brute Force — O(n²) Time, O(1) Space**

> **▎"The obvious version is: for each day, scan forward until I hit a warmer
> temperature. That's `O(n²)`, and with `n ≤ 10⁵` it's `~10¹⁰` operations — TLE.
> It rescans the same future days for every index, so I want a structure that
> remembers the days still waiting for an answer."**

```java id="m8q2vx"
class Solution {
    public int[] dailyTemperatures(int[] temperatures) {
        int n = temperatures.length;
        int[] ans = new int[n];

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                if (temperatures[j] > temperatures[i]) {
                    ans[i] = j - i; // days waited
                    break;
                }
            }
        }

        return ans;
    }
}
```

**For your understanding:** the `break` makes each scan stop early, but on a long descending run every day still scans to the end of the array — that's the `O(n²)` worst case, and nothing learned in one scan is reused by the next.

---

## **2️⃣ Write this — Monotonic Stack — O(n) Time, O(n) Space ✅**

Keep a **monotonically decreasing stack of indices**; a warmer temperature resolves every colder day waiting on top of it.

```java id="k5p7mt"
class Solution {
    public int[] dailyTemperatures(int[] temperatures) {
        int n = temperatures.length;

        int[] ans = new int[n];                    // default 0 = no warmer day
        Deque<Integer> stack = new ArrayDeque<>(); // holds indices; ArrayDeque as a stack — push/pop/peek all hit the head

        for (int i = 0; i < n; i++) {
            while (!stack.isEmpty() &&
                   temperatures[i] > temperatures[stack.peek()]) {

                int prev = stack.pop();
                ans[prev] = i - prev;              // days waited
            }

            stack.push(i);
        }

        return ans;
    }
}
```

**Say while writing:** the stack holds indices whose next warmer day hasn't been found yet, and it's decreasing by construction. When day `i` is warmer than the top, it *is* that day's answer, so I pop and record `i - prev`. Every index is pushed exactly once and popped at most once, so despite the nested `while` the total work is `O(n)`. Days still on the stack at the end keep their default `0`.

---

## **3️⃣ Offer only if asked — Backward Jump / DP — O(n) Time, O(1) Extra Space**

Sweep right to left and use the already-computed answers to jump straight to the next candidate instead of scanning.

```java id="t4n9qp"
class Solution {
    public int[] dailyTemperatures(int[] temperatures) {
        int n = temperatures.length;
        int[] ans = new int[n];

        for (int i = n - 2; i >= 0; i--) {
            int j = i + 1;

            while (j < n && temperatures[j] <= temperatures[i]) {
                if (ans[j] == 0) {
                    j = n;              // sentinel: no warmer day for j, so none for i either
                    break;
                }

                j += ans[j];            // jump ahead
            }

            if (j < n) {
                ans[i] = j - i;
            }
        }

        return ans;
    }
}
```

**Trade-off:** same `O(n)` amortized time with `O(1)` extra space beyond the output, but the jump argument is far harder to justify under pressure than "pushed once, popped once" — lead with the stack and keep this in reserve.

> **▎Related problems:** Next Greater Element I, Next Greater Element II, Stock Span, Trapping Rain Water, Largest Rectangle in Histogram.
