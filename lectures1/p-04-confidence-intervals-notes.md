---
title: "Confidence Intervals"
subtitle: "Reading guide for lecture p-04"
---

<div class="tip">

<br>

KEY CONCEPTS:

### A sampling distribution is the distribution of a statistic, not of data.

* Draw a sample, compute a statistic, write it down. Repeat.
* Population statistic: $\mu$ (fixed, unknown).
* Sample statistic: $\bar{x}$ (varies from sample to sample).
* The spread of those sample statistics is the sampling distribution.

### The standard error is the "average error" of a sample statistic.

*How far, on average, will our best guess be from the truth?*

* Of the mean: $SE_{\bar{x}} = \frac{s_x}{\sqrt{n}}$
* Of the slope: $SE_{b_1} = \sqrt{\frac{\sigma^2_\varepsilon}{\sum{(x_i - \bar{x})^2}}} \approx \frac{residual}{sample\ size \cdot var(x)}$

### The Central Limit Theorem is what makes inference possible.

The sampling distribution of the mean is **always normal**, no matter what the
population looks like. As the slide notes parenthetically — *otherwise we would
not have inferential statistics.*

### A confidence interval is an estimate plus or minus a margin.

* Of the mean: $\bar{x} - t \cdot SE_{\bar{x}} < \mu < \bar{x} + t \cdot SE_{\bar{x}}$
* Of the slope: $b_1 - t \cdot SE_{b_1} < \beta_1 < b_1 + t \cdot SE_{b_1}$

Equivalently, $\beta_1 = b_1 \pm t \cdot SE_{b_1}$.

### The 95% refers to the procedure, not to one interval.

> *An interval that will contain the true slope in 95% of the samples that we
> draw.*

The parameter is fixed. The interval is what moves from sample to sample.

### The road map is now complete.

|  | Of the mean | Of the slope |
|---|---|---|
| Variance | $\sigma^2_x = \frac{\sum(x_i-\bar{x})^2}{n-1}$ | $\sigma^2_\varepsilon = \frac{SSE}{n-2}$ |
| Standard deviation | $\sigma_x = \sqrt{\sigma^2_x}$ | $\sigma_\varepsilon = \sqrt{\sigma^2_\varepsilon}$ |
| Standard error | $SE_{\bar{x}} = \frac{\sigma_x}{\sqrt{n}}$ | $SE_{b_1} = \sqrt{\frac{\sigma^2_\varepsilon}{\sum(x_i-\bar{x})^2}}$ |
| Confidence interval | $\mu = \bar{x} \pm t \cdot SE_{\bar{x}}$ | $\beta_1 = b_1 \pm t \cdot SE_{b_1}$ |

<br>

</div>

<br>

# Key relationships

## The interval moves; the parameter does not

Slides 15 through 17 are the most important sequence in the deck, and they are
easy to flip past because each looks almost identical to the last.

In all three, the true mean $\mu$ is drawn as a fixed vertical line. What
changes is *which sample you happened to draw*:

- A sample from the **left tail** → the interval sits low, but still covers $\mu$.
- A sample from the **right tail** → the interval sits high, but still covers $\mu$.
- A sample from the **far right tail** → the interval sits too high and **misses** $\mu$.

Then the question: *how often will this happen?* Five percent of the time, by
construction.

This is the single most misread idea in applied statistics. A 95% confidence
interval does **not** mean there is a 95% chance the true value is inside
*your* interval. Your interval either contains it or it does not — you just
cannot tell which. The 95% is a property of the **procedure**: repeat the study
many times, and 95% of the intervals you build this way will capture the truth.

Read the three slides as three draws from the same machine, not as three
different situations.

## The Central Limit Theorem is load-bearing, not a footnote

Slide 8 is presented as an "aside," but nothing after it works without it.

A standard error is a single number describing spread. To turn a spread into an
*interval* you also need to know the **shape** of the sampling distribution —
how far out you must go to capture 95% of it. The CLT supplies that shape for
free, and crucially it does so regardless of what the population looks like.
The population can be skewed, lumpy, bimodal; the distribution of the sample
statistic still converges to normal.

That is why the slide's parenthetical is not a joke: *otherwise we would not
have inferential statistics.* Without a known shape, a standard error would be
uninterpretable.

## Everything is taught twice, on purpose

This deck has a strict two-column structure, and it is the same structure as
the road map:

1. Establish the concept on the **mean**, where you already have intuition from
   your first statistics course.
2. Re-establish it on the **slope**, where the arithmetic differs but the logic
   is identical.

Sampling distribution of the mean → sampling distribution of the slope.
Standard error of the mean → standard error of the slope. Confidence interval
of the mean → confidence interval of the slope.

If a slope concept feels slippery, find the matching mean slide and reason
there first. The transfer is exact; only the formula changes.

## Where "significance" is about to come from

Slide 19 plots the confidence interval of the slope against a dashed vertical
line at zero. The deck does not say the word yet, but that picture is the whole
of hypothesis testing:

- If the interval **excludes zero**, you can rule out "no relationship" at that
  confidence level. The result is statistically significant.
- If the interval **contains zero**, you cannot.

That is why the standard error matters so much in practice. It sets the width
of the interval, which decides whether zero falls inside. Chain the whole course
together and you get:

> unexplained variance → standard error → interval width → significance

Every lecture from p-02 forward has been building one link of that chain.

## Answering the deck's own third question

*"We care about the sampling variance of which statistic in regression?"*

The **slope**, $b_1$. Not of Y, not of X, not of the residual. Those all feed
into the calculation, but the thing whose sampling distribution we actually
care about — the thing we build an interval around and test — is the estimated
coefficient.

This is worth saying out loud because the arithmetic spends most of its time on
the variance of Y and the variance of X, which makes it easy to lose track of
what the answer is *about*.

## A note on the slides' notation

Slides 18 and 19 both write the interval as

$b_1 - t \cdot SE_{b_1} < \beta_1 > b_1 + t \cdot SE_{b_1}$

with a greater-than sign on the right. That should be a second less-than sign —
as written it says $\beta_1$ is larger than both endpoints, which is the
opposite of the intended meaning. The same slip appears on the mean version one
slide earlier. Read both as $<\ \ldots\ <$.

## How to read the slides

| Slides | What they are doing | What to take away |
|---|---|---|
| 2–3 | Road map and metaphors | Carried over. The fourth rung is finally the subject. |
| 4–7 | Sampling distribution of the mean | Population $\mu = 5$, one sample gives $\bar{x} = 5.4$. The gap is the error. |
| 8 | The CLT "aside" | Not an aside. This is what makes intervals possible. |
| 9–12 | Sampling distribution of the slope | Same story, now for $b_1$. Watch $n=10$ vs $n=50$. |
| 13 | The intuitive standard error | Repeated from p-03. Skim if it is solid. |
| 14 | Confidence intervals defined | Read this sentence carefully — it is about samples, not about one interval. |
| 15–17 | **The three-draw sequence** | The thesis. The interval moves; $\mu$ does not. Misses happen 5% of the time. |
| 18–19 | The formulas | Mean, then slope. Note the typo in the inequality. |
| 20 | The road map, complete | All four rungs, both columns. |
| 21 | Four questions | A real checklist this time, not a summary. |

# What should be clear in my mind?

The deck closes with four questions. Here is what each is looking for:

1. **What is a sampling distribution?** The distribution of a *statistic* across
   repeated samples from the same population — not the distribution of your
   data. A dot in it is one study, not one observation.
2. **What is the relationship between the sampling distribution and the standard
   error?** The standard error *is* the standard deviation of the sampling
   distribution. It measures the typical distance from an estimate to the truth.
3. **We care about the sampling variance of which statistic in regression?** The
   slope, $b_1$. Everything else is an input to computing it.
4. **What role does the standard error play in the confidence interval?** It
   sets the width. The interval is the estimate plus or minus $t$ standard
   errors, so a smaller standard error means a tighter interval and a more
   informative result.

## Key takeaways

- **A sampling distribution is made of statistics, not observations.** One dot
  is one whole study.
- **The standard error is the standard deviation of the sampling
  distribution** — the average distance from an estimate to the truth.
- **The Central Limit Theorem supplies the shape** that turns a standard error
  into an interval, and it works regardless of the population's shape.
- **The 95% belongs to the procedure.** Across many samples, 95% of the
  intervals built this way capture the parameter. Your particular interval
  either does or does not.
- **The parameter is fixed; the interval is what moves.** Slides 15–17 are
  three draws from one machine.
- **Everything is taught on the mean first, then transferred to the slope.**
  When the slope version is confusing, go back to the mean version.
- **An interval that excludes zero is a significant result** — this is where
  the course goes next.
