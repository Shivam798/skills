# **82. Remove Duplicates from Sorted List II**

> **Pattern:** **Sentinel Node + Block Skip (Linked List In-Place Deletion)**

---

## **1️⃣ Say it, then drop it — Frequency Map, Then Rebuild — O(n) Time, O(n) Space**

> **▎"I could count every value in a `HashMap` on one pass, then walk again and
> keep only the nodes whose count is `1`. That's `O(n)` time, and with `n ≤ 300`
> it would pass comfortably — I'm not rejecting it for speed. I'm rejecting it
> because it costs `O(n)` extra space and completely ignores the fact that the
> list is already sorted, which means duplicates are contiguous and I can splice
> them out in place."**

```java id="w4m8qv"
class Solution {
    public ListNode deleteDuplicates(ListNode head) {
        Map<Integer, Integer> count = new HashMap<>();

        for (ListNode cur = head; cur != null; cur = cur.next) {
            count.merge(cur.val, 1, Integer::sum);   // val -> how many nodes carry it
        }

        ListNode dummy = new ListNode(0);            // sentinel, so "is this the first survivor?" needs no branch
        ListNode tail = dummy;

        for (ListNode cur = head; cur != null; cur = cur.next) {
            if (count.get(cur.val) == 1) {
                tail.next = cur;                     // relink the survivor
                tail = cur;
            }
        }

        tail.next = null;                            // cut whatever the last survivor still pointed at
        return dummy.next;                           // dummy.next is the real head
    }
}
```

**For your understanding:** the map is the entire objection — it stores a counter per distinct value purely to learn something the sorted order already tells you for free. The `tail.next = null` is not optional: without it the last kept node still points into the deleted suffix.

---

## **2️⃣ Write this — Sentinel + Skip the Whole Duplicate Block — O(n) Time, O(1) Space ✅**

Anchor a fake node in front of the list, then whenever `cur` starts a run of equal values, walk `cur` past the entire run and splice it out without moving the anchor.

```java id="p9r3nz"
class Solution {
    public ListNode deleteDuplicates(ListNode head) {
        ListNode dummy = new ListNode(0, head);   // ListNode(val, next): 0 is filler, next = head
        ListNode prev = dummy;                    // last node confirmed unique
        ListNode cur = head;

        while (cur != null) {
            if (cur.next != null && cur.next.val == cur.val) {
                int dup = cur.val;

                while (cur != null && cur.val == dup) {
                    cur = cur.next;               // walk off the ENTIRE duplicate block
                }

                prev.next = cur;                  // splice the block out; prev deliberately stays put
            } else {
                prev = cur;                       // cur survives, so it becomes the new anchor
                cur = cur.next;
            }
        }

        return dummy.next;                        // the real head may itself have been deleted
    }
}
```

**Say while writing:** the invariant is that everything from `dummy` up to `prev` is final, and `prev.next` is always rewritten rather than trusted — that's what lets a whole block vanish in one assignment. The sentinel is the whole reason there's no special case for "the first value is the duplicate": deleting the real head is just `dummy.next = cur`, which is also why the return is `dummy.next` and not `head`. `cur` only ever moves forward, so despite the nested `while` every node is visited once — `O(n)`, with three pointers of extra space. Empty list, all-equal (`[1,1,1]` → empty), and head-deleted all fall out of the same two branches.

---

## **3️⃣ Offer only if asked — Recursion — O(n) Time, O(n) Space (stack)**

Decide the fate of the head only, then let the recursive call return an already-cleaned tail to attach.

```java id="h6t2kx"
class Solution {
    public ListNode deleteDuplicates(ListNode head) {
        if (head == null || head.next == null) return head;

        if (head.val == head.next.val) {
            int dup = head.val;

            while (head != null && head.val == dup) {
                head = head.next;                  // drop the whole block
            }

            return deleteDuplicates(head);         // nothing kept here — restart on the remainder
        }

        head.next = deleteDuplicates(head.next);   // head is unique: keep it, clean the tail
        return head;
    }
}
```

**Trade-off:** shorter and it needs no sentinel at all, since "the head was deleted" is expressed by returning a different node. But the stack depth is `O(n)` — fine at `n ≤ 300`, a real overflow risk if the same code is reused on a long list — so it stays the follow-up, not the board answer.

> **▎Watch for:** the sibling problem, **83. Remove Duplicates from Sorted List**, which *keeps* one copy of each value. There the answer is `cur.next = cur.next.next` on a match and no sentinel is needed at all, because the head always survives. Reaching for the block-skip loop on 83 is the classic over-solve.

> **▎Related problems:** Remove Duplicates from Sorted List, Remove Linked List Elements, Remove Nth Node From End of List, Partition List, Reorder List.
