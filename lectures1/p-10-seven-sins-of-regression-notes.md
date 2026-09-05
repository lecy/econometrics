---
title: "Seven Sins of Regression"
subtitle: "Reading guide for lecture p-10"
---

<div class="tip">

<br>

KEY CONCEPTS:

### (1) Omitted variable bias.

A variable Z related to both X and Y is left out.

* **When it matters:** spurious correlations ($Z \rightarrow X$ and
  $Z \rightarrow Y$) and indirect effects ($X \rightarrow Z \rightarrow Y$)
* **When it doesn't:** Z unrelated to X

### (2) Multicollinearity.

Two explanatory variables are highly correlated with each other.

* You **cannot tell the independent effects** of either variable
* The standard errors of **both** slopes are inflated
* The higher the collinearity, the smaller the independent region, the larger
  the standard errors, the less likely significance

### (3) Measurement bias.

* Measurement error is **random** error
* In the **dependent** variable → affects **standard errors only**
* In an **independent** variable → causes **attenuation**
* Attenuation **always pushes the slope toward zero**, whether the relationship
  is positive or negative
* **Systematic** mis-measurement (adding the same amount to each observation) is
  a linear transformation, and changes nothing but the intercept

### (4) Misspecification bias.

The functional form is wrong — a straight line fitted to a curved relationship.

### (5) Group differences (heterogeneity bias).

> If you have natural group structures in your data and there are innate
> differences in the groups that are correlated with your study variable, then
> you will likely end up with heterogeneity bias if you do not include the
> groups in your model.

A "group" can be many individuals over one or more periods — **or one
individual measured over time**.

Six scenarios, comparing the pooled model against within-group (fixed-effect)
slopes:

| Scenario | Pooled model is |
|---|---|
| 1 | unbiased + efficient |
| 2 | unbiased + inefficient |
| 3 | biased + inefficient |
| Matthew effect | program impact over-stated |
| Artificial program impact | program impact over-stated |
| Simpson's paradox | **impact has the wrong sign** |

### (6) Bias via selection.

When people choose whether to participate, the treatment group differs from the
control group on whatever drove that choice — e.g. *propensity to succeed*.

Self-selected groups and randomly assigned groups can produce opposite slopes
from the same underlying process.

### (7) Simultaneity bias.

The causal structure is a feedback loop: $X_1 \rightarrow Y \rightarrow X_2
\rightarrow X_1$. Independent effects cannot be separated. Monetary policy is
the standard example.

<br>

</div>

<br>

# Key relationships

## Five of the seven are the same sin wearing different clothes

The deck presents seven items. They are not seven independent topics. Look at
what is actually missing from the model in each case:

| Sin | What is omitted |
|---|---|
| (1) Omitted variable bias | a confounder Z |
| (5) Heterogeneity bias | **group membership** |
| (6) Selection bias | **whatever drove the decision to participate** |
| (7) Simultaneity | the reverse-causal path |

All four are the same diagnosis: **something correlated with X is not in the
model**, so $b_1$ absorbs its effect. Run each through
$bias = \alpha_1 \beta_2$ from p-07 and the arithmetic is identical. Only the
name of the missing thing changes.

Sin (2), multicollinearity, is the *cost of the cure* — what happens when the
variable you added to fix the problem is too closely tied to your treatment.
Sins (3) and (4) are the measurement and functional-form problems from p-09.

So the deck is really: one disease with four presentations, one expensive
treatment, and two unrelated ailments. Learning it as seven separate facts is
much harder than learning it as that.

## Multicollinearity and omitted variable bias are the two ends of one dial

This is the tension p-06 introduced, now named on both ends.

- Leave the correlated variable **out** → omitted variable bias. Your estimate is
  wrong.
- Put it **in** → multicollinearity. Your estimate is right on average but the
  standard errors balloon, because there is little independent variation left in
  X to estimate from.

Notice that these are not two different problems to be avoided separately. They
are two readings of the same fact: *your treatment and your confounder move
together*. There is no specification that escapes both. What you choose is which
cost to pay.

And there is no statistical test that resolves it, because the question is
whether the variable belongs in the model — a claim about the world.

## Heterogeneity bias is the most under-appreciated sin

The blood pressure example is the one to remember, because the numbers reverse.

Pooled across everyone, the regression of blood pressure on dosage gives a
**positive** slope of $+3.664$, highly significant, with $R^2 = 0.73$. Every
diagnostic looks excellent.

Split by individual, **every within-person slope is negative**. Higher doses
lower blood pressure — for each person.

Both results are correct descriptions of different comparisons. The pooled slope
is comparing *across* people: sicker people take more medication and have higher
blood pressure. The within-person slope compares each person to themselves.
Only the second answers "what does the drug do?"

This is Simpson's paradox, and the deck's six-scenario slide shows that it is
the extreme case of a continuum — the pooled model can be fine, merely
inefficient, over-stated, or sign-flipped, depending on how the group intercepts
line up with X.

**The practical rule:** if your data have a natural group structure — people
over time, students in schools, firms in industries — the pooled slope is
answering a different question from the within-group slope, and you have to
decide which one you meant.

## Cross-section variation versus within-group variation

The two slides with those titles are the whole idea, and it is worth naming the
distinction as a habit:

- **Cross-section (between-group) variation** compares different units to each
  other. It is contaminated by everything those units differ on.
- **Within-group variation** compares a unit to itself. Everything fixed about
  that unit — measured or not — cancels.

Including group dummies (fixed effects) forces the model to use only the second.
That is why the technique is so powerful: it removes *all* time-invariant
confounders at once without measuring any of them, which is the same trick DiD
plays in p-08 and the same ambition randomization achieves in a different way.

## Selection bias is heterogeneity bias you caused by asking

The office-hours example is neat because both panels show real data from the
same underlying process, and the slopes point in opposite directions.

When students **choose** whether to attend office hours, attendance is
correlated with an unmeasured propensity — and if weaker students seek help, the
raw comparison makes tutoring look harmful. When students are **assigned**, that
correlation is broken and the true positive effect appears.

The Venn version makes the mechanism explicit: in the self-selected panel the
"propensity to succeed" circle overlaps both office hours and test scores. That
is precisely $\alpha_1 \neq 0$ and $\beta_2 \neq 0$ — the two conditions for
bias from p-07.

## How to read the slides

| Slides | What they are doing | What to take away |
|---|---|---|
| 2–4 | Sin 1: omitted variables | Spurious vs. indirect; when Z is harmless. |
| 5–6 | Sin 2: multicollinearity | The independent region shrinks; standard errors inflate. |
| 7–11 | Sin 3: measurement | Random error vs. systematic. Attenuation always toward zero. |
| 12 | Sin 4: misspecification | Cross-reference p-09. |
| 13–14 | Sin 5 introduced | **The six-scenario slide.** Pooled vs. fixed-effect slopes. |
| 15–17 | Cross-section vs within-group | The blood-pressure reversal. Pooled $+3.66$, within-person all negative. |
| 18–20 | Heterogeneity in Venn form | Used cars: if car type is uncorrelated with mileage, $\alpha_1 = 0$ and there is no bias. |
| 21–23 | Sin 6: selection | Self-selected vs assigned. Propensity to succeed is the omitted variable. |
| 24 | Sin 7: simultaneity | Feedback loops. Flagged as not covered further. |

# What should be clear in my mind?

This deck has no closing checklist. These are the things to be able to do:

1. **Name all seven and say what each does to the slope and the standard
   error.** Most bias the slope; multicollinearity inflates standard errors;
   measurement error in Y does only the latter.
2. **Recognise that sins 1, 5, 6, and 7 share a mechanism.** Something
   correlated with X is missing, so $b_1$ absorbs it.
3. **Explain the multicollinearity/OVB trade-off** and why no test settles it.
4. **Reproduce the blood-pressure reversal** and say which slope answers the
   causal question.
5. **Explain why fixed effects work** — they use within-group variation only,
   which cancels every time-invariant difference.
6. **Spot selection bias in a study design** by asking what determined who ended
   up in the treatment group.

## Key takeaways

- **Seven sins, but mostly one mechanism.** OVB, heterogeneity, selection, and
  simultaneity all reduce to something correlated with X being outside the
  model.
- **Multicollinearity is the price of fixing OVB**, not a separate hazard to
  dodge. You choose which cost to pay.
- **Attenuation always runs toward zero**; systematic mis-measurement moves only
  the intercept.
- **A "group" can be one person measured repeatedly.** Panel data is group data.
- **Pooled and within-group slopes answer different questions** and can have
  opposite signs.
- **Simpson's paradox is the extreme end of heterogeneity bias**, not a curiosity.
- **Fixed effects remove all time-invariant confounders without measuring any of
  them.**
- **Selection bias is created by who chose to participate.** Ask what drove the
  choice; that is your omitted variable.
