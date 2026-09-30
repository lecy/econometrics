---
title: "Interpreting Program Impact"
subtitle: "Reading guide for lecture p-05"
---

<div class="tip">

<br>

KEY CONCEPTS:

### A program is a bet. The coefficient is the expected value; the interval is the risk.

* $b_1$ = the point estimate = our best guess of the payoff
* the confidence interval = the range of plausible outcomes
* the cost of the program = the price of placing the bet

Choosing between programs is choosing between bets, and that always balances
expected payoff against uncertainty.

### Statistical significance tells you one thing only: whether the sign is certain.

> Statistical significance tells us if we can be certain about the **direction**
> of our program effects (the confidence interval does NOT contain zero).

* CI excludes zero → "significant" → all plausible outcomes have the same sign
* CI contains zero → "not significant" → you cannot rule out the opposite sign

It says nothing about how large the effect is, or whether the program is worth
buying.

### The p-value is the largest confidence interval you can draw before it contains the null.

* $p = 0.03$ → the 97% interval just touches zero
* A 95% interval might exclude zero while the 99% interval from the *same
  model* contains it

Significance is therefore a function of the threshold you picked, not a
property of the finding.

### Anatomy of a coefficient plot.

* the vertical line at $b_1 = 0$ = the **null hypothesis** (no impact)
* the dot = the **slope estimate** (best guess)
* the whiskers = the **confidence interval**
* not significant if the interval crosses the line

### Estimates should be unbiased and efficient.

* **Unbiased** = accurate. Estimates cluster around the true value.
* **Efficient** = precise. Estimates cluster tightly.

A model can be accurate but imprecise — right on average, but any single study
lands far off.

### Power is the ability to detect an effect that is really there.

* **Type I error** — claiming impact when there is none (false positive).
  Usually caused by **bias**.
* **Type II error** — missing impact that exists (false negative). Usually
  caused by **low power**, i.e. large standard errors.

### Confidence has an increasing marginal cost.

| Interval | Captures | Gain |
|---|---|---|
| $\pm 1.0$ SD | 68.2% | — |
| $\pm 1.5$ SD | 86.6% | +18.4 |
| $\pm 2.0$ SD | 95.4% | +8.8 |
| $\pm 2.5$ SD | 98.8% | +3.4 |
| $\pm 3.0$ SD | 99.8% | +1.0 |

Going from 95% to 99.9% confidence costs far more interval width than the
first steps did. The $t$-value for a 95% two-sided interval is 1.96.

<br>

</div>

<br>

# Key relationships

## The bet is the organizing metaphor, and it is doing real work

Most of this deck is not about regression at all — it is about four bets. That
is deliberate, and the mapping is exact:

| In the bet | In the regression |
|---|---|
| price of the bet | cost of the program |
| expected value | the coefficient $b_1$ |
| range of outcomes | the confidence interval |
| chance of losing money | the interval crossing zero |
| rounds of play | sample size |

Once the mapping is in place, questions that sound technical become questions
you already know how to answer. *Would you rather have a bet with a $1,400
expected value and no chance of loss, or one with a $2,500 expected value and a
one-in-four chance of losing $2,000?* There is no universally right answer —
and that is the point the deck is making about programs.

Note the aside on slide 8, which is more careful than it needs to be: with a
single two-outcome bet the expected value is theoretical and unachievable. It
only becomes the *likely* outcome across many plays — which is exactly the
relationship between one sample and the sampling distribution. Rounds of play
*are* sample size.

## Significance answers a narrower question than people think

This is the argument the deck builds across slides 14 through 19, and it is
worth stating bluntly:

**"Statistically significant" means the confidence interval does not contain
zero. That is all it means.**

It does not mean the effect is large. It does not mean the program is
worthwhile. It does not mean the result is important. It means every plausible
value has the same sign, so you can be confident about the *direction* of the
effect.

The deck proves this by constructing cases where significance and value point
in opposite directions. Bet #2 has the higher expected value ($2,500) but is
"not significant" because the range spans zero. Bet #4 has a much lower
expected value ($1,050) but is "significant" because every outcome is positive.
If significance were the decision rule, you would take the worse bet.

Hence the deck's own warning: *statistical significance should NOT be the first
or only piece of information to consider.*

## The p-value as a dial, not a verdict

Slides 36 to 38 give a definition of the p-value that is more useful than the
textbook one, and it follows directly from the coefficient plot.

Take one estimate and start widening the interval. At 95% confidence it might
clear zero. At 99% confidence — same data, same model — it might not. Somewhere
in between there is a confidence level at which the interval *just* touches
zero. That level is the p-value:

> The p-value tells you how large you can draw your confidence interval before
> it contains the null.

A $p$ of 0.03 means the 97% interval is the widest one that still excludes
zero.

Two consequences worth holding onto. First, the same estimate is "significant"
or not depending on the threshold you chose in advance — nothing about the
finding changed between slides 36 and 37. Second, the p-value is continuous
information, and collapsing it to a yes/no at 0.05 throws most of it away.

## Effect size and precision are two independent axes

The dartboard slide makes this concrete. An evaluation can be:

- **Accurate and precise** — estimates cluster tightly around the truth. Ideal.
- **Accurate but imprecise** — right on average, but any single study lands far
  off. This is the low-power case.

Bias and precision are different failures with different causes, and the deck
maps them onto the two error types:

- **Bias** → Type I errors. Your estimate is centred in the wrong place, so you
  can be confidently wrong.
- **Low precision** → Type II errors. Your estimate is centred correctly but so
  noisy you cannot rule out zero.

The low-power slides make the second case vivid: the true slope is 3, the model
is unbiased, the estimates cluster around 3 — and you still fail to reject the
null, over and over, because the intervals are too wide. Being right is not
enough if you cannot demonstrate it.

## Why more confidence gets expensive

Slides 61 through 65 answer a question students rarely ask: why settle for 95%?

Because confidence is bought with interval width, and the exchange rate gets
steadily worse. Going from 1.5 to 2.0 standard deviations buys 8.8 points of
confidence. The next half-step buys 3.4. The one after that buys 1.0. Near
100%, the interval has to grow without bound.

That is the real reason for conventional thresholds: past a point, extra
confidence costs more precision than it is worth. It also links back to the
standard error — the only way to get a narrower interval at the *same*
confidence level is to shrink $SE_{b_1}$, which returns you to the three levers
from p-03.

## Coefficient plots versus regression tables

Slide 55 sets a dense table of coefficients and standard errors against a
coefficient plot of the same results. The point is presentational but not
trivial: the plot shows effect size and uncertainty simultaneously and in the
units of the outcome, while the table forces the reader to do arithmetic in
their head to figure out whether an interval covers zero.

Given the deck's argument — that significance alone is a poor summary — this is
consistent. A coefficient plot makes it hard to report only the asterisks.

## Looking ahead

Slide 34 flags what comes next: adding control variables changes both the
coefficient and the standard error, which means it can change your answer about
whether a program works, and in which direction. Everything in this deck is
about interpreting a plot; p-06 onward is about whether you have specified the
right model in the first place.

## How to read the slides

| Slides | What they are doing | What to take away |
|---|---|---|
| 2 | "Which model is the right one?" | The question the whole unit is building toward. |
| 4–13 | The four bets | Expected value vs. range. Build the mapping to regression here. |
| 8, 10 | The aside on repeated play | Rounds of play = sample size. This is the CLT again. |
| 14–19 | Significance vs. value | The core argument. Significance only fixes the sign. |
| 20, 27 | Anatomy of a coefficient plot | Null line, point estimate, interval. |
| 21–22, 28–33 | Program comparisons | Practice reading plots. Ask both questions each time. |
| 23–26 | Effect sizes | Caffeine and potato chips: significant and not. |
| 33 | Dartboards | Accurate vs. precise. |
| 34 | Looking ahead | Controls move coefficients *and* standard errors. |
| 35–40 | **What is a p-value?** | The widest interval that still excludes the null. |
| 43–48 | Mechanics: t-values | Choose confidence → get $t$. 1.96 for 95%. |
| 49 | R output | A $t$-test as the two-group version of the same idea. |
| 50–53 | How often are we wrong? | Alpha is the miss rate. 90% intervals are narrower than 95%. |
| 54 | Unbiased and efficient | The two things an estimate should be. |
| 55 | Plots vs. tables | Presentation follows from the argument. |
| 56 | The checklist | Six items. |
| 57–66 | Power and the cost of confidence | Type I/II errors; diminishing returns on confidence. |

The repeated "which program is better? / what about now?" slides are an
exercise, not repetition. Each variation changes one thing — the width of an
interval, the position of a point estimate, the confidence level — and asks you
to notice that significance and magnitude move independently.

# What should be clear in my mind?

The deck closes with six items:

1. **Interpreting program impact means understanding both the effect size (the
   slope) and the precision with which it is estimated (the interval).** Neither
   alone is an answer.
2. **The level of confidence you select determines the $t$-value, which
   determines the size of the interval.** The width is a choice, not a
   discovery.
3. **For a program to be statistically significant, the interval around the
   slope must not contain the null (slope = 0).**
4. **You can choose an arbitrary level of confidence such that the interval will
   not contain the null.** Which is precisely why significance is a weak
   criterion.
5. **The p-value tells you the largest confidence interval you can draw that
   does not contain the null.**
6. **Program investments are bets that balance effect size against confidence.**

## Key takeaways

- **A coefficient is an expected value; an interval is a risk profile.** Program
  choice is portfolio choice.
- **Significance only certifies the direction of an effect**, never its size or
  its worth.
- **Significance and value can point in opposite directions** — the deck builds
  bets where the better wager is the "insignificant" one.
- **The p-value is the widest interval that still clears the null**, which makes
  it a continuous measure that the 0.05 convention flattens.
- **The same estimate can be significant at 95% and not at 99%.** Nothing about
  the finding changes; only your threshold does.
- **Unbiased and efficient are separate goals.** Bias produces false positives;
  imprecision produces false negatives.
- **Low power means being right without being able to show it** — unbiased
  estimates that still cannot reject the null.
- **Confidence has increasing marginal cost.** The last few percentage points
  are far more expensive than the first.
- **Coefficient plots show effect size and uncertainty together**; tables of
  asterisks do not.
