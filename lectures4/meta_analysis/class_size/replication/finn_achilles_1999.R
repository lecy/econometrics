# ===============================================================
# REPLICATION STUDY 2: FINN & ACHILLES (1999)
# ===============================================================
# Finn, J. D., & Achilles, C. M. (1999). Tennessee's class size study:
#   Findings, implications, misconceptions. Educational Evaluation and
#   Policy Analysis, 21(2), 97-109.
#
# Purpose: code a paper that reports ONLY effect sizes, on the same
# children already coded from Finn & Achilles (1990), and show what
# happens to a pooled estimate when one experiment is counted many
# times.
#
# Run finn_achilles_1990.R first (Step 7 below reads its CSV).
#
# Companion guide: ../class-size-replication-finn-achilles-1999.html
# Output:          finn_achilles_1999_coded.csv
# ===============================================================

library(metafor)

# ===============================================================
# STEP 1. ENTER THE REPORTED STATISTICS (with their source)
# ===============================================================

## Table 1 (p. 99): small-class effect sizes, Grades K-3, all pupils.
## Contrast: Small - (Regular + Aide)/2, divided by the SD of pupils
## in regular classes (table note). Blank cells are NA.
## Footnote b: the Grade 3 "Reading" value is the Total Language scale.
t1 <- data.frame(
  scale = rep(c("word_study", "sat_reading", "total_reading", "total_math"), each = 4),
  grade = rep(0:3, 4),                                   # 0 = kindergarten
  d     = c(0.15, 0.22, 0.20, NA,                        # Word Study Skills
            0.18, 0.22, 0.19, 0.25,                      # Reading (G3 = Total Language)
            0.18, 0.24, 0.23, 0.26,                      # Total Reading
            0.15, 0.27, 0.20, 0.23)                      # Total Mathematics
)
t1 <- t1[!is.na(t1$d), ]
t1$scale[t1$scale == "sat_reading" & t1$grade == 3] <- "total_language"

## Table 1 column heads: pupils per grade. Footnote a: Grades 2-3
## exclude pupils whose teachers received STAR training.
N_grade <- c("0" = 5738, "1" = 6572, "2" = 5148, "3" = 4744)

## Table 1, BSF rows: differences in PERCENT PASSING, with no base rate
## and no SD. Grade 1 base rates exist in the 1990 paper; Grades 2-3
## have none anywhere in this article.
bsf <- data.frame(
  scale = rep(c("bsf_reading", "bsf_math"), each = 3),
  grade = rep(1:3, 2),
  pp    = c(9.6, 6.9, 7.2,   5.9, 4.7, 6.7)
)

## Table 2 (p. 100): Lasting Benefits Study, Grades 4-7, after all pupils
## returned to regular classes. Contrast: Small - Regular (NOT the
## average with aide). Note: Grade 4 uses the regular-class SD; Grades
## 5-7 use a pooled within-cell SD.
t2_scales <- c("total_reading", "total_language", "total_math", "science",
               "social_science", "study_skills", "cbt_language_arts", "cbt_math")
t2 <- data.frame(
  scale = rep(t2_scales, each = 4),
  grade = rep(4:7, length(t2_scales)),
  d     = c(0.13, 0.22, 0.21, 0.15,
            0.13, 0.18, 0.14, 0.15,
            0.12, 0.18, 0.16, 0.14,
            0.12, 0.17, 0.15, 0.14,
            0.11, 0.17, 0.15, 0.10,
            0.14, 0.18, 0.16, 0.16,
            0.11, 0.34, 0.26, 0.08,
            0.16, 0.28, 0.17, 0.08)
)
N_follow <- c("4" = 4230, "5" = 4649, "6" = 4333, "7" = 4944)

## Table 3 (p. 102): differences in grade-equivalent months. There is no
## SD on the GE scale, so these can't become a d. Not entered.

# ===============================================================
# STEP 2. CHECK GRADE 1 AGAINST THE 1990 PAPER
# ===============================================================
# The Grade 1 column describes the same children as Finn & Achilles
# (1990), Tables 5 and 6. Both use the same contrast, so they should agree.

g1_check <- data.frame(
  outcome = c("word_study", "sat_reading", "sat_math", "bsf_reading_pp", "bsf_math_pp",
              "white_sat_reading", "minority_sat_reading"),
  y1999   = c(0.22, 0.22, 0.27, 9.6, 5.9, 0.16, 0.35),
  y1990   = c(0.22, 0.23, 0.27, 10.1, 5.2, 0.15, 0.35)
)
g1_check$match <- g1_check$y1999 == g1_check$y1990
g1_check
# Most values agree, but SAT reading (.22 vs .23), white SAT reading
# (.16 vs .15), and the BSF pass-rate differences (9.6 vs 10.1; 5.9 vs
# 5.2) do not. N differs too (6,572 vs 6,570). The 1999 table is
# "taken from Finn (1998)" (p. 99), a later reanalysis. The race-specific
# BSF values agree exactly, so the overall BSF numbers were probably
# computed differently (e.g., pupils pooled rather than classes averaged).
#
# Decision: the 1999 Grade 1 rows are DUPLICATES of children already
# coded. Keep the 1990 rows (they come with means and SDs) and record
# the discrepancy.

# ===============================================================
# STEP 3. VARIANCES WHEN ONLY d AND TOTAL N ARE REPORTED
# ===============================================================
# Arm sizes are not reported. Borrow the Grade 1 arm shares from the
# 1990 coding: small 1,870, regular 2,496, aide 2,204 of 6,570.
share <- c(small = 1870, regular = 2496, aide = 2204) / 6570

# For Table 1 the contrast compares small with the AVERAGE of two groups:
#   Var(mean_S - (mean_R + mean_A)/2) = sigma^2 * (1/nS + 1/(4 nR) + 1/(4 nA))
# so the sampling variance of d is approximately
#   v = 1/nS + 1/(4 nR) + 1/(4 nA) + d^2 / (2N)
var_small_vs_others <- function(d, N) {
  n <- N * share
  1 / n[["small"]] + 1 / (4 * n[["regular"]]) + 1 / (4 * n[["aide"]]) + d^2 / (2 * N)
}

# Table 2 is small vs. regular only. Which pupils are in each N is not
# stated. Assume the same shares, with the aide pupils left out of the contrast.
var_small_vs_regular <- function(d, N) {
  n <- N * share
  1 / n[["small"]] + 1 / n[["regular"]] + d^2 / (2 * N)
}

# Clustering (from the 1990 coding): DEFF = 2.93 while pupils were in
# their experimental classes (K-3). After Grade 4 the pupils were spread
# across new classes, so no design effect is applied there, and the
# residual clustering is unknown.
deff_k3 <- 2.93

t1$N     <- N_grade[as.character(t1$grade)]
t1$var_d <- mapply(var_small_vs_others, t1$d, t1$N)
t1$var_d_clust <- t1$var_d * deff_k3

t2$N     <- N_follow[as.character(t2$grade)]
t2$var_d <- mapply(var_small_vs_regular, t2$d, t2$N)
t2$var_d_clust <- t2$var_d

# ===============================================================
# STEP 4. BSF: CAN A PERCENTAGE-POINT DIFFERENCE BECOME A d?
# ===============================================================
# A logit conversion needs both pass rates, not just the difference.
# Show why guessing the base rate is risky: the same 7-point gap gives
# very different d values depending on where it sits.
gap_to_d <- function(p_ctrl, gap) (qlogis(p_ctrl + gap) - qlogis(p_ctrl)) * sqrt(3) / pi
round(sapply(c(0.50, 0.70, 0.85), gap_to_d, gap = 0.072), 3)
# 0.16 to 0.41 for the same 7.2 points. Decision: don't code BSF for
# Grades 2-3. Grade 1 BSF is already coded from the 1990 paper.

# ===============================================================
# STEP 5. ASSEMBLE THE CODED ROWS
# ===============================================================
subject_of <- c(word_study = "reading", sat_reading = "reading", total_reading = "reading",
                total_language = "language", total_math = "math", science = "science",
                social_science = "social science", study_skills = "study skills",
                cbt_language_arts = "language", cbt_math = "math")

coded <- rbind(
  data.frame(t1, control = "(regular + aide)/2", sd_type = "student SD, regular classes",
             timing = "during treatment", test_type = "standardized (SAT)"),
  data.frame(t2, control = "regular",
             sd_type = ifelse(t2$grade == 4, "student SD, regular classes", "pooled within-cell SD"),
             timing = "after treatment (follow-up)",
             test_type = ifelse(grepl("^cbt", t2$scale), "curriculum-based (domains mastered)",
                                "standardized (CTBS)"))
)
coded$study_id   <- "finn_achilles_1999"
coded$source     <- ifelse(coded$grade <= 3, "Finn (1998) via Table 1", "Lasting Benefits reports via Table 2")
coded$dataset    <- "STAR"
coded$cohort     <- "1985 K entry"
coded$design     <- "RCT"
coded$size_S     <- 15
coded$size_L     <- 22
coded$subject    <- subject_of[coded$scale]
coded$published  <- 1
coded$dup_of     <- ifelse(coded$grade == 1, "finn_achilles_1990",
                    ifelse(coded$grade == 5, "nye_1992", NA))   # Table 2, grade 5 = Nye et al. (1992)
coded$in_primary <- coded$grade %in% c(0, 2, 3)    # new, during-treatment rows
coded$se_clust   <- sqrt(coded$var_d_clust)
coded$notes      <- "d as printed; variance from total N with arm shares borrowed from 1990"

coded <- coded[, c("study_id", "source", "dataset", "cohort", "design", "grade", "timing",
                   "scale", "subject", "test_type", "control", "sd_type", "size_S", "size_L",
                   "published", "d", "N", "var_d", "var_d_clust", "se_clust",
                   "dup_of", "in_primary", "notes")]
coded[coded$grade <= 3, c("grade", "scale", "d", "N", "se_clust", "dup_of", "in_primary")]

write.csv(coded, "finn_achilles_1999_coded.csv", row.names = FALSE)

# ===============================================================
# STEP 6. HOW MANY TIMES DOES STAR GRADE 1 APPEAR IN SHIN & CHUNG?
# ===============================================================
# From Shin & Chung (2009), Table 2: studies whose data = STAR and whose
# grades include 1.
star_rows <- data.frame(
  study  = c("Achilles 1994", "Finn & Achilles 1990", "Finn & Achilles 1999",
             "Finn et al. 1989", "Goldstein et al. 1998", "Johnston et al. 1990",
             "Mosteller 1995", "Nye et al. 1992"),
  grades = c("K-3", "1", "K-3", "1", "K,1", "K-3", "1", "5")
)
star_rows$has_grade1 <- star_rows$grades != "5"
star_rows
sum(star_rows$has_grade1)   # 7 of 17 "studies" include the same Grade 1 children

# ===============================================================
# STEP 7. WHAT DOUBLE COUNTING DOES TO THE POOLED ESTIMATE
# ===============================================================
# Combine the reading and math rows from both papers for Grades K-3 and
# pool them four ways. (The 1990 rows use small vs. regular and the 1999
# rows small vs. others. That's a small inconsistency, accepted here to
# keep the example simple.)

c90 <- read.csv("finn_achilles_1990_coded.csv")
c90 <- c90[c90$outcome %in% c("word_study", "sat_reading", "sat_math"), ]
star <- rbind(
  data.frame(src = "1990", grade = 1, scale = c90$outcome, d = c90$d,
             v = c90$var_d, v_cl = c90$var_d_clust),
  data.frame(src = "1999", grade = coded$grade, scale = coded$scale, d = coded$d,
             v = coded$var_d, v_cl = coded$var_d_clust)[coded$grade <= 3 &
                  coded$scale %in% c("word_study", "sat_reading", "total_reading", "total_math"), ]
)
star$subject <- ifelse(star$scale %in% c("sat_math", "total_math"), "math", "reading")

# (A) Every row independent, naive variances: what a meta-analysis does
#     if it treats each report and each outcome as a separate study.
A <- rma(yi = d, vi = v, data = star, method = "FE")

# (B) Drop the duplicate 1999 Grade 1 rows.
star_B <- star[!(star$src == "1999" & star$grade == 1), ]
B <- rma(yi = d, vi = v, data = star_B, method = "FE")

# (C) Same rows, clustered variances.
C <- rma(yi = d, vi = v_cl, data = star_B, method = "FE")

# (D) Treat the rows as what they are: correlated measures on one cohort.
#     Build a covariance matrix with assumed correlations, then pool with
#     generalized least squares (rma.mv with a known V).
r_same_grade  <- 0.7   # different tests, same pupils, same year
r_cross_grade <- 0.5   # overlapping pupils, different years
k <- nrow(star_B)
R <- outer(seq_len(k), seq_len(k), function(i, j)
  ifelse(i == j, 1, ifelse(star_B$grade[i] == star_B$grade[j], r_same_grade, r_cross_grade)))
V <- R * sqrt(outer(star_B$v_cl, star_B$v_cl))
D <- rma.mv(yi = d, V = V, data = star_B)

pooled <- data.frame(
  approach = c("A: all rows, independent, naive var",
               "B: duplicates dropped",
               "C: + clustered variances",
               "D: + correlation among rows (one cohort)"),
  k        = c(A$k, B$k, C$k, D$k),
  estimate = round(c(A$b, B$b, C$b, D$b), 3),
  se       = round(c(A$se, B$se, C$se, D$se), 4)
)
pooled
# The point estimate barely moves. The SE grows about 5-6 fold: from a
# value that treats ~20 rows as ~20 experiments to one that treats them
# as one experiment measured many times. Shin & Chung's pooled SE of
# .0104 for 120 effect sizes is the kind of number approach (A)
# produces.
