# ===============================================================
# REPLICATION STUDY 4: GOLDSTEIN & BLATCHFORD (1998)
# ===============================================================
# Goldstein, H., & Blatchford, P. (1998). Class size and educational
#   achievement: A review of methodology with particular reference to
#   study design. British Educational Research Journal, 24(3), 255-268.
#
# Purpose: a methodology review that includes a multilevel reanalysis
# of STAR. It reports effects that are already standardized, only by
# race, and with and without adjusting for a "pretest" that was
# measured AFTER a year of treatment. The script checks the tables,
# decides which estimate answers the meta-analysis question, and
# rebuilds an overall effect from the subgroups.
#
# Companion guide: ../class-size-replication-goldstein-blatchford.html
# Output:          goldstein_blatchford_1998_coded.csv
# ===============================================================

library(metafor)

# ===============================================================
# STEP 1. ENTER THE REPORTED STATISTICS (with their source)
# ===============================================================

## Table I (p. 264): END-OF-KINDERGARTEN scores, standardized to mean 0,
## SD 1 across all pupils. Rows = kindergarten class type, columns =
## grade 1 class type ("Regular" pools regular and regular-with-aide).
## Numbers of pupils in brackets in the table.
t1 <- data.frame(
  subject = rep(c("math", "reading"), each = 3),
  k_class = rep(c("small", "regular", "total"), 2),
  m_small = c(0.26, 0.00, 0.22,   0.25,  0.00, 0.21),
  n_small = c(1211,  231, 1442,   1202,   227, 1429),
  m_reg   = c(0.02, 0.08, 0.07,  -0.14,  0.07, 0.05),
  n_reg   = c( 101, 2705, 2806,    100,  2668, 2768),
  m_miss  = c(-0.25, -0.35, -0.32, -0.17, -0.33, -0.29),
  n_miss  = c( 450, 1174, 1624,    434,  1147, 1581),
  m_total = c(0.12, -0.04, 0.00,   0.12, -0.05, 0.00),
  n_total = c(2762, 4109, 6871,    1736,  4042, 5778)    # as printed
)

## Table II (p. 265): END-OF-GRADE-1 small-minus-regular effects in SD
## units from a multilevel model, by race only. "Adjusted" controls for
## the end-of-kindergarten score.
t2 <- data.frame(
  subject    = rep(c("math", "reading"), each = 2),
  race       = rep(c("black", "white"), 2),
  unadjusted = c(0.40, 0.29, 0.32, 0.13),
  adjusted   = c(0.35, 0.18, 0.21, 0.04)
)
## Also Table II: between-school SD of the class size effect (reading,
## adjusted model) = 0.25.
tau_school <- 0.25

# ===============================================================
# STEP 2. CHECK THAT THE COUNTS ADD UP
# ===============================================================
t1$n_rowsum <- with(t1, n_small + n_reg + n_miss)
t1[, c("subject", "k_class", "n_total", "n_rowsum")]
# Reading adds up exactly. Math doesn't: the "small" row prints 2,762 but
# its cells sum to 1,762, and the grand total prints 6,871 but the cells
# sum to 5,872. The column sums (1,442 + 2,806 + 1,624 = 5,872) agree
# with the cells, so the printed totals have a wrong first digit. The
# regular row is off by one (4,109 vs. 4,110).

# The row means should be the n-weighted averages of the cells:
t1$m_check <- with(t1, round((m_small * n_small + m_reg * n_reg + m_miss * n_miss) / n_rowsum, 3))
t1[, c("subject", "k_class", "m_total", "m_check")]
# They agree to rounding, which confirms the cell counts are right and the
# printed math totals are typos.

# ===============================================================
# STEP 3. REPRODUCE THE TEXT'S KINDERGARTEN EFFECTS
# ===============================================================
# Text, p. 264: "an overall difference in favour of the small classes,
# whether classified by kindergarten membership (0.16 units for
# mathematics and 0.17 for reading) or grade 1 membership (0.29 for
# mathematics and 0.26 for reading)."
by_k  <- with(t1[t1$k_class != "total", ], tapply(m_total, subject, function(x) x[1] - x[2]))
by_g1 <- with(t1[t1$k_class == "total", ], setNames(m_small - m_reg, subject))
rbind(by_k_membership = by_k, by_g1_membership = by_g1)
# By kindergarten class: 0.16 and 0.17, matching the text. By grade 1 class:
# the table gives 0.15 and 0.16, not 0.29 and 0.26. The next paragraph
# says the difference is "about 0.15" and "the same at the end of
# kindergarten and the end of grade 1", which agrees with the table, not
# with 0.29/0.26. Record the inconsistency; code from the table.

# ===============================================================
# STEP 4. WHICH TABLE II COLUMN ANSWERS THE META-ANALYSIS QUESTION?
# ===============================================================
# The adjusted column controls for the end-of-kindergarten score. For
# most pupils, that score was measured after a year in their assigned
# class, so it already contains part of the treatment effect. Adjusting
# for it estimates the ADDITIONAL effect of grade 1, given kindergarten.
# That is a legitimate question, but a different one: the cumulative
# effect of small classes by the end of grade 1 is the UNADJUSTED
# column.
#
# Contrast with Molnar (case study 3): there the pretest was taken in
# October, before the treatment could act, so adjusting removes
# pre-existing differences. Here, adjusting removes treatment.
#
# Decision: unadjusted = primary; adjusted = stored for a sensitivity
# analysis of "second-year" effects.
t2$diff <- t2$unadjusted - t2$adjusted
t2

# ===============================================================
# STEP 5. VARIANCES: NOTHING IS REPORTED
# ===============================================================
# No SEs, no n by race or class type for grade 1. Impute from the
# 1990 coding:
#   - grade 1 pupils: 6,570 (Finn & Achilles, 1990)
#   - minority share: about one third (1990, note 6: 32.8, 36.4, 29.4%)
#   - small-class share: 1,870 / 6,570
#   - design effect for classes: 2.93
N_g1   <- 6570
p_blk  <- 0.33
p_sml  <- 1870 / 6570
deff   <- 2.93

n_race <- c(black = N_g1 * p_blk, white = N_g1 * (1 - p_blk))
t2$n   <- n_race[t2$race]
t2$n_S <- t2$n * p_sml
t2$n_R <- t2$n * (1 - p_sml)
t2$v   <- with(t2, (1 / n_S + 1 / n_R + unadjusted^2 / (2 * n)) * deff)
t2$se  <- sqrt(t2$v)
t2[, c("subject", "race", "unadjusted", "n", "se")]

# A second check from the paper's own multilevel output: the effect
# varies across schools with SD 0.25 (reading). With about 79 schools,
# the average effect can't be known more precisely than about
#   0.25 / sqrt(79)
round(tau_school / sqrt(79), 3)
# 0.028 from school-to-school variation alone. That is a third to a half of
# the clustered SEs above (0.057-0.082), so the imputed SEs are the right order of
# magnitude.

# ===============================================================
# STEP 6. REBUILD AN OVERALL EFFECT FROM THE SUBGROUPS
# ===============================================================
# Most meta-analyses want one overall effect per outcome. Weight the two
# race groups by their share of pupils. Because the groups are separate
# children, their variances add with squared weights (no covariance).
overall <- do.call(rbind, lapply(split(t2, t2$subject), function(s) {
  w <- c(black = p_blk, white = 1 - p_blk)[s$race]
  data.frame(subject    = s$subject[1],
             unadjusted = sum(w * s$unadjusted),
             adjusted   = sum(w * s$adjusted),
             v          = sum(w^2 * s$v))
}))
overall$se <- sqrt(overall$v)
overall[, c("unadjusted", "adjusted", "se")] <- round(overall[, c("unadjusted", "adjusted", "se")], 3)
overall
# Unadjusted: math 0.33, reading 0.19. Note that "minority" in STAR
# includes a few non-Black pupils. G&B report Black and white only, so
# the weights are approximate.

# ===============================================================
# STEP 7. SAME CHILDREN, DIFFERENT ANALYSTS
# ===============================================================
# Compare with Finn & Achilles' grade 1 race-specific effects for the
# same pupils (1990 Table 6 / 1999 Table 1).
same_kids <- data.frame(
  subject = c("math", "math", "reading", "reading"),
  race    = c("black/minority", "white", "black/minority", "white"),
  goldstein_blatchford = c(0.40, 0.29, 0.32, 0.13),
  finn_achilles_1990   = c(0.31, 0.22, 0.35, 0.15)
)
same_kids$gap <- same_kids$goldstein_blatchford - same_kids$finn_achilles_1990
same_kids
# Differences of -0.03 to +0.09 SD for the same children. Candidate
# reasons, none stated in the paper: (a) G&B standardize by the SD of ALL
# pupils, F&A by the SD of regular-class pupils; (b) G&B contrast small
# with regular and aide pupils POOLED BY n, F&A with the average of the two class means;
# (c) pupil-level multilevel model vs. class means; (d) G&B's sample may
# be restricted to pupils with kindergarten scores.

# ===============================================================
# STEP 8. ASSEMBLE THE CODED ROWS
# ===============================================================
coded <- rbind(
  data.frame(grade = 0, subject = c("math", "reading"), group = "all",
             d = unname(by_k), adjusted_for_K = FALSE,
             source_table = "Table I (by kindergarten class)", se = NA),
  data.frame(grade = 1, subject = t2$subject, group = t2$race,
             d = t2$unadjusted, adjusted_for_K = FALSE,
             source_table = "Table II, no adjustment", se = round(t2$se, 4)),
  data.frame(grade = 1, subject = t2$subject, group = t2$race,
             d = t2$adjusted, adjusted_for_K = TRUE,
             source_table = "Table II, adjusted", se = round(t2$se, 4)),
  data.frame(grade = 1, subject = overall$subject, group = "all (rebuilt)",
             d = overall$unadjusted, adjusted_for_K = FALSE,
             source_table = "Table II, weighted by race", se = overall$se)
)
coded$study_id    <- "goldstein_blatchford_1998"
coded$dataset     <- "STAR"
coded$cohort      <- "1985 K entry"
coded$design      <- "RCT (secondary analysis)"
coded$control     <- "regular + aide, pooled"
coded$sd_type     <- "SD of all pupils (z-scores)"
coded$published   <- 1
coded$dup_of      <- ifelse(coded$grade == 0, "finn_achilles_1999", "finn_achilles_1990")
coded$in_primary  <- FALSE
coded$use         <- ifelse(coded$adjusted_for_K, "sensitivity: second-year effect",
                     ifelse(coded$group %in% c("black", "white"), "moderator: race",
                            "cross-check only"))
coded$notes       <- "no SEs reported; SE imputed from 1990 arm shares, 33% Black, DEFF 2.93"
coded[, c("grade", "subject", "group", "d", "se", "adjusted_for_K", "use")]

write.csv(coded, "goldstein_blatchford_1998_coded.csv", row.names = FALSE)

# ===============================================================
# STEP 9. WHAT SHIN & CHUNG RECORDED
# ===============================================================
# Table 2: "Goldstein, et al., 1998, BERJ, random = 1, STAR, R, M,
# published = 1, grade K, 1."
#  - Correct on design, data, subjects, and grades.
#  - It is one of seven reports of these Grade 1 children in their sample
#    (see finn_achilles_1999.R, Step 6).
#  - "et al." for a two-author paper.
#  - Their formula needs means, SDs, and n per group. Table I gives means
#    (in SD units) and n; Table II gives neither, only effects.
