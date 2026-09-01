# Full Post Examples

Each example shows the finished post, then what it's doing. Lengths sit in the
150-300 word range. Names and numbers are illustrative — replace with your own.

---

## 1. Story Post

> I've been wrong about remote work.
>
> Not about whether it works — it does. About what it costs, and who pays.
>
> Two years ago I argued hard for our team going fully distributed. I had the
> data: output held, retention improved, we hired in four new cities.
>
> What I missed was our juniors.
>
> Our senior engineers thrived. They already had the context, the relationships,
> the confidence to ping someone at 4pm and say "this doesn't make sense to me."
> Our juniors sat with that same confusion for three days because a Slack message
> felt like an interruption and a video call felt like an admission.
>
> The turning point was an exit interview. She said, "I never knew if I was doing
> badly or if that's just what the work feels like."
>
> We hadn't taken away her desk. We'd taken away the ambient signal that told her
> she was fine.
>
> We didn't go back to an office. We did make the invisible visible: weekly
> written feedback, explicit "you are on track" statements, a standing 30 minutes
> where interrupting me is the entire point.
>
> Remote work doesn't remove the cost of learning. It moves that cost onto the
> person least equipped to carry it, unless you deliberately move it back.
>
> If you're distributed and you have juniors: how do they find out they're doing
> okay?

**What it's doing:** honest-admission hook. One idea (remote's cost falls on
juniors), one story, one insight. The turning point is a quote, not a summary.
Closes with a question the author genuinely wants answered.

---

## 2. List Post

> The engineers who get promoted fastest aren't the strongest coders.
>
> After sitting on promotion panels for six years, the pattern is boringly
> consistent.
>
> 1. **They make their work legible.** Not louder — legible. Their PRs explain
>    the decision, not just the change.
>
> 2. **They pick problems nobody owns.** The flaky test suite. The runbook that
>    lies. Unowned problems have no competition.
>
> 3. **They finish.** Including the unglamorous 10% — the migration's last three
>    callers, the doc, the cleanup.
>
> 4. **They say the uncomfortable thing early.** "I think this estimate is
>    wrong" in week one, not week six.
>
> 5. **They make other people faster.** One person who unblocks four is worth
>    more than one person who ships alone.
>
> None of this requires being the best engineer in the room. All of it requires
> deciding that the work isn't done when the code works.
>
> Worth reviewing before your next promo cycle — not the week of.

**What it's doing:** five items, each one line of claim plus one line of
context. Bold carries the scan. The close is a specific, non-needy CTA. No
"agree?".

---

## 3. Contrarian Post

> Culture fit is the most expensive hiring filter most teams still use.
>
> The standard defense: teams that get along ship faster, and a bad personality
> match poisons a small group.
>
> That's true, and it's not what "culture fit" measures in practice.
>
> In every debrief I've run, "not a culture fit" decoded to one of three things:
> they interviewed differently than we do, they disagreed with someone senior, or
> we couldn't picture having a drink with them. None of those predict
> performance. All of them correlate with hiring people like the people already
> there.
>
> The teams I've seen get this right replaced it with two written questions: what
> specific behavior would make this person hard to work with here, and is that
> behavior something we actually need to be different?
>
> That second question is where the good hires live. The person who challenges
> decisions is "hard to work with" right up until they're the reason you didn't
> ship the wrong thing.
>
> Where the culture-fit crowd is right: values misalignment is real and it is
> expensive. Someone who treats people badly is not a diversity of thought
> problem.
>
> The fix isn't to stop screening for fit. It's to write down what you mean
> before the debrief, not after.
>
> What did "culture fit" mean the last time you heard it in a hiring loop?

**What it's doing:** position stated in line 1. Steelmans the other side before
attacking, offers a replacement mechanism rather than only criticism, and
concedes the real limit. Argues with ideas, not people.

---

## 4. Observation Post

> Every failed platform migration I've worked on failed at the same moment: the
> point where both systems are live.
>
> Four migrations, three companies. The technical work was never what killed
> them.
>
> What killed them was the dual-running period stretching from "six weeks" to
> "however long", because nobody owned the decommission. Writing the new system
> is a project with a team and a deadline. Turning the old one off is a chore
> with neither.
>
> So the old system stays. Then it gets a bug fix. Then a feature, because it's
> where the data still is. Eighteen months later you have two systems, one team,
> and a migration nobody will admit is dead.
>
> The one migration I've seen finish cleanly had a named owner for the shutdown,
> with a date, before the first line of the new system was written. That date
> moved twice. It still happened.
>
> My read: migrations don't need better plans for the build. They need someone
> whose job is the ending.
>
> Curious whether this holds outside my sample — if you've run one that landed,
> who owned turning the old thing off?

**What it's doing:** specific-observation hook with a real sample size (four,
not forty-seven). Evidence, then a mechanism for why, then an interpretation
labeled as one. Closes by inviting disconfirmation rather than agreement.

---

## Before / After

**Before**

> 🚀 Excited to announce that our team just shipped a major performance
> improvement! 🎉 We reduced our API latency by 60%! 💪
>
> Huge shoutout to the incredible team. Couldn't have done it without you! 🙌
>
> Lessons learned:
> ✅ Teamwork makes the dream work
> ✅ Never give up
> ✅ Always measure
>
> Agree? Comment YES if you've been through this! 👇
>
> #engineering #performance #teamwork #leadership #startup #tech #innovation
> #growth #success #motivation

Problems: announcement hook, emoji strings, three unrelated lessons in one post,
platitudes, engagement bait close, hashtag stuffing.

**After**

> We cut API latency 60% last month. The fix had nothing to do with the API.
>
> We spent three weeks profiling handlers. Shaved 40ms. Real, and irrelevant.
>
> The actual cost was a config default nobody had read since 2021: our connection
> pool was sized for a service that no longer existed. Under load we spent more
> time waiting for connections than serving requests.
>
> One line. 60%.
>
> What bothers me isn't that we missed it. It's that we spent three weeks looking
> where the work felt like engineering, instead of where the evidence pointed on
> day one.
>
> Before you optimize anything: what have you not measured because measuring it
> felt too boring to count as work?
>
> #engineering #performance

Fixes: unexpected-angle hook, one idea, the insight is about the author's own
process, honest close, two hashtags at the end.
