---
title: "Control Variables"
subtitle: "Reading guide for lecture p-06"
---

<div class="tip">

<br>

KEY CONCEPTS:

### The driving question.

> Why are slopes and standard errors changing when we add "control" variables?

### A Ballentine diagram is a picture of the variance partition.

Two overlapping circles, one for Y and one for the policy variable $X_1$,
divided into three regions:

* the **overlap** — the part of Y that $X_1$ explains, i.e. $cov(X_1, Y)$
* the **Y-only** region — the residual, everything left unexplained
* the **$X_1$-only** region — variation in the treatment that does not move Y

### The slope and the standard error are both ratios of regions.

Using the labels on the two-type slides (**A** = residual, **B** = overlap,
**C** = $X_1$ only):

* $slope = \frac{cov(X_1,Y)}{var(X_1)} = \frac{B}{B+C}$
* $SE_{b_1} \approx \frac{residual}{n \cdot var(X_1)} = \frac{A}{B+C}$

Both share the denominator $var(X_1)$. The slope uses the overlap on top; the
standard error uses the residual on top.

### There are three ways to shrink the standard error.

1. Increase the **sample size**
2. **Explain more variance of Y** — shrink the residual
3. **Increase the variance of X** — widen the treatment range

The second is what a control variable can buy you. The third is a design
choice: assigning caffeine over 0–1000mg instead of 0–500mg increases
$var(X)$.

### First type: a control uncorrelated with the policy variable.

Example: teacher quality, when studying class size.

* It overlaps **Y only** — it eats into the residual.
* $slope: \frac{B}{B+C} \rightarrow \frac{B}{B+C}$ — **unchanged**
* $SE_{b_1}: \frac{A}{B+C} \rightarrow \frac{a}{B+C}$ — **smaller**

In the worked example the slope moves from $-4.22$ to $-3.91$ and the standard
error falls from $0.18$ to $0.03$ — six times smaller.

### Second type: a control correlated with the policy variable.

Example: socio-economic status, when studying class size.

* It overlaps **both circles** — it eats into the explained overlap.
* $slope: \frac{B}{B+C} \rightarrow \frac{b}{b+c}$ — **changes**, up or down
* $SE_{b_1}: \frac{A}{B+C} \rightarrow \frac{a}{b+c}$ — **usually larger**

In the worked example the slope moves from $-4.22$ to $-2.67$ and the standard
error rises from $0.18$ to $1.63$ — almost ten times larger.

### Control variables target either the Explained SS or the Residual SS.

That single sentence is the whole lecture.

### $R^2$ in region terms.

$R^2 = \frac{explained\ var(y)}{var(y)}$, and the error $\varepsilon$ is
proportional to the residual region.

<br>

</div>

<br>

# Key relationships

## Every control variable eats one of the two halves

p-02 split the variance of Y into an explained piece and a residual piece. This
lecture asks a single question about that split: **when you add a new variable,
which piece does it come out of?**

There are only two answers, and they have opposite consequences:

| The control is… | It removes… | Slope | Standard error |
|---|---|---|---|
| uncorrelated with $X_1$ | **residual** | unchanged | **smaller** |
| correlated with $X_1$ | **explained overlap** | changes | **larger** |

Everything else in the deck — the diagrams, the regression tables, the
coefficient plots — is a demonstration of those two rows.

## Why the first type is nearly free

A control that predicts Y but has nothing to do with your treatment sits on top
of the Y circle without touching the overlap. Teacher quality explains test
scores; it is essentially uncorrelated with class size (the deck's pairs plot
shows $-0.057$).

Adding it shrinks the residual region and leaves both the numerator and
denominator of the slope untouched. You get the same estimate with a tighter
interval — the second of the three levers from p-03, cashed in.

The scatterplot pair on slide 27 shows this beautifully: the raw class-size vs.
test-score cloud is diffuse, and the same plot with teacher quality residualised
out is a tight band. Nothing about the relationship changed; the noise around it
was removed.

**This is the free lunch of regression.** If you can find variables that predict
your outcome and are unrelated to your treatment, add them.

## Why the second type is expensive

A control correlated with your policy variable overlaps *both* circles, and the
region it removes is the part they share — the very overlap that identifies your
slope.

Two things happen at once, and both are bad for precision:

- The numerator of the slope changes, because part of what you were attributing
  to $X_1$ is now attributed to the control. The estimate moves.
- The denominator, $var(X_1)$, shrinks, because the independent variation in
  $X_1$ is what is left after removing the shared part. A smaller denominator
  means a larger standard error.

In the worked example, socio-economic status correlates with class size at
$-0.99$. Almost nothing is left of class size once SES is accounted for, which
is why the standard error explodes by a factor of ten and the coefficient
collapses toward zero.

## The trap: this deck shows the cost, not the decision

It would be easy to read slides 17 and 18 as "do not add correlated controls."
That is exactly the wrong lesson, and the next lecture is the correction.

A correlated control might be **necessary**. If SES genuinely causes both class
size and test scores, then leaving it out gives you a biased estimate — the
class-size coefficient would be absorbing SES's effect. p-07 (omitted variable
bias) is about when you *must* pay this price.

So hold the two lectures together:

- **p-06:** correlated controls cost you precision.
- **p-07:** omitting them costs you accuracy.

And recall p-05's pair: unbiased and efficient. A correlated control trades
efficiency for unbiasedness. Whether that is a good trade depends entirely on
whether the variable belongs in the model, which is a question about the world,
not about the data.

## Why experiments make this problem disappear

The coffee-study slides reframe the caffeine example as observational: caffeine
is no longer assigned, it is chosen. That is what creates the possibility of
correlated controls in the first place.

Under random assignment, the treatment is by construction uncorrelated with
everything else. Every available control is therefore a **type-one** control:
it can only shrink the residual, never shift the slope. That is a large part of
why experiments are valuable, and it is the subject of the
randomization-breaks-OVB slides.

## Design and the third lever

Slide 12 is the one that is easy to skip and worth pausing on. Assigning
caffeine across 0–1000mg rather than 0–500mg makes the $X_1$ circle bigger,
which enlarges the denominator of both the slope and the standard error.

You cannot do this after the fact. Unlike adding controls, widening the range
of the treatment is a decision made before data collection — which is why the
third lever belongs to research design rather than to modelling.

## A note on the diagrams' labels

The deck uses the letters A, B, C in two different ways, and it is worth
knowing before you start comparing slides:

- On the early slides and on the $R^2$ slide, **A is the overlap** (explained)
  and **B is the residual**: $R^2 \approx \frac{A}{A+B}$, and
  $SE \approx \frac{B}{n(A+C)}$.
- On the two-type slides, **A is the residual** and **B is the overlap**:
  $slope = \frac{B}{B+C}$, $SE = \frac{A}{B+C}$.

The regions and the logic are identical in both; only the letters swap. Read
each diagram on its own terms rather than carrying the letters across.

## How to read the slides

| Slides | What they are doing | What to take away |
|---|---|---|
| 2 | The driving question | Why do slopes *and* standard errors move? |
| 3–7 | Ballentine diagrams introduced | Three regions; the slope is a ratio of two of them. |
| 8–9 | Residual and $R^2$ | Same overlap can mean different $R^2$ if var(Y) differs. |
| 10–12 | The three levers, in region terms | Slide 12 on widening $var(X)$ is a design point. |
| 13–14 | The two types, and a pairs plot | Note teacher quality vs class size is $-0.057$; SES is $-0.99$. |
| 15–16 | **Type one: uncorrelated** | Slope steady, standard error six times smaller. |
| 17–18 | **Type two: correlated** | Slope collapses, standard error ten times larger. |
| 19–24 | The coffee study | Observational data is where correlated controls come from. |
| 25–28 | Class-size example worked visually | Residualised scatterplots: the noise, removed. |
| 29 | Coefficient plots of the three models | Model 2 tightest; Model 4 crosses zero. |
| 30–32 | $R^2$, and removing the explained SS | Closing the loop back to the partition. |

This deck has no closing checklist slide. The question on slide 2 is the
checklist.

# What should be clear in my mind?

The deck opens with one question rather than closing with a list, so this is
what you should be able to answer:

1. **Why do slopes change when we add controls?** Because a control that is
   correlated with the policy variable takes over part of the shared overlap.
   The slope is recomputed on what remains, so it moves — up or down, depending
   on the direction of the correlations.
2. **Why do standard errors change when we add controls?** Because both pieces
   of $SE_{b_1} \approx \frac{residual}{n \cdot var(X_1)}$ can move. An
   uncorrelated control shrinks the numerator (good). A correlated control
   shrinks the denominator (bad), usually by more.
3. **Which kind of control is which?** Look at the correlation between the
   control and your policy variable, not between the control and Y.
4. **When is a bigger standard error worth accepting?** When the control is
   needed to avoid bias — the subject of p-07.

## Key takeaways

- **Controls target one of the two halves of the variance partition** — the
  residual or the explained overlap. Which one determines everything.
- **Uncorrelated controls are close to free.** They shrink the residual, leave
  the slope alone, and tighten the interval.
- **Correlated controls are expensive.** They change the estimate and inflate
  the standard error by eating the overlap that identifies it.
- **What matters is the control's correlation with X, not with Y.** A control
  strongly related to Y and unrelated to your treatment is the ideal case.
- **The standard error blows up as a control approaches perfect collinearity
  with the treatment** — at $-0.99$, there is almost no independent variation
  left to estimate from.
- **Precision is not the only goal.** p-07 explains when you must accept a worse
  standard error to get an unbiased estimate.
- **Random assignment turns every control into the harmless kind**, which is a
  large part of the case for experiments.
- **Widening the range of the treatment is a design lever** you cannot pull once
  the data are collected.
