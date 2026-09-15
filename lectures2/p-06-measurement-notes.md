---
title: "Measurement Theory"
subtitle: "Reading guide for lecture p-06"
eyebrow: "Research Design"
dek: "A reading guide for lecture p-06 — what a number actually measures, how to tell whether a scale is reliable, and what happens when a metric becomes a target."
concepts_sub: "Types of measures, instruments, validity, reliability, and the statistic that checks reliability."
relationships_sub: "The mental map. How measurement connects to the regression and design problems from earlier units."
clear_sub: "The questions to ask before you trust an outcome variable."
---

<div class="tip">

KEY CONCEPTS:

### The same poverty rate can describe two very different communities.

Harlem and Chinatown both sit in the 40–80% poverty band on the Manhattan map. In Harlem
the residents are mostly US-born, with high rates of inter-generational poverty. Chinatown
has many new immigrants with few financial assets but strong social capital, and their
children are highly mobile.

The deck makes the point with two communities that each have a **25% poverty rate**:

* **Community A:** 1% of the population enters poverty each year and 1% leaves.
  That leaves **24% in chronic poverty**.
* **Community B:** 20% enter each year and 20% leave. Only **5% are chronically poor**.

The poverty rate measures a *stock*. It says nothing about the *flows* in and out, and the
flows are what separate a trap from a way station.

### A measure is only as good as the construct behind it.

Before you can build an index you have to decide what it is an index *of*. The deck's list
for poverty: lack of money, lack of opportunity, limited access to healthcare, lack of
education, lack of mobility, or position in a caste. It also lists "lack of character" as
one popular theory. And is a college student on a fixed budget poor?

A richer poverty measure might combine several dimensions: **financial capital, human
capital, social capital, physical health, and public goods.** If you have good parks, free
libraries, and public art, do you need as much money?

### There are three types of measures.

* **Direct measures** count the thing itself, like the number of windshields a factory
  worker installs.
* **Markers or predictors** are direct measures that stand in as proxies for something
  harder to measure.
* **Latent constructs** can't be observed at all, only inferred. Intelligence (IQ tests),
  depression (surveys), and health (surveys) are examples.

### An instrument is the tool that turns a construct into a number.

For direct measures the instruments are microscopes, spectrometers, and scales. For latent
constructs they are **survey questions, observational protocols for coding data, and
standardized exams.** The Oxford Happiness Questionnaire is an example: agree/disagree items
on a six-point scale, some of them reverse-coded (R) so that agreement means *less* happiness.

### Validity asks whether you measure the right thing. Reliability asks whether you measure it consistently.

* **Validity:** do the items measure the latent construct they claim to?
* **Reliability:** how consistently do the items measure the same construct?

The deck's four-item "good dancer" scale scores each item 0–4, for a total of 0 to 16. One
item is "I am athletic." It is plausibly related to dancing, but it measures a different
construct, and the correlation structure shows it.

### Cronbach's alpha measures internal consistency.

Alpha measures how closely related a set of items are as a group. It is the standard
measure of **scale reliability**, and it runs from 0 to 1:

`α = (N · c̄) / (v̄ + (N − 1) · c̄)`

where `N` is the number of items, `c̄` is the average inter-item covariance, and `v̄` is the
average variance per item.

| α | Reliability |
|---|---|
| 0.9 – 1.0 | Excellent |
| 0.8 – 0.9 | Good |
| 0.7 – 0.8 | Acceptable |
| 0.6 – 0.7 | Questionable |
| below 0.6 | Poor / inadequate |

</div>

# Key relationships

## Dropping the item that doesn't belong can raise alpha

The two worked examples in the deck follow the same logic. Read the correlation matrix,
find the items that don't correlate with the rest, and remove them.

* **Good dancer:** all four items give **α = 0.68**. Drop "I am athletic" and alpha rises
  to **0.86**.
* **Bro culture:** six items give **α = 0.16**. In the correlation matrix, *beards* and
  *Michael Jackson* correlate with nothing (all near 0.02). Drop them and alpha rises to
  **0.61**. *Salmon shorts* correlates only weakly with the others (0.25–0.35). Drop it too
  and the three remaining items (beer pong, Family Guy, Santacon, with inter-item
  correlations of 0.65–0.91) give **α = 0.89**.

The formula also shows the other lever. Holding the average covariance fixed, adding items
raises alpha. A long scale can look reliable even when its items are only weakly related,
so a high alpha is not a substitute for looking at the correlations.

## Reliability is necessary but not sufficient for validity

The three-item bro-culture scale is highly reliable. The items hang together, because
people who like beer pong also like Family Guy. Whether that cluster actually measures the
traits on the slide (entitlement, disregard for others, self-destructive behavior) is a
*validity* question, and alpha can't answer it. A scale can consistently measure the wrong
thing.

The reverse doesn't hold. An unreliable instrument can't be valid. The Myers-Briggs reading
is the cautionary case. Retake the test after five weeks and there is roughly a 50% chance
you land in a different type, which is no better than a coin toss.

## Unreliable measures are the measurement error from Unit 06

A low-alpha scale is a noisy measure, and you already know what noise does to a regression:

* **Noise in the outcome (Y)** leaves the slope unbiased but widens the confidence
  interval. That lowers statistical power, the subject of lecture p-05.
* **Noise in the policy variable (X)** attenuates the slope toward zero.
* **Noise in a control variable** means the control only partly adjusts for the
  confounder it stands in for, so some omitted variable bias remains.

Improving an instrument's reliability improves every estimate built on top of it.

## Good instruments are built for the people who use them

The examples section shows three practical designs:

* **Progress out of Poverty Index (PPI):** 10 easy questions that take 5–10 minutes, such as
  "What material is your roof made out of?" and "How many of your children are in school?"
  These are *markers*. The scored answers give the likelihood that a household is below the
  poverty line, and the questions are calibrated separately for each country.
* **Krishna's Stages of Progress:** villagers in 50 Gujarat villages ranked the order in
  which households spend as they escape poverty, starting with food, clothes, a better roof,
  school enrollment, and repaying debts. The ordering itself becomes the scale.
* **The Apgar score:** five signs (heart rate, respiration, muscle tone, reflex irritability,
  and skin color), each scored 0–2, for a total of 0–10. It is taken right after birth and
  again five minutes later. It is fast, standardized, and repeated.

## Measurement is inherently political

Tie a metric to rewards and penalties and it starts to change the behavior it was meant to
record. The deck lists five challenges:

1. What if we can't measure what we care about?
2. Data collection costs time and money.
3. **Perverse incentives.** Under *multi-tasking*, what gets measured gets done at the
   expense of everything else. Under *creaming*, providers avoid serving the poorest and
   hardest cases.
4. **Poor counterfactuals.** Most agencies lack the capacity to evaluate properly.
5. Fatigue from reporting to multiple stakeholders.

The Humans of New York teacher makes the fourth point concrete. Forty percent of their job
rating depends on test scores, which also reflect abuse at home, missed breakfasts, and late
arrivals. A rating built on raw outcomes, without a counterfactual, holds a person
accountable for things they don't control. The closing slides, drawn from Soss, Fording, and
Schram's *The Organization of Discipline*, argue that performance management doesn't just
measure agents. It reshapes what they do.

## How to read the slides

* **Slides 1–9:** the poverty-rate example, and what a better index would include.
* **Slides 10–13:** types of measures and instruments.
* **Slides 14–35:** reliability, Cronbach's alpha, and the two item-pruning examples.
  Read these most carefully.
* **Slides 36–39:** three practical instruments.
* **Slides 40–47:** the politics of measurement.

The [measurement lab app](https://jdlecy.shinyapps.io/measurement-lab/#section-warmup) is the hands-on companion. Work through it after slides 14–35.

# What should be clear in my mind?

## Questions to ask of any outcome measure

* Is this a direct measure, a marker, or a latent construct?
* If it is latent, what instrument produced it, and has that instrument been validated?
* Is reliability reported? Is alpha at least 0.7?
* Does the measure capture a stock when the program is meant to change flows?
* Could the people being measured move the number without moving the outcome?
* Does the metric hold someone accountable for things outside their control?

## Key takeaways

* Two places with the same rate can have very different underlying realities, so ask what
  the number summarizes and what it hides.
* Most outcomes in public policy are latent constructs, measured only through an instrument.
* Validity means measuring the right construct. Reliability means measuring it consistently.
* Cronbach's alpha measures internal consistency. Aim for 0.7 or higher, and use the item
  correlations to find items that don't belong.
* A reliable scale can still be invalid, but an unreliable scale can't be valid.
* Measurement error has regression consequences: noisy outcomes cost power, and noisy
  predictors bias slopes toward zero.
* Once a metric carries rewards or penalties, expect people to optimize the metric.
