# ===============================================================
# REPLICATION STUDY 3: MOLNAR ET AL. (1999), WISCONSIN SAGE
# ===============================================================
# Molnar, A., Smith, P., Zahorik, J., Palmer, A., Halbach, A., &
#   Ehrle, K. (1999). Evaluating the SAGE program: A pilot program in
#   targeted pupil-teacher reduction in Wisconsin. Educational
#   Evaluation and Policy Analysis, 21(2), 165-177.
#
# Purpose: a quasi-experiment (30 SAGE schools vs. 14-17 comparison
# schools) that reports raw means, pre-post means, a regression, and
# HLM. Each supports a different effect size. The script computes all
# four, picks one, and documents why.
#
# Companion guide: ../class-size-replication-molnar.html
# Output:          molnar_1999_coded.csv
# ===============================================================

library(metafor)

# ===============================================================
# STEP 1. ENTER THE REPORTED STATISTICS (with their source)
# ===============================================================
tests <- c("reading", "language_arts", "math", "total")

## Table 8 (p. 170): first-grade means and SDs, CTBS Terra Nova scale
## scores. Two independent cohorts, each tested fall (pre) and spring (post).
t8 <- data.frame(
  cohort    = rep(c("1996-97", "1997-98"), each = 4),
  test      = rep(tests, 2),
  pre_sage  = c(531.04, 527.29, 490.12, 516.49,   533.35, 530.50, 492.34, 519.06),
  pre_sage_sd = c(36.88, 43.59, 40.21, 35.08,     36.43, 43.78, 42.51, 35.34),
  pre_comp  = c(533.66, 529.15, 489.76, 518.03,   535.06, 528.97, 493.02, 519.51),
  pre_comp_sd = c(38.24, 44.27, 40.56, 35.43,     36.18, 43.39, 38.38, 33.35),
  post_sage = c(582.33, 581.09, 545.56, 569.90,   580.33, 586.02, 538.63, 568.63),
  post_sage_sd = c(37.17, 39.45, 42.64, 33.93,    41.33, 45.33, 40.09, 36.66),
  post_comp = c(578.66, 575.31, 538.27, 564.50,   570.80, 573.98, 525.14, 556.87),
  post_comp_sd = c(39.99, 42.71, 44.50, 35.58,    45.52, 46.84, 42.53, 38.83)
)

## Table 7 (p. 170): number of first graders with valid scores.
t8$n_sage <- c(1575, 1575, 1566, 1552,   1318, 1319, 1334, 1310)
t8$n_comp <- c( 941,  941,  928,  918,    844,  844,  841,  829)

## Table 9 (p. 171): OLS "beta" coefficients for the SAGE dummy. Despite
## the label, these are UNSTANDARDIZED (points on the CTBS scale): the
## constants are 176-378 and the text calls 6.3 a 6.3-point effect.
## Controls: pretest, days absent, lunch eligibility, race dummies.
## Last row of Table 9 = residual SD ("SE").
t8$b_sage    <- c(2.74, 3.85, 3.88, 3.30,   6.98, 7.25, 7.06, 6.33)
t8$resid_sd  <- c(32.84, 33.60, 33.26, 24.54,  35.50, 36.30, 29.88, 24.34)

## Table 12 (p. 172): HLM, Model A, Level-2 slope on classroom
## pupil-teacher ratio (points per additional pupil per teacher).
t8$hlm_ptr   <- c(-0.54, -0.72, -1.17, -0.88,   -0.29, -0.90, -1.12, -0.83)

## Table 6 (p. 169): average pupils per teacher, first grade.
ptr <- data.frame(cohort = c("1996-97", "1997-98"),
                  sage = c(14.63, 13.47), comp = c(24.53, 22.42))

## Table 5 (p. 168), first grade 1997-98: classroom types.
rooms_9798 <- c(regular_15 = 84, shared_space_15 = 8, two_teacher_30 = 23,
                floating_30 = 2, split_day = 0, three_teacher_45 = 1)

# ===============================================================
# STEP 2. REPRODUCE THE AUTHORS' OWN NUMBERS
# ===============================================================
# Text, p. 170: "The overall effects of 3.3 points in 1996-97 and 6.3
# points in 1997-98 translate to approximately 0.1 and 0.2 standard
# deviation score gains." Those are the Table 9 Total coefficients.
# Which SD did they divide by? Try the candidates:
tot <- t8[t8$test == "total", ]
sd_pool <- function(s1, s2, n1, n2) sqrt(((n1 - 1) * s1^2 + (n2 - 1) * s2^2) / (n1 + n2 - 2))
tot$sp_post <- with(tot, sd_pool(post_sage_sd, post_comp_sd, n_sage, n_comp))
data.frame(cohort = tot$cohort, b = tot$b_sage,
           over_post_sd  = round(tot$b_sage / tot$sp_post, 3),
           over_resid_sd = round(tot$b_sage / tot$resid_sd, 3))
# Dividing by the posttest SD gives 0.10 and 0.17, which match "approximately
# 0.1 and 0.2". Dividing by the residual SD would give 0.13 and 0.26.

# ===============================================================
# STEP 3. FOUR EFFECT SIZES FROM THE SAME STUDY
# ===============================================================
t8$sp_post <- with(t8, sd_pool(post_sage_sd, post_comp_sd, n_sage, n_comp))
t8$sp_pre  <- with(t8, sd_pool(pre_sage_sd,  pre_comp_sd,  n_sage, n_comp))

# (1) Posttest only: raw spring difference / pooled posttest SD.
#     This is what Shin & Chung's stated formula produces.
t8$d_post <- with(t8, (post_sage - post_comp) / sp_post)

# (2) Gain scores: difference in pre-to-post change / pooled posttest SD.
t8$d_gain <- with(t8, ((post_sage - pre_sage) - (post_comp - pre_comp)) / sp_post)

# (3) Regression-adjusted: SAGE coefficient / pooled (unadjusted) posttest
#     SD. This is the What Works Clearinghouse rule for studies with
#     covariates.
t8$d_adj <- with(t8, b_sage / sp_post)

# (4) HLM dose-response: slope per pupil x the actual reduction in
#     pupils per teacher, / pooled posttest SD, sign flipped so that
#     positive favors smaller classes (template 4 in
#     effect_size_calculation_templates.R).
t8$delta <- ifelse(t8$cohort == "1996-97", ptr$comp[1] - ptr$sage[1], ptr$comp[2] - ptr$sage[2])
t8$d_hlm <- with(t8, -1 * hlm_ptr * delta / sp_post)

routes <- t8[, c("cohort", "test", "d_post", "d_gain", "d_adj", "d_hlm")]
routes[, 3:6] <- round(routes[, 3:6], 3)
routes
# 1997-98 total: 0.31 (posttest), 0.33 (gain), 0.17 (adjusted), 0.20 (HLM).
# The choice of route roughly doubles or halves the effect.

# ===============================================================
# STEP 4. WHY DO THE RAW AND ADJUSTED ESTIMATES DIFFER?
# ===============================================================
# The fall means are almost identical (519.06 vs. 519.51), so the
# pretest adjustment can't be what halves the effect. Candidates:
#  (a) Different students. Table 2: 39% of SAGE and 37% of comparison
#      pupils in 1997-98 ENROLLED during the year. The Table 8 fall and
#      spring columns are not the same children. The regression uses
#      only pupils with a pretest, a posttest, and complete covariates.
#  (b) Covariates. In 1997-98, fewer SAGE pupils were eligible for free lunch
#      (43.8% vs. 52.2%, Table 1), so adjusting for SES lowers
#      the SAGE advantage.
# The paper gives no way to separate (a) from (b). Record both.

# ===============================================================
# STEP 5. VARIANCE OF THE ADJUSTED EFFECT
# ===============================================================
# Covariates make the estimate more precise. Approximate the SE of the
# SAGE coefficient from the residual SD, then put it on the d scale:
#   SE(b) ~ resid_sd * sqrt(1/nS + 1/nC);   v(d) = (SE(b) / sp_post)^2
t8$v_adj   <- with(t8, (resid_sd * sqrt(1 / n_sage + 1 / n_comp) / sp_post)^2)
t8$v_naive <- with(t8, (n_sage + n_comp) / (n_sage * n_comp) + d_adj^2 / (2 * (n_sage + n_comp)))
data.frame(t8[, c("cohort", "test")], v_naive = round(t8$v_naive, 5), v_adj = round(t8$v_adj, 5))
# For Total, the adjusted variance is about 40% of the naive one.

# ===============================================================
# STEP 6. CLUSTERING: TREATMENT WAS ASSIGNED TO SCHOOLS
# ===============================================================
# SAGE status is a property of the SCHOOL: 30 SAGE schools vs. 17
# (1996-97) or 14 (1997-98) comparison schools. The relevant ICC is
# between schools, which the paper doesn't report. With a pretest
# covariate, school-level ICCs for early-grade achievement are often
# around .05-.10 (Hedges & Hedberg, 2007). Use .10 and vary it.
schools <- c("1996-97" = 30 + 17, "1997-98" = 30 + 14)
t8$m_bar <- (t8$n_sage + t8$n_comp) / schools[t8$cohort]      # pupils per school
icc_school <- 0.10
t8$deff <- 1 + (t8$m_bar - 1) * icc_school
data.frame(cohort = t8$cohort, m_bar = round(t8$m_bar, 1), deff = round(t8$deff, 2))[t8$test == "total", ]

sapply(c(0.05, 0.10, 0.20), function(icc)        # sensitivity for 1997-98 total
  round(sqrt(t8$v_adj[8] * (1 + (t8$m_bar[8] - 1) * icc)), 3))
# SE of 0.053 to 0.093 depending on the ICC; with no design effect it is 0.029.

t8$v_adj_clust <- t8$v_adj * t8$deff

# ===============================================================
# STEP 7. IS THIS EVEN A CLASS SIZE STUDY?
# ===============================================================
# SAGE reduced the pupil-teacher RATIO within classrooms. In 1997-98,
# 26 of 118 first-grade SAGE rooms were 30:2, 45:3, or floating-teacher
# rooms: normal-sized classes with extra teachers.
round(sum(rooms_9798[c("two_teacher_30", "floating_30", "three_teacher_45")]) /
        sum(rooms_9798), 2)
# 0.22. And SAGE bundled three other interventions (lighted schoolhouse,
# rigorous curriculum, staff development). HLM Model B (Table 12): once
# PTR is controlled, the SAGE dummy is not significant, which suggests
# the ratio carries the effect. Code measure = "PTR (within classroom)"
# and test it as a moderator or sensitivity exclusion.

# ===============================================================
# STEP 8. ASSEMBLE THE CODED ROWS
# ===============================================================
coded <- data.frame(
  study_id    = "molnar_1999",
  dataset     = "SAGE",
  cohort      = t8$cohort,
  design      = "quasi-experiment, comparison schools",
  assign_unit = "school",
  measure     = "PTR (within classroom)",
  size_S      = ifelse(t8$cohort == "1996-97", ptr$sage[1], ptr$sage[2]),
  size_L      = ifelse(t8$cohort == "1996-97", ptr$comp[1], ptr$comp[2]),
  delta       = round(t8$delta, 2),
  subject     = c("reading", "language", "math", "total")[match(t8$test, tests)],
  outcome     = t8$test,
  test_type   = "standardized (CTBS Terra Nova)",
  grade       = 1,
  timing      = "end of first year of treatment",
  published   = 1,
  control     = "comparison schools",
  sd_type     = "pooled unadjusted posttest SD",
  es_method   = "regression-adjusted difference (WWC)",
  direction   = 1,
  primary     = t8$test %in% c("reading", "math"),
  ceiling     = t8$cohort == "1996-97",
  d           = round(t8$d_adj, 4),
  var_d       = round(t8$v_adj, 6),
  var_d_clust = round(t8$v_adj_clust, 6),
  d_post      = round(t8$d_post, 4),
  d_gain      = round(t8$d_gain, 4),
  d_hlm       = round(t8$d_hlm, 4),
  n_S         = t8$n_sage,
  n_L         = t8$n_comp,
  notes       = "var from residual SD; DEFF assumes school ICC = .10; 26/118 SAGE rooms were 30:2 or 45:3 (1997-98)"
)
coded$se_clust <- round(sqrt(coded$var_d_clust), 4)
coded[, c("cohort", "outcome", "d", "se_clust", "d_post", "primary", "ceiling")]

write.csv(coded, "molnar_1999_coded.csv", row.names = FALSE)

# ===============================================================
# STEP 9. WHAT SHIN & CHUNG RECORDED
# ===============================================================
# Table 2 of Shin & Chung: "Monlar, et al., 1995, EEPA, random = 0, WI,
# R, M, published = 1, grade 1, 2."
#  - The year is 1999 (their own reference list says 1999).
#  - The paper reports Grade 1 only. Grade 2 was tested but not reported.
#  - Their formula (group means, pooled SD) implies the posttest route:
#    1997-98 reading 0.22 and math 0.33, vs. 0.16 and 0.17 adjusted.
#  - They say they used class size, not pupil-teacher ratio. SAGE is a
#    pupil-teacher ratio program.
