---
title: "Statistical Power"
subtitle: "Reading guide for lecture p-11"
---

<div class="tip">

<br>

KEY CONCEPTS:

### Statistical power is not the level of confidence.

> Power determines how often we **reject the null** (the CI does not contain
> ZERO). Level of confidence is how often a confidence interval drawn from a
> random sample will contain the **TRUE SLOPE**.

Two different reference points, two different questions. A study can be
performing exactly as designed on one and failing badly on the other.

### Statistical power, defined.

> The probability of identifying a specific program effect (slope or effect
> size) using a specific sampling framework.

Note the two qualifiers: power is always power *for a particular effect size*
under *a particular design*. It is not a property of a method.

### "Type I error" is used in two distinct ways.

| | Null is | A false positive means | Measured by |
|---|---|---|---|
| **Sampling version** | the true slope | the CI misses the true value | alpha |
| **Program evaluation version** | slope $= 0$ | concluding a program worked when it did not | the regression p-value |

The p-value your software reports corresponds to the **second**.

### The worked example.

True slope $= 1$, $n = 10$, alpha $= 0.05$, 100 simulated samples:

* **7 of 100** confidence intervals fail to contain the true slope — about what
  alpha predicts. Confidence is working.
* **More than half** of the samples fail to reject the null. Power is terrible.
* The p-value would be around 0.50

### Three ways to increase power.

1. **Increase the sample size.** $n = 10 \rightarrow 50$: failure to reject
   drops from about $\frac{1}{2}$ to about $\frac{1}{3}$. At $n = 75$, only
   5–10%.
2. **Add control variables.** Same mechanism — a smaller residual means a
   smaller standard error means a narrower interval.
3. **Have a bigger effect to find.** With $n = 10$ but a true slope of 4 instead
   of 1, power is high. *It is easier to detect large changes than small ones.*

### Leverage can bias estimates systematically across random samples.

If the sampling frame concentrates observations in particular regions of X,
those high-leverage points pull the fitted slope in a consistent direction —
producing estimates that are systematically too large or too small even though
every sample was drawn at random.

<br>

</div>

<br>

# Key relationships

## The distinction this deck exists to make

Almost everything here is in service of one sentence: **confidence and power
are different properties, measured against different nulls.**

Take the worked example seriously, because the two numbers point opposite ways:

- Only 7 of 100 intervals miss the **true slope of 1**. With alpha at 0.05 you
  expected about 5. The confidence procedure is behaving exactly as advertised.
- Yet more than half of those same intervals contain **zero**, so more than half
  of these studies would report "no significant effect" — about a real effect.

Both statements describe the same 100 simulations. Nothing is broken. The study
is correctly quantifying its own uncertainty and is simply too small to
distinguish a slope of 1 from a slope of 0.

The lesson: **"we used a 95% confidence interval" says nothing about whether
your study could have found anything.** Those are separate design questions, and
only the second is about power.

## Two nulls, two false positives

The deck is unusually careful about a genuine ambiguity in the term "Type I
error," and it is worth keeping the two straight:

- In the **sampling** sense, the null is the true parameter, and a false
  positive is an interval that fails to cover it. This is the frequentist
  coverage property from p-04's three-draw sequence — the purple intervals in
  the simulation.
- In the **program evaluation** sense, the null is zero effect, and a false
  positive is claiming a program worked when it did not. This is what a p-value
  in a regression table reports, and it is the version that matters for
  decisions.

They coincide only in the special case where the true effect actually is zero.
Everywhere else they are answering different questions, which is why a study can
have good coverage and no power at the same time.

## Power depends on the effect you are looking for

The slide that makes this concrete is the one where the sample size stays at 10
and the true slope changes from 1 to 4. Nothing about the design improved — same
data-collection budget, same noise — and power goes from dismal to good.

That has two consequences worth carrying into research design:

- **You cannot compute power without naming an effect size.** "Is my study
  powered?" is not a well-formed question. "Is my study powered to detect a
  slope of 1?" is.
- **Small effects require large studies, and the relationship is unforgiving.**
  If the intervention you are evaluating is realistically going to move the
  outcome a little, the sample size must do all the work.

This is also the honest reason many program evaluations fail to find effects. It
is often not that the program did nothing; it is that the design could never
have detected what the program plausibly does.

## Power reuses the same three levers

Slide 12 says power improves with sample size or control variables. That is not
a new mechanism — it is the standard-error formula from p-03, seen from the
other end:

$SE_{b_1} \approx \frac{residual}{sample\ size \cdot var(x)}$

Anything that shrinks the standard error narrows the interval, and a narrower
interval is less likely to contain zero. So the levers for power are the levers
for precision:

- more cases,
- more explained variance (controls, from p-06),
- more variation in X.

Which means the whole course now closes a loop. Unexplained variance sets the
standard error (p-02, p-03); the standard error sets the interval (p-04); the
interval decides significance (p-05); and how often you get significance when
there is something to find is power (p-11).

## Type II errors are a design failure, not an analysis failure

Put p-05's error table next to this deck and the asymmetry stands out:

- **Type I errors** come mostly from **bias** — a mis-specified model, an
  omitted variable. They are fixed by thinking harder about the model.
- **Type II errors** come mostly from **low power** — too few cases, too much
  noise, too small an effect. They are fixed *before data collection* or not at
  all.

You can re-specify a model after the fact. You cannot re-power a study after the
fact. That is the practical argument for doing power calculations at the design
stage rather than treating them as a reviewer's request.

## The leverage puzzle at the end

Slides 16 and 17 pose a question rather than answering it: the estimates are
systematically too large (then too small) across repeated random samples. If
sampling is random, where does a *systematic* error come from?

Slides 18 and 19 give the answer with one word circled — **leverage**. Points at
the extremes of X exert disproportionate pull on the fitted line (this is p-09's
outlier geometry). When the sampling frame reliably includes a cluster in a
high-leverage region, every sample inherits the same tug, and the bias shows up
in the sampling distribution as a shifted centre rather than as extra spread.

The important structural point: this is **bias, not noise**. More samples will
not average it away, and a larger $n$ will not fix it. It is a specification
problem masquerading as a sampling one — which is exactly what the deck's hint
says.

## How to read the slides

| Slides | What they are doing | What to take away |
|---|---|---|
| 1–4 | Sampling distribution recap | $n = 10$ vs $n = 50$. Carried over from p-03. |
| 5–7 | Confidence interval width | 60%, 90%, 95%, 99% on the same estimate. |
| 8–9 | The normal distribution and $n = 50$ | Setup for the simulation. |
| 10–11 | **The two-nulls slides** | The thesis. Read the notes text carefully — it is doing the work. |
| 12–14 | Power and sample size | $n = 10 \rightarrow 50 \rightarrow 75$; failure rate $\frac{1}{2} \rightarrow \frac{1}{3} \rightarrow 5\text{–}10\%$. |
| 15 | Power and effect size | True slope of 4 at $n = 10$. Big effects are easy to find. |
| 16–17 | **A puzzle** | Systematic error from random samples. Try to answer before turning the page. |
| 18–19 | The answer: leverage | Extreme-X clusters bias every sample the same way. |

# What should be clear in my mind?

This deck has no closing checklist. These are the things to be able to answer:

1. **The difference between confidence and power.** Confidence asks how often
   your interval covers the true slope. Power asks how often you reject zero
   when the effect is real. Different nulls, different questions.
2. **Why a study can have correct coverage and no power.** The interval is
   honestly reporting a lot of uncertainty; that uncertainty just happens to
   span zero.
3. **The two meanings of Type I error**, and which one your regression p-value
   reports.
4. **What power depends on:** sample size, residual variance, variation in X,
   and the size of the effect you are trying to detect.
5. **Why power must be specified against an effect size.** "Powered" is
   meaningless without "powered to detect what."
6. **Why leverage produces systematic rather than random error**, and why more
   sampling will not fix it.

## Key takeaways

- **Power and confidence are not the same thing.** One is measured against the
  true slope, the other against zero.
- **7 misses in 100 is good coverage; failing to reject half the time is bad
  power.** Both were true of the same simulation.
- **Power is always power to detect a specific effect** under a specific design.
- **Big effects are easy to find; small ones need large samples.** Sample size
  and effect size trade off directly.
- **The levers for power are the levers for precision** — more cases, more
  explained variance, more spread in X.
- **Type I errors are usually a modelling failure; Type II errors are usually a
  design failure.** Only the first can be fixed after the data are collected.
- **Leverage biases every sample the same way**, so it shows up as a shifted
  sampling distribution, not a wider one.
