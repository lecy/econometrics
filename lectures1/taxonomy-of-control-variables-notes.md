---
title: "Taxonomy of Control Variables"
subtitle: "Reading guide"
---

<div class="tip">

<br>

KEY CONCEPTS:

### A good estimate of program impact is accurate and precise.

* **Accurate** ("unbiased") = no omitted variable bias
* **Precise** ("efficient") = small standard errors

These are separate properties with separate causes, and different control
variables buy you different ones.

### The full model has one policy variable and two kinds of control.

$Y = B_0 + B_1X_1 + B_2X_2 + B_3X_3 + e$

* $X_1$ = the **policy variable**; $B_1$ = program impact
* $X_2$ = a control **correlated** with $X_1$ — a competing hypothesis
* $X_3$ = a control **uncorrelated** with $X_1$ — a pure predictor of Y

### Type A: the control is uncorrelated with $X_1$.

* Explains extra Y
* Smaller standard errors
* **More precise** estimates

### Type B: the control is correlated with $X_1$.

* Removes bias from $B_1$
* **More accurate** estimates

### Dropping each type produces a two-by-two.

|  | $X_3$ included | $X_3$ omitted |
|---|---|---|
| **$X_2$ included** | Unbiased & Precise | Unbiased & Imprecise |
| **$X_2$ omitted** | **Biased & Precise** | Biased & Imprecise |

* **A** — $y = b_0 + b_1x_1 + b_2x_2 + b_3x_3$ — unbiased and precise
* **B** — $y = b_0 + b_1x_1 + b_2x_2$ — unbiased, but large standard errors
* **C** — $y = b_0 + b_1x_1 + b_3x_3$ — **biased, with false confidence**
* **D** — $y = b_0 + b_1x_1$ — biased and imprecise

<br>

</div>

<br>

# Key relationships

## Two jobs, two kinds of variable

This deck is a short one and it does one thing: it sorts control variables by
**which quality problem they solve**.

- A control that is *correlated with your treatment* is a **competing
  hypothesis**. Including it is how you rule out the rival explanation, which is
  what makes your estimate accurate.
- A control that is *uncorrelated with your treatment* but predicts the outcome
  is a **noise reducer**. Including it is how you shrink the residual, which is
  what makes your estimate precise.

The classification depends on the control's relationship to $X_1$, not to Y.
Both types predict Y — that is what makes them controls at all. What separates
them is whether they also move with your treatment.

## Case C is the one to be afraid of

Three of the four cells are honest failures. Case C is a dishonest one.

If you include the noise-reducing control and omit the competing hypothesis, you
get **tight confidence intervals around a biased estimate**. The model looks
excellent — small standard errors, strong significance, high $R^2$ — and the
number it is confident about is wrong.

The deck says this plainly: *the uncorrelated control results in small standard
error, which can give false confidence when the absence of $X_2$ results in
omitted variable bias.*

Compare case D, the naïve model. It is also biased, but its standard errors are
large, so it advertises its own uncertainty. Adding a type-A control to a
mis-specified model does not fix anything — it just removes the warning label.

This is the practical reason $R^2$ and significance are poor guides to model
quality. Neither one can see bias.

## Precision is cheap; accuracy is a claim about the world

There is an asymmetry between the two fixes that is worth naming.

Adding a type-A control is a **technical** improvement. You can hunt for such
variables in your data, add them, and read the standard errors to see if it
worked. Nothing about your causal argument changes.

Adding a type-B control is a **substantive** claim. You are asserting that this
particular alternative explanation exists and needs to be ruled out. No
diagnostic in the regression output will tell you which competing hypotheses you
have forgotten — that comes from theory and knowledge of the setting.

Which is why the exam question at the end of the deck is about matching diagrams
to descriptions rather than computing anything. The skill being tested is
reading a specification, not running one.

## How this deck sits between p-06 and p-07

It is the synthesis of the two:

- **p-06** showed what happens to slopes and standard errors when you *add* each
  type of control.
- **p-07** showed what happens to bias when you *omit* one.
- **This deck** puts both moves in one grid and names the resulting model
  quality.

If you understood those two lectures, this one should feel like a summary. If it
does not, the grid is the place to start over.

## How to read the slides

| Slides | What they are doing | What to take away |
|---|---|---|
| 1 | The two quality criteria | Accurate and precise are different goals. |
| 2 | **The taxonomy** | Type A buys precision; Type B buys accuracy. |
| 3 | Four candidate models | Try to rank them before turning the page. |
| 4–8 | Each case explained | Note that case C is called out as "complicated." |
| 9, 11 | Exam-style matching | Class size, SES, teacher quality. Do these. |
| 10 | **The two-by-two** | The summary slide. Four cells, four verdicts. |

# What should be clear in my mind?

1. **What makes a regression estimate good.** Two things, independently:
   unbiased (no omitted variable bias) and efficient (small standard errors).
2. **Which control buys which.** Correlated with the treatment → removes bias.
   Uncorrelated with the treatment → reduces standard errors.
3. **How to classify a control.** Look at its relationship to your *policy
   variable*. Its relationship to Y is what makes it a control; its relationship
   to $X_1$ is what makes it one type or the other.
4. **Why "biased and precise" is the dangerous cell.** Small standard errors
   around the wrong estimate look like a good model and are not.

## Key takeaways

- **Accuracy and precision are separate goals** with separate remedies.
- **Type A (uncorrelated) controls buy precision;** Type B (correlated) controls
  buy accuracy.
- **The classification is by correlation with the treatment**, not with the
  outcome.
- **Biased & precise is worse than biased & imprecise**, because it hides its own
  error behind tight intervals.
- **No regression diagnostic detects a missing competing hypothesis.** That
  judgement comes from theory.
- **Adding noise-reducing controls to a mis-specified model makes it look better
  without making it better.**
