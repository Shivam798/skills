---
name: dsa
description: Solve a LeetCode / DSA problem as a graded ladder of approaches in the exact order you would present them in an interview — brute force first, then each refinement, ending at the optimal. Use whenever the user pastes a LeetCode URL, a problem number, a problem title, or a raw DSA problem statement, or asks for "approaches", "optimal solution", "how do I answer this in an interview", or "interview strategy" for an algorithm problem. Default language is Java.
---

# DSA Interview Answer

Turn any DSA problem into the answer you would actually give in an interview: a
ladder of approaches, worst to best, each one motivated by the specific weakness
of the one before it.

The output is a **single markdown document**. No preamble, no "Here's the
solution!", no closing chatter. Start at the `#` title and stop at the last line
of the document.

## Input

Any of: a LeetCode URL, a problem number (`238`), a title (`Product of Array
Except Self`), or a pasted problem statement.

If given only a number or title, solve it from knowledge. If anything about the
problem is genuinely ambiguous (unclear constraints, multiple problems share the
title), state the assumption in one line under the title and solve anyway — do
not stop to ask.

**Language:** Java by default. If the user names another language, use that one
throughout and keep every other rule identical.

## The ladder — the core idea

Approaches are ordered **worst to best**, and each one exists because it fixes a
concrete flaw in its predecessor. The reader should never wonder "why are we
moving on?" — the callout after each approach tells them.

Include an approach when it:

- is what an interviewer expects you to say first (**always** open with brute force),
- shows you noticed a constraint (a solution the problem *forbids* — e.g. division
  on 238 — is worth showing precisely because rejecting it proves you read the rules),
- is a real intermediate step (extra arrays → same idea done in `O(1)` space),
- is a legitimate alternative to the optimal with a different trade-off.

Typical count is **2–4**. Never pad the ladder with a variant that teaches nothing.
Mark exactly one approach `✅ Optimal` — the one you would actually write in the
interview. If a later approach beats it on space but is harder to derive under
pressure, keep the ✅ on the interview-preferred one and say so in its callout
(see approach 3 of the 739 reference).

## Document format

Follow this skeleton exactly. Bold (`**`) is used aggressively in headings — that
is intentional and part of the format.

````
# **<number>. <Exact Problem Title>**

> **Pattern:** **<Pattern Name (Canonical Category)>**

---

## **1️⃣ <Approach Name> — O(<time>) Time, O(<space>) Space**

<One or two plain sentences: the idea, not the code.>

```java id="a1b2c3"
class Solution {
    public <returnType> <methodName>(<args>) {
        // ...
    }
}
```

> **▎<Why this is not the answer — the cost, the failure, the waste — and the hint toward the next approach.>**

---

## **2️⃣ <Approach Name> — O(<time>) Time, O(<space>) Space ✅ Optimal**

...

---

## **Interview Strategy**

* **Recognize the pattern:** **<trigger → technique>.**
* <What the data structure holds / what the invariant is.>
* <The key insight that makes it work.>
* <How to justify the complexity out loud.>

> **▎Related problems:** <3–5 comma-separated problems drilling the same pattern.>
````

### Rules for each piece

**Title** — `# **<number>. <Title>**`, matching LeetCode's numbering and wording.

**Pattern line** — include when the problem is a clean instance of a named
technique (Monotonic Stack, Sliding Window, Two Pointers, Binary Search on
Answer, Union-Find, Prefix Sum, Backtracking, Topological Sort, …). Omit it when
the problem is a one-off construction rather than a pattern instance. Format:
`> **Pattern:** **Monotonic Stack (Next Greater Element)**`

**`---`** — a horizontal rule between every approach and before Interview Strategy.

**Approach heading** — `## **N️⃣ <Name> — O(x) Time, O(y) Space**`. Use the keycap
emoji digits `1️⃣ 2️⃣ 3️⃣ 4️⃣`. Say **Extra** Space (`O(1) Extra Space`) whenever the
output array is excluded from the count. Append ` ✅ Optimal` to exactly one heading.

**Prose** — one or two sentences above the code, describing the *idea*. Never
narrate the code line by line. Use inline code for the recurrence or invariant
when it sharpens things: `` `res[i] = (product left of i) × (product right of i)` ``.

**Code block** — opening fence carries a random 6-character lowercase
alphanumeric id: ` ```java id="k9w4nt" `. Generate a fresh id per block, unique
within the document. Then:

- Full compilable `class Solution { ... }` with LeetCode's exact signature.
- Blank lines separating logical stages — the reader is scanning, not compiling.
- Short trailing `//` comments on the lines carrying the insight, explaining
  **why**, not what. `// skip self`, `// ≥2 zeros → everything 0`,
  `// grow the running right-product`. Never comment `i++`.
- No imports, no `main`, no test harness, no print statements.

**Transition callout** — a blockquote immediately after the code, whole line bold,
opening with `▎`:

`> **▎Rescanning the array for every index is `O(n²)` → TLE for `n` up to `10⁵`. We're recomputing overlapping products.**`

This is the load-bearing part of the format. Each callout must do one job:

- *Non-optimal:* name the concrete cost and why it disqualifies the approach.
  Ground it in the real constraints — `n ≤ 10⁵` → `O(n²)` ≈ `10¹⁰` ops → TLE.
  Then point at what to fix, so the next heading feels inevitable.
- *Optimal:* say what it achieves and which pitfalls it dissolves — "no division,
  and naturally handles zeros without any special cases."
- *Post-optimal alternative:* give the trade-off honestly and state which one to
  write in an interview.

Backtick every complexity and constraint inside callouts.

**Interview Strategy** — closing section, `*` bullets, only for problems with a
transferable pattern. Cover: the trigger→technique mapping, what the structure
holds, the key invariant, and the one-sentence complexity justification (e.g.
"every index is pushed once and popped once"). Close with the related-problems
callout, same `> **▎...**` form.

## Correctness bar

The code is the deliverable — it must compile and pass. Before writing each block:

- Check the edge cases the problem is really testing: empty / single element,
  all-equal, duplicates, negatives, zeros, overflow, `n == 1`.
- Verify index bounds at both ends of every loop, especially reverse sweeps.
- Confirm the stated complexity matches the code you wrote, including amortized
  arguments (a `while` inside a `for` is often still `O(n)` — if so, say why).
- Prefer `Deque`/`ArrayDeque` over `Stack`, `StringBuilder` over `+=` in loops,
  `long` where products or sums can overflow `int`.

## References

Two full worked examples in the exact target format — read one before writing if
you need to calibrate tone, comment density, or callout phrasing:

- `references/example-238-product-except-self.md` — 4-rung ladder, includes a
  deliberately forbidden approach, no Interview Strategy section.
- `references/example-739-daily-temperatures.md` — pattern line, ✅ not on the
  final rung, full Interview Strategy section.
