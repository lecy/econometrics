---
title: "Omitted Variable Bias"
subtitle: "Reading guide for lecture p-07"
---

<div class="tip">

<br>

KEY CONCEPTS:

### Greek letters mean the truth; Latin letters mean your best guess.

* **Full model** — every relevant variable is included, so the slopes are
  correct: $\beta_1$
* **Naïve model** — variables are missing, so the slopes may be biased: $b_1$

Note the mapping the deck makes explicit: *full model* plays the role of a
population statistic and *naïve model* the role of a sample statistic. But this
is not sampling error — you can have the entire population and still be wrong
if a variable is missing.

### The main question.

> If we have an omitted variable, will our estimate of program impact ($b_1$)
> sufficiently represent the true program impact ($\beta_1$)?

And the practical framing:

> We will ALWAYS have omitted variables in observational studies. The real
> question is not whether it is there, but how much will it affect our
> estimates?

### The three models.

* Full regression: $Y = \beta_0 + \beta_1 X_1 + \beta_2 X_2 + \varepsilon_1$
* Naïve regression: $Y = b_0 + b_1 X_1 + e$
* Auxiliary regression: $X_2 = \alpha_0 + \alpha_1 X_1 + \varepsilon_2$

The auxiliary regression puts the **omitted variable on the left-hand side**.

### The take-away, in three lines.

1. $bias = \beta_2 \alpha_1$ — the product of two slopes: $X_1 \rightarrow X_2$
   and $X_2 \rightarrow Y$
2. $b_1 = \beta_1 + bias$ — the naïve slope is the true slope plus bias
3. $slope = \frac{cov(x,y)}{var(x)}$ — the sign of a slope always follows the
   sign of the covariance

### Bias is the indirect effect.

* $b_1 =$ direct effect **+** indirect effect
* $\beta_1 =$ direct effect
* $bias = b_1 - \beta_1 =$ indirect effect

The naïve slope absorbs everything that reaches Y *through* $X_1$, including
the part that really belongs to $X_2$.

### Two cases.

**Case 1 — omitted variable correlated with the policy variable.** The circles
overlap; the shared region is discarded by the regression. $b_1 \approx A + B$,
$\beta_1 \approx A$, so $bias \approx B$. **Biased.**

**Case 2 — omitted variable uncorrelated with the policy variable.** No overlap.
$b_1 \approx A$ and $\beta_1 \approx A$, so $bias \approx 0$. Since
$\alpha_1 = 0$, $bias = 0 \cdot \beta_2 = 0$. **Unbiased.**

### A worked example.

From the class-size data:

* naïve: $b_1 = -0.433$
* full: $\beta_1 = -0.377$
* auxiliary: $\alpha_1 = -0.0099$, and $\beta_2 = 5.65$

$\beta_2 \alpha_1 = 5.65 \cdot -0.0099 = -0.056$, and
$b_1 - \beta_1 = -0.433 - (-0.377) = -0.056$. The two routes agree.

In the multi-model table the bias reaches **51%** — the naïve model
overestimates program impact by half.

<br>

</div>

<br>

# Key relationships

## Bias needs two things to be true at once

This is the whole lecture compressed into one line:

$$bias = \alpha_1 \cdot \beta_2$$

A product is zero if either factor is zero, so omitted variable bias requires
**both**:

- $\alpha_1 \neq 0$ — the omitted variable is **correlated with your policy
  variable**
- $\beta_2 \neq 0$ — the omitted variable **actually affects Y**

Fail either condition and the omission is harmless. This is why the deck can be
relaxed about the fact that observational studies always omit something: most
omitted variables are irrelevant on at least one of the two channels.

It also tells you what to worry about. The dangerous omitted variable is not
the one most strongly related to your outcome — it is the one related to your
outcome *and* to your treatment.

## You can sign the bias without measuring anything

Because bias is a product of two slopes, its **direction** is the product of two
signs. That is a genuinely useful skill, and it works even when the omitted
variable is unmeasurable:

| $\alpha_1$ ($X_1 \rightarrow X_2$) | $\beta_2$ ($X_2 \rightarrow Y$) | Bias | Naïve slope is |
|---|---|---|---|
| + | + | + | too large |
| − | − | + | too large |
| + | − | − | too small |
| − | + | − | too small |

So even if you cannot fix the problem, you can often say which way your estimate
is wrong — and therefore whether your finding survives. If you estimate a
positive effect and reason that the bias is positive, your true effect is
*smaller* than reported, and you should ask whether it would survive the
correction.

The deck's warning attaches here: *if the naïve slope is too large it can make
it look significant when it's not.*

## This is the mirror image of p-06

Put the two lectures side by side and they are the same diagram read in
opposite directions:

| | p-06: adding a control | p-07: omitting a variable |
|---|---|---|
| **Uncorrelated with $X_1$** | shrinks residual, slope unchanged, SE smaller | no bias |
| **Correlated with $X_1$** | eats the overlap, slope changes, SE larger | bias |

Notice that the *same* variable is harmless in both directions or harmful in
both directions. A control uncorrelated with your policy variable neither biases
you when omitted nor distorts you when added — it only ever affects precision.
A correlated one always does both.

That gives you the decision rule the two lectures jointly imply:

- **Correlated with $X_1$ and affects Y** → you must include it, and you will pay
  in standard errors.
- **Uncorrelated with $X_1$ but affects Y** → include it if you can; it is free
  precision.
- **Does not affect Y** → it does not matter either way.

p-06 showed the cost. p-07 shows the reason to pay it. Together they are the
accuracy-versus-precision trade from p-05, made concrete.

## Why bias is not the same as sampling error

Slide 2 makes a point worth dwelling on. You are used to Greek-versus-Latin
meaning population-versus-sample, and here it means full-model-versus-naïve.
The analogy is deliberate but the mechanism is completely different.

Sampling error shrinks as $n$ grows. **Omitted variable bias does not.** You can
have census data on every unit in the population and still get the wrong slope,
because the problem is not that you have too few rows — it is that you have too
few columns.

This is the clearest illustration of the p-05 distinction: more data buys you
efficiency, never unbiasedness. No sample size fixes a missing variable.

## The formula that cannot be used, and the one that can

Slide 13 is honest about something most treatments gloss over:

$$bias = b_1 - \beta_1$$

is the definition, and it is useless in practice — if you knew $\beta_1$ you
would not be estimating it.

What makes the lecture practical is the *other* route,
$bias = \alpha_1 \beta_2$, because both of those can sometimes be reasoned
about from theory, prior studies, or partial data even when the full model
cannot be run. That is the difference between a definition and a tool.

## The path diagram is the thing to remember

If you keep one image from this deck, keep the triangle:

- $X_1 \rightarrow Y$ is the **direct effect**, $\beta_1$
- $X_1 \rightarrow X_2 \rightarrow Y$ is the **indirect path**, $\alpha_1$ then
  $\beta_2$
- the naïve regression cannot tell the two routes apart, so it reports their sum

Every question about omitted variable bias reduces to: *is there a second route
from my treatment to my outcome, and how strong is it?*

## How to read the slides

| Slides | What they are doing | What to take away |
|---|---|---|
| 2 | Notation | Greek = truth, Latin = best guess. Bias is not sampling error. |
| 3–4 | The main question | Omission is universal; magnitude is the real question. |
| 5–8 | p-06 recapped | The two control types, restated as a setup. |
| 9–11 | The two cases | Correlated → bias. Uncorrelated → none. |
| 12 | The multi-model table | Bias of 51% in the worked example. |
| 13 | The definition | $b_1 - \beta_1$. True, and unusable. |
| 14–17 | Direct and indirect effects | The path diagram. Note $X_2$ goes on the left in the auxiliary regression. |
| 19 | Worked calculation | Both routes give $-0.056$. Check this arithmetic yourself. |
| 20 | **The take-away** | Three numbered lines. If you memorise one slide, this one. |
| 21 | Why it matters | Case 1 too large, Case 2 too small; significance can be manufactured. |
| 22–26 | When does OVB occur? | The two Venn cases, with the algebra beside each. |

This deck has no closing checklist. Slide 20 is the summary.

# What should be clear in my mind?

The deck ends on its take-away rather than a question list, so these are the
things to be able to produce on demand:

1. **What omitted variable bias is.** The naïve slope absorbs the indirect
   effect of the omitted variable, so $b_1 = \beta_1 + bias$.
2. **The two conditions.** Bias requires the omitted variable to be correlated
   with the policy variable *and* to affect the outcome. Either alone is
   harmless.
3. **How to compute it two ways.** $bias = b_1 - \beta_1$ (definition, needs the
   truth) or $bias = \alpha_1\beta_2$ (product of two estimable slopes).
4. **How to sign it.** Multiply the signs of the two paths to know whether your
   naïve estimate is too large or too small.
5. **Why more data does not help.** Bias is a specification problem, not a
   sampling problem.

## Key takeaways

- **$bias = \alpha_1 \beta_2$.** Two slopes multiplied — the effect of your
  treatment on the omitted variable, times the effect of the omitted variable on
  the outcome.
- **Both channels must be open.** Zero on either one means zero bias.
- **The naïve slope is direct plus indirect effect.** Regression cannot separate
  routes it cannot see.
- **You can often sign the bias without measuring the variable**, which tells you
  whether your result would survive correction.
- **Bias does not shrink with sample size.** It is a missing-column problem, not
  a missing-row problem.
- **The dangerous omitted variable is correlated with your treatment**, not
  merely predictive of your outcome.
- **p-06 and p-07 are one decision.** Correlated controls cost precision;
  omitting them costs accuracy. You have to choose, and the choice is about the
  world, not the data.
