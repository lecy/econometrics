---
title: "Hypothesis Testing with Dummy Variables"
subtitle: "Reading guide"
---

<div class="tip">

<br>

KEY CONCEPTS:

### The motivating example: Teach for America.

Average math score (percentile) by group:

|  | Suburban | Urban |
|---|---|---|
| **Regular teachers** | 75 | 57 |
| **Teach for America** | 75 | 66 |

10 TFA fellows (4 suburban, 6 urban), 10 regular teachers (7 suburban, 3
urban).

* **Pooled comparison:** TFA $= \frac{4(75)+6(66)}{10} = 69.6$; regular
  $= \frac{7(75)+3(57)}{10} = 69.6$. **No difference.**
* **Within suburban schools:** 75 vs 75. No difference.
* **Within urban schools:** 66 vs 57. **A 9-point difference.**

The pooled comparison hides the effect because TFA fellows are concentrated in
urban schools and regular teachers in suburban ones. Comparing programs without
controlling for environment leads us to conclude TFA is *not* working when it
is.

### Two ways to write the same model.

**Cell-means (fully interacted, no intercept):**

$math = b_1 d.sub.tfa + b_2 d.sub.reg + b_3 d.urb.tfa + b_4 d.urb.reg$

Each coefficient **is** a group mean: 75, 75, 66, 57. There is no intercept —
the four dummies sum to a column of 1s, so including one would be perfect
multicollinearity.

**Reference-group (additive with interaction):**

$math = b_0 + b_1 d.sub + b_2 d.reg + b_3 d.sub.reg$

with $b_0 = 66$, $b_1 = 9$, $b_2 = -9$, $b_3 = 9$:

* $b_0 = 66$ — urban TFA (the reference group)
* $b_0 + b_1 = 75$ — suburban TFA
* $b_0 + b_2 = 57$ — urban regular
* $b_0 + b_1 + b_2 + b_3 = 66 + 9 - 9 + 9 = 75$ — suburban regular

### You can always recover the group means.

> No matter which groups you omit, you can always recover the group means. You
> just multiply all coefficients by the appropriate row in the design matrix.

### Why not use the cell-means model?

Because each coefficient would be tested against zero, and *"is this group mean
zero?"* is not a research question. We already know the means are not zero.

The cell-means model makes group means easy to read and makes hypothesis
testing impossible.

### The contrasts you actually want.

With four groups A, B, C, D there are six pairwise comparisons:

* $H_1$: A = B? Do regular teachers perform differently in urban and suburban schools?
* $H_2$: B = D? Do regular and TFA teachers differ in urban schools?
* $H_3$: A = C? Do regular and TFA teachers differ in suburban schools?

The reference-group parameterization turns three of these into direct tests of
$b_1 = 0$, $b_2 = 0$, and $b_3 = 0$.

### The interaction is a test against a counterfactual.

* $b_0 + b_1 + b_2$ = the **additive expectation** (the counterfactual)
* $b_0 + b_1 + b_2 + b_3$ = what is actually observed
* Testing $b_3 = 0$ asks whether the combination is simply additive

### The same structure covers many designs.

* **Pre-post with control group:**
  $outcome = b_0 + b_1 d.treat + b_2 d.time2 + b_3 d.treat.post$ — test $b_3$
* **Differential treatment response:**
  $BP = b_0 + b_1 d.treat + b_2 d.female + b_3 d.treat.female$ — does the drug
  work the same for women as for men?
* **Compound disadvantage:** race × sex. Is the penalty for minority women
  simply the minority penalty plus the female penalty ($b_3 = 0$), or is there
  an extra penalty ($b_3 \neq 0$)?

### Two mechanical rules.

* A factor with $k$ levels becomes $k$ dummies, of which **one must be
  omitted** as the reference.
* **Dummies from the same categorical variable cannot be interacted** — the
  product is always zero, because the categories are mutually exclusive.

<br>

</div>

<br>

# Key relationships

## The specification decides which questions you can ask

This is the thesis, and it is a different point from anything earlier in the
sequence.

Both models in this deck are the *same model*. Same four group means, same
fitted values, same $R^2$, same residuals. Nothing about the description of the
data changes when you switch between them.

What changes is **which comparisons the software puts a p-value on**. Every
regression tests each coefficient against zero. So the parameterization you
choose determines which contrasts get tested for free — and which ones you would
have to compute by hand.

- The cell-means model tests four uninteresting hypotheses (is each group mean
  zero?).
- The reference-group model tests three interesting ones (is there an
  environment effect, a program effect, an interaction?).

**The design matrix is a research-question decision, not a formatting choice.**
That is the sentence to carry away.

## Choose your reference group so the tested contrast is the one you care about

It follows that omitting a different group changes what the coefficients mean —
and the deck shows exactly this. With urban TFA as the reference,
$b_0 = 66,\ b_1 = 9,\ b_2 = -9,\ b_3 = 9$. With suburban regular as the
reference, the same data give $75, -18, 0, 9$.

Both recover all four group means. But they hand you different default tests.

So the practical workflow is backwards from what students usually do: decide
which comparison answers your research question *first*, then pick the reference
category that makes that comparison a single coefficient.

## The TFA example is omitted variable bias, in table form

Before any regression appears, slides 3 through 13 have already made the
argument from p-07 using nothing but arithmetic.

Run it through $bias = \alpha_1 \beta_2$:

- $\alpha_1 \neq 0$: TFA status is correlated with school environment (6 of 10
  TFA fellows are in urban schools; 7 of 10 regular teachers are in suburban
  schools).
- $\beta_2 \neq 0$: school environment strongly affects scores (75 vs 57 for
  regular teachers).

Both channels are open, so omitting environment biases the program comparison.
And here the bias is large enough to cancel the effect exactly — 69.6 versus
69.6.

Notice which direction it runs. This is the case p-05 warned about in reverse:
not a false positive manufactured by bias, but a **false negative**. The naive
analysis concludes the program does not work. A program that helps in urban
schools gets defunded because more of its teachers are in urban schools.

## Why the pooled comparison is not just noisy but wrong

It is tempting to read the 69.6 = 69.6 result as "the effects cancel out." They
do not cancel; they were never comparable in the first place.

The pooled TFA average is 40% suburban and 60% urban. The pooled regular average
is 70% suburban and 30% urban. You are comparing two differently-weighted mixes
of two different populations. The number is a weighted average of things that
should not be averaged together.

This is the same structure as p-10's heterogeneity bias and the blood-pressure
reversal: **the between-group comparison and the within-group comparison are
different quantities**, and only the second answers the causal question.

## The interaction always tests "is the combination additive?"

Every example in the back half of the deck is the same test wearing different
clothing:

| Setting | $b_3$ asks |
|---|---|
| TFA × urban | does the program work differently in urban schools? |
| Treatment × post | did the treated group gain more than the common trend? |
| Treatment × female | does the drug work differently for women? |
| Minority × female | is the wage penalty more than the sum of its parts? |

In every case $b_0 + b_1 + b_2$ is the counterfactual — what you would expect if
the two factors acted independently — and $b_3$ is the gap between that
expectation and reality.

Once you see this, the difference-in-differences model from p-08 stops being a
special technique and becomes an instance: DiD is just treatment × time, and the
parallel-trends assumption is just the claim that the additive counterfactual is
the right one.

## The two mechanical rules, and why they hold

**Why one dummy must be omitted.** The full set of dummies for a factor sums to
a column of ones, which is exactly what the intercept already is. Including both
is perfect multicollinearity — the extreme end of p-10's second sin — and the
software will silently drop one for you. Better to choose which one.

**Why same-variable dummies cannot be interacted.** $White \times Black$ is zero
for every observation, because no one is both. An interaction asks "what happens
when both conditions hold," and for mutually exclusive categories that never
happens. Interactions are for combinations *across* factors, not within one.

## How to read the slides

| Slides | What they are doing | What to take away |
|---|---|---|
| 2–3 | The research question and the group means | Memorise the 2×2: 75/57 and 75/66. |
| 4–8 | The arithmetic | Pooled: no difference. Within urban: 9 points. |
| 9–13 | **Why the pooled comparison fails** | Selection into school type. This is OVB with no algebra. |
| 14–17 | The cell-means design matrix | Coefficients *are* group means; no intercept possible. |
| 18–20 | The reference-group design matrix | Additive coding; recover any mean from the design matrix row. |
| 21–24 | Hypothesis testing and contrasts | Six possible comparisons; which ones does your model test? |
| 25–27 | **Coefficients as contrasts** | $b_1 = 0$, $b_2 = 0$, $b_3 = 0$ each name a real question. |
| 28–30 | Pre-post designs and compound effects | DiD and the race×sex penalty as the same test. |
| 31–35 | Differential treatment response | Blood pressure and diet pills, with and without an interaction. |
| 36 | A different reference group | Same means, coefficients $75, -18, 0, 9$. |
| 37–41 | Number of groups | $k$ levels, $k-1$ dummies; never interact within a factor. |
| 42–46 | Venn diagrams | Group structure as a control variable. Back to p-10. |

# What should be clear in my mind?

This deck has no closing checklist. These are the things to be able to do:

1. **Explain why the pooled TFA comparison shows no effect.** Selection into
   school environments, which is correlated with both program and outcome.
2. **Write both design matrices** for a 2×2 and recover all four group means
   from either.
3. **Say why the cell-means model cannot test your hypothesis** even though it
   displays the group means most clearly.
4. **Translate a research question into a coefficient test** by choosing the
   reference category.
5. **State what an interaction tests** — whether the joint effect exceeds the
   additive expectation.
6. **Explain the two mechanical rules:** omit one dummy per factor; never
   interact dummies from the same factor.

## Key takeaways

- **The design matrix determines which hypotheses get tested**, not what the
  model fits. Both parameterizations describe the data identically.
- **Cell-means coding shows group means but tests nothing useful.**
  Reference-group coding tests contrasts you care about.
- **Choose the omitted category to match your research question.** Different
  reference groups give different default tests from the same data.
- **You can always recover every group mean** by multiplying coefficients
  through the appropriate design-matrix row.
- **The TFA example is omitted variable bias producing a false negative** — the
  program works, and the naive comparison says it does not.
- **Between-group and within-group comparisons are different quantities.** Only
  the second answers the causal question.
- **Every interaction tests the same thing:** is the combination additive, or is
  there something extra?
- **Difference-in-differences is an interaction**, and its counterfactual is the
  additive expectation $b_0 + b_1 + b_2$.
- **$k$ levels give $k-1$ dummies**, and dummies from one factor can never be
  interacted with each other.
