# **739. Daily Temperatures**

> **Pattern:** **Monotonic Stack (Next Greater Element)**

---

## **1️⃣ Brute Force — O(n²) Time, O(1) Space**

For each day, scan forward until you find a warmer day.

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

> **▎With `n ≤ 10⁵`, `O(n²)` becomes roughly `10¹⁰` operations, leading to TLE. We're repeatedly rescanning the same future days.**

---

## **2️⃣ Monotonic Stack — O(n) Time, O(n) Space ✅ Optimal**

Maintain a **monotonically decreasing stack of indices**. Whenever a warmer temperature appears, it resolves all colder days waiting on the stack.

```java id="k5p7mt"
class Solution {
    public int[] dailyTemperatures(int[] temperatures) {
        int n = temperatures.length;

        int[] ans = new int[n];                    // default 0 = no warmer day
        Deque<Integer> stack = new ArrayDeque<>(); // stores indices

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

> **▎Optimal. Every index is pushed exactly once and popped at most once, so the total work is `O(n)` despite the nested `while` loop.**

---

## **3️⃣ Backward DP / Array Jump — O(n) Time, O(1) Extra Space**

Traverse from right to left. Instead of checking every future day, use the already-computed answers to **jump directly** to the next candidate.

```java id="t4n9qp"
class Solution {
    public int[] dailyTemperatures(int[] temperatures) {
        int n = temperatures.length;
        int[] ans = new int[n];

        for (int i = n - 2; i >= 0; i--) {
            int j = i + 1;

            while (j < n && temperatures[j] <= temperatures[i]) {
                if (ans[j] == 0) {
                    j = n;              // no warmer day exists for j
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

> **▎Same `O(n)` time (amortized through jumps) while using only `O(1)` extra space beyond the output array. Clever, but less intuitive than the monotonic-stack solution, so the stack approach is generally preferred in interviews.**

---

## **Interview Strategy**

* **Recognize the pattern:** **Next Greater Element → Monotonic Stack.**
* Explain that the stack stores **indices whose next warmer day hasn't been found yet**.
* When a warmer temperature arrives, it **resolves** all colder days on top of the stack.
* Justify `O(n)` by noting that **every index is pushed once and popped once**.

> **▎Related problems:** Next Greater Element I, Next Greater Element II, Stock Span, Trapping Rain Water, Largest Rectangle in Histogram.
