---
title: "Introduction to Counterfactual Analysis"
subtitle: "Reading guide for lecture p-01"
eyebrow: "Research Design"
dek: "A reading guide for lecture p-01 — what a counterfactual is, why the choice of comparison group decides the answer, and how that choice hides inside every null hypothesis."
concepts_sub: "The definitions the deck depends on, each stated as a claim."
relationships_sub: "The mental map. Why the deck spends most of its slides on examples rather than formulas."
clear_sub: "The checklist to run against yourself once the deck is done."
---

<div class="tip">

KEY CONCEPTS:

### A counterfactual is a claim about a world that did not happen.

The formal definition the deck opens with, from Lewis (1973):

* A counterfactual assertion is a conditional whose **antecedent is false** and whose
  consequent describes how the world **would have been** if the antecedent had obtained.
* It takes the subjunctive form: *"If P had obtained, then Q would have obtained."*
* "If the wind had not reached 50 miles per hour, the bridge would not have collapsed."

### Every causal claim implies a counterfactual claim.

If you assert *"P caused Q in circumstances C"*, you have committed yourself to
*"if P had not occurred in circumstances C, then Q would not have occurred."*
Causal judgment and counterfactual judgment are the same act described two ways —
which is why research design is mostly the business of building a credible "would have."

### In statistics the counterfactual becomes a difference between two groups.

Start from conditional probability, `Pr( A | B )`, and let B be a treatment:

* Binary outcome: `Pr( Y=TRUE | Treat=TRUE ) − Pr( Y=TRUE | Treat=FALSE )`
* Continuous outcome: `[ mean(Y) | Treat=TRUE ] − [ mean(Y) | Treat=FALSE ]`
* Succinctly: **Treatment Effect = Y(t) − Y(c)**

The first term is the world *with* the treatment; the second is the world *without*.

### We settle for average treatment effects because we only get one world.

The Paris Climate Accord slide makes the point bluntly: the effect is the 2050
temperature with the accord minus the 2050 temperature without it, and we do not have
two planets. So we compare *groups* that stand in for states of the world, and report
the **average** treatment effect — the easiest thing to measure and the most compact way
to state program effectiveness.

### "Treatment" is a dosage, not a label.

The part of an average treatment effect that is rarely made explicit: what the typical
treatment actually was. "Going to the gym increases muscle mass" — how many visits per
week, how long, doing what? An effect size means nothing until the dose is specified.

### The null hypothesis *is* the counterfactual, written as a number.

In the regression framing carried over from the first course:

* `b1 = MEAN(treatment) − MEAN(control)`, i.e. `b1 = T2 − C2`
* `b1 = 0` is the null: no program impact
* Significance is the question of whether the confidence interval around `b1` contains zero
* **Effect** in program evaluation = the observed change **plus** its confidence interval

### A comparison group is not automatically a control group.

Both stand in for the untreated world, but only one earns the stronger name:

* **Comparison group** — chosen by the researcher, not necessarily equivalent.
* **Control group** — a comparison group that is statistically identical to the treatment
  group. This is a special case, not the default.

</div>

# Key relationships

## The deck's real subject is the denominator of the comparison, not the math

Almost none of these slides are about estimation. The regression machinery — difference
of means, confidence interval, `b1 = 0` — is review from the first course and gets about
ten slides. The other forty are examples in which the statistics are held fixed and only
the comparison group changes. That is the argument: **the hard part of causal inference
is choosing what to compare against, and no amount of estimation rescues a bad choice.**

## The suicide-rate example is the spine of the deck

A school district in suburban California has had multiple student suicides. The
superintendent cut counseling services. Parents want to know whether the district's rate
is unusually high. You are hired as the expert evaluator.

The same district rate is then tested against three different nulls:

* against the **population average** — rates are significantly **higher**
* against **all high-school students in California** — rates are **no different**
* against **all suburban high-school students** — rates are significantly **lower**

Every one of these is a defensible counterfactual. The conclusion flips from "higher" to
"no different" to "lower" without a single change to the model or the data. As the slide
says: the conclusions *are driven entirely by the selection of the counterfactual.*

The question the deck leaves you with is not which test is correct but **which comparison
best answers the research question that was actually asked.**

## Significance and magnitude can point in opposite directions

The deck poses two cases and asks which finding is more meaningful:

* **Case A** — the district rate is *triple* the comparison rate, but not significant at
  α = 0.05.
* **Case B** — the district rate is *slightly* larger (0.25 cases per year) and is
  significant.

Neither answer is free. Case A is a large effect measured imprecisely, usually because
suicide is a rare event in a small district. Case B is a precisely measured effect that
may be too small to act on. This is the effect-size-versus-precision tension that lecture
p-04 takes up directly.

## The pundit study shows how a null can be chosen badly

Hamilton College students scored 472 predictions by 26 media prognosticators on a −10 to
+10 accuracy scale. Krugman scored 8.2 (p = 0.001), Friedman 2 (p = 0.2461, not
significant), Cal Thomas −8.7 (p = 0.0004).

The null being tested is **zero on the prognosticator scale** — equivalent to a coin flip.
The deck asks whether a coin flip is a good counterfactual for a prediction made on
television. It is a low bar chosen for convenience rather than for meaning: nobody
believes a paid columnist is guessing at random. Plausible alternatives — the base rate of
the event, a naive "no change" forecast, or the average of the other 25 pundits — would
each produce a different ranking.

## The charter school example is omitted variable bias wearing a research-design hat

Raw comparison: charter schools outscore public schools. Add controls for the population
each school actually serves and the advantage shrinks or reverses, because charters are
disproportionately sited in better communities and, per Ravitch, "skim the most motivated
students out of the poorest communities."

Read this as the bridge back to the first course. In the regression sequence this was
omitted variable bias. Here it is the same problem stated as a design failure: the
comparison group was never equivalent to begin with.

## Experiments, quasi-experiments, and observational studies are a spectrum, not a hierarchy

The deck closes by placing the three side by side and citing the within-study comparison
literature (Cook, Shadish & Wong 2008; Aiken et al. 1998; West et al. 2000) for the claim
that **careful quasi-experimental methods can reproduce experimental results.** The final
slide states the course's organizing question directly:

`Y(treatment) − Y(CONTROL)  =  Y(treatment) − Y(COMPARISON)  ?`

The rest of the course is the set of conditions under which that equality holds.

## How to read the slides

Slides 3–13 are the philosophical and statistical setup. Slides 14–47 are five worked
examples — the suicide district, the pundits, the Bingham & Felbinger cognitive-ability
study, and the charter schools — and they are the point, not illustrations of it. For each
one, stop and answer the deck's own two questions before advancing.

# What should be clear in my mind?

## The two questions a valid counterfactual must answer

The deck states these explicitly, and they are worth memorizing:

1. **Compared to what?** Program outcomes differ from outcomes in *the comparison group*,
   and that group is defined by the researcher. Only when it is statistically identical to
   the treatment group does it deserve to be called a control group.
2. **How big is the program effect?** Is the difference meaningful — both statistically
   significant *and* socially salient?

## Key takeaways

* A counterfactual is the world that did not happen; a causal claim is a counterfactual
  claim in disguise.
* `Treatment Effect = Y(t) − Y(c)`, and because we only have one world, we estimate it by
  comparing groups rather than timelines.
* The null hypothesis is where the counterfactual enters the statistics. Choosing the null
  *is* choosing the comparison group.
* Change the comparison group and the sign of your conclusion can change while the data,
  the model, and the p-value machinery stay exactly the same.
* A large-but-imprecise effect and a small-but-significant effect are different findings.
  Report both magnitude and interval.
* "Treatment" without a stated dose is not yet a measurable intervention.
* Comparison group ≠ control group. Earning the second name is what the remaining lectures
  are about.
