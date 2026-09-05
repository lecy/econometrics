---
title: "Varieties of the Counterfactual"
subtitle: "Reading guide for lecture p-03"
eyebrow: "Research Design"
dek: "A reading guide for lecture p-03 — the three estimators, the single condition each one needs to be unbiased, and the fact that all three are the same regression with a different omitted group."
concepts_sub: "Three formulas, and the identifying assumption that sits under each."
relationships_sub: "The mental map. Why diff-in-diff is the general case and the other two are special cases of it."
clear_sub: "The diagnostic questions to ask of any impact estimate."
---

<div class="tip">

KEY CONCEPTS:

### There are three valid counterfactuals, and each has its own formula.

Notation throughout: `T1`/`T2` are the treatment group's mean outcome before and after;
`C1`/`C2` are the comparison group's.

| Estimator | Formula | What stands in for the missing world |
|---|---|---|
| **Reflexive (pre–post)** | `T2 − T1` | the treated group's own past |
| **Post-test only** | `T2 − C2` | another group, measured after |
| **Difference-in-difference** | `(T2 − T1) − (C2 − C1)` | the treated group's past, adjusted for trend |

### Difference-in-difference is the general case.

Read the other two as diff-in-diff with a term assumed away:

* **Reflexive is valid iff `C2 − C1 = 0`** — there is no secular trend, so the comparison
  term contributes nothing.
* **Post-test only is valid iff `C1 − T1 = 0`** — the groups were equivalent at baseline,
  so the pre-period terms cancel.

Each estimator is a bet that one of those conditions holds. Diff-in-diff makes neither bet.

### Diff-in-diff separates program gains from gains that would have happened anyway.

* `T2 − T1` = total gains in the treatment group
* `C2 − C1` = total gains in the comparison group = **the secular trend**
* The difference is program impact

Its strength, stated plainly on the slides: **the groups do not have to be identical before
treatment.** That is what makes it robust where the post-test-only estimator fails.

### The comparison group supplies the trend, not the counterfactual.

A distinction the deck insists on:

* A **control group** is created by randomization and is assumed identical. It *is* the
  counterfactual.
* A **comparison group** is not identical. It is there to measure the trend, which is then
  used to *construct* the counterfactual.

In the gender pay gap example you never compare `C2` to `T2` directly. You build the
counterfactual as `T1 + (C2 − C1)` — the salary a female ED would have received if she had
been given the same recruitment premium as incoming male EDs — and compare that to actual.

### The parallel lines assumption is what diff-in-diff must buy.

For `C2 − C1` to be an honest estimate of the trend, the two groups must have been moving
at the same rate before the intervention. With a pre-treatment period `t=0`, the test is:

`T1 − T0 = C1 − C0`

If the lines were not parallel before the program, there is no reason to believe the
comparison group captures what the treatment group would have done.

### All three estimators are the same dummy-variable regression.

`Y = b0 + b1(TreatDummy) + e`, where `b1 = MEAN(treat) − MEAN(control)`.

* Post-test only: the omitted group is `C2`, so `b0 = C2` and `b0 + b1 = T2`
* Reflexive: the omitted group is `T1` — **the group's own past is the control** — so
  `b0 = T1` and `b0 + b1 = T2`

The default hypothesis test on `b1` is the test of program impact. Only the definition of
the omitted category changes.

### Post-test-only bias has a predictable direction.

If the groups were not equivalent at baseline:

* `C1 < T1` → the measured effect **overstates** impact
* `C1 > T1` → the measured effect **understates** impact
* `C1 = T1` → `T2 − C2` is unbiased

</div>

# Key relationships

## The lecture picks up exactly where the design lectures stopped

By this point you have chosen a comparison, tested for equivalence and attrition bias, and
decided between intention-to-treat and treatment-on-the-treated. The remaining question is
purely computational: *now how do we actually calculate program impact?* This deck is the
answer, and it is short because there are only three answers.

## Failing to account for the trend inflates every estimate

The slide that makes this vivid: if the comparison group gained `C2 − C1` over the study
period and you ignore it, you attribute all of the treatment group's change to the program.
Whenever anything else is moving — the economy, students aging, a policy elsewhere — the
reflexive estimator over-credits the program.

## The teacher-effects example is a reflexive design in disguise

Change in student performance from the start to the end of the academic year, in percentile
units. It is reflexive, because impact comes from comparing the *same students over time*
rather than one classroom to another at a point in time.

The deck then adds a subtlety worth sitting with: because performance is measured in
**percentiles**, the average change across all groups is forced to zero by construction, so
the design carries an element of diff-in-diff for free. But that only holds across the whole
population — within a sub-population there can be a real trend, and then diff-in-diff is
genuinely needed.

## The microfinance example is now a quiz rather than a demonstration

The same table from lecture p-02 returns, and this time the question is *which estimator
are we using, and which one would be unbiased?* The answer: the $13.33-versus-$16.37
calculation is post-test only, its baseline-equivalence condition fails because
entrepreneurial people select into loans, and diff-in-diff would recover the true null.

## Attrition is a data-handling problem, not an estimator problem

The attrition slides ask a sharper question than they first appear to. With non-random
attrition, the reflexive estimate `T2 − T1` moves from $2.00 to $2.50 and the program looks
effective. The fix shown is to **remove the attriters from `T1`** as well, so the same
people are being compared at both time points — which restores `T2 − T1 = 0`.

The deck flags a common confusion explicitly: *this is not about ITT versus TOT.* Those
require outcome data on both groups at `T2`. This is about which observations you keep when
some participants are missing.

## This deck is the map of the third course

The final slides line the estimators up against the methods they lead to:

* **Diff-in-diff** → difference-in-difference analysis, fixed effects models
* **Reflexive** → pre–post with treatment group only, time series regression
* **Post-test only** → true experiments, post-test comparison with no baseline, propensity
  score matching, regression discontinuity

Every technique in the advanced regression sequence is one of these three counterfactuals
with better machinery attached.

# What should be clear in my mind?

## Diagnostic questions for any impact estimate

* Which of the three estimators is this?
* What condition does it need to be unbiased — no trend, or baseline equivalence?
* Is that condition tested anywhere in the paper, or just assumed?
* If it is diff-in-diff, were the pre-treatment trends parallel?
* Is the second group a control group or a comparison group, and is the paper's language
  honest about which?

## Key takeaways

* Three estimators, three formulas: `T2 − T1`, `T2 − C2`, and `(T2 − T1) − (C2 − C1)`.
* Diff-in-diff is the general form; reflexive and post-test-only are the special cases where
  the trend term or the baseline term drops out.
* Reflexive needs no trend. Post-test-only needs baseline equivalence. Diff-in-diff needs
  parallel pre-treatment trends.
* A comparison group measures trend; a control group *is* the counterfactual. Do not use the
  words interchangeably.
* Baseline imbalance biases post-test-only estimates in a knowable direction, so you can
  often say which way a flawed study is wrong.
* All three are `Y = b0 + b1(dummy) + e` with a different omitted group, so the regression
  machinery from the first course carries over unchanged.
* When attrition is present, apply the same filter to the pre-period that attrition applied
  to the post-period.
