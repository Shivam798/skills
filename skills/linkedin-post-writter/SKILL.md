---
name: linkedin-post-writter
description: Create engaging, authentic LinkedIn posts like a Top Voice. Use this skill when asked to write LinkedIn content, social media posts for LinkedIn, professional thought leadership content, or help with LinkedIn engagement strategy. Triggers include requests for LinkedIn posts, professional social content, thought leadership pieces, or viral/engaging LinkedIn content.
---

# LinkedIn Post Writer

Create engaging, authentic LinkedIn posts that drive meaningful engagement and
establish thought leadership.

## Inputs

The request may carry any of these. All are optional except the topic.

```
<topic, or the file being attached>
format: story | list | contrarian | observation
include my experience: <one real detail>
examples: <the real-world example(s) to use>
```

### When the user passes them

**`format:`** — use it. Execute that format as well as it can be executed, but do
not silently switch to a different one. If a different format would clearly reach
further, write the one they asked for anyway and add a single line to the end of
`Do these:` saying which format you'd test against it.

**`include my experience:`** — build the post around it, usually in the hook or
right after it, because a specific real detail is the strongest opening LinkedIn
has. Keep the facts exactly as given. Sharpen the wording, never the claim: do not
round numbers up, add a company name, invent a colleague, or stretch "a few weeks"
into "months". If the detail is thin, ask one question to get the missing piece
rather than filling it in.

**`examples:`** — use every one they listed, by name. These are the concrete
anchors the reader recognises — a product they use daily, a company that published
the number, a failure that made the news — so give each one a real line rather
than a passing mention. Verify anything you state as fact about them; if you
cannot confirm a detail, use the example without that detail instead of guessing.
Do not pad the list with examples of your own on top of theirs.

### When the user passes nothing

**Format** — choose the one that will reach furthest for that specific topic and
audience, and just write it. Rough guide:

| Topic shape | Format that usually reaches furthest |
|---|---|
| A thing that broke, a decision, a mistake | Story |
| A guide, framework, or attached document | List |
| Advice everyone repeats that is wrong | Contrarian |
| A pattern across many companies or repos | Observation |

**Experience** — leave it out. Write the post so it stands on the substance alone.
Never invent a personal anecdote, a timeframe, a number, or an "it happened to me
last week" to fill the gap; a fabricated detail is the one thing that ends a
person's credibility when someone asks about it in the comments.

**Examples** — use the minimum the post needs to land, usually one: the single
thing the reader already touches every day. Do not stack three more on top to look
thorough; each extra example costs a reader and adds nothing the first one didn't
already do. Hold the rest back and offer them instead of spending them.

If the chosen format genuinely needs a personal anchor to work, write the line as
a visible placeholder — `[the moment this happened to you]` — so the user fills it
in themselves, and say so in one line at the end of `Do these:`.

### Remind them how to steer it

One post per request — this skill is not for batching. If the user wants a
different angle they ask again, and the second attempt is better for having seen
the first.

The first time you write a post in a conversation, add this as the last line of
`Do these:`

```
- Want a different angle? Steer it with "format:", "examples:" or "include my experience: <detail>"
```

Drop that line on later posts in the same conversation — they know by then.

## Output Format (follow this every time)

The user is going to copy the post straight into LinkedIn. Make the copy boundary
unmistakable and keep everything else short.

### 1. The post body goes between two `---` rules

Nothing else may appear between them — no commentary, no notes, no headings. The
text between the rules is exactly what gets pasted, hashtags included.

```
---
[hook line]

[body]

#Hashtag #Hashtag #Hashtag
---
```

Write the post as plain text with real line breaks. Do not wrap it in a code
fence, do not use markdown bold/italics/bullets inside it — LinkedIn renders none
of that, and `**asterisks**` paste through as literal characters. Use emoji or a
leading dash if a list needs visual markers.

Do not print a character count, a hook-length note, or any other stat about the
post. Check the limits yourself while writing — the hook must clear the
~210-character "see more" cut and the whole post must sit under 3,000 characters —
but keep that work silent. The user wants the post, not the measurements.

### 2. Everything else is a short action list, not an essay

After the post, give only what the user has to *do* — no research write-ups, no
tables of algorithm findings, no explaining the reasoning back to them. Aim for
six lines or fewer:

```
Do these:
- Post Tue-Thu, 12 PM or 5 PM (document posts peak there)
- Upload the PDF natively - no link anywhere in the body
- Drop your first comment within 60 seconds
- Reply to every comment for the first 90 minutes
- Leave 3-5 comments on other posts just before you publish
```

Do not volunteer a first comment, a follow-up comment, or alternate versions of
the post. One post is the deliverable. Write those only if the user asks for
them, and then put each in its own `---` block.

### 3. The answer contains these two things and nothing else

A complete answer is one `---` post block, then the `Do these:` list. That is the whole response. Do not add:

- an intro line before the post ("Here's the post", "Updated version below")
- a note on what you changed or why
- character counts, hook-length notes, or any other stat
- a first comment, alternate hooks, or variants
- research summaries, sources, or algorithm explanations
- a closing question, suggestion, or offer to tweak anything

Say nothing after the last bullet of `Do these:`. The narrow exceptions above —
a format you'd test instead, a placeholder the user must fill, the offer of more
options — belong inside that list as one bullet each, not as prose after it.

If something genuinely blocks the work — a fact you would otherwise have to invent
— ask that one question instead of guessing, and ask it on its own with no post
attached.

## Core Principles

### Authenticity Over Performance

LinkedIn has matured. Readers can spot manufactured vulnerability and engagement
bait instantly. The posts that resonate now are genuinely useful or genuinely
human — not optimized for virality.

**What works:**

- Real experiences with honest reflection
- Specific insights from your actual work
- Admitting what you don't know
- Sharing without needing validation

**What doesn't:**

- Performed vulnerability for engagement
- Stories that feel too perfectly structured
- Lessons that sound like motivational posters

### One Idea Per Post

The biggest mistake is cramming multiple tips, stories, or angles into one post.
Focus on:

- One core idea
- One story
- One insight
- One lesson

If you have five points, that's five posts.

### Value Without Strings

Every post must educate, inspire, or entertain. Ask: *"Would I find this
valuable if a stranger posted it?"* Not *"Will this get engagement?"*

## Building Your Signature Voice

Top Voices don't just post well — they're recognizable. Their perspective,
style, and focus areas are consistent.

### Define Your POV

Answer these before writing:

- What topic do I have genuine expertise in?
- What's my contrarian belief in my industry?
- What perspective do I bring that others don't?
- What would I want to be known for saying?

### Consistency Markers

Develop 2-3 recognizable elements:

- A recurring theme or topic area
- A consistent tone (analytical, warm, direct, witty)
- A signature format you're known for
- Phrases or frameworks you've coined

### Voice Calibration

Your LinkedIn voice should be:

- More polished than a text to a friend
- Less formal than a company memo
- As smart as your best work conversations
- As human as your real personality

## Post Anatomy

### The Hook (Lines 1-2)

The first 2-3 lines appear before "See more" and determine everything.

**Modern hooks that work** (avoid overused patterns):

| Type | Example | Why It Works |
|---|---|---|
| Honest admission | "I've been wrong about remote work." | Genuine, not performed |
| Specific observation | "I've noticed something in every founder who scaled past $10M." | Credibility + curiosity |
| Direct challenge | "Most career advice optimizes for the wrong thing." | Provokes thought |
| Unexpected angle | "The best hire I made had the worst resume." | Subverts expectations |
| Simple truth | "Nobody talks about how lonely leadership is." | Resonates emotionally |

**Hooks to retire:**

- "This one thing made me $X" (feels like a scam ad)
- "The CEO pulled me aside and said..." (overused curiosity bait)
- "I'm excited to announce..." (corporate and skippable)
- "[Number] words that changed my life" (too formulaic)

See `references/hooks.md` for comprehensive examples.

### The Body

**Structure for scannability:**

- Short paragraphs (1-3 sentences max)
- Line breaks between thoughts
- Bullet points for lists (but don't overuse)
- Bold for emphasis sparingly

**Storytelling framework:**

1. Set the scene (briefly — one sentence)
2. Introduce tension or conflict
3. Show the turning point
4. Deliver the insight
5. Make it applicable to the reader

### The Close

End with purpose, not desperation.

**Good closes:**

- Genuine question that invites perspective
- Specific call to action ("Bookmark this for your next negotiation")
- Reflection that lingers ("Something to sit with this week")

**Avoid:**

- "Agree?" (lazy)
- "Comment YES if..." (engagement bait)
- "Share this with someone who needs it" (needy)
- "Follow me for more" (salesy)

### The closing question must be effortless to answer

This is the line that generates the early comments reach depends on, so it gets
written as carefully as the hook. Two tests it has to pass:

**1. Can someone answer it without thinking?** If the reader has to search their
memory, reconstruct an example, or re-read the question, they scroll instead. A
question phrased around something they *stopped* noticing, *hadn't* considered, or
*didn't* realise is asking for recall they don't have on demand — it reads clever
and performs badly.

- Weak: "Which limit do you hit so often that you'd stopped noticing someone chose it?"
- Strong: "What's the most annoying rate limit you deal with?"

**2. Does it give them a way to sound smart?** The best closers offer a small,
low-risk call the reader can make in public. Guesses invite corrections,
corrections invite replies, and replies are what turn three comments into thirty.

- Better still: "What's the most annoying limit you deal with — and do you reckon it's a bucket or a window?"

**Cut the throat-clearing.** "Genuinely curious:", "Curious whether...", "Honest
question:", "Am I the only one who..." are filler that protest slightly too much.
Ask the question directly; one short sentence beats a hedged two.

Keep it to one question. Two questions in a close means most people answer
neither.

## Vulnerability Done Right

Authentic sharing builds connection. Performed vulnerability destroys trust.

### Strategic Vulnerability vs. Exploitation

**Share when:**

- The experience taught you something others can learn
- You've processed it enough to offer perspective
- It serves the reader, not your need for validation
- Time has passed and you have hindsight

**Don't share when:**

- The wound is still fresh
- You're seeking sympathy, not providing value
- It could harm others involved
- It feels performative even to you

### The Vulnerability Test

Before posting something personal, ask:

1. Am I sharing this to help others or to process my own feelings?
2. Would I be comfortable if this went viral?
3. Does this include genuine insight or just pain?
4. Have I protected others who were involved?

## Post Formats

### Story Post

**Best for:** Personal experiences, lessons learned, career moments

```
[Hook - honest admission or surprising outcome]

[One sentence of context]

[What happened - the tension or challenge]

[The turning point]

[What you learned]

[Question or reflection for reader]
```

### List Post

**Best for:** Frameworks, actionable advice, curated insights

```
[Hook - clear value promise]

[Why this matters - one sentence]

1. [Point with brief context]
2. [Point with brief context]
3. [Point with brief context]
(3-7 items max)

[Closing insight or question]
```

### Contrarian Post

**Best for:** Challenging conventional wisdom (with substance)

```
[Your contrarian position, stated directly]

[The common belief you're challenging]

[Your reasoning - why you see it differently]

[Evidence or experience]

[Nuanced conclusion - acknowledge complexity]

[Invite discussion]
```

**Contrarian guardrails:**

- Have genuine expertise on the topic
- Argue against ideas, not people
- Offer an alternative, not just criticism
- Acknowledge what the other side gets right
- Be open to being wrong

### Observation Post

**Best for:** Industry insights, trends, patterns you've noticed

```
[What you've observed]

[Specific evidence or examples]

[Why it matters]

[Your interpretation]

[Question to test if others see it too]
```

## Media Formats

Text-only posts aren't the only option. Different formats serve different
purposes.

### Document/Carousel Posts

- Higher save rates and extended engagement
- Best for: step-by-step guides, frameworks, before/after
- Keep to 5-10 slides
- Each slide should stand alone
- End with a summary or CTA slide

### Image Posts

- Use when visual adds genuine value (charts, diagrams, photos from events)
- Avoid: stock photos, generic graphics, memes (unless that's your brand)
- Native uploads outperform links

### Polls

- Good for: genuine market research, sparking discussion
- Bad for: obvious questions, engagement farming
- Always follow up with your take on the results

### Video

- LinkedIn favors native video over links
- Keep under 90 seconds for most content
- Captions are essential (most watch muted)
- Face-to-camera builds personal connection

## Engagement Strategy

What happens after you post matters as much as what you post.

### The First Hour

LinkedIn's algorithm weighs early engagement heavily:

- Respond to every comment in the first 60 minutes
- Ask follow-up questions to extend conversations
- Thank people genuinely, not generically

### Comment Quality

Your comments on others' posts build your brand too:

- Add insight, not just agreement
- Share relevant experience
- Ask thoughtful follow-up questions
- Avoid "Great post!" without substance

### What Not to Do

- Engagement pods (LinkedIn detects and penalizes these)
- Asking people to "comment for a free resource"
- Posting and disappearing
- Commenting just to get visibility

## Writing Guidelines

### Tone Spectrum

Find your spot on each scale:

```
Corporate  <————————>  Casual
Reserved   <————————>  Vulnerable
Analytical <————————>  Emotional
Serious    <————————>  Playful
```

Most Top Voices sit slightly right of center on each.

### Length

- **Optimal:** 150-300 words (enough for depth, short enough to finish)
- **Maximum:** 3,000 characters
- Use whitespace generously — dense text kills engagement

### Formatting Rules

- Never use hashtags inline with text
- Place 3-5 hashtags at the very end, after a line break
- One emoji max, if any (overuse signals inauthenticity)
- Use "I" not "we" for personal posts

## What to Avoid

**Content anti-patterns:**

- "I'm excited to announce..." (corporate speak)
- Humblebrags disguised as lessons
- Recycled viral post formats (the airport conversation, the Uber driver wisdom)
- Posting others' frameworks without credit
- Tragedy exploitation (using global events for engagement)

**Engagement anti-patterns:**

- "Comment YES if you agree"
- "Share this with 3 people"
- Tagging people who didn't ask to be tagged
- Posting controversial takes you don't actually believe
- Fake questions where you just want to share your answer

**Format anti-patterns:**

- Every. Sentence. As. Its. Own. Line.
- Excessive emoji strings
- ALL CAPS FOR EMPHASIS
- Hashtag stuffing

## Content Categories That Perform

1. **Career lessons** — Failures, pivots, decisions made
2. **Behind-the-scenes** — Real work experiences, how things actually work
3. **Industry insights** — Patterns you've noticed, trends you're seeing
4. **How-to frameworks** — Actionable processes readers can apply
5. **Contrarian takes** — Challenge assumptions (with substance)
6. **Personal milestones** — Only when tied to broader insights

## References

- `references/hooks.md` — Complete hook patterns with examples
- `references/examples.md` — Full post examples demonstrating best practices
