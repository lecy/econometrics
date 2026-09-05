---
title: "Effect Size, ATE, ITT, and TOT"
subtitle: "Reading guide for lecture p-04"
eyebrow: "Research Design"
dek: "A reading guide for lecture p-04 — what counts as an effect, and the difference between being offered a treatment and actually taking it."
concepts_sub: "The three ways of defining who counts as treated, and what an effect actually is."
relationships_sub: "The mental map. Why this deck reviews the whole course before adding one idea."
clear_sub: "The questions to ask before you accept a reported effectiveness number."
---

<div class="tip">

KEY CONCEPTS:

### An "effect" is a magnitude *and* an interval, not a p-value.

The deck's own definition: **the observed change plus its confidence interval** — the size
of the impact together with how accurately it was measured, so that you can say with
confidence whether it is positive.

In regression terms, `b1 = MEAN(treat) − MEAN(control)`, the null is `b1 = 0`, and
significance is the question of whether the interval around `b1` contains zero.

### The average treatment effect is the default because it is the easiest thing to measure.

The ATE is the difference in average outcomes between treatment and comparison groups. It
is the most compact way to report program effectiveness — and it silently averages over
everyone, including people who never engaged with the program at all.

### Intention to treat counts everyone who was *offered* the treatment.

**ITT** measures the effect of being assigned to the program, whether or not the person
used it. In the bed-net example: group T is everyone *given* bed nets.

### Treatment on the treated counts only those who actually took it.

**TOT** measures the effect among people who were given bed nets **and used them.**

The deck's framing question is exactly this: *Is group T those who are given bed nets, or
those who use them?* Both are legitimate. They answer different questions.

### The contraception app makes the distinction concrete.

From the news story the deck reproduces:

* Used **perfectly**, 5 in 1,000 women per year become pregnant — **99.5% effective**
* Under **typical use**, 7 in 100 become pregnant — about **93% effective**

The deck asks which number is the TOT and which is the ITT. Perfect use is treatment on
the treated. Typical use is intention to treat.

Then the harder question: *is real effectiveness 99.5% or 93%?* For a policy-maker deciding
whether to fund distribution, the ITT number is the honest one, because real people forget.
For a clinician advising a highly motivated patient, the TOT number is more informative.

### ITT is usually the conservative estimate, and usually the policy-relevant one.

Because ITT includes non-compliers, it dilutes the measured effect toward zero. That makes
it a lower bound on what the program does — and an accurate picture of what a funder can
expect when they roll the program out to people who behave normally.

### Selection and attrition are the two ways the comparison breaks.

Reviewed here from earlier lectures, with the fixes stated plainly:

* **Selection into the study** — participants differ from non-participants.
  *The fix:* randomization or matching, to force an apples-to-apples comparison.
* **Selection out of the study (attrition)** — leavers differ from stayers.
  *The fix:* compare the characteristics of those who stay against those who leave.

</div>

# Key relationships

## This deck is a survey, and ITT/TOT is the new idea in it

Roughly two-thirds of these slides revisit material developed in p-01, p-02, and p-03: the
suicide-rate example, the caffeine hypothesis-testing frame, the Bonferroni correction, the
microfinance selection table, the attrition sequence, the three counterfactuals, and the
staggered-start case study. If those are fresh, skim to slide 42.

The genuinely new content is **slides 42–46: different interpretations of program effects**
— ATE, ITT, and TOT — plus the sampling-distribution refresher at the end.

## ITT versus TOT is a choice about the denominator

Every effectiveness number is a fraction, and this pair of terms is a dispute about what
goes underneath. ITT divides by everyone offered the program; TOT divides by everyone who
complied. Neither is a correction of the other. Reporting only one, without saying which,
is the actual error.

## The distinction has teeth precisely because compliance is not random

If people who use the bed nets differ systematically from people who were given them and
did not — more health-literate, more able to plan, less exhausted — then the TOT estimate
carries all the selection problems from lecture p-02 back into the analysis. TOT is an
estimate on a self-selected subgroup. That is why ITT preserves the randomization and TOT
generally does not.

## The two considerations for choosing an estimator, restated

The deck compresses lecture p-03 into two questions to ask of any design:

1. **Does `C1 = T1`?** Usually not, for comparison groups. Randomization is what buys it,
   which is why post-test-only estimators are legitimate in experiments.
2. **Is `C2 − C1` an accurate reflection of the trend?** Sometimes a comparison group
   captures it adequately even when it is not equivalent.

Answer the first "yes" and post-test-only works. Answer the second "yes" and diff-in-diff
works. Answer both "no" and you do not yet have a study.

## Why the sampling distribution shows up at the end

The closing slides return to the sampling distribution at n = 10 and n = 50, and to the
anatomy of a confidence interval — 2.5% of sample statistics above, 2.5% below, the true
slope somewhere inside. This is not filler. It is the justification for the deck's opening
definition: an effect is a point estimate *plus* an interval, and the interval comes from
the sampling distribution. Sample size is the lever that tightens it.

## How to read the slides

Treat this as the integrative deck for the first half of the course. Read slides 42–46
closely and carefully; use the rest as a self-check. If any of the review slides is not
immediately obvious, that is a signal to go back to the lecture where it was introduced
rather than to keep going here.

# What should be clear in my mind?

## Questions to ask of any reported effectiveness number

* Is this ITT or TOT? Does the paper say?
* Who is in the denominator — everyone offered the program, or everyone who complied?
* If it is TOT, what made people comply, and could that be driving the result?
* Is the number reported with an interval, or on its own?
* Which of the three counterfactuals produced it, and is its identifying condition met?

## Key takeaways

* An effect is a magnitude with a confidence interval. A p-value alone is not an effect.
* The ATE is the workhorse because it is easy to compute and easy to communicate.
* ITT measures the effect of *offering* a program; TOT measures the effect of *receiving*
  it. Both are valid answers to different questions.
* ITT is typically smaller, typically more conservative, and typically the number a funder
  should plan against.
* TOT conditions on compliance, and compliance is rarely random — so TOT reintroduces the
  selection problem the design was built to avoid.
* Perfect-use versus typical-use effectiveness in medicine is exactly the TOT/ITT
  distinction under a different name.
* Randomization is what licenses the post-test-only estimator; without it you need either a
  credible trend or a matching strategy.
