---
title: "Variance, Covariance, and the Regression Slope"
subtitle: "Reading guide for lecture p-01"
---

<div class="tip">

<br>

KEY CONCEPTS:

### Everything in this lecture is built from one quantity: the deviation.

* $x_i$ = a data point
* $\bar{x}$ = the mean of X
* $x_i - \bar{x}$ = distance to the mean = **a deviation**

Square it, multiply it by another one, or divide one by another — that is the
whole lecture.

### Variance measures distances from data points to the mean.

* $var(x) = \frac{\sum{(x_i - \bar{x})^2}}{n-1}$
* Deviations always sum to zero, so they must be squared before averaging.
* Variance is a **total**: it grows with the number and the extremity of cases.

### Standard deviation puts variance back into the original units.

* $sd(x) = \sqrt{var(x)}$
* Read as: the average distance a point must travel to reach the mean.
* Standard deviation is an **average**, not a total.

### Standard error measures the distance from an estimate to the truth.

* Standard deviation describes the **data**. Standard error describes the **estimate**.
* $SE_{\bar{x}} = \frac{sd(x)}{\sqrt{n}}$
* "The truth" is $\mu$ for a mean and $\beta_1$ for a slope.

### Covariance measures whether two variables sit above or below their means together.

* $cov(x,y) = \frac{\sum{(x_i - \bar{x})(y_i - \bar{y})}}{n-1}$
* $(+)(+)$ and $(-)(-)$ contribute **positively**
* $(+)(-)$ and $(-)(+)$ contribute **negatively**
* Note that $var(x) = cov(x,x)$

### Correlation is covariance rescaled into unitless form.

* $cor(x,y) = \frac{cov(x,y)}{sd(x) \cdot sd(y)}$
* $-1 < cor(x,y) < +1$

### The regression slope is covariance divided by variance.

* $Y = b_0 + b_1 X + e$
* $b_1 = \frac{cov(x,y)}{var(x)}$
* The line always passes through the means: $\bar{y} = b_0 + b_1 \bar{x}$

### The same four concepts apply to the mean and to the slope.

|                     | Of the mean                                       | Of the slope                                                     |
|---------------------|---------------------------------------------------|------------------------------------------------------------------|
| Variance            | $\sigma^2_x = \frac{\sum(x_i-\bar{x})^2}{n-1}$     | $\sigma^2_\varepsilon = \frac{SSE}{n-2} = \frac{\sum e_i^2}{n-2}$ |
| Standard deviation  | $\sigma_x = \sqrt{\sigma^2_x}$                     | $\sigma_\varepsilon = \sqrt{\sigma^2_\varepsilon}$                |
| Standard error      | $SE_{\bar{x}} = \frac{\sigma_x}{\sqrt{n}}$         | $SE_{b_1} = \sqrt{\frac{\sigma^2_\varepsilon}{\sum(x_i-\bar{x})^2}}$ |
| Confidence interval | $\mu = \bar{x} \pm t \cdot SE_{\bar{x}}$           | $\beta_1 = b_1 \pm t \cdot SE_{b_1}$                             |

<br>

</div>

<br>

# Key relationships

## Four topics, one operation

The lecture appears to introduce four separate measures — variance, covariance,
correlation, and the regression slope. It does not. It introduces **one
operation** and then divides it by four different things.

Take a deviation. Multiply it by a second deviation. Add up the products.
That is it:

- Multiply a deviation **by itself** and divide by $n-1$ → **variance**
- Multiply x's deviation **by y's deviation** and divide by $n-1$ → **covariance**
- Divide covariance **by the variance of X** → **the slope**
- Divide covariance **by both standard deviations** → **the correlation**

Variance is not a different kind of thing from covariance; it is the special
case where both variables are the same one. If you understand the deviation
product, you understand the whole lecture, and the four names are just
bookkeeping for what sits in the denominator.

## The denominator decides the interpretation

Slope and correlation have the **identical numerator**. Everything that
distinguishes them is what they are divided by, and what you divide by
determines what units survive:

- **The slope keeps units.** Dividing by $var(x)$ leaves "units of Y per unit
  of X." That is why a slope can be interpreted as an effect: *heart rate rises
  9 bpm per 100 mg of caffeine.*
- **The correlation throws units away.** Dividing by both standard deviations
  cancels the units entirely, leaving a number between $-1$ and $+1$. That is
  why correlations can be compared across studies, and why a correlation can
  never tell you how large an effect is.

So: **slope answers "how much," correlation answers "how tightly."** Students
routinely treat a bigger slope as a stronger relationship. It is not, and the
scatterplot pairs at the end of the deck exist to break that habit.

## Sign, strength, and steepness are three different questions

The closing sequence of the lecture is a diagnostic, not new content. It
separates three things that intuition tends to fuse:

- **Sign** — do the variables move together or oppositely? Set by which
  quadrants the data occupy.
- **Strength** — how tightly does Y track X? Set by the spread around the line.
  A tight cloud beats a diffuse one.
- **Steepness** — how much does Y change per unit of X? Set by the slope, which
  depends on the *scales* of the variables and says nothing about strength.

The one case that ties them together: a perfectly flat line has zero
correlation no matter how tight the points are, because Y is not moving with X
at all. Tightness alone is not a relationship.

## This lecture is descriptive; the course is inferential

Nothing here involves uncertainty. Covariance, correlation, and the slope are
descriptions of the data in front of you — no sampling, no significance, no
claim about a population. That is worth noticing, because it is exactly what
the rest of the term adds.

Slide 2 is not a summary of this lecture. It is the map of the next four:

> variance → standard deviation → standard error → confidence interval

You climbed that ladder for the **mean** in your first statistics course. The
course now climbs it again for the **slope**. This lecture builds the bottom
rungs; p-02 partitions the variance, p-03 derives the standard errors, p-04
builds the confidence intervals. The only structural change on the slope side
is that dispersion gets measured with **residuals** ($e_i$, distance from the
point to the *line*) instead of deviations ($x_i - \bar{x}$, distance from the
point to the *mean*). Same ladder, different reference point.

This is also why the lecture insists on the phrase **"of the."** There is no
such thing as "the standard error" — only the standard error *of the mean* or
*of the slope*, which are different formulas answering different questions.

## How to read the slides

| Slides  | What they are doing                    | What to take away |
|---------|----------------------------------------|-------------------|
| 2–3     | The map for the whole unit             | Skim now; return after p-04. Slide 2 is a reference, not a lesson. |
| 4–8     | Variance, SD, SE via the cyclist metaphor | Variance is a total, SD is an average, SE is about the *estimate*. |
| 9–12    | Covariance mechanics                   | The four-quadrant diagram. This is the load-bearing image of the lecture. |
| 13–18   | Covariance by picture, including outliers | A single extreme point can dominate the entire measure. Plot before you trust a coefficient. |
| 19–21   | The regression slope                   | Slide 21 is the payoff: the slope is rise-over-run computed across all cases at once. |
| 22–24   | Correlation                            | It is a unit conversion, nothing more. |
| 25–29   | Self-test scatterplots                 | No new content. Check whether you have separated tightness, steepness, and sign. |
| 30      | The checklist                          | If any of the four is fuzzy, reread that block. |

The slides on outliers (16–18) are a thought experiment rather than new
material. Because covariance multiplies two deviations, one point far from
*both* means contributes a product that can outweigh every other case
combined — in the worked example, a single product of magnitude 100 against a
total of 3 from all the other points. The lesson is not a formula; it is that
the measure is fragile.

# What should be clear in my mind?

1. **What variance and standard deviation are.** Variance is total dispersion
   (a sum of squared deviations); standard deviation is typical dispersion (that
   sum averaged and returned to the original units).
2. **The difference between standard deviation and standard error.** Standard
   deviation is how far the *data* are from the mean. Standard error is how far
   your *estimate* is from the truth. One describes a sample; the other
   describes how much your answer would move if you drew a new sample.
3. **The definitions of covariance and correlation.** Covariance is the average
   product of paired deviations — positive when cases sit on the same side of
   both means. Correlation is that same quantity with the units divided out, so
   it lands between $-1$ and $+1$ and can be compared across studies.
4. **The "intuitive" regression formula.** $b_1 = cov(x,y) / var(x)$ — rise over
   run, computed simultaneously across every case in the data.

## Key takeaways

- **One operation, four names.** Variance, covariance, correlation, and slope
  are all built from the deviation product. Only the denominator changes.
- **Variance is a total; standard deviation is an average.** Two cyclists can
  ride the same number of trips and differ on both counts independently.
- **Deviations are squared because they otherwise sum to zero**, and the square
  root at the end is only there to restore interpretable units.
- **Standard deviation describes data; standard error describes estimates.**
  This distinction is the hinge the rest of the course turns on.
- **Covariance works by signs**, so it is fully determined by which quadrants
  around $(\bar{x}, \bar{y})$ the data occupy — and is therefore highly
  vulnerable to a single outlier.
- **Slope and correlation share a numerator.** Slope keeps units and answers
  *how much*; correlation drops units and answers *how tightly*.
- **The regression line always passes through $(\bar{x}, \bar{y})$.** Fitting
  only chooses the angle of tilt around that pivot.
- **Nothing in this lecture is inferential yet.** Uncertainty enters in p-02
  through p-04, using the same four-rung ladder applied to the slope.
