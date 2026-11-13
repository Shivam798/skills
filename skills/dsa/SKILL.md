---
name: dsa
description: Solve a LeetCode / DSA problem as the interview script — the solutions you should mention, in the exact order you should mention them, with full working code for every one of them and a clear marker on the single one you would write on the board. Use whenever the user pastes a LeetCode URL, a problem number, a problem title, or a raw DSA problem statement, or asks for "approaches", "optimal solution", "how do I answer this in an interview", or "interview strategy" for an algorithm problem. Default language is Java.
---

# DSA Interview Answer

Produce the **speaking order** for an interview: which solutions to mention, in
what sequence, and which single one to actually write on the board — plus
**working code for every approach**, so the reader can study each one even for
the steps they'd only say out loud.

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

## The core rule — every approach gets code, one gets the board

Two separate things, and never conflate them:

- **The label says what to do in the room.** An approach marked *say it, then
  drop it* is a sentence you speak, not something you implement live. Exactly
  **one** approach is marked **`✅ Write this`** — the one you commit to on the
  board. A *offer only if asked* step is held in reserve.
- **The code is always there anyway.** **Every step carries a full, compilable
  `class Solution`**, including the ones you'd only mention. The reader is
  studying the problem, not just rehearsing it — they need to see what the
  discarded idea actually looks like, and code they can run beats a description.

So each step has both: the spoken line (what leaves your mouth) *and* the
implementation (what it would be if you wrote it).

Total steps: **2–4**. Never include a step that teaches nothing. Order is the
deliverable: step 1 is the first thing out of your mouth, and each later step
exists because the previous one was rejected for a stated reason.

## Document format

Follow this skeleton exactly. Bold (`**`) is used aggressively in headings — that
is intentional and part of the format.

````
# **<number>. <Exact Problem Title>**

> **Pattern:** **<Pattern Name (Canonical Category)>**

---

## **1️⃣ Say it, then drop it — <Approach Name> — O(<time>) Time, O(<space>) Space**

> **▎"<What you say out loud, first person: the idea, its cost, and the reason
> you're not writing it.>"**

```java id="a1b2c3"
class Solution {
    public <returnType> <methodName>(<args>) {
        // ...
    }
}
```

**For your understanding:** <one or two sentences on how this code works and the
exact line where its weakness lives.>

---

## **2️⃣ Write this — <Approach Name> — O(<time>) Time, O(<space>) Space ✅**

<One sentence: the idea, not the code.>

```java id="d4e5f6"
class Solution {
    // ...
}
```

**Say while writing:** <the invariant, why the complexity holds, and which edge
cases this dissolves.>

---

## **3️⃣ Offer only if asked — <Approach Name> — O(<time>) Time, O(<space>) Space**

<One sentence: the idea.>

```java id="g7h8i9"
class Solution {
    // ...
}
```

**Trade-off:** <why it stays off the board even though it works.>

---

> **▎Watch for:** <the one trap or near-miss variant an interviewer probes —
> e.g. the sibling problem whose answer differs. Omit if there isn't one.>

> **▎Related problems:** <3–5 comma-separated problems drilling the same pattern.>
````

### Rules for each piece

**Title** — `# **<number>. <Title>**`, matching LeetCode's numbering and wording.

**Pattern line** — include when the problem is a clean instance of a named
technique (Monotonic Stack, Sliding Window, Two Pointers, Binary Search on
Answer, Union-Find, Prefix Sum, Backtracking, Topological Sort, …). Omit it when
the problem is a one-off construction rather than a pattern instance. Format:
`> **Pattern:** **Monotonic Stack (Next Greater Element)**`

**`---`** — a horizontal rule between every step and before the closing callouts.

**Step heading** — `## **N️⃣ <Verb phrase> — <Name> — O(x) Time, O(y) Space**`.
Use the keycap emoji digits `1️⃣ 2️⃣ 3️⃣ 4️⃣`. The verb phrase is one of exactly
three: **`Say it, then drop it`**, **`Write this`**, **`Offer only if asked`**.
Say **Extra** Space (`O(1) Extra Space`) whenever the output array is excluded
from the count. Append ` ✅` to the single `Write this` heading.

**Spoken line** — on `Say it, then drop it` steps, the blockquote comes *first*,
above the code: whole line bold, opening with `▎`, in quotes, first person, as
you'd actually say it. Ground the rejection in the real constraints — `n ≤ 10⁵` →
`O(n²)` ≈ `10¹⁰` ops → TLE. If the problem *forbids* an approach (division on
238), the spoken line is where you show you read the rules. If the brute force
would in fact pass the given limits, say so honestly and reject it on the better
reason instead.

**Prose** — on `Write this` and `Offer only if asked` steps, one sentence above
the code describing the *idea*. Never narrate the code line by line. Use inline
code for the recurrence or invariant when it sharpens things:
`` `res[i] = (product left of i) × (product right of i)` ``.

**Code block** — **required on every step, no exceptions.** Opening fence carries
a random 6-character lowercase alphanumeric id: ` ```java id="k9w4nt" `. Generate
a fresh id per block, unique within the document. Then:

- Full compilable `class Solution { ... }` with LeetCode's exact signature.
- It must actually be *correct* — a discarded approach is still code the reader
  will run, so it gets the same edge-case scrutiny as the optimal one.
- Blank lines separating logical stages — the reader is scanning, not compiling.
- Short trailing `//` comments on the lines carrying the insight, explaining
  **why**, not what. `// skip self`, `// ≥2 zeros → everything 0`,
  `// grow the running right-product`. Never comment `i++`.
- **Name every idiom the code leans on, right where it appears.** Assume the
  reader knows the language but not the trick, and never leave them to ask what a
  line is for afterwards. Anything scaffolding-shaped gets a trailing `//`:
  LeetCode's two-arg `ListNode(int val, ListNode next)` (`// val is filler; next
  = head`), a dummy/sentinel head and why the return is `dummy.next` (`// the
  real head may itself have been deleted`), the `fast.next != null &&
  fast.next.next != null` middle convention (`// slow lands on the LAST node of
  the first half`), `ArrayDeque` used as a stack, a mutable `int[1]` holder
  threaded through recursion, a `long` cast guarding overflow, an
  `Integer.MIN_VALUE` sentinel. If it doesn't fit on the line, it becomes one
  clause in the line under the code.
- No imports, no `main`, no test harness, no print statements.

**The line under the code** — one of three labels, matching the step type:

- **`For your understanding:`** (discarded steps) — how the code works, and the
  exact line or loop where the cost lives.
- **`Say while writing:`** (the written step) — the talk track. The invariant
  (what each pointer / structure holds), the one-sentence complexity
  justification ("every index is pushed once and popped once", "the inner
  `while` is amortized `O(n)`"), and the edge cases the construction dissolves
  (empty input, head deleted, all-equal, overflow). Include one clause on any
  scaffolding construct the code needed — what the sentinel buys, what the
  pointer convention guarantees — so the mechanism is never left implicit.
- **`Trade-off:`** (reserve steps) — why it works but stays off the board.

Backtick every complexity and constraint in all three.

**Closing callouts** — same `> **▎...**` form, at most two lines: a `Watch for:`
trap and a `Related problems:` list. Omit either when there's nothing real to
say. No bullet-list strategy section — the talk track already carried it.

## Correctness bar

Every code block is a deliverable — all of them must compile and pass. Before
writing each one:

- Check the edge cases the problem is really testing: empty / single element,
  all-equal, duplicates, negatives, zeros, overflow, `n == 1`.
- Verify index bounds at both ends of every loop, especially reverse sweeps.
- Confirm the stated complexity matches the code you wrote, including amortized
  arguments (a `while` inside a `for` is often still `O(n)` — if so, say why).
- Prefer `Deque`/`ArrayDeque` over `Stack`, `StringBuilder` over `+=` in loops,
  `long` where products or sums can overflow `int`.

Complexities quoted in the spoken lines must be right too — you say them out loud.

## References

Three full worked examples in the exact target format — read one before writing if
you need to calibrate tone, comment density, or spoken-line phrasing:

- `references/example-238-product-except-self.md` — three discarded steps, one of
  them a forbidden approach, no closing trap line.
- `references/example-739-daily-temperatures.md` — pattern line, one discarded
  step, plus a reserve approach after the written one.
- `references/example-82-remove-duplicates-sorted-list-ii.md` — the idiom-comment
  standard: a brute force that *would* pass the limits and is rejected on the
  better reason, and a sentinel-node solution where every piece of scaffolding
  (`ListNode(val, next)`, why `prev` stays put, why the return is `dummy.next`)
  is explained on the line it appears.
