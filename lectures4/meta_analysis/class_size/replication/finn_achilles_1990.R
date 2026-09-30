# ===============================================================
# REPLICATION STUDY 1: FINN & ACHILLES (1990)
# ===============================================================
# Finn, J. D., & Achilles, C. M. (1990). Answers and questions about
#   class size: A statewide experiment. American Educational Research
#   Journal, 27(3), 557-577.
#
# Purpose: extract the statistics needed to code this study for a
# class-size meta-analysis (Shin & Chung, 2009, list it in Table 2),
# reproduce the effect sizes the authors report, and document every
# coding decision along the way.
#
# Companion guide: ../class-size-replication-finn-achilles.html
# Output:          finn_achilles_1990_coded.csv
# ===============================================================

library(metafor)

# ===============================================================
# STEP 1. ENTER THE REPORTED STATISTICS (with their source)
# ===============================================================
# Rule: type numbers exactly as printed. Anything you derive or
# impute goes in a later step, never in this block.

measures <- c("word_study", "sat_reading", "bsf_reading", "sat_math", "bsf_math")

## Table 5 (p. 566): Grade 1 means for the three class types.
## BSF values are the average percentage of pupils passing.
means <- data.frame(
  measure = measures,
  small   = c(535.5, 521.8, 68.0, 536.9, 84.4),
  regular = c(520.6, 505.1, 55.9, 523.7, 78.1),
  aide    = c(527.2, 512.7, 60.0, 527.7, 80.2)
)

## Table 3 (p. 564), bottom row: student-level SDs, regular classes
## only (footnote b). BSF SDs come from scoring each pupil 0/1, so
## they are on the percentage-point scale (footnote a).
sd_student <- c(51.55, 55.48, 48.56, 41.60, 38.91)

## Table 5 (p. 566): the authors' own effect sizes, for checking.
## Row "Student SD" uses the SDs above; row "Class SD" divides by the
## SD of class means in regular classes (the SD itself is not printed).
reported <- data.frame(
  measure            = measures,
  es_student_small   = c(.22, .23, .21, .27, .13),  # Small - Others
  es_class_small     = c(.62, .64, .51, .66, .32),
  es_student_aide    = c(.13, .14, .08, .10, .05),  # Aide - Regular
  es_class_aide      = c(.35, .37, .26, .23, .15)
)

## Sample sizes (p. 560): 6,570 students in 331 classes after
## screening: 122 small, 111 regular, 98 aide. Students per class
## type are NOT reported. Class sizes (p. 559): "about 22 students
## present and providing data" in regular classes, "about 15" in small.
n_students_total <- 6570
n_classes <- c(small = 122, regular = 111, aide = 98)
per_class <- c(small = 15, regular = 22, aide = 22)

# ===============================================================
# STEP 2. REPRODUCE THE AUTHORS' EFFECT SIZES
# ===============================================================
# Footnote to Table 6 (p. 567) gives the contrast:
#   Small - (Regular + Aide)/2, divided by the regular-class SD.
# That is Glass's delta with the control-group SD as standardizer.

means$others <- (means$regular + means$aide) / 2
check <- data.frame(
  measure  = measures,
  diff     = means$small - means$others,
  ours     = round((means$small - means$others) / sd_student, 3),
  reported = reported$es_student_small
)
check
# All five match to rounding. Two things this confirms:
#  1. The Table 3 SD row is the standardizer (not a pooled SD).
#  2. For BSF, the effect size is a difference in percentage points
#     divided by the SD of a 0/1 pass score, even though the
#     significance tests used log-odds (Table 5, footnote e).

# The class-level SDs are not printed, but you can back them out:
sd_class <- (means$small - means$others) / reported$es_class_small
round(sd_class, 1)
# SAT scales: about 17-19 points between class means, versus 42-55
# points between students. A meta-analysis that mixes class-SD and
# student-SD effect sizes mixes two different scales.

# ===============================================================
# STEP 3. DECISION: WHICH GROUP IS THE CONTROL?
# ===============================================================
# Option A (authors): Small vs. average of Regular and Aide.
# Option B:           Small vs. Regular only.
#
# The aide classes have 22-25 students, the same size as regular
# classes, plus a second adult. That lowers the pupil-adult ratio
# without shrinking the class, so it's a different treatment. For a
# meta-analysis of class size (not PTR), Option B is the cleaner
# contrast. Option A is kept as a sensitivity check.
#
# Note also (p. 560): half the regular and aide pupils were swapped
# between those two arms after kindergarten, so "aide" in Grade 1 is
# a mixture. Small-class pupils were never reassigned.

# ===============================================================
# STEP 4. DECISION: SAMPLE SIZES PER ARM (IMPUTED)
# ===============================================================
# The paper gives classes per arm and approximate class sizes, not
# students per arm. Impute: classes x typical size, then rescale so
# the three arms add to the reported 6,570.

n_raw <- n_classes * per_class                      # 1830, 2442, 2156
n_arm <- round(n_raw * n_students_total / sum(n_raw))
n_arm
# small ~1,870, regular ~2,496, aide ~2,204. Record in the notes
# field that these are imputed. They only affect the variance, not d.

# ===============================================================
# STEP 5. SAT OUTCOMES: HEDGES' g, SMALL vs. REGULAR
# ===============================================================
# Only the regular-class SD is reported, so it serves as the SD for
# both groups. escalc() then applies the small-sample correction J.

sat <- c("word_study", "sat_reading", "sat_math")
i   <- match(sat, measures)

es_sat <- escalc(measure = "SMD",
                 m1i = means$small[i],   sd1i = sd_student[i], n1i = rep(n_arm[["small"]], 3),
                 m2i = means$regular[i], sd2i = sd_student[i], n2i = rep(n_arm[["regular"]], 3),
                 slab = sat)
es_sat
# With n in the thousands, J = 0.9998, so g and d are the same to
# three decimals. The small-vs-regular effects (.29 to .32) are
# larger than the authors' small-vs-others effects (.22 to .27)
# because aide classes scored a bit above regular classes.

# ===============================================================
# STEP 6. BSF OUTCOMES: PASS RATES TO d
# ===============================================================
# Two defensible routes:
#  (a) Authors' route: percentage-point difference / SD of 0/1 score.
#  (b) Logit route: log odds ratio x sqrt(3)/pi (Chinn, 2000;
#      Borenstein et al., 2009, ch. 7). This is metafor's "OR2DL".
# Route (b) is the standard way to put a dichotomous outcome on the
# SMD scale, so it's the primary choice here. Cell counts are
# reconstructed from the pass rates and the imputed n.

bsf <- c("bsf_reading", "bsf_math")
j   <- match(bsf, measures)

p_small <- means$small[j] / 100
p_reg   <- means$regular[j] / 100
es_bsf <- escalc(measure = "OR2DL",
                 ai = round(p_small * n_arm[["small"]]),   bi = round((1 - p_small) * n_arm[["small"]]),
                 ci = round(p_reg * n_arm[["regular"]]),   di = round((1 - p_reg) * n_arm[["regular"]]),
                 slab = bsf)

bsf_compare <- data.frame(
  measure     = bsf,
  authors_way = round((means$small[j] - means$regular[j]) / sd_student[j], 3),
  logit_way   = round(as.numeric(es_bsf$yi), 3)
)
bsf_compare
# The logit route gives slightly larger values. Neither is wrong, but
# pick one rule and use it for every dichotomous outcome in the review.

# ===============================================================
# STEP 7. DECISION: ADJUST THE VARIANCE FOR CLUSTERING
# ===============================================================
# escalc() treats ~4,400 students as independent. They were taught in
# 233 small and regular classes. The class-level effect sizes in
# Table 5 let us estimate the intraclass correlation (ICC).
#
# For regular classes with m students each:
#   Var(class means) = tau^2 + (sigma^2 - tau^2) / m
# Solving for tau^2 gives the ICC = tau^2 / sigma^2.

m_reg <- per_class[["regular"]]
tau2  <- (sd_class^2 - sd_student^2 / m_reg) / (1 - 1 / m_reg)
icc   <- tau2 / sd_student^2
data.frame(measure = measures, sd_class = round(sd_class, 1), icc = round(icc, 3))
# SAT scales: ICC about .09 to .13. The BSF class-level SDs are on the
# log-odds scale (Table 5, footnote e), so their ICCs aren't usable.
# Use the mean of the SAT ICCs for all five outcomes.

icc_use <- mean(icc[match(sat, measures)])
m_bar   <- n_students_total / sum(n_classes)          # ~19.8 students per class
deff    <- 1 + (m_bar - 1) * icc_use                  # Kish design effect
round(c(icc = icc_use, m_bar = m_bar, deff = deff), 3)
# The variance should be about 2.9 times larger than the naive one
# (the SE about 1.7 times larger).
# Randomization was blocked within schools, which would shrink the
# variance again, so this is a conservative (upper) adjustment.

# ===============================================================
# STEP 8. ASSEMBLE THE CODED ROWS
# ===============================================================
# One row per outcome. Keep all five, flag them as dependent (same
# students, same study), and mark the two primary outcomes.

es_all <- rbind(
  data.frame(measure = sat, yi = as.numeric(es_sat$yi), vi = as.numeric(es_sat$vi),
             es_method = "Hedges g, regular-class SD"),
  data.frame(measure = bsf, yi = as.numeric(es_bsf$yi), vi = as.numeric(es_bsf$vi),
             es_method = "log OR x sqrt(3)/pi")
)
es_all <- es_all[match(measures, es_all$measure), ]

coded <- data.frame(
  study_id    = "finn_achilles_1990",
  dataset     = "STAR",
  cohort      = "1985 K entry",
  design      = "RCT",
  assign_unit = "students & teachers within schools",
  measure     = "class size",
  size_S      = 15,
  size_L      = 22,
  delta       = 7,
  subject     = c("reading", "reading", "reading", "math", "math"),
  outcome     = measures,
  test_type   = c("standardized", "standardized", "curriculum-based",
                  "standardized", "curriculum-based"),
  grade       = 1,
  timing      = "end of year 2 of treatment",
  published   = 1,
  control     = "regular (no aide)",
  sd_type     = ifelse(measures %in% bsf, "none (logit conversion)", "student SD, regular classes"),
  direction   = 1,
  primary     = measures %in% c("sat_reading", "sat_math"),
  d           = round(es_all$yi, 4),
  var_d       = round(es_all$vi, 6),
  var_d_clust = round(es_all$vi * deff, 6),
  es_method   = es_all$es_method,
  n_S         = n_arm[["small"]],
  n_L         = n_arm[["regular"]],
  notes       = "n per arm imputed from classes x size; var_d_clust uses DEFF from Table 5 class-level ES"
)
coded$se_clust <- round(sqrt(coded$var_d_clust), 4)
coded[, c("outcome", "d", "var_d", "var_d_clust", "se_clust", "primary")]

write.csv(coded, "finn_achilles_1990_coded.csv", row.names = FALSE)

# ===============================================================
# STEP 9. ONE EFFECT PER STUDY? A COMPOSITE WITHIN SUBJECT
# ===============================================================
# If the meta-analysis allows one effect per subject per study, average
# the correlated outcomes. The variance of a mean of k correlated
# effects needs the correlation r between outcomes, which the paper
# doesn't report. r = .7 is a common assumption for reading subtests.

composite <- function(y, v, r) {
  k <- length(y)
  V <- r * sqrt(outer(v, v)); diag(V) <- v
  c(d = mean(y), var = sum(V) / k^2)
}
r_assumed <- 0.7
rbind(
  reading = composite(coded$d[1:3], coded$var_d_clust[1:3], r_assumed),
  math    = composite(coded$d[4:5], coded$var_d_clust[4:5], r_assumed)
)

# ===============================================================
# STEP 10. WHAT NOT TO ADD
# ===============================================================
# - Table 4 and Table 6 (white / minority): these are the same students
#   split in two. Entering them alongside the overall rows counts every
#   student twice. Use them only in a moderator analysis that replaces
#   the overall rows.
# - Tables 9-11 (longitudinal): a 35% subset of the same Grade 1
#   students, with no SDs printed. Don't add.
# - Table 7 (motivation, self-concept): not an achievement outcome.
# - Other STAR papers (Finn et al., 1989; Achilles, 1994; Finn &
#   Achilles, 1999; Mosteller, 1995; Nye et al., 1992) report the same
#   children. The dataset and cohort columns are there so overlaps can
#   be found and resolved later.

# Race subgroups, small vs. regular, for a moderator analysis only:
race <- data.frame(
  group   = rep(c("white", "minority"), each = 5),
  measure = rep(measures, 2),
  small   = c(545.2, 530.3, 69.5, 545.8, 88.1,  518.6, 507.1, 65.4, 521.3, 77.8),  # Table 4, p. 565
  regular = c(534.4, 518.1, 62.3, 535.4, 85.1,  503.5, 489.0, 48.0, 509.2, 69.4),
  aide    = c(540.2, 525.3, 67.1, 538.2, 85.0,  505.6, 491.7, 48.3, 510.3, 72.2),
  sd      = c(50.42, 56.04, 47.26, 40.37, 34.34, 44.58, 47.71, 49.90, 37.97, 45.16)
)
race$es_table6  <- round((race$small - (race$regular + race$aide) / 2) / race$sd, 2)  # check vs Table 6
race$es_vs_reg  <- round((race$small - race$regular) / race$sd, 3)
race
