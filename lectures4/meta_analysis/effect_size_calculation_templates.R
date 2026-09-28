
# ===============================================================
# EFFECT SIZE CALCULATION TEMPLATES FOR META-ANALYSIS
# ===============================================================
# These templates guide researchers through coding and interpreting
# effect sizes for different designs (between, within, regression-based, etc.)
# Each template lists arguments and definitions, performs calculations,
# and returns text-based interpretations.
# ===============================================================

# --- Helper: small-sample bias correction for Hedges' g ---
J_correction <- function(df) {
  1 - 3/(4*df - 1)
}

# ===============================================================
# 1. BETWEEN-SUBJECTS: Standardized Mean Difference (SMD)
# ===============================================================

## EFFECT: Standardized Mean Difference (SMD)
## METRIC: Hedges' g
## REPORTED STATS: Between-subjects t-test or group means

mean_t <- NA  # Mean of treatment group (post-test)
mean_c <- NA  # Mean of control group (post-test)
sd_t   <- NA  # Standard deviation of treatment group
sd_c   <- NA  # Standard deviation of control group
n_t    <- NA  # Sample size of treatment group
n_c    <- NA  # Sample size of control group

direction <- 1  # 1 = higher is better; -1 = lower is better

# --- Compute pooled SD and Hedges' g ---
s_p <- sqrt(((n_t - 1)*sd_t^2 + (n_c - 1)*sd_c^2) / (n_t + n_c - 2))
d <- direction * ( (mean_t - mean_c) / s_p )
df <- n_t + n_c - 2
d <- d * J_correction(df)  # small-sample correction
v_d <- (n_t + n_c)/(n_t*n_c) + (d^2)/(2*(n_t + n_c))

interpretation <- paste0(
  "Between-group effect (Hedges' g): ", round(d, 3),
  ". Variance: ", round(v_d, 4),
  ".\nInterpretation: A positive g indicates higher scores in the treatment group. ",
  "Effect sizes of 0.2, 0.5, and 0.8 are commonly interpreted as small, medium, and large effects, respectively."
)

list(effect = "Hedges g (between-subjects)", d = d, var = v_d, df = df, note = interpretation)

# ===============================================================
# 2. WITHIN-SUBJECTS: Standardized Mean Change (SMC)
# ===============================================================

## EFFECT: Standardized Mean Change (SMC)
## METRIC: Hedges' g
## REPORTED STATS: Pre-Post within-subject comparison

mean_pre  <- NA  # Mean before treatment or intervention
mean_post <- NA  # Mean after treatment or intervention
sd_pre    <- NA  # Standard deviation before
sd_post   <- NA  # Standard deviation after
n         <- NA  # Sample size (same participants)
r         <- 0.5 # Correlation between pre- and post-scores (estimate if unknown)

direction <- 1  # 1 = improvement is positive, -1 = decline is positive

# --- Compute SD of change and effect size ---
sd_change <- sqrt(sd_pre^2 + sd_post^2 - 2*r*sd_pre*sd_post)
d <- direction * ((mean_post - mean_pre) / sd_change)
df <- n - 1
d <- d * J_correction(df)
v_d <- (2*(1 - r))/n + (d^2)/(2*n)

interpretation <- paste0(
  "Within-group effect (Standardized Mean Change, Hedges' g): ", round(d, 3),
  ". Variance: ", round(v_d, 4),
  ".\nInterpretation: Positive g indicates improvement from pre to post. ",
  "Accounting for pre-post correlation (r = ", r, ") adjusts the variance."
)

list(effect = "Hedges g (within-subjects)", d = d, var = v_d, df = df, note = interpretation)

# ===============================================================
# 3. REGRESSION WITH BINARY TREATMENT
# ===============================================================

## EFFECT: Regression coefficient standardized to d
## METRIC: Standardized Mean Difference equivalent
## REPORTED STATS: OLS regression with binary treatment indicator (0/1)

beta  <- NA   # Coefficient on treatment dummy
s_y   <- NA   # Standard deviation of dependent variable (Y)
n_t   <- NA   # Number in treatment group
n_c   <- NA   # Number in control group
df    <- NA   # Degrees of freedom (optional)
direction <- 1

d <- direction * (beta / s_y)
if (!is.na(df)) d <- d * J_correction(df)
v_d <- if (!is.na(n_t) && !is.na(n_c)) { (n_t + n_c)/(n_t*n_c) + (d^2)/(2*(n_t + n_c)) } else { NA }

interpretation <- paste0(
  "Regression-based effect (standardized): ", round(d, 3),
  ". Variance: ", round(v_d, 4),
  ".\nInterpretation: The standardized mean difference equivalent of the regression coefficient, ",
  "where beta represents the mean shift in Y when D=1 versus D=0."
)

list(effect = "Regression standardized difference", d = d, var = v_d, note = interpretation)

# ===============================================================
# 4. CONTINUOUS DOSAGE VARIABLE (e.g., class size)
# ===============================================================

## EFFECT: Dosage-based effect (continuous X)
## METRIC: Standardized change per unit difference
## REPORTED STATS: OLS regression with continuous predictor (e.g., students per class)

beta  <- NA  # Regression slope (change in Y per 1-unit change in X)
s_y   <- NA  # SD of outcome variable
delta <- 8   # Number of units of change to standardize over (e.g., 8-student reduction)
direction <- -1 # -1 if smaller X = better outcome (e.g., smaller classes)

d <- direction * (beta * delta / s_y)

interpretation <- paste0(
  "Continuous-dosage effect (standardized over ", delta, " units): ", round(d, 3),
  ".\nInterpretation: Represents the expected standardized change in Y ",
  "for a ", delta, "-unit change in X (e.g., an 8-student reduction in class size)."
)

list(effect = "Dosage standardized difference", d = d, note = interpretation)

# ===============================================================
# 5. DIFFERENCE-IN-DIFFERENCES (DID)
# ===============================================================

## EFFECT: Interaction coefficient standardized to d
## METRIC: Standardized Mean Difference equivalent
## REPORTED STATS: DID regression (Y = b0 + b1*D + b2*T + b3*D*T + e)

beta3 <- NA   # DID interaction term
s_change <- NA  # SD of change scores
direction <- 1

d <- direction * (beta3 / s_change)

interpretation <- paste0(
  "Difference-in-Differences effect: ", round(d, 3),
  ".\nInterpretation: Represents the standardized difference in outcome change ",
  "between treated and untreated groups across time periods."
)

list(effect = "DID standardized difference", d = d, note = interpretation)

# ===============================================================
# 6. FIXED EFFECTS (WITHIN-UNIT) MODELS
# ===============================================================

## EFFECT: Within-unit coefficient standardized to d
## METRIC: Standardized Mean Difference equivalent
## REPORTED STATS: Panel fixed effects regression

beta_within <- NA   # Within-unit (fixed effects) coefficient
s_within_y  <- NA   # Within-unit SD of outcome variable

d <- beta_within / s_within_y

interpretation <- paste0(
  "Fixed-effects (within-unit) effect: ", round(d, 3),
  ".\nInterpretation: Captures within-unit variation only, ",
  "standardized by the within-unit SD of Y."
)

list(effect = "Fixed-effects standardized difference", d = d, note = interpretation)

# ===============================================================
# 7. LOGISTIC REGRESSION METRICS
# ===============================================================

## EFFECT: Odds ratio or log-odds ratio converted to d
## METRIC: Standardized Mean Difference

or <- NA       # Odds ratio
log_or <- NA   # Log odds ratio (alternative)

if (!is.na(or)) {
  d <- log(or) * sqrt(3)/pi
} else if (!is.na(log_or)) {
  d <- log_or * sqrt(3)/pi
} else {
  d <- NA
}

interpretation <- paste0(
  "Logistic effect (odds ratio -> d): ", round(d, 3),
  ".\nInterpretation: Translates odds-based effect to a standardized mean difference. ",
  "Approximation assumes logistic residual variance = π²/3."
)

list(effect = "Logistic standardized difference", d = d, note = interpretation)
