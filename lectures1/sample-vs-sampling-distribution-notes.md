---
title: "Distribution of the Sample vs the Sampling Distribution"
subtitle: "Reading guide"
---

<div class="tip">

<br>

KEY CONCEPTS:

### Deviations are the currency of every variance.

Every sum of squares in regression is built by measuring a distance, squaring
it, and adding it up. Only the *reference point* changes:

* $y_i - \bar{y}$ = **deviation** — distance from the mean
* $y_i - \hat{y}_i = e_i$ = **residual** — distance from the regression line
* $\hat{y}_i - \bar{y}$ = **explained** — distance the model moved you off the mean

$var(y) = \frac{\sum{(y_i - \bar{y})^2}}{n-1}$

### There are two different variances, and they answer different questions.

|                | Sample distribution | Sampling distribution |
|----------------|---------------------|------------------------|
| What varies    | the **data**        | the **estimate**       |
| Question       | How spread out are the observations? | How much would my estimate move in a new sample? |
| Centered on    | the center of the data | the "true" parameter |
| Measured in    | standard **deviations** | standard **errors** |
| You can see it | yes — it is your data | no — it is hypothetical |

### The variance of Y partitions into an explained and an unexplained part.

* Total SS: $\sum{(y_i - \bar{y})^2}$ &nbsp; `(deviations)`
* Regression SS: $\sum{(\hat{y}_i - \bar{y})^2}$ &nbsp; `(explained)`
* Error SS: $\sum{(y_i - \hat{y}_i)^2}$ &nbsp; `(residuals)`
* $TSS = RSS + ESS$

Total SS becomes the **variance of Y**. Error SS becomes the **variance of the
slope**.

### The regression line is a conditional mean.

* Standard deviation: on average, how far is **the mean** from each data point.
* SD of the residual: on average, how far is **the conditional mean** from each
  data point.

Same sentence, one word changed. The regression line is what the mean of Y
becomes once you let it depend on X.

### The standard error of the slope is built out of the unexplained variance.

* $SSE = \sum{e_i^2}$ &nbsp; (sum of squared error terms)
* $\hat{\sigma}^2_\varepsilon = \frac{SSE}{n-2}$ &nbsp; (variance of the residual)
* $SE_{b_1} = \sqrt{\frac{\hat{\sigma}^2_\varepsilon}{\sum{(x_i - \bar{x})^2}}}$

Or in words:

$Standard\ Error\ of\ the\ Slope \approx \frac{residual}{sample\ size \cdot variance\ X}$

**Standard error:** on average, how far off is our best guess of the slope from
the true slope?

### The Central Limit Theorem is what makes the sampling distribution usable.

Across repeated samples the estimated slope is approximately normally
distributed and centered on the true slope. That shape is what licenses:

* $\beta_1 = b_1 \pm t \cdot SE_{b_1}$

### Inference happens in the sampling distribution, not in the sample.

Unexplained variance $\rightarrow$ Error SS $\rightarrow$ standard error
$\rightarrow$ confidence interval $\rightarrow$ p-value

<br>

</div>

<br>

# Key relationships

## The whole deck in one sentence

**Sample variance describes your data; sampling variance describes your
estimate — and the second is manufactured out of the first.**

That is the subtle part. These are not two unrelated topics that happen to
share the word *variance*. The unexplained portion of the variance in your
data is the raw material the standard error is made from. Noisy data produce
an unstable estimate. The deck alternates between the two on purpose:
slides labeled **"this is sample variance"** and **"this is sampling
variance"** are asking you to notice which one you are looking at, because the
pictures look similar and the meaning is completely different.

## Two distributions, two centers, two rulers

The side-by-side slide near the end is the thesis of the lecture. Read it
carefully:

- The **sample distribution** puts heart rates on the axis. Its center is the
  center of the data. The red segments are deviations, and their typical size
  is a **standard deviation**.
- The **sampling distribution** puts *slopes* on the axis. Its center is the
  true slope. The intervals are estimates from repeated samples, and their
  typical spread is a **standard error**.

Same picture-making logic, different unit of observation. In the first, a dot
is a person. In the second, a dot is an entire study.

## You only ever get one sample

This is why the simulation slides exist. In real work you draw one sample,
compute one slope, and that is all you will ever see. The sampling
distribution is **counterfactual** — it is the spread of the estimates you
*would have* gotten from all the samples you did not draw.

The simulations make that invisible object visible: each frame draws a new
sample from the same population, fits a new line, and drops one more slope
onto the sampling distribution. Watching the line jump around from sample to
sample *is* sampling variance. The standard error is just the width of that
jumping, calculated rather than simulated.

## Three deviations, three sums of squares

Every quantity in the deck comes from one of three distances:

| Distance | Name | Sum of squares | Becomes |
|---|---|---|---|
| $y_i - \bar{y}$ | deviation | Total SS | variance of Y |
| $\hat{y}_i - \bar{y}$ | explained | Regression SS | model fit ($R^2$) |
| $y_i - \hat{y}_i$ | residual | Error SS | variance of the **slope** |

The third row is the one this deck is really about. Everything that determines
whether your result is statistically significant flows out of the residual.

> **Notation warning.** This deck writes $TSS = RSS + ESS$ where **RSS =
> Regression SS** and **ESS = Error SS**. Many textbooks use exactly the
> opposite (RSS = Residual, ESS = Explained). One slide reconciles it
> explicitly — *"Error SS, same as the Residual SS."* When you see **ESS** in
> these slides, read **error**, not explained.

## Why the regression line is "just" a mean

Slide 5 is doing more work than it looks like. It slices caffeine into bins
and plots the average heart rate in each: 74, 78, 82, 86, 90, 95, 99, 103,
107, 111 — against a flat "mean of Y" line at 90.

The flat line is the unconditional mean: your best guess about anyone's heart
rate if you know nothing about them. The rising sequence of bin averages is
the conditional mean: your best guess once you know their caffeine intake. The
regression line is a smooth version of that second sequence.

Once you see it that way, the parallel interpretations fall out for free:

- Standard deviation = how far the data sit from **the mean**.
- SD of the residual = how far the data sit from **the conditional mean**.

Regression did not introduce a new kind of dispersion. It moved the reference
point from a flat line to a tilted one.

## What makes a standard error small

The approximation slide is worth memorizing because it tells you what to do as
a researcher:

$SE_{b_1} \approx \dfrac{residual}{sample\ size \cdot variance\ X}$

Three levers, and only three:

- **Less residual** (numerator) — a better-specified model with less
  unexplained noise. This is what control variables and specification buy you.
- **A larger sample** (denominator) — more cases, more precision.
- **More spread in X** (denominator) — because
  $\sum(x_i - \bar{x})^2 = (n-1) \cdot var(x)$, a treatment that barely varies
  cannot produce a precise estimate of its effect, no matter how many cases
  you have.

That last one surprises people. If everyone in your study got roughly the same
dose, you cannot learn much about dosage.

## The chain that ends in a p-value

The final slide is the payoff, and it is worth being able to recite:

> unexplained variance → Error SS → standard error → confidence interval → p-value

Read left to right, this says that statistical significance is downstream of
model fit. Read right to left, it says a p-value is never a standalone fact —
it inherits everything from how much of Y your model failed to explain. This
is also why the Central Limit Theorem appears in the middle of the deck: it is
the step that turns a spread of hypothetical estimates into a probability
statement.

## How to read the slides

| Slides | What they are doing | What to take away |
|---|---|---|
| 1–2 | Framing: deviations as the common currency | Every variance is squared distances from *some* reference point. |
| 3–6 | Sample variance, four ways | The mean, then the conditional mean, then the partition into explained and residual. |
| 7 | Partitioning the variance of Y | The formula sheet for the whole deck. Note the ESS/RSS convention. |
| 8–10 | The Central Limit Theorem and $SE_{b_1}$ | The standard error is the residual variance, scaled by n and the spread of X. |
| 11–12, 15 | Simulations | The sampling distribution made visible. Each frame is a study you did not run. |
| 13–14 | Back to sample variance | Deliberate whiplash. Ask yourself which variance you are looking at. |
| 16 | Sample vs sampling, side by side | **The thesis slide.** Two centers, two rulers. |
| 17 | Deviations vs residuals | The conditional-mean parallel. |
| 18 | Unexplained variance → p-value | The chain. Be able to recite it. |

The alternation between "this is sample variance" and "this is sampling
variance" is not disorganization — it is the exercise. If you can label each
slide correctly without reading the title, you have the distinction.

# What should be clear in my mind?

1. **The difference between the distribution of the sample and the sampling
   distribution.** One describes the data you collected and is measured in
   standard deviations; the other describes how your *estimate* would behave
   across repeated samples and is measured in standard errors. You observe the
   first and can only infer the second.
2. **The difference between a deviation and a residual.** A deviation is the
   distance from a data point to the mean. A residual is the distance from a
   data point to the regression line — that is, to the conditional mean. Both
   are "distances from a best guess"; the second just has a better guess.
3. **Where the standard error of the slope comes from.** It is the variance of
   the residual, divided by the spread of X, square-rooted. Unexplained
   variance in your model becomes uncertainty in your estimate.
4. **Why the confidence interval and p-value depend on unexplained variance.**
   Because the whole chain — Error SS to standard error to interval to p-value
   — starts at the residual. Improving fit narrows the interval.

## Key takeaways

- **Two variances, one word.** Sample variance is about spread in the data;
  sampling variance is about spread in the estimate. Always ask which one is
  on the axis.
- **A dot means different things in the two pictures.** In the sample
  distribution a dot is an observation. In the sampling distribution a dot is
  a whole study.
- **The sampling distribution is counterfactual.** You draw one sample; the
  standard error is a calculated stand-in for the ones you did not draw.
- **The regression line is the mean conditioned on X.** This is why the
  interpretation of the residual SD mirrors the interpretation of the ordinary
  SD word for word.
- **Total SS splits into explained and error**, and it is the *error* half
  that determines the precision of your slope.
- **Three levers shrink a standard error:** less residual, more cases, more
  variation in X. A treatment with little variation cannot yield a precise
  estimate.
- **Significance is downstream of fit.** Unexplained variance → Error SS →
  standard error → confidence interval → p-value.
- **Watch the abbreviation.** In this deck ESS means *Error* SS, the opposite
  of the common textbook convention.
