---
title: "Testing the Validity of the Counterfactual"
subtitle: "Reading guide for lecture p-02"
eyebrow: "Research Design"
dek: "A reading guide for lecture p-02 — the selection problem, the two tests every study should report, and why the Bonferroni correction changes your decision rule."
concepts_sub: "The selection problem, the balance tests, and the correction that makes them honest."
relationships_sub: "The mental map. Selection in, selection out, and which estimator survives each."
clear_sub: "The checklist to run against any study's balance table."
---

<div class="tip">

KEY CONCEPTS:

### Nature gives us correlations, not experiments.

The deck opens with the city-scaling example from Radiolab. Walking speed correlates with
patents, crime, and salary. So does population.

* *If you increased the walking speed of a city, would you get more patents?*
* Obviously not — **population** drives both.

Four ways a correlation can appear without X causing Y:

1. X and Z both affect Y (no correlation between X and Z)
2. Z affects both X and Y — high correlation, no causal relationship
3. Causal chain X → Z → Y — no *direct* relationship, high correlation
4. **Reverse causality** — `Y = b0 + b1X + e` and `X = b0 + b1Y + e` are both highly
   significant. Nothing in the regression output tells you which direction is causal.

### The counterfactual is valid when groups differ *only* by the treatment.

Stated as the deck states it: the framework is valid and robust when the groups differ by
the treatment and are **otherwise identical**. When that holds, post-treatment differences
in outcomes can be read as caused by the treatment. Everything else in this lecture is
machinery for checking that condition.

### Selection is the biggest problem in impact evaluation.

*Those who participate in a program are different from those who do not.* The microfinance
example makes it concrete. Suppose loans have **zero** effect on income, and:

|                    | Not entrepreneurial | Entrepreneurial |
|--------------------|--------------------:|----------------:|
| No loan            | 30 people @ $10     | 15 people @ $20 |
| Takes a loan       | 20 people @ $10     | 35 people @ $20 |

* No loan: (30·$10 + 15·$20) / 45 = **$13.33**
* Loan: (20·$10 + 35·$20) / 55 = **$16.37**

The loan appears to work — and we built the example so that it does nothing. People who
know they are good at business are more likely to borrow. That is selection, not impact.

### The estimator you choose decides whether selection fools you.

Same data, two estimators:

* **Post-test only** (`T2 − C2`) — requires the groups to be balanced *before* the
  intervention. In the microfinance example they are not, so it reports a false effect.
* **Difference-in-difference** (`[T2 − T1] − [C2 − C1]`) — the pre-treatment imbalance
  cancels out, so it correctly reports no impact. The cost is that it needs pre-treatment
  data, which is often the thing you do not have.

More robust, more data-intensive. That trade recurs for the rest of the course.

### Selection also happens on the way *out* — attrition.

Reflexive design, average household income $2.00 before and after a program that does
nothing:

* **Random attrition** — people drop out at every income level; mean stays $2.00;
  `T2 − T1 = 0`. The study still gets the right answer.
* **Non-random attrition (low earners leave)** — mean rises to $2.50; the program looks
  effective.
* **Non-random attrition (high earners leave)** — mean falls to $1.50; the program looks
  harmful.

Attrition is natural. The question is never whether it happened but whether it was random.

### Randomization "fails" 5 times in 100, by construction.

If you randomly split 100 people into two groups of 50, how often do the average weights
differ? **Mathematically, always** — they are never exactly equal. So "different" has to
mean statistically different, which means a t-test at some α.

At α = 0.05, each measured characteristic will read as significantly different **5 times
out of 100** even when both groups came from the same population. The deck calls this
**unhappy randomization** — not a failure of the process, just a bad draw.

### The Bonferroni correction fixes the multiple-comparison problem.

The balance table reports many contrasts, and each gets its own 5% chance of a false
alarm. With *n* contrasts the chance of at least one p-value below 0.05 is roughly
**n × 0.05**, not 0.05.

So to stay 95% confident about the *groups* rather than about each contrast, divide:

* 10 contrasts → new decision rule is 0.05 / 10 = **0.005**
* 7 contrasts → new α = 0.05 / 7 = **0.0071**; a smallest p-value of 0.04 is
  `0.04 > 0.0071`, so **do not reject** — the groups are equivalent

</div>

# Key relationships

## The lecture has two halves that mirror each other

**Selection into** the study group (who joins) and **selection out of** it (who leaves)
are the same problem at two different moments, and they get the same fix: compare the
traits of the groups you actually have, and test whether the differences are larger than
chance would produce.

## The balance table is the most important table in any study

The deck says this outright. Before you read a single result, read the table comparing
treatment and control characteristics. For the counterfactual to hold, the groups can only
differ by the treatment — so this table is where a study either earns its causal language
or does not.

Two things to check: **which** traits were measured (unmeasured traits cannot be balanced,
only assumed), and **whether the decision rule was corrected** for the number of contrasts.

## The four attrition tests, and the two that get reported

The deck's attrition diagram splits each group into stayers and leavers, producing four
possible tests:

* **Test 0** — group equivalence at time 1, before attrition
* **Test 1** — group equivalence at time 2, after attrition
* **Test 2** — do stayers differ from leavers? *This is the only real test of random
  attrition.*
* **Test 3** — do the two groups experience the same kind of attrition?

Most studies report only 0 and 1. That is defensible — test 1 is agnostic about the type
of attrition and only asks whether balance survived it — but it is weaker than test 2.

The deck is careful about a nuance worth keeping: attrition can be **non-random and still
harmless** if it is non-random *in the same way in both groups*. If all high performers
leave both arms, the groups stay balanced. Test 3 checks exactly that.

## All four tests are the same regression

This is the practical payoff of the lecture. Subset the data to isolate the two groups you
want to compare, build a dummy for one of them, and run:

`Y = b0 + b1(dummy) + e`

A significant `b1` means the groups are not balanced (test 1), attrition is non-random
(test 2), or attrition is non-equivalent (test 3). `Y` can be the pre-treatment outcome or
any participant trait. It is the same tool you used in Lab 2, pointed at different subsets.

## RCTs, natural experiments, and quasi-experiments arrive at balance differently

* **RCT** — assumes complete control over assignment.
* **Natural experiment** — borrows randomization that already exists in the world: charter
  school lotteries, the Vietnam draft.
* **Quasi-experimental** — manufactures equivalence by other means, matching above all.

All three are trying to satisfy the same condition. Only the mechanism differs.

## How to read the slides

Slides 3–19 are the correlation-is-not-causation setup and can be skimmed if the first
course is fresh. Slides 21–29 are the two worked examples and are the heart of the
lecture. Slides 34–43 are the statistical argument about balance testing, and slide 42
(Bonferroni) is the one you will actually need to apply in the lab.

# What should be clear in my mind?

## What the deck asks you to be able to do

* State why a correlation between X and Y is consistent with at least four different causal
  stories.
* Explain when `b1` is an impact and when it is just a relationship in the data.
* Compute a post-test-only and a difference-in-difference estimate from the same table and
  say why they disagree.
* Read a balance table and apply the corrected decision rule.
* Say which attrition test a study reported, and which it skipped.

## Key takeaways

* Selection is the central problem of impact evaluation: participants differ from
  non-participants before the program ever starts.
* Post-test-only estimators require pre-treatment balance. Difference-in-difference does
  not, but it requires pre-treatment data.
* Attrition is selection out of the study, and non-random attrition biases the estimate in
  whichever direction the leavers came from.
* Randomization does not guarantee balance in any particular sample. Expect roughly one
  significant contrast in twenty by chance alone.
* Unhappy randomization is bad luck, not a broken process — but it still threatens the
  counterfactual and still has to be dealt with.
* With *n* contrasts in the balance table, the decision rule is α / n, not α.
* Every balance and attrition test is the same one-dummy regression run on a different
  subset of the data.
