---
title: "Randomization Breaks Omitted Variable Bias"
subtitle: "Reading guide"
---

<div class="tip">

<br>

KEY CONCEPTS:

### The observational problem.

In a study of caffeine and heart rate, stress and sleep are omitted variables —
and they are connected to *both* caffeine consumption and heart rate.

> If we can't measure stress and sleep quality to include in our study it will
> cause bias: we can't confidently say caffeine is the factor driving the
> increase in heart rate, or if it co-occurs with the other factors that are
> actually increasing heart rate.

### What randomization does.

> Randomization breaks the correlations between the variable that has been
> randomized and the rest of the variables in the study — except the outcome, if
> the relationship is in fact causal.

Assigning caffeine doses at random severs the arrows from stress and sleep into
caffeine. They may still affect heart rate; they no longer travel *through* the
treatment.

### The test this creates.

> If the relationship was spurious then caffeine dosage no longer predicts heart
> rate.

A relationship that survives randomization is causal. A relationship that
disappears was riding on the omitted variables all along.

### In Venn terms.

* $X_2$ **overlapping** $X_1$ → will cause bias when omitted
* $X_2$ **not overlapping** $X_1$ → will **not** cause bias when omitted

Randomization moves every other variable from the first picture to the second.

### The same logic applies to program participation.

Whoever chooses to participate in a program differs from those who do not, on
things you cannot measure. Randomizing participants into treatment groups
breaks those correlations exactly as it does for a dose.

<br>

</div>

<br>

# Key relationships

## Randomization sets one term of the bias formula to zero

This deck is short because it only needs one line from p-07:

$$bias = \alpha_1 \cdot \beta_2$$

where $\alpha_1$ is the slope of the omitted variable regressed on the
treatment. Randomization makes the treatment independent of everything that was
determined before assignment, so **$\alpha_1 = 0$ for every such variable**, and
therefore:

$$bias = 0 \cdot \beta_2 = 0$$

Note what it does *not* do. It does not make $\beta_2$ zero — stress still
affects heart rate, and sleep still affects heart rate. Those variables remain in
the residual, where they inflate your standard errors. Randomization buys you
**accuracy, not precision**.

That is why randomized studies still use control variables: type-A controls
(uncorrelated with the treatment, which after randomization means *all* of them)
shrink the residual and tighten the interval. Under randomization, every control
is a type-A control.

## The two failure routes, and which one randomization closes

An observed association between caffeine and heart rate could be either:

- **Causal** — caffeine raises heart rate directly.
- **Spurious or confounded** — stress causes people to drink more coffee *and*
  raises heart rate, so the two move together without one causing the other.

The naïve regression cannot tell these apart, because both produce the same
correlation. Randomization can, and the mechanism is worth stating carefully:
once dose is assigned by a coin flip, stressed people are no more likely to get
a high dose than anyone else. Any remaining association cannot be running through
stress.

Hence the deck's sharpest slide: *if the relationship was spurious then caffeine
dosage no longer predicts heart rate.* Randomization does not merely reduce bias
— it converts the study into a test that a spurious relationship fails.

## Why this is the strongest answer to p-07's problem

p-07 ended in an uncomfortable place. Observational studies always omit
something; you can sometimes sign the bias but rarely remove it; and the
correlated controls that would fix it are expensive and never provably complete.

Randomization sidesteps the entire problem rather than solving it case by case.
You do not need to know what the confounders *are*, or measure them, or even be
able to name them. Whatever they are — measured, unmeasured, unmeasurable —
random assignment breaks their correlation with the treatment simultaneously.

That is a qualitatively different kind of guarantee from "we controlled for
everything we could think of," and it is the reason experiments sit at the top
of the evidence hierarchy.

## What randomization does not fix

Worth being clear about the limits, since the deck focuses on the win:

- It does not remove noise. The omitted variables still explain part of Y, so
  standard errors are unaffected.
- It only breaks correlations with things determined **before** assignment.
  Anything that happens after — attrition, non-compliance, differential
  measurement — can reintroduce exactly the same problem.
- It says nothing about whether your effect generalises beyond the units you
  randomized.

## Where this sits

Read it immediately after p-07, and before or alongside the taxonomy deck. The
sequence is:

- **p-06** — correlated controls cost precision.
- **p-07** — omitting them costs accuracy; $bias = \alpha_1\beta_2$.
- **this deck** — randomization sets $\alpha_1 = 0$, so the trade-off
  disappears.
- **taxonomy** — how to classify controls when you cannot randomize.

## How to read the slides

| Slides | What they are doing | What to take away |
|---|---|---|
| 2–4 | Setup: is a relationship causal? | The question randomization answers. |
| 5 | The observational case | Stress and sleep connect to *both* caffeine and heart rate. |
| 6 | **The key claim** | Randomization severs correlations with the treatment. |
| 7 | The consequence | A spurious relationship disappears after randomization. |
| 8–9 | Venn versions | Overlap with $X_1$ → bias; no overlap → no bias. |
| 10–11 | Program participation | The same logic for who enrols, not just how much. |

# What should be clear in my mind?

1. **What randomization actually does.** It breaks the correlation between the
   randomized variable and everything else determined beforehand — it does not
   remove those variables' effects on the outcome.
2. **Why that eliminates bias.** Because $bias = \alpha_1\beta_2$, and
   randomization forces $\alpha_1 = 0$.
3. **Why it does not improve precision.** The omitted variables still sit in the
   residual, so standard errors are unchanged. Controls are still useful in a
   randomized study.
4. **What the spuriousness test is.** If an association vanishes once the
   treatment is randomized, it was never causal.

## Key takeaways

- **Randomization zeroes $\alpha_1$**, and a product with a zero in it is zero.
- **It buys accuracy, not precision.** Bias goes away; noise does not.
- **You do not need to name the confounders.** Random assignment handles
  unmeasured and unmeasurable ones at the same time.
- **After randomization every control is a type-A control** — safe to add, and
  useful for shrinking standard errors.
- **A spurious relationship fails the randomized test**, which is what makes an
  experiment a test rather than a description.
- **Only pre-assignment correlations are broken.** Attrition and non-compliance
  can bring confounding back in.
