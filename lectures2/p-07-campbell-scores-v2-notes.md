---
title: "Campbell Scores"
subtitle: "Reading guide for lecture p-07"
eyebrow: "Research Design"
dek: "A reading guide for lecture p-07 — ten competing hypotheses that could explain your result instead of the program, and the standard of proof each one is held to."
concepts_sub: "The ten items, grouped, with the fix for each."
relationships_sub: "The mental map. Why two items are guilty until proven innocent and eight are not."
clear_sub: "The checklist to run against a study before crediting the program."
---

<div class="tip">

KEY CONCEPTS:

### A Campbell Score is a structured search for competing hypotheses.

Two statements about the same result:

* **The program hypothesis** — the change we saw in the study group above and beyond the
  comparison group was a result of *the program*.
* **The competing hypothesis** — the change we saw was a result of *____________*, where
  the blank is filled by any item on the Campbell Score.

This is the **identification problem** stated in plain language. Getting a significant
result establishes that the outcome changed. It does not establish that the program caused
the change.

### The ten items fall into four families.

**Selection / omitted variables**

1. Selection into a program
2. Non-random attrition

**Trends in the data**

3. Maturation
4. Secular trends
5. Seasonality
6. Testing
7. Regression to the mean

**Study calibration**

8. Measurement error
9. Study time-frame

**Contamination**

10. Intervening events

### Items 1 and 2 are guilty until proven innocent. The other eight are not.

This is the deck's most important procedural rule. Selection and attrition are so common
and so damaging that a rigorous evaluation must **affirmatively demonstrate** it has
handled them before it earns any baseline of internal validity.

The remaining eight are *potential* concerns. You cannot simply assume they are present —
you have to make a reasonable argument from the data and evidence in the study, or from
sound reasoning that goes beyond speculation.

### Selection into a program (#1)

If people choose whether to enroll, enrollees differ from non-enrollees. This is a source
of omitted variable bias.
**The fix:** randomization into treatment and control, or a rigorous matching process —
and the randomization must be *happy*, which you demonstrate with a balance table and a
Bonferroni-corrected decision rule (α / number of contrasts).

### Non-random attrition (#2)

If leavers differ from stayers, the effect calculation is biased.
**The fix:** compare the characteristics of those who stay against those who leave, using
only measures taken *before* the treatment occurred.

A key qualification: if attrition is non-random but occurs **equally across groups**, it
typically will not bias the results. That reprieve is unavailable in reflexive designs,
where there is no second group to absorb it.

### Maturation (#3) and secular trends (#4)

The same problem at two scales. **Maturation** is growth expected naturally within
individuals — children's cognitive ability improves whether or not you intervene.
**Secular trends** are global processes outside the individual — economic or cultural
change.
**The fix for both:** a comparison group, so the trend can be differenced out.

### Seasonality (#5)

Data with cycles have natural highs and lows, so a pre–post comparison across different
points in the cycle produces an invalid impact claim.
**The fix:** compare observations from the same period, or average over a full cycle.

### Testing (#6)

Repeated exposure to the same questions or tasks improves performance independently of any
training.
**The fix:** change the test, use a post-test-only design, or use a control group that also
takes the test. Applies to a narrow set of programs.

### Regression to the mean (#7)

Any extreme observation is more likely to be followed by one closer to the mean than by one
equally extreme. Quality-improvement programs aimed at **low performers** therefore have a
built-in improvement bias regardless of whether they work.
**The fix:** do not select the study group from the top or bottom of the distribution based
on a single time period.

### Measurement error (#8)

Significant measurement error in the dependent variable **biases effects toward zero**,
making programs look less effective than they are.
**The fix:** better measures.

### Study time-frame (#9)

Too short and a real effect looks like nothing. Too long and attrition takes over.
**The fix:** use prior research in the domain to choose the window.

### Intervening events (#10)

Something happens during the study that affects one group and not the other — the treatment
school burns down, prices change for a substitute good in the control area.
**The fix:** there often isn't one. Intervening events can be very hard to remove.

</div>

# Key relationships

## The ants video is the whole idea in three minutes

The deck opens with "Can Ants Count?" as the inspiration for the assignment. The
experimental logic there is the logic here: you do not prove ants count by showing they
walk the right distance. You prove it by systematically eliminating every other
explanation for why they walked the right distance. A Campbell Score is that elimination
process turned into a checklist.

## Two standards of proof, and why the asymmetry is correct

Selection and attrition get the harsher standard because they are near-universal in
observational work — most observational studies *will* be significantly affected by them.
Assuming innocence there would let almost every weak study pass.

The other eight are held to the ordinary standard because they are situational. Seasonality
is irrelevant to most studies; testing effects apply to a small set of programs. Asserting
them without evidence would let a critic dismiss any study by reciting the list.

## The trend slides show why `T2 − C2` is not always enough

Three cases, and they are worth studying closely:

* `C1 = T1` — groups equivalent at baseline. `T2 − C2` removes the trend correctly.
* `C1 ≠ T1`, comparison below treatment — `T2 − C2` does **not** fully remove the trend.
* `C1 ≠ T1`, comparison above treatment — `T2 − C2` removes **too much** trend.

The note attached to both failure cases is the point: **diff-in-diff separates trends even
when the groups are not equivalent.** This is the Campbell Score view of what lecture p-03
established formally.

## Regression to the mean is the item people miss most often

Two examples make it stick. The batting slump: players are sent to the batting coach only
when performing badly, so performance improves afterward whether or not the coach helps.
And the FiveThirtyEight piece on sham surgery: chronic pain peaks and wanes, patients seek
treatment at the worst moment, so improvement afterward may be the condition's natural
course rather than the operation.

The surgery example is doing double duty — invasive procedures also produce stronger
placebo effects than pills or injections — which is a good reminder that these ten items
are not mutually exclusive.

## The Iowa liquor example shows time-frame and measurement error compounding

* One year after the policy change: a significant jump in consumption. Conclusion: **policy
  bad.**
* Two or more years after: the jump was new stores stocking their shelves. Conclusion:
  **policy good.**

And the deck's aside is as important as the main lesson: "consumption" here is measured as
*wholesale volume*, not consumer consumption. So the study has a serious measurement problem
(#8) sitting underneath its time-frame problem (#9).

## How to use this in the assignment

Your job is to make a strong case, using the item definitions and the evidence in the case
study. For items 1 and 2, look for what the study did to *rule them out* — a balance table,
an attrition analysis — and score down if it is absent. For items 3–10, look for positive
evidence in the study that the threat is live. Both directions require argument from
evidence, not assertion.

# What should be clear in my mind?

## The checklist, in order

1. Could people select into the program? What did the study do about it?
2. Who left, and did the study check whether leavers differ from stayers?
3. Would the outcome have grown on its own (maturation)?
4. Was something moving in the wider world (secular trend)?
5. Do the data have cycles, and were like periods compared?
6. Were subjects tested repeatedly on the same instrument?
7. Was the study group selected because it was extreme?
8. How well is the dependent variable measured?
9. Was the observation window long enough to see the effect, and short enough to retain
   the sample?
10. Did anything happen to one group and not the other during the study?

## Key takeaways

* A significant result identifies a change; a Campbell Score is what identifies the *cause*.
* Ten competing hypotheses, in four families: selection, trends, calibration, contamination.
* Selection and attrition are guilty until proven innocent. The other eight require you to
  make an evidence-based argument that they are present.
* Most trend threats — maturation, secular trends, testing — are solved by the same tool: a
  comparison group.
* `T2 − C2` only removes the trend cleanly when the groups started equal; diff-in-diff works
  even when they did not.
* Measurement error biases toward zero, so a null result in a badly measured study is weak
  evidence of no effect.
* Regression to the mean manufactures apparent improvement whenever a program targets the
  worst performers.
