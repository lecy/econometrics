---
title: "Interactions in Regression Models"
subtitle: "Reading guide for lecture p-08 (dummy variables)"
---

<div class="tip">

<br>

KEY CONCEPTS:

### An interaction is a product term, and it always means "does the effect differ by group?"

The deck covers two kinds:

1. **Dummy × dummy** — the difference-in-difference model
2. **Dummy × continuous** — varying program impact (slopes) by group

### Difference-in-differences: interacting two dummies.

$Y = b_0 + b_1 \cdot Treat + b_2 \cdot Post + b_3 \cdot (Treat \cdot Post) + e$

| Coefficient | Label | Meaning |
|---|---|---|
| $b_0$ | A | comparison group, before |
| $b_1$ | B | treatment group offset, before |
| $b_2$ | C | change over time common to both groups |
| $b_3$ | D | **the program effect** |

* Comparison group, after: $A + C$
* Treatment group, before: $A + B$
* Treatment group **counterfactual**, after: $A + B + C$
* Treatment group, actually observed after: $A + B + C + D$

In the worked example $b_0 = 20$, $b_1 = 15$, $b_2 = 10$, $b_3 = 20$: the
counterfactual is $45$, the observed outcome is $65$, and the program effect is
the $20$ between them.

### The comparison group supplies the counterfactual trend.

Both groups would have moved by $b_2$ anyway. The interaction term isolates the
*extra* movement in the treatment group — the part that the common trend does
not explain.

### Dummy × continuous: letting the slope vary by group.

$height = b_0 + b_1 dumA + b_2 dumB + b_3 fertilizer + b_4 (dumA \cdot fertilizer) + b_5 (dumB \cdot fertilizer) + e$

With Type C as the omitted reference category:

* $b_0$ = height of Type C at $fertilizer = 0$ — the reference **intercept**
* $b_1$ = how much higher Type A starts than Type C — an **intercept shift**
* $b_3$ = the effect of fertilizer for Type C — the reference **slope**
* $b_4$ = the *difference* in fertilizer slope between Type A and Type C
* **Fertilizer slope for Type A** $= b_3 + b_4$

### The reference category is arbitrary; the fit is not.

The deck runs the same model with different groups omitted. Every coefficient
changes, and $R^2$ stays at $0.59$. You are re-describing the same fitted lines
from a different baseline.

<br>

</div>

<br>

# Key relationships

## Main effects shift intercepts; interactions shift slopes

This is the sentence that organises the whole deck.

- A **dummy on its own** moves a group's line **up or down**. Same slope,
  different starting height.
- A **dummy interacted with a continuous variable** changes that group's
  **slope**. The lines are no longer parallel.

In the corn example you can see both at once: Type A starts 8.98 units above
Type C ($b_1$, an intercept shift) *and* responds to fertilizer differently
($b_4$, a slope shift). Type A's line is flat, Type B's rises steeply, Type C's
falls. Without the interaction terms the model would be forced to give all three
the same slope and would fit none of them.

So the diagnostic question is: *do I think the groups start at different levels,
respond at different rates, or both?* Each answer maps to a specific term.

## Every coefficient is a comparison to the omitted group

Interaction models are hard to read because nothing means what it appears to
mean in isolation. Everything is relative to whichever category you left out.

- $b_3$ is not "the effect of fertilizer." It is the effect of fertilizer
  **for Type C**.
- $b_4$ is not "the effect of fertilizer for Type A." It is the **difference**
  between Type A's effect and Type C's.
- To get Type A's actual slope you must **add**: $b_3 + b_4$.

The four-model table drives this home. Same data, same fitted lines, same
$R^2 = 0.59$ — and completely different numbers, because each model uses a
different reference group. If you ever find yourself surprised that a
coefficient changed sign when you re-coded a factor, this is why.

**Practical habit:** before interpreting any interaction model, say out loud
which group is the baseline. Every number in the output is an answer to
"compared to *that*."

## Difference-in-differences is the same trick with a purpose

The DiD model is just dummy × dummy — but the two dummies are chosen so the
interaction has a causal reading.

The setup gives you four cells: treated and untreated, before and after. Three
of them tell you what you need to construct a counterfactual:

- The comparison group's change over time ($b_2$) says what would have happened
  anyway.
- The treatment group's starting point ($b_0 + b_1$) says where they began.
- Add the two and you have where the treatment group **would have ended up**
  without the program: $A + B + C$.

The fourth cell is what actually happened. The gap is $b_3$.

This is why the counterfactual line on the slide is dashed: it is not data. It
is constructed from the comparison group's trend, transplanted onto the
treatment group's starting level.

## The assumption hiding in the dashed line

Worth being explicit, because the slides show the mechanics rather than the
caveat: **DiD assumes the two groups would have moved in parallel** absent the
program. That is what licenses using the comparison group's change as the
treatment group's counterfactual.

Notice what this buys you. The two groups are allowed to differ in *level* —
that is exactly what $b_1$ absorbs, and it is why DiD is useful when treatment
was not randomly assigned. What they are not allowed to differ in is *trend*.

Look again at the first example: the treatment group starts at 55 and the
comparison at 75. They are not comparable groups. DiD does not care, as long as
both were on track to improve by the same amount.

## How this connects to the rest of the sequence

Interactions are the natural next move after p-05 through p-07:

- p-05 asked whether a program worked. This deck asks whether it worked
  **differently for different groups** — the same coefficient plot, split.
- p-07 warned that omitted variables bias your estimate. DiD is one of the
  standard responses: instead of measuring the confounders, difference them
  out. Anything that is fixed about a group cancels when you take the
  before-and-after difference.

That last point is worth holding onto. The comparison-group design is not just a
convenience — it is a way of neutralising unmeasured differences without ever
naming them, which is the same ambition as randomization, achieved by a
different route.

## How to read the slides

| Slides | What they are doing | What to take away |
|---|---|---|
| 1–2 | Framing | Two kinds of interaction, one idea. |
| 3 | The two-group, two-period plot | 75→95 and 55→85. Compute the DiD yourself before turning the page. |
| 4 | The counterfactual added | The dashed line is constructed, not observed. |
| 5–6 | The regression version | Map A, B, C, D onto $b_0$ through $b_3$. |
| 7 | Framing part two | Now the slopes vary. |
| 8 | Intercept terms | $b_0$ is Type C's intercept; $b_1$ is A's offset from it. |
| 9 | **Slope terms** | $b_3$ is C's slope; $b_4$ is the *difference*; A's slope is $b_3 + b_4$. |
| 10 | Four models, four baselines | Same $R^2$, different coefficients. The reference category is a choice. |

# What should be clear in my mind?

This deck has no closing checklist, so these are the things to be able to do:

1. **Read a difference-in-difference table.** Given $b_0$ through $b_3$, state
   all four cell means and identify which one is the counterfactual.
2. **Say what the interaction coefficient means.** It is the *difference in
   differences* — the extra change in the treatment group beyond the common
   trend.
3. **Recover a group's slope from an interaction model.** Reference group:
   $b_3$. Any other group: $b_3$ plus its own interaction term.
4. **Name the omitted category before interpreting anything.** Every coefficient
   is relative to it.
5. **State the parallel-trends assumption** and explain why differing *levels*
   between groups are acceptable but differing *trends* are not.

## Key takeaways

- **An interaction is a product term** that asks whether an effect differs
  across groups.
- **Dummies alone move intercepts; interactions move slopes.** You can use both
  at once, and the corn example does.
- **Every coefficient is a comparison to the omitted reference group.** Nothing
  is absolute.
- **A group's slope is the reference slope plus its interaction term**, not the
  interaction term alone.
- **Changing the reference category changes every number and no fitted line.**
  $R^2$ is the tell: it does not move.
- **In DiD, $b_3$ is the program effect** and $A+B+C$ is the counterfactual.
- **The comparison group's trend is the counterfactual trend**, which is an
  assumption, not a measurement.
- **DiD tolerates level differences between groups but not trend differences.**
