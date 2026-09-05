---
title: "Partitioning the Variance of Y"
subtitle: "Reading guide for lecture p-02"
---

<div class="tip">

<br>

KEY CONCEPTS:

### Inserting the regression line splits every deviation in two.

Take the distance from a point to the mean and add and subtract $\hat{y}_i$:

$\underbrace{y_i - \bar{y}}_{total} = \underbrace{(\hat{y}_i - \bar{y})}_{explained} + \underbrace{(y_i - \hat{y}_i)}_{unexplained}$

* $\hat{y}_i - \bar{y}$ = how far the model moved you off the mean
* $y_i - \hat{y}_i = e_i$ = how far it still missed by

### Squaring and summing gives three sums of squares.

* $Total\ SS = \sum{(y_i - \bar{y})^2}$
* $Regression\ SS = \sum{(\hat{y}_i - \bar{y})^2}$
* $Error\ SS = \sum{(y_i - \hat{y}_i)^2}$
* $TSS = RSS + ESS$

Divide any of them by $n-1$ and you have a variance. The slides often work with
the raw sums because the divisors cancel.

### $R^2$ is the explained share of the total.

* $R^2 = \frac{RSS}{TSS} = \frac{Explained\ SS}{Total\ SS}$
* $R^2 = 1 - \frac{ESS}{TSS}$

> *Note:* these slides use **RSS = Regression SS** and **ESS = Error SS**. The
> deck flags this itself — some textbooks use RSS for *residual* and ESS for
> *explained*.

### In Venn terms, the overlap between X and Y is the explained part.

* The circle Y is $var(y)$; the overlap with X is $cov(x,y)$.
* More overlap = more covariance = stronger correlation = higher $R^2$.
* $cov(x,y) = 0$ means the circles do not touch and X explains nothing.

### The standard error of the slope is built from the unexplained part.

* $SSE = \sum{e_i^2}$
* $\hat{\sigma}^2_\varepsilon = \frac{SSE}{n-2}$ &nbsp; (variance of the residual)
* $SE_{b_1} = \sqrt{\frac{\hat{\sigma}^2_\varepsilon}{\sum{(x_i - \bar{x})^2}}}$

### The same standard error can be written two ways.

Because $\sum{(x_i - \bar{x})^2} = (n-1) \cdot var(x)$:

$SE_{b_1} = \frac{s_\varepsilon}{\sqrt{(n-1) \cdot var(x)}} = \frac{s_\varepsilon}{\sqrt{\sum{(x_i - \bar{x})^2}}}$

The first form is preferred in the slides because it names its three moving
parts out loud:

$Standard\ Error\ of\ the\ Slope \approx \frac{residual}{sample\ size \cdot variance\ X}$

Compare the standard error of the *mean*, which has only two:
$SE_{\bar{x}} = \frac{s_x}{\sqrt{n}}$

<br>

</div>

<br>

# Key relationships

## The whole lecture is one algebraic trick

Add and subtract $\hat{y}_i$. That is it.

The distance from a data point to the mean is the only thing we had before
this lecture. By inserting the fitted value in the middle of that distance, it
becomes two distances: the part the model accounts for, and the part it does
not. Everything downstream — $R^2$, the standard error, the confidence
interval, the p-value — is bookkeeping on those two pieces.

Notice what is *not* being assumed here. This is an identity, not a modeling
choice. Any line drawn through the data would split the deviations this way.
What makes the regression line special is that it is the line that makes the
unexplained piece as small as possible.

> Worth knowing if a student asks why $TSS = RSS + ESS$ holds *exactly* rather
> than approximately: when you square the sum of the two pieces, the
> cross-product term sums to zero, because least squares forces the residuals
> to be uncorrelated with the fitted values. The slides do not derive this —
> they present the partition as a given — but that orthogonality is what makes
> it clean.

## Three pictures of the same partition

The deck shows the split three different ways, and the exercise is to be able
to move between them:

- **The scatterplot.** For one point, a bracket from the mean line up to the
  regression line (explained) and another from the line to the point
  (unexplained). This is the most literal picture.
- **The stacked bar.** Total variance of Y as a single column, cut into an
  orange explained portion and a blue unexplained portion. This is the picture
  that makes $R^2$ obvious — it is just the orange fraction.
- **The Venn diagram.** A circle for Y, a circle for X, and their overlap. The
  overlap is $cov(x,y)$, and it *is* the explained portion.

If you can look at a scatterplot and sketch its bar and its Venn diagram, you
have the lecture.

## The Venn diagram connects this lecture back to p-01

The overlap region is labelled $cov(x,y)$, and that is not decoration. In p-01
the slope was $cov(x,y)/var(x)$. Here the same covariance is the part of Y
that X can account for.

So covariance is doing two jobs at once: it sets the *size of the slope* and
it sets the *share of variance explained*. When the circles barely overlap you
get a small $b_1$ and a small $R^2$ together. When they overlap a lot you get
both large. That is why "more correlation" and "better fit" feel like the same
thing — in simple regression with one X, they are.

## $R^2$ and the standard error read the same split in opposite directions

This is the relationship worth carrying forward. One partition, two consumers:

| | Uses | Reports |
|---|---|---|
| $R^2 = RSS/TSS$ | the **explained** piece | how well the model fits |
| $SE_{b_1}$ | the **unexplained** piece | how precise the estimate is |

They are complements, not competitors: $R^2$ goes up exactly when the residual
goes down, which is exactly when the standard error shrinks. A model that
explains more of Y produces a tighter estimate of the slope. Fit and precision
are two readings of the same number.

This is also the honest answer to "why do we care about $R^2$?" On its own it
is a description. What matters is that the *other* half of the same split is
what determines whether your finding is statistically significant.

## Where the standard error gets its three levers

Writing the standard error as

$SE_{b_1} = \frac{s_\varepsilon}{\sqrt{(n-1) \cdot var(x)}}$

makes visible what the compact $\sum(x_i - \bar{x})^2$ version hides. Three
things, and only three, move it:

- **The residual** ($s_\varepsilon$, numerator) — unexplained variance in Y.
- **The sample size** ($n$, denominator) — more cases, more precision.
- **The variance of X** (denominator) — a treatment that barely varies cannot
  produce a precise estimate of its effect.

Contrast the standard error of the *mean*, $s_x/\sqrt{n}$, which has only the
first two. The third lever is new, and it is the one that has consequences for
research design: it says that how you *assign* or *sample* your explanatory
variable matters as much as how many cases you collect.

## Where this sits in the sequence

p-01 produced the slope out of covariance and variance. This lecture takes the
variance of Y apart and finds the standard error inside the leftover piece.
p-03 and p-04 take that standard error and turn it into a confidence interval
and a significance test. The road map slide near the end is the same one from
p-01, and by now three of its four rungs are built.

## How to read the slides

| Slides | What they are doing | What to take away |
|---|---|---|
| 1–2 | Variance recap | Squared distances from the mean, divided by $n-1$. Nothing new yet. |
| 3–7 | The partition and $R^2$ | $TSS = RSS + ESS$. This is the core. |
| 8, 14 | One point, close up | The bracket picture. Explained is mean-to-line; unexplained is line-to-point. |
| 9–10 | The two extremes | Perfect fit explains everything; the typical case explains some. |
| 11–12 | The stacked-bar version | $R^2$ as the orange fraction of the column. |
| 13, 15–17 | The Venn version | Overlap = $cov(x,y)$ = explained. Note the RSS/ESS footnote on slide 15. |
| 18–21 | Standard error of the slope | Built from the residual; three levers. |
| 22 | The road map | Same map as p-01. Rung three is now in place. |
| 23 | The checklist | Two items, both about the split. |

The repetition across slides 4, 6, 11, 12 is not padding — the same diagram is
being re-shown with a different annotation layered on each time. Read them as
one slide seen four ways.

# What should be clear in my mind?

1. **We split the variance of Y into explained and unexplained portions with a
   trick — inserting the regression line $\hat{y}$.** The distance from a point
   to the mean becomes the distance from the mean to the line, plus the distance
   from the line to the point. Square and sum, and $TSS = RSS + ESS$.
2. **The standard error of the slope is derived from the unexplained portion of
   Y, the residual.** Everything the model failed to explain becomes uncertainty
   about the slope. Improving fit and tightening your estimate are the same act.

## Key takeaways

- **The partition is an identity, not an assumption.** Adding and subtracting
  $\hat{y}_i$ always works; least squares just makes the leftover piece as small
  as it can be.
- **Three sums of squares, one equation.** $TSS = RSS + ESS$ — total, explained,
  error.
- **$R^2$ is the explained share**, $RSS/TSS$, and equivalently $1 - ESS/TSS$.
- **The Venn overlap is the covariance.** The same quantity that set the slope
  in p-01 sets the explained share here.
- **$R^2$ and $SE_{b_1}$ come from opposite halves of one split.** Better fit
  means a smaller residual means a smaller standard error.
- **The slope has three levers, the mean has two.** Residual, sample size, and —
  new in regression — the variance of X.
- **Watch the abbreviations.** These slides use RSS = Regression SS and ESS =
  Error SS; many textbooks reverse both.
