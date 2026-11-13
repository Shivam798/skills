# **238. Product of Array Except Self**

---

## **1️⃣ Say it, then drop it — Brute Force — O(n²) Time, O(1) Extra Space**

> **▎"The direct version is: for each index, walk the whole array multiplying
> every other element. That's `O(n²)`, and with `n` up to `10⁵` that's `~10¹⁰`
> operations — TLE. It's recomputing the same overlapping products over and over,
> so I want to compute each partial product once."**

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

**For your understanding:** the inner loop is the whole cost — it rebuilds a product of `n - 1` elements from scratch for every one of the `n` indices, even though consecutive indices share all but two factors.

---

## **2️⃣ Say it, then drop it — Division — O(n) Time, O(1) Extra Space**

> **▎"If division were allowed I'd take the product of everything once and divide
> out `nums[i]`. But the problem explicitly forbids division, and zeros force
> special-casing anyway — no zeros, one zero, and two-or-more zeros are three
> different branches. So I'll build it from prefix and suffix products instead."**

```java id="k9w4nt"
class Solution {
    public int[] productExceptSelf(int[] nums) {
        int total = 1, zeros = 0;

        for (int x : nums) {
            if (x == 0) {
                zeros++;
            } else {
                total *= x; // product of non-zero elements only
            }
        }

        int n = nums.length;
        int[] res = new int[n];

        for (int i = 0; i < n; i++) {
            if (zeros > 1) {
                res[i] = 0;                          // ≥2 zeros → everything 0
            } else if (zeros == 1) {
                res[i] = (nums[i] == 0) ? total : 0;  // only the zero slot survives
            } else {
                res[i] = total / nums[i];
            }
        }

        return res;
    }
}
```

**For your understanding:** note that `total` deliberately skips zeros — you can't divide by `0`, which is why the zero count has to be tracked separately and branched on. Mentioning this approach and rejecting it is what proves you read the constraint.

---

## **3️⃣ Say it, then drop it — Prefix & Suffix Arrays — O(n) Time, O(n) Space**

> **▎"`res[i] = (product of everything left of i) × (product of everything right
> of i)`. I can precompute both directions into two arrays and multiply them
> pairwise — clean `O(n)`, no division. But that's two extra arrays, and the
> problem asks for `O(1)` extra space, so I'll fold both sweeps into the output
> array itself."**

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

**For your understanding:** this is the right idea already — the only waste is `suf`, since the suffix product is consumed in a single right-to-left sweep and never needs to be stored for more than one index at a time.

---

## **4️⃣ Write this — Prefix + Running Suffix — O(n) Time, O(1) Extra Space ✅**

Store prefix products directly in `res`, then sweep right to left maintaining a running suffix product.

```java id="p7c5zr"
class Solution {
    public int[] productExceptSelf(int[] nums) {
        int n = nums.length;
        int[] res = new int[n];   // the output itself — never counted as extra space

        res[0] = 1;               // nothing sits left of index 0
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

**Say while writing:** after the first loop `res[i]` holds the product of everything strictly left of `i`; the second loop multiplies in the product of everything strictly right of `i`, carried in the scalar `suffix`. Two linear passes, so `O(n)`, and the output array doesn't count toward space — `O(1)` extra. No division means zeros need no special-casing at all: an index whose value is `0` still gets a correct product, and two zeros make every entry `0` automatically.

> **▎Related problems:** Trapping Rain Water, Maximum Product Subarray, Subarray Sum Equals K, Range Sum Query — Immutable.
