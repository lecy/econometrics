---
title: "Bias from Specification or Measurement"
subtitle: "Reading guide for lecture p-09"
---

<div class="tip">

<br>

KEY CONCEPTS:

### Anscombe's quartet: identical summary statistics, four different relationships.

Four datasets with the same mean, variance, correlation, and regression line —
and completely different scatterplots. One is well behaved, one is non-linear,
two are driven by outliers.

The lesson: **summary statistics cannot detect a specification problem. Only the
plot can.**

### Two classes of inferential failure.

* **Type I error** — false positive; claiming impact where there is none.
  Typically caused by **bias** (bias causes significance).
* **Type II error** — false negative; missing real impact. Caused by bias *or*
  by **inflated standard errors**.

### A linear transformation is not measurement error.

**Linear transformation** ($X_2 = X_1 + 100$): add the *same constant* to every
value.

* $mean(X_2) = mean(X_1) + 100$
* $var(X_2) = var(X_1)$ — **unchanged**
* Slopes and standard errors are **identical**; only the intercept moves

**Measurement error** ($X_2 = X_1 + \varepsilon$): add *random noise* to every
value, equally likely to over- or under-measure.

* $mean(X_2) = mean(X_1)$ — unchanged
* $var(X_2) = var(X_1) + \varepsilon$ — **larger**

### Measurement error in the dependent variable inflates standard errors.

* Slope: **unbiased**
* Standard error: **larger**
* Risk: **Type II error**

Noise in Y goes straight into the residual, which is the numerator of
$SE_{b_1}$.

### Measurement error in the independent variable causes attenuation bias.

Because $var(x_1)$ sits in the denominator of both quantities, inflating it
shrinks both:

$b_1 \downarrow = \frac{cov(x_1,y)}{var(x_1) \uparrow}
\qquad
SE_{b_1} \downarrow = \frac{residual}{sample\ size \cdot var(x_1) \uparrow}$

* Slope: **biased toward zero**
* Standard error: **smaller**
* Risk: a confidently estimated effect that is too small

### Outliers do different damage depending on where they sit.

| Position | Slope | SE | Risk |
|---|---|---|---|
| Middle of X | unbiased | larger | false negative |
| Extreme of X, with the trend | **too large** | larger | **false positive** |
| Extreme of X, against the trend | **too small** | larger | false negative |

Leverage comes from distance along X, not from being far from the line.

### Fixes for non-linearity.

* **Log transformations** — level-level, log-linear, linear-log, log-log. For
  highly skewed data, logging converts a curved cloud into a linear one.
* **Quadratic models** — $Y = b_0 + b_1X_1 + b_2X_1^2 + e$, when the
  relationship rises and then falls.
* **Cook's distance and residual plots** — for identifying influential points.

<br>

</div>

<br>

# Key relationships

## One question, asked of every problem

This deck looks like a grab-bag — Anscombe, error types, transformations,
outliers, logs, quadratics. It is not. Every section asks the same two
questions about a different threat:

1. What does it do to the **slope**?
2. What does it do to the **standard error**?

And those two answers determine the third: which kind of error you are at risk
of. Build this table as you read and the deck becomes one page:

| Threat | Slope | Standard error | Risk |
|---|---|---|---|
| Omitted variable (p-07) | biased | — | Type I |
| Measurement error in **Y** | unbiased | larger | Type II |
| Measurement error in **X** | biased toward zero | **smaller** | too-small effect, held confidently |
| Outlier in middle of X | unbiased | larger | Type II |
| Outlier at extreme, with trend | too large | larger | **Type I** |
| Outlier at extreme, against trend | too small | larger | Type II |
| Wrong functional form | meaningless | — | either |

## Adding a constant versus adding noise

Slides 9 through 12 set up a contrast that is easy to skim and worth slowing
down for, because both operations look like "changing X."

Adding 100 to every observation slides the whole distribution to the right. The
spacing between points is untouched, so $var(x)$ is untouched, so the slope and
the standard error are *exactly* the same. Only $b_0$ changes, because the
intercept answers "what is Y when X = 0," and X = 0 now means something
different.

Adding random error to every observation leaves the centre where it was but
spreads the points out. $var(x)$ **increases** — and $var(x)$ is load-bearing in
both formulas you care about.

The distinction is: a constant preserves the ordering and spacing of your data;
noise degrades it. That is why one is harmless and the other is not.

## Attenuation bias is the nastiest failure in the deck

Every other threat here either biases you *or* inflates your standard errors.
Measurement error in X does something worse: it **shrinks both at once**.

Look at the two formulas together. $var(x_1)$ is in the denominator of the
slope, so a bigger $var(x_1)$ makes $b_1$ smaller. And $var(x_1)$ is in the
denominator of the standard error, so a bigger $var(x_1)$ makes $SE_{b_1}$
smaller too.

The result is an estimate that is **too close to zero** and a confidence
interval that is **too narrow around it**. Nothing in your output looks wrong.
You will report a small, precisely estimated effect, and the true effect is
larger.

Two consolations. First, the direction is predictable: attenuation is always
*toward* zero, never away from it, so a significant finding measured with error
is if anything an understatement. Second, it is a measurement problem, so it is
fixable at the design stage — better instruments, repeated measures — rather
than in the regression.

## Outliers are about leverage, not about being far from the line

The three-panel slide is the one to internalise. All three panels have exactly
one unusual point, and they do completely different things.

What matters is **where the point sits along X**, not how far it is from the
fitted line:

- Near the **middle of X**, an unusual point has almost no leverage. It cannot
  pivot the line, because the line passes through $(\bar{x}, \bar{y})$ and the
  point is near that pivot. It just adds residual, which inflates your standard
  error.
- Out at the **extreme of X**, the same point has enormous leverage — it is
  furthest from the pivot, so it swings the line hardest. Depending on which way
  it sits, it makes the slope too steep or too shallow.

This connects back to p-01's outlier slides, where a single point far from both
means dominated the covariance. Same mechanism, seen from the other side.

Note that the extreme cases inflate the standard error *as well as* biasing the
slope, which is why the deck lists "SE larger" under all three panels. An
influential point rarely fits the line it created.

## Why the fix for skew is a log, not a deletion

Slides 20 through 22 introduce a second kind of outlier: not a data error, but
the natural consequence of **highly skewed data**. Metro population and
nonprofit counts are the example, and the level-level plot is a hockey stick
with a few enormous values on the right.

You cannot delete these points — they are real, and deleting the largest metros
would be a substantive decision, not a technical one. Logging both axes instead
converts a curved, heteroskedastic cloud into a straight, even band.

The four combinations are worth knowing by name because they change what the
coefficient means:

- **level-level** — a one-unit change in X gives $b_1$ units of Y
- **log-linear** (log Y) — a one-unit change in X gives roughly $100 \cdot b_1$
  percent change in Y
- **linear-log** (log X) — a one-percent change in X gives roughly $b_1/100$
  units of Y
- **log-log** — a one-percent change in X gives $b_1$ percent change in Y (an
  elasticity)

## Deleting an outlier is a claim, and the numbers will flatter you

The before-and-after table on slide 19 is instructive and slightly alarming:
removing one point moves the slope from 0.50 to 0.35 and takes $R^2$ from 0.67
to **1.00**, with the standard error dropping by a factor of hundreds.

That is a real risk of specification work: nearly any model looks better after
you remove the observations that disagree with it. The diagnostic tools —
residual plots, Cook's distance — tell you *which* points are influential, but
they cannot tell you whether those points are errors or evidence. That judgement
is substantive.

The honest workflow is to report both, or to have a rule decided before you
looked.

## How to read the slides

| Slides | What they are doing | What to take away |
|---|---|---|
| 2–5 | Anscombe's quartet | Same statistics, four relationships. Always plot. |
| 6–7 | Type I and Type II errors | Bias → false positives. Big standard errors → false negatives. |
| 8–11 | Linear transformations | Adding a constant changes only the intercept. |
| 12 | Measurement error defined | Same mean, more variance. This is the key contrast with slide 9. |
| 13 | Error in the DV | No bias, bigger standard errors, Type II risk. |
| 14 | **Attenuation bias** | Error in X shrinks the slope *and* the standard error. |
| 15–17 | Outliers by position | Leverage comes from distance along X. |
| 18–19 | Cook's distance; before/after | Diagnostics find influence; they do not justify deletion. |
| 20–22 | Logged models | The fix for skew-driven outliers. |
| 23–24 | Quadratic models | The fix for genuinely curved relationships. |

# What should be clear in my mind?

This deck has no closing checklist. These are the things to be able to answer:

1. **Why summary statistics are not enough.** Anscombe's quartet: four datasets
   agree on every number you would report and disagree on everything that
   matters.
2. **The difference between a linear transformation and measurement error.** One
   preserves $var(x)$ and is harmless; the other inflates it and is not.
3. **What measurement error does, depending on where it is.** In Y: bigger
   standard errors, no bias. In X: attenuation toward zero, with a *smaller*
   standard error.
4. **Why an outlier's position along X determines its damage.** Leverage is
   distance from the pivot at $(\bar{x}, \bar{y})$.
5. **Which threats produce which error type.** Bias-producing threats risk false
   positives; variance-inflating threats risk false negatives.
6. **When to log and when to go quadratic.** Log for skew and multiplicative
   relationships; quadratic for relationships that turn around.

## Key takeaways

- **Always plot the data.** Anscombe's quartet exists to make this
  non-negotiable.
- **Ask two questions of every threat:** what does it do to the slope, and what
  does it do to the standard error?
- **Adding a constant is free; adding noise is not.** The difference is whether
  $var(x)$ changes.
- **Measurement error in Y costs precision only.** It lands in the residual.
- **Measurement error in X causes attenuation bias** — a smaller estimate
  reported with more confidence, which is the worst combination in the deck.
- **Attenuation always runs toward zero**, so a significant result measured with
  error is likely an understatement.
- **Outliers in the middle of X inflate standard errors; outliers at the extremes
  bend the slope.**
- **Cook's distance identifies influence, not error.** Whether to drop a point is
  a substantive judgement.
- **Logs fix skew; quadratics fix curvature.** Both change what the coefficient
  means, so re-state the interpretation when you transform.
