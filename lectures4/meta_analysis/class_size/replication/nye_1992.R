# ===============================================================
# REPLICATION STUDY 5: NYE ET AL. (1992), LASTING BENEFITS STUDY
# ===============================================================
# Nye, B. A., Zaharias, J. B., Fulton, B. D., Wallenhorst, M. P.,
#   Achilles, C. M., & Hooper, R. (1992). The Lasting Benefits Study:
#   A continuing analysis of the effect of small class size in
#   kindergarten through third grade on student achievement test
#   scores in subsequent grade levels. Fifth grade technical report.
#   Nashville: Center of Excellence for Research in Basic Skills,
#   Tennessee State University. (ERIC ED 354 992)
#
# Purpose: a follow-up of STAR pupils two years after they returned to
# regular classes. The report prints means and effect sizes but no SDs.
# This is the one study in Shin & Chung's sample for which their
# subgroup estimate (grade 5) can be reproduced exactly.
#
# Page numbers are the report's own (printed at the foot of each page).
# Companion guide: class-size-replication-nye.html (this folder)
# Output:          nye_1992_coded.csv
# ===============================================================

library(metafor)

# ===============================================================
# STEP 1. ENTER THE REPORTED STATISTICS (with their source)
# ===============================================================
measures <- c("total_reading", "total_language", "total_math", "science",
              "social_science", "study_skills", "crt_language_arts", "crt_math")

## Appendix B (p. 27): grade 5 means for all pupils, by grade-3 STAR
## class type. NRT = CTBS/4 scaled scores; CRT = number of domains
## mastered (out of 7 language arts, 9 math). The aide Total Reading
## mean is smudged ("712.j2"); the text (p. 23) gives 712.52.
m <- data.frame(
  measure = measures,
  small   = c(722.95, 726.34, 731.69, 729.80, 742.83, 722.80, 4.5635, 3.6842),
  regular = c(712.42, 718.13, 723.61, 720.81, 734.69, 712.18, 3.7162, 3.0014),
  aide    = c(712.52, 717.10, 723.27, 718.15, 733.38, 711.33, 3.7912, 3.1600)
)

## Table 8 (p. 22), repeated as Table 3 (p. 6): effect sizes, small vs.
## regular, "divided by the standard deviation of the regular class"
## (p. 20). The aide column is aide minus regular, despite its
## "Regular vs. Reg/Aide" label.
es_small <- c(.22, .18, .18, .17, .17, .18, .34, .28)
es_aide  <- c(.002, -.02, -.008, -.05, -.03, -.01, .03, .07)

## Table 1 (p. 4): pupils by grade-3 class type and race.
n <- c(small = 1578, regular = 1467, aide = 1604)
minority_share <- c(small = 497 / 1578, regular = 556 / 1467, aide = 557 / 1604)

## Table 6 (p. 19): NRT means by race (white, minority) and class type.
race <- data.frame(
  measure = rep(measures[1:6], each = 2),
  group   = rep(c("white", "minority"), 6),
  small   = c(730.55, 706.34, 731.57, 714.91, 735.00, 724.45,
              740.39, 706.62, 749.15, 728.97, 728.65, 710.00),
  regular = c(722.06, 696.63, 725.72, 705.66, 729.23, 714.41,
              733.08, 700.65, 742.28, 722.26, 721.03, 697.65),
  aide    = c(720.31, 697.91, 723.52, 705.03, 726.35, 717.49,
              728.65, 698.41, 739.77, 721.37, 717.47, 699.75)
)

# ===============================================================
# STEP 2. REPRODUCE THE AUTHORS' DIFFERENCES (Table 7, p. 21)
# ===============================================================
m$diff_small <- m$small - m$regular
m$diff_aide  <- m$aide - m$regular
m[, c("measure", "diff_small", "diff_aide")]
# All sixteen differences match Table 7 to the second decimal.

# ===============================================================
# STEP 3. THE MISSING SDs: BACK THEM OUT
# ===============================================================
# SD = difference / effect size. The effect sizes are rounded to two
# decimals, so each SD comes with a range.
m$sd_mid <- m$diff_small / es_small
m$sd_lo  <- m$diff_small / (es_small + .005)
m$sd_hi  <- m$diff_small / (es_small - .005)
data.frame(measure = m$measure, round(m[, c("sd_lo", "sd_mid", "sd_hi")], 1))
# NRT scales: about 45-59 points; CRT domain counts: about 2.4-2.5.

# Check with the aide column, which uses the same SD:
data.frame(measure = measures, implied = round(m$diff_aide / m$sd_mid, 3), printed = es_aide)
# Agrees to rounding wherever the aide effect is large enough to check.

# ===============================================================
# STEP 4. CHECK THE TABLES AGAINST EACH OTHER
# ===============================================================
# The "All" mean should be the race-weighted average of the white and
# minority means. Table 6 vs. Appendix B for Total Math, minority row:
#   Table 6:    724.45, 714.41, 717.49
#   Appendix B: 706.62, 700.65, 698.41   (identical to the Science row)
w_small <- 1 - minority_share["small"]
c(table6 = unname(w_small * 735.00 + (1 - w_small) * 724.45),
  appendixB = unname(w_small * 735.00 + (1 - w_small) * 706.62),
  printed_all = 731.69)
# Only Table 6 reproduces the overall mean. Appendix B repeated the
# Science minority row under Total Math. Use Table 6.

# ===============================================================
# STEP 5. DECISION: ADJUST FOR RACIAL COMPOSITION?
# ===============================================================
# The groups are not balanced: 31.5% of former small-class pupils are
# minority vs. 37.9% of regular-class pupils (Table 1). Minority pupils
# score 20-30 points lower on every scale, so part of the raw gap is
# composition. Direct standardization: compare within race, then weight
# both groups by the same race shares (all pupils: 1,610 / 4,649).
p_min <- 1610 / 4649
rs <- do.call(rbind, lapply(split(race, race$measure), function(s) {
  dw <- s$small[s$group == "white"]    - s$regular[s$group == "white"]
  dm <- s$small[s$group == "minority"] - s$regular[s$group == "minority"]
  data.frame(measure = s$measure[1], diff_white = dw, diff_minority = dm,
             diff_std = (1 - p_min) * dw + p_min * dm)
}))
rs <- rs[match(measures[1:6], rs$measure), ]
rs$diff_raw <- m$diff_small[1:6]
rs$d_raw <- es_small[1:6]
rs$d_std <- rs$diff_std / m$sd_mid[1:6]
data.frame(measure = rs$measure, round(rs[, -1], 2), row.names = NULL)
# Standardizing for race lowers the effects from 0.17-0.22 to
# 0.13-0.19: a sixth to a quarter of each raw gap is composition.

# ===============================================================
# STEP 6. REPRODUCE SHIN & CHUNG'S GRADE 5 ROW
# ===============================================================
# Shin & Chung's Table 2 lists Nye et al. (1992) as their only grade 5
# study, so their Table 7 grade 5 row must come from this report:
#   k = 7, Q = 7.3, d = .20, SE = .0137
# Variance of each effect with the reported n (1,578 small, 1,467 regular):
v <- 1 / n[["small"]] + 1 / n[["regular"]] + es_small^2 / (2 * (n[["small"]] + n[["regular"]]))

fe <- function(keep) {
  f <- rma(yi = es_small[keep], vi = v[keep], method = "FE")
  data.frame(dropped = paste(setdiff(measures, measures[keep]), collapse = ", "),
             k = f$k, d = round(f$b[1], 3), se = round(f$se, 4), Q = round(f$QE, 1))
}
do.call(rbind, lapply(seq_along(measures), function(j) fe(setdiff(seq_along(measures), j))))
# Dropping the language arts CRT (0.34) gives k = 7, d = 0.197, SE = 0.0137,
# Q = 7.3: an exact match. Every other choice of seven gives Q of 17 to 21.
# The SE matches only if the seven effects are treated as independent,
# with no allowance for their being the same 3,045 pupils.

# ===============================================================
# STEP 7. ASSEMBLE THE CODED ROWS
# ===============================================================
deff <- 2.93   # from finn_achilles_1990.R; an upper bound here (see guide)
coded <- data.frame(
  study_id    = "nye_1992",
  dataset     = "STAR (Lasting Benefits Study)",
  cohort      = "1985 K entry and later STAR entrants",
  design      = "RCT follow-up",
  assign_unit = "students & teachers within schools (K-3)",
  measure     = "class size",
  size_S      = 15,
  size_L      = 24,
  grade       = 5,
  timing      = "2 years after treatment ended",
  exposure    = "small class in grade 3; 1-4 years",
  outcome     = measures,
  subject     = c("reading", "language", "math", "science", "social science",
                  "study skills", "language", "math"),
  test_type   = c(rep("standardized (CTBS/4)", 6), rep("curriculum-based (domains mastered)", 2)),
  control     = "regular (no aide)",
  sd_type     = "regular-class SD (per report; F&A 1999 say pooled)",
  published   = 0,
  d           = es_small,
  d_race_std  = c(round(rs$d_std, 3), NA, NA),
  var_d       = round(v, 6),
  var_d_clust = round(v * deff, 6),
  n_S         = n[["small"]],
  n_L         = n[["regular"]],
  primary     = measures %in% c("total_reading", "total_math"),
  in_shin_chung = measures != "crt_language_arts",
  notes       = "SDs not reported; F&A 1999 Table 2 grade 5 repeats these values"
)
coded[, c("outcome", "d", "d_race_std", "var_d", "primary", "in_shin_chung")]
write.csv(coded, "nye_1992_coded.csv", row.names = FALSE)
