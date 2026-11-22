# AI Prompt Guide: Multiverse Analysis

## How to use this guide

1. Fill in every field marked **`[FILL IN]`** in Sections 1 and 2. Delete the example text in italics once you have replaced it.
2. Open your AI coding agent (Claude Code, ChatGPT Codex, etc.) in your project folder. The data file needs to be inside that folder.
3. Copy everything from **"START OF PROMPT"** to **"END OF PROMPT"** and paste it into the agent.
4. Read the agent's output critically. It will run the models, but **you** are responsible for deciding whether the choices make sense and for writing the interpretation.

> **Tip:** Before you paste the prompt, make sure you can describe the paper's main model in one sentence: *"The authors regress Y on X, controlling for A, B, and C, using [method] on [sample]."* If you can't, reread the methods section first.

---

## START OF PROMPT

You are helping me conduct a **multiverse analysis** in R. The goal is to test how sensitive a published finding is to reasonable choices about how the model is specified. Follow the instructions below in order. Write all code as a clear, commented R script and produce a rendered report (QMD → HTML). Do not modify the original data file.

---

### SECTION 1: Baseline Model and Data

#### 1.1 The paper

- **Citation:** `[FILL IN]`
- **Research question (one sentence):** `[FILL IN]`

#### 1.2 The baseline model (as described in the paper)

- **Dependent variable (outcome):** `[FILL IN: variable name in the dataset]`
- **Focal independent variable** (the coefficient we care about, e.g. the treatment or policy variable): `[FILL IN: variable name]`
- **Other variables in the paper's model:** `[FILL IN: variable names, or "none"]`
- **Estimation method:** `[FILL IN: e.g., OLS, logistic regression, fixed effects panel model]`
- **Unit of analysis and sample:** `[FILL IN: e.g., counties, 2010–2019, excluding Alaska]`
- **Reported result to reproduce:** `[FILL IN: e.g., "coefficient on X = 0.42, SE = 0.11, Table 2, Column 3"]`
- **Clustering or grouping structure, if any:** `[FILL IN: e.g., observations nested within states; or "none"]`

#### 1.3 The data

- **Data file location:** `[FILL IN: e.g., data/paper-replication-data.csv]`
- **Data dictionary location:** `[FILL IN: e.g., data/data-dictionary.csv, or the research guide from Option 4]`
- **Notes on the data:** `[FILL IN: anything unusual: missing value codes like -99, variables that need to be recoded, filters the authors applied]`

#### 1.4 First task: reproduce the baseline

Before building the multiverse:

1. Load the data and the data dictionary. Summarize the variables used in the model (type, range, number missing).
2. Estimate the baseline model exactly as described above.
3. Compare your estimate of the focal coefficient to the result reported in the paper. If they differ meaningfully, **stop and tell me**. List the likely reasons (sample restrictions, variable coding, missing data handling) before continuing.

---

### SECTION 2: Forks

A **fork** is a decision point where a researcher could reasonably have made a different choice. Every combination of fork options defines one model in the multiverse.

#### 2.1 Design choices (three forks)

For each design choice, list the option used in the paper (Option A) and a reasonable alternative (Option B). Briefly justify why the alternative is defensible.

| # | Design choice | Option A (paper's choice) | Option B (alternative) | Why B is defensible |
|---|---------------|---------------------------|------------------------|---------------------|
| D1 | `[FILL IN]` | `[FILL IN]` | `[FILL IN]` | `[FILL IN]` |
| D2 | `[FILL IN]` | `[FILL IN]` | `[FILL IN]` | `[FILL IN]` |
| D3 | `[FILL IN]` | `[FILL IN]` | `[FILL IN]` | `[FILL IN]` |

*Examples of design choices:*

- *Choice or functional form of the dependent variable (e.g., raw value vs. logged; rate vs. count; alternate outcome measure)*
- *How a variable is measured (e.g., raw counts vs. per capita; continuous vs. categorical)*
- *Non-linear terms (e.g., adding a quadratic term for X; logging a skewed predictor)*
- *Interaction terms (e.g., X × region)*
- *Sample definitions (e.g., including vs. excluding a subgroup)*

#### 2.2 Control variables (three forks)

List three control variables. Each one is a fork with two options: **included** or **excluded**. The multiverse will include every combination (2³ = 8 control sets, from no controls to all three).

| # | Control variable (name in dataset) | Why it might matter |
|---|------------------------------------|---------------------|
| C1 | `[FILL IN]` | `[FILL IN]` |
| C2 | `[FILL IN]` | `[FILL IN]` |
| C3 | `[FILL IN]` | `[FILL IN]` |

Any variables from the paper's model that are **not** listed as forks above should be held constant in every specification. `[FILL IN: list them, or "none"]`

---

### SECTION 3: Standard Defaults (NOT forks)

The following practices apply to every specification. **Do not treat them as forks** and do not include them in the leverage calculations in Section 5. They are applied uniformly (3.1) or reported as separate robustness checks (3.2 and 3.3).

#### 3.1 Robust standard errors (applied to all models)

- Use heteroskedasticity-robust standard errors (HC1) for every model in the multiverse.
- If I listed a clustering structure in Section 1.2, use cluster-robust standard errors at that level instead.
- For the baseline model only, also report conventional standard errors so I can see how much the correction matters.

#### 3.2 Outlier trimming (robustness check)

- Create a trimmed sample that drops observations below the 1st percentile or above the 99th percentile of the **dependent variable** and the **focal independent variable** (using their baseline form).
- Re-run the **entire multiverse** on the trimmed sample.
- Report how many observations were dropped.

#### 3.3 Slices of the data (robustness check)

- **Slicing variable:** `[FILL IN: a key variable to sort by, such as the focal independent variable or a size measure like population. If left blank, use the focal independent variable.]`
- Sort the data by the slicing variable and split it into three equal-sized groups: **bottom, middle, and top thirds**.
- Re-run the **entire multiverse** separately within each slice.
- Report the sample size of each slice and warn me if any slice is too small to estimate the full model reliably (e.g., fewer than 10 observations per parameter).

---

### SECTION 4: Running the Multiverse

1. **Build the specification grid.** Cross all options: 2 × 2 × 2 design choices × 8 control sets = **64 specifications**. (If any design choice has more than two options, adjust the count and tell me the total.)
2. **Hold the sample constant.** Different control sets can drop different rows because of missing data. Use a common analytic sample (the rows that are complete for every variable used in any specification) so that differences between models come from specification choices, not changing samples. Report the N of the common sample and compare it to the paper's N.
3. **Make estimates comparable.** If a design choice changes the scale of the dependent or focal variable (e.g., logging), raw coefficients are not directly comparable across specifications. In that case, track a comparable quantity for the focal variable in every model, such as a standardized coefficient or an elasticity/percent change. Tell me which quantity you chose and why.
4. **Estimate all models** for: (a) the full sample, (b) the trimmed sample, and (c) each of the three slices, giving 5 × 64 = 320 models.
5. **For every model, store:** specification ID, the option chosen at each fork, sample (full / trimmed / bottom / middle / top), N, focal estimate, robust SE, p-value, 95% confidence interval, and R² (or an equivalent fit statistic).
6. **Save** the full results table as a CSV in the `results` folder.

---

### SECTION 5: Analysis and Reporting

Use the **full sample** for the main leverage analysis. Then summarize the trimmed and sliced results.

#### 5.1 Overview of the multiverse

- Distribution of the focal estimate across all 64 specifications: minimum, median, maximum
- Share of specifications where the estimate has the **same sign** as the paper's result
- Share of specifications that are **statistically significant** at p < 0.05
- A **specification curve**: estimates sorted from smallest to largest with 95% CIs, plus a panel below showing which fork options each specification used. Mark the baseline (paper's) specification.

#### 5.2 Leverage and significance of each decision

For each of the six forks (D1, D2, D3, C1, C2, C3), report:

1. **Leverage:** how much switching this fork changes the focal estimate, holding the other forks constant. Estimate this with a *specification regression*: regress the focal estimate from each of the 64 models on indicator variables for the six forks. The coefficient on each indicator is that fork's leverage. Express it in the estimate's units and as a percentage of the baseline estimate.
2. **Effect on significance:** the share of specifications significant at p < 0.05 when the fork is set to Option A vs. Option B (or excluded vs. included), and the difference between them.
3. **Sign changes:** whether any specifications flip the sign of the focal estimate, and which fork options they share.

Present the results in one summary table, with forks ranked from highest to lowest absolute leverage:

| Fork | Description | Leverage (units) | Leverage (% of baseline) | % significant (A) | % significant (B) | Sign flips? |
|------|-------------|------------------|--------------------------|-------------------|-------------------|-------------|

Also produce a simple chart of leverage by fork (e.g., a dot or bar chart).

> **Important caveat to include in the report:** The p-values from the specification regression are *descriptive*, not formal inference. All 64 models use the same data, so they are not independent observations. Interpret the specification regression as a tool for ranking how much each decision matters, not as a hypothesis test.

#### 5.3 Robustness checks (defaults)

- **Robust SEs:** For the baseline model, compare conventional and robust SEs. Did the correction change the significance of the focal estimate?
- **Trimming:** Compare the overview statistics (5.1) and the leverage table (5.2) for the full and trimmed samples. Do outliers drive the result?
- **Slices:** Report the median focal estimate and the share significant within each slice (bottom, middle, top). Is the relationship consistent across the range of the slicing variable, or concentrated in one part of the distribution?

#### 5.4 Written summary

Write a short plain-language summary (3–5 paragraphs) that answers:

1. How robust is the paper's main finding?
2. Which decisions are most consequential?
3. Which results depend on outliers or on one slice of the data?
4. Anything surprising or concerning I should look at more closely.

Do **not** decide which specification choices are most justifiable. That is my job. You may list considerations relevant to each fork.

---

### SECTION 6: Ground Rules

- **Do not modify the original data file.** Make all transformations in code.
- **Document every decision you make that I did not specify** (e.g., how you handled missing value codes or which standardization you used), both in code comments and in an "Analyst decisions" section of the report.
- **If a fork cannot be built from the available data** (e.g., a variable is missing or coded differently than I described), stop and ask me rather than guessing.
- **Set a random seed** if anything involves randomness.
- **Organize outputs:** scripts in `code/`, the results CSV, figures, and the rendered report in `results/`.

## END OF PROMPT

---

## After the agent finishes: your part

The agent produces the numbers. Your write-up should add your own judgment:

- **Check the baseline.** Did the reproduction match the paper? If not, why?
- **Interpret the leverage table.** Which decisions are most consequential in specifying the model?
- **Evaluate the forks.** Which decisions do you think are most justifiable, and why? Use theory, the data, and the paper's own arguments. A decision with high leverage is not automatically "wrong"; it means the choice needs a strong justification.
- **Assess the defaults.** What did the trimming and slicing checks reveal about the finding?
