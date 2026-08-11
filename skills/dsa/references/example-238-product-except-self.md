# **238. Product of Array Except Self**

---

## **1️⃣ Brute Force — O(n²) Time, O(1) Extra Space**

For each index, walk the whole array multiplying every other element.

```java id="r6m2qp"
class Solution {
    public int[] productExceptSelf(int[] nums) {
        int n = nums.length;
        int[] res = new int[n];

        for (int i = 0; i < n; i++) {
            int prod = 1;

            for (int j = 0; j < n; j++) {
                if (j != i) prod *= nums[j]; // skip self
            }

            res[i] = prod;
        }

        return res;
    }
}
```

> **▎Rescanning the array for every index is `O(n²)` → TLE for `n` up to `10⁵`. We're recomputing overlapping products.**

---

## **2️⃣ Division — O(n) Time, O(1) Extra Space (but disallowed)**

Multiply everything once, then divide out each element.

```java id="k9w4nt"
class Solution {
    public int[] productExceptSelf(int[] nums) {
        int total = 1, zeros = 0;

        for (int x : nums) {
            if (x == 0) {
                zeros++;
            } else {
                total *= x; // product of non-zero elements
            }
        }

        int n = nums.length;
        int[] res = new int[n];

        for (int i = 0; i < n; i++) {
            if (zeros > 1) {
                res[i] = 0; // ≥2 zeros → everything 0
            } else if (zeros == 1) {
                res[i] = (nums[i] == 0) ? total : 0; // only the zero slot survives
            } else {
                res[i] = total / nums[i];
            }
        }

        return res;
    }
}
```

> **▎`O(n)` and simple, but the problem forbids division—and zeros force ugly special-casing. Shows you spotted the constraint.**

---

## **3️⃣ Prefix & Suffix Arrays — O(n) Time, O(n) Space**

`res[i] = (product of everything left of i) × (product of everything right of i)`. Precompute both directions.

```java id="v3x8hm"
class Solution {
    public int[] productExceptSelf(int[] nums) {
        int n = nums.length;

        int[] pre = new int[n];
        int[] suf = new int[n];
        int[] res = new int[n];

        pre[0] = 1;
        for (int i = 1; i < n; i++) {
            pre[i] = pre[i - 1] * nums[i - 1]; // product of all to the left
        }

        suf[n - 1] = 1;
        for (int i = n - 2; i >= 0; i--) {
            suf[i] = suf[i + 1] * nums[i + 1]; // product of all to the right
        }

        for (int i = 0; i < n; i++) {
            res[i] = pre[i] * suf[i];
        }

        return res;
    }
}
```

> **▎No division, clean `O(n)`—but requires two extra arrays. We can fold both into the output array itself.**

---

## **4️⃣ Prefix + Running Suffix — O(n) Time, O(1) Extra Space ✅ Optimal**

Store prefix products directly in `res`, then sweep from right to left while maintaining a running suffix product.

```java id="p7c5zr"
class Solution {
    public int[] productExceptSelf(int[] nums) {
        int n = nums.length;
        int[] res = new int[n];

        res[0] = 1;
        for (int i = 1; i < n; i++) {
            res[i] = res[i - 1] * nums[i - 1]; // product of everything left of i
        }

        int suffix = 1;

        for (int i = n - 1; i >= 0; i--) {
            res[i] *= suffix;   // left-product × right-product
            suffix *= nums[i];  // grow the running right-product
        }

        return res;
    }
}
```

> **▎Optimal: `O(1)` extra space (the output array doesn't count), no division, and naturally handles zeros without any special cases.**
