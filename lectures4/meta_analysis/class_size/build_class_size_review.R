# Builds Class_Size_Evidence_Review.docx by combining
#   Class_Size_Policy_Overview.docx          -> executive summary
#   overview_of_evidence_for_class_size.docx -> how later studies resolved the question
# Styles come from Class_Size_Policy_Overview.docx. Run from this folder.

library(officer)

doc <- read_docx("Class_Size_Policy_Overview.docx")
n <- nrow(docx_summary(doc))
for (i in seq_len(n)) { doc <- cursor_begin(doc); doc <- body_remove(doc) }

b <- fp_text_lite(bold = TRUE)
i_ <- fp_text_lite(italic = TRUE)

H1 <- function(x) doc <<- body_add_par(doc, x, style = "heading 1")
H2 <- function(x) doc <<- body_add_par(doc, x, style = "heading 2")
H3 <- function(x) doc <<- body_add_par(doc, x, style = "heading 3")
P  <- function(x) doc <<- body_add_par(doc, x, style = "Normal")
# paragraph with a bold lead-in
PB <- function(lead, x, style = "Normal")
  doc <<- body_add_fpar(doc, fpar(ftext(lead, b), ftext(x)), style = style)
BL <- function(x) doc <<- body_add_par(doc, x, style = "List Bullet")
BB <- function(lead, x) PB(lead, x, style = "List Bullet")
NL <- function(x) doc <<- body_add_par(doc, x, style = "List Number")
TB <- function(df) {
  doc <<- body_add_table(doc, df, style = "Light List Accent 1",
                         first_row = TRUE, first_column = FALSE)
  P("")
}

# ------------------------------------------------------------------
doc <- body_add_par(doc, "Does Class Size Matter?", style = "Title")
doc <- body_add_par(doc, "Evidence, Debate, and How Later Studies Resolved the Question", style = "Subtitle")
doc <- body_add_fpar(doc, fpar(ftext("Key references: ", b),
  ftext("Glass & Smith (1979) · Finn & Achilles (1990, 1999) · Hanushek and Krueger in Mishel & Rothstein (2002) · Shin & Chung (2009)")),
  style = "Normal")

# ==================================================================
H1("Executive Summary")

P(paste("Few questions in education policy have produced as much research, or as much disagreement, as whether",
  "reducing class size improves student learning. Class size reduction (CSR) is intuitively appealing: smaller",
  "classes promise more individual attention, easier classroom management, and better learning. It is also",
  "one of the most expensive reforms available. Shin and Chung (2009) cite estimates that a nationwide U.S.",
  "program would cost roughly $2 billion to over $11 billion a year in operating costs alone."))

P(paste("For most of the twentieth century the evidence looked contradictory. Large correlational studies such as",
  "the Coleman Report (1966) found little relationship between school resources and achievement. Glass and",
  "Smith (1979) published the first meta-analysis of class size and found a consistent, strongly nonlinear",
  "benefit of smaller classes. Hanushek (2002) argued that the econometric estimates were inconsistent and",
  "the effects too small to justify the cost. Shin and Chung (2009) reaffirmed a modest positive effect of",
  "about 0.20 standard deviations (SD)."))

H2("Bottom line")
BB("Smaller classes raise achievement, modestly. ",
   "Cutting early-grade classes from about 22 to about 15 pupils, as in Tennessee's Project STAR, raises reading and math scores by roughly 0.20 SD.")
BB("The effect is concentrated. ",
   "It is largest in kindergarten through grade 3, and about twice as large for minority and disadvantaged students. Evidence for secondary grades is thin and centers near zero.")
BB("The relationship is nonlinear. ",
   "Cuts at the low end of the range (20 to 10) matter far more than cuts at the high end (40 to 30).")
BB("The evidence rests heavily on one experiment. ",
   "STAR supplies 78 of the 120 effect sizes in Shin and Chung (2009). Counting each state once lowers the pooled estimate from 0.20 to 0.08.")
BB("Implementation decides whether CSR pays off. ",
   "Hiring many teachers at once can lower teacher quality and offset the benefit, as California found in 1996–97.")

H2("Why the debate persisted")
P(paste("The disagreement was never mainly about a lack of evidence. It came from how the evidence was read:",
  "which studies counted, how their results were put on a common scale, and what counted as one independent",
  "piece of evidence. Vote counting, meta-analysis weighted by study, and meta-analysis weighted by effect",
  "size can reach different conclusions from the same literature. The same is true of choices about which",
  "confounders a synthesis records."))

H2("What a meta-analyst must code")
BB("Outcome: ", "standardized reading and math scores dominate. Record subject and type of test.")
BB("Treatment: ", "actual class size, not the pupil–teacher ratio (PTR). Record the sizes compared (S and L), not just a \"small vs. regular\" label.")
BB("Design: ", "random assignment, matching, or intact classes, and whether a pretest or covariates were used.")
BB("Timing: ", "same-year, next-year, or long-run outcomes, and years of exposure.")
BB("Moderators: ", "grade, student subgroup (race, SES), and place.")
BB("Dependence: ", "which data set each effect size comes from, so repeated reports of the same children (above all STAR) are not counted as independent studies.")

# ==================================================================
H1("How Later Studies Resolved the Question")

# ------------------------------------------------------------------
H2("1. A literature that looked like noise")
P(paste("Empirical work on class size goes back at least to Rice (1902). By the late 1970s, Glass and Smith wrote,",
  "review after review had \"dissolved into cynical despair or epistemological confusion,\" and most",
  "instructional researchers treated class size as a dead issue. Four problems made the literature hard to read:"))
BB("Vote counting. ", "Reviewers tallied studies for and against, ignoring the size of each effect, its precision, and study quality. Searches were selective and often skipped dissertations and unpublished reports.")
BB("No common metric. ", "Studies used different tests, subjects, and grades, so there was nothing to average.")
BB("Different treatments. ", "\"Smaller vs. larger\" covered everything from one-to-one tutoring vs. a class of 40 to 22 vs. 28 pupils in one district.")
BB("Confounding in both directions. ", "Class size is chosen by districts, principals, and parents, and the forces behind those choices also affect achievement.")

H3("Confounders that make large classes look better")
BL("Higher-SES schools and districts tend to be larger, with more pupils per class, and their students score higher for reasons unrelated to class size.")
BL("Experienced teachers may be assigned to, or choose, the larger sections.")
BL("Schools put weaker or more disruptive pupils in smaller classes, and struggling schools receive extra staff. Low class size and low performance become correlated through reverse causation.")
H3("Features that make small classes look better")
BL("Tutoring studies (1 pupil vs. 25) capture a change in how teaching is done, not just head count.")
BL("Short experiments may pick up novelty or Hawthorne effects.")
BL("Without a pretest, any pre-existing difference between groups is attributed to class size.")

H3("The aggregate-trend argument")
P(paste("Hanushek (2002) adds a historical test. U.S. pupil–teacher ratios fell by about a third between 1960",
  "and 1995, yet SAT and NAEP trends show no matching gain. Krueger (2002) replies that aggregate trends mix",
  "many changes at once, including who takes the SAT, demographic shifts, and curriculum. Within NAEP, scores",
  "and pupil–teacher ratios are negatively related, with a slope close to STAR's. The same historical",
  "data support opposite conclusions depending on the assumptions brought to them."))

# ------------------------------------------------------------------
H2("2. Glass and Smith (1979): a common metric and a curve")
P(paste("Glass and Smith read about 300 documents and kept 77 studies yielding 725 effect sizes, from nearly",
  "900,000 pupils over 70 years in more than a dozen countries. They made three moves that are now standard:"))
BB("A standardized effect size: ", "the small-class mean minus the large-class mean, divided by the within-class SD.")
BB("A regression on the contrast: ", "effect sizes regressed on the actual class sizes compared (S, S², and L − S), instead of crude categories.")
BB("Coded moderators: ", "year, grade, subject, pupil IQ, duration, type of test, and how pupils were assigned.")
P(paste("The raw average was unimpressive: a mean effect of 0.09 SD, with only 60% of comparisons favoring the",
  "smaller class. The regression showed why. The predicted effect of 1 vs. 40 pupils was 0.57 SD, but 20 vs.",
  "40 was only 0.05 SD. Randomized studies produced a much steeper curve than uncontrolled ones (multiple R",
  "of .62 vs. .19). The relationship was absent in studies before 1940 and strong after 1960. It was",
  "somewhat stronger for secondary pupils (age 12 and over) than for elementary pupils. Glass and Smith",
  "reported no standard errors, on purpose: many comparisons came from the same study, and there was \"no",
  "sensible way to reduce each study to one observation.\""))

# ------------------------------------------------------------------
H2("3. Hanushek vs. Krueger: what counts as one piece of evidence")
P(paste("Hanushek's (1997) tabulation of 277 estimates from 59 production-function studies counted each",
  "regression estimate as a vote. Positive and negative significant results were about equally common",
  "(14.8% and 13.4%), so he concluded there was no consistent relationship. Krueger pointed out that nine",
  "studies supplied 44% of the estimates, some by splitting one data set by grade, race, and subject. Giving",
  "each study one vote raised the share of positive significant results to 25.5%, and the positive-to-negative",
  "ratio from 1.07 to 1.57. Hanushek replied that each estimate is a distinct empirical exercise and that",
  "weighting by study leans on low-quality aggregate work. The dispute is unresolved, but it shows that the",
  "unit of analysis is a modeling choice with real consequences."))

# ------------------------------------------------------------------
H2("4. Project STAR: the experiment that changed the debate")
P(paste("Beginning in 1985, Tennessee randomly assigned kindergartners and teachers within 79 schools to small",
  "classes (13–17), regular classes (22–25), or regular classes with a full-time aide, and kept them",
  "there through grade 3. First graders in small classes scored about 0.2–0.3 SD higher in reading and",
  "math (Finn & Achilles, 1990). Effects for minority students were roughly double those for white students",
  "(Finn & Achilles, 1999). Aides made little difference."))
P(paste("STAR was not flawless. There was no baseline pretest, and attrition was substantial: only about half the",
  "kindergarten cohort stayed all four years, and those who left scored lower. Schools volunteered, and",
  "pupils moved between class types after kindergarten. Goldstein and Blatchford (1998) also found that the",
  "reading effect varied across schools with an SD of 0.25, about as large as the effect itself. STAR is the",
  "best single piece of evidence, but it is one draw."))

# ------------------------------------------------------------------
H2("5. Shin and Chung (2009): a random-effects meta-analysis")
P(paste("Shin and Chung searched five databases for U.S. K–12 studies from 1989 to 2008 that compared small and",
  "regular or large classes on standardized tests. Of 129 studies found, 17 yielding 120 effect sizes met",
  "their criteria. The effects were strongly heterogeneous (Q = 719.4, df = 119), so they used a random-effects",
  "model. The overall effect was d = 0.20 (95% CI 0.18 to 0.22)."))
TB(data.frame(
  Moderator = c("Design", "Publication", "School level", "Grade", "Subject", "Unit of analysis"),
  Finding = c("Random assignment 0.20 (k = 90); not random 0.11 (k = 21)",
              "Published 0.21 (k = 76); unpublished 0.13 (k = 44)",
              "Elementary 0.20 (k = 114); secondary −0.05 (k = 6, one 10th-grade study)",
              "K 0.17, grade 1 0.24, grade 2 0.20, grade 3 0.16, grade 4 0.13, grade 5 0.20; slope −0.01 per grade",
              "Reading 0.19, math 0.20; other subjects too few effect sizes to judge",
              "Each effect size 0.20; each study 0.17; each state 0.08")))

# ------------------------------------------------------------------
H2("6. The two meta-analyses side by side")
TB(data.frame(
  Moderator = c("Evidence base", "Overall effect", "Nonlinearity", "Study quality",
                "Elementary vs. secondary", "Publication status", "Subject", "Pupil ability / SES"),
  `Glass and Smith (1979)` = c(
    "77 studies, 725 effect sizes, 1900s–1970s, many countries",
    "Mean 0.09; 0.57 for 1 vs. 40; 0.05 for 20 vs. 40",
    "Strong: benefits concentrated below about 20 pupils",
    "Randomized studies show a much steeper curve",
    "Somewhat stronger in secondary grades",
    "No difference by source",
    "No appreciable difference",
    "No moderation by IQ; SES not coded"),
  `Shin and Chung (2009)` = c(
    "17 U.S. studies, 120 effect sizes, 1989–2008",
    "d = 0.20 (random effects)",
    "Not modeled: small vs. regular or large",
    "Random 0.20 vs. non-random 0.11",
    "Elementary 0.20 vs. secondary −0.05",
    "Published 0.21 vs. unpublished 0.13",
    "Reading 0.19, math 0.20",
    "Not coded; cites STAR's larger minority effects"),
  check.names = FALSE))
P(paste("The elementary vs. secondary row is the most instructive. Glass and Smith's \"secondary\" group was",
  "everyone aged 12 and over, including college lectures. Shin and Chung's secondary estimate comes from one",
  "study. Neither can separate grade level from the kind of study done at that grade. A moderator in a",
  "meta-analysis is an observational variable across studies, and it can be confounded just like a regressor",
  "in a primary study."))

# ------------------------------------------------------------------
H2("7. The consensus that emerged, and its limits")
H3("What is broadly accepted")
BL("Smaller classes do raise achievement, with effects concentrated in K–3 and larger for disadvantaged and minority students.")
BL("The effect is nonlinear: cuts from 25 to 15 pupils buy more per pupil removed than cuts from 35 to 25. Groups under about 10 blend into the tutoring literature.")
BL("Well-controlled studies cluster around 0.15–0.25 SD in the elementary grades: meaningful, but not transformative.")
BL("Evidence for secondary grades is thin. Shin and Chung's d = −0.05 rests on six effect sizes from one study.")
H3("Is 0.2 SD worth the money?")
P(paste("Krueger (2002) argues that the right question is not whether the effect is zero but how large it must be",
  "to justify the cost. Under his assumptions (a 1 SD gain raises later earnings by 8%, a 4% discount rate, 1%",
  "productivity growth), cutting K–3 classes from 22 to 15 breaks even at about 0.10 SD, and STAR's",
  "estimates exceed that. Hanushek calls the chain of assumptions \"heroic\" and argues that the right",
  "comparison is CSR versus other uses of the money, especially teacher quality."))
H3("What remains disputed")
BB("How much rests on STAR. ", "The pooled estimate falls from 0.20 to 0.08 when Tennessee counts once.")
BB("Teacher quality. ", "Hiring many teachers at once draws from the weaker end of the pool.")
BB("Whether a pilot scales. ", "STAR's schools volunteered and had rooms and teachers to spare. California's statewide cap (1996–97) led districts to hire many uncredentialed teachers, and experienced teachers left high-poverty schools for new suburban openings. Jepsen and Rivkin (2009) find that smaller classes raised achievement there, but the influx of inexperienced teachers dampened the gains, most in schools serving disadvantaged pupils.")
H3("Policy implications")
BL("CSR is most defensible in K–3, and most of all for disadvantaged and minority students.")
BL("Blanket CSR across all grades is hard to justify given how little evidence supports effects in secondary school.")
BL("CSR pays off only if the new teachers are good. That constraint binds hardest in the lowest-SES districts.")

# ------------------------------------------------------------------
H2("8. What remains unresolved: lessons from replicating the meta-analysis")
P(paste("Coding primary studies from Shin and Chung's list for this course's replication case studies exposes",
  "problems the pooled estimate hides:"))
BB("The two meta-analyses disagree on the policy-relevant cut. ",
   "Glass and Smith's own regression, evaluated at STAR's 15 vs. 22 pupils, predicts about 0.13 SD overall and 0.08 SD for elementary grades. Shin and Chung report 0.20 for elementary grades. Their state-level estimate, 0.08, is the one that matches.")
BB("One experiment counted many times. ",
   "Seven of Shin and Chung's 17 studies include the same STAR first graders. Treating repeated reports of one cohort as independent studies shrinks the standard error several-fold without changing the mean much.")
BB("Same data, different analysts, different numbers. ",
   "For the same first graders, Goldstein and Blatchford's (1998) race-specific effects differ from Finn and Achilles' (1990) by up to 0.09 SD.")
BB("The route to an effect size matters. ",
   "For Wisconsin's SAGE program (Molnar et al., 1999), the raw posttest difference gives 0.31 SD, but the regression-adjusted difference gives 0.17. SAGE also lowered the pupil–teacher ratio rather than always shrinking the class.")
BB("Neither meta-analysis codes who is in the classes. ",
   "SES and race are the strongest known moderators, yet neither synthesis records them.")

# ==================================================================
H1("Appendix A. A Coding Framework for Class Size Studies")
TB(data.frame(
  Dimension = c("Outcomes", "Intervention", "Magnitude", "Timing", "Controls", "Context", "Dependence"),
  `What the literature shows` = c(
    "Standardized reading and math scores dominate; some studies use writing, science, ACT/SAT, retention, graduation, or earnings. Glass and Smith also included ad hoc tests.",
    "Class size (pupils per class) differs from PTR, which aides and specialists can lower without shrinking the class. Some studies use a binary contrast, others a continuous count.",
    "STAR's cut from about 22 to 15 in K–3 yields about 0.20 SD. Cuts at the high end (e.g., 30 to 25) show little effect.",
    "Most outcomes are end-of-year or next-year. STAR gains appear mainly in the first year of small-class exposure and then persist.",
    "Pretests, SES, teacher experience and credentials, school resources, and demographics. Omitted confounders can bias estimates in either direction.",
    "Larger effects in early grades and for minority and disadvantaged students.",
    "Many effect sizes per study, and many studies of the same data set (STAR)."),
  `What to code` = c(
    "Subject and type of test.",
    "Operational definition and scale; the actual sizes compared (S, L) or the range of the continuous measure.",
    "Size of the reduction, as a moderator.",
    "Same-year, next-year, or long-run; years of exposure.",
    "Whether each is controlled; design (random, matched, uncontrolled); pretest or gain scores.",
    "Grade, subgroup, and place.",
    "Study ID, data set, and cohort, so dependent rows can be grouped or dropped."),
  check.names = FALSE))

# ==================================================================
H1("Appendix B. The Modeling Exercise")
P(paste("The course's synthetic panel data set reproduces the structural features of the class size literature in",
  "a setting where the true data-generating process is known, so students can see how modeling choices",
  "recover or distort the true effects."))
H2("How the confounding is built in")
BL("free_lunch (an SES proxy) is negatively correlated with mother_edu and pretest scores, and positively correlated with class_size in some schools, mirroring the school-level SES gradient.")
BL("teacher_exp is positively correlated with graduate degree attainment, so dropping either biases the other's coefficient.")
BL("class_size depends partly on school size_factor, which is correlated with school SES, so OLS without fixed effects is endogenous.")
BL("Pretest scores absorb much of the SES signal, so models with a pretest show weaker free_lunch and mother_edu coefficients.")
H2("The reversal problem")
P(paste("Regressing test_score on class_size alone gives a positive coefficient: larger classes appear better.",
  "Lower-SES schools have smaller sections and lower scores for reasons unrelated to class size, and that SES",
  "gradient dominates the bivariate relationship."))
TB(data.frame(
  Model = c("m1: test_score ~ class_size", "m2: + free_lunch + mother_edu",
            "m3: + teacher_exp + student_aide + teacher_edu", "m5: full OLS with pretest + year FE",
            "m7: feols with teacher_id + year FE"),
  `What it shows` = c("Biased positive coefficient: the reversal problem.",
                      "SES controls push the sign toward negative: omitted variable bias.",
                      "Teacher controls absorb some confounding but miss the SES channel.",
                      "Absorbs most confounders; the coefficient approaches the true parameter.",
                      "Within-teacher variation in class size; the cleanest observational estimate."),
  check.names = FALSE))
H2("The unit-of-analysis choice, again")
BL("Pooling all 1,248 classroom-year observations in one OLS model gives each observation equal weight, like Hanushek's approach.")
BL("Running 8 school-level regressions gives each site equal weight, like Krueger's approach.")
BL("Fixed effects (teacher, school, year) use only within-unit variation, closest in spirit to a controlled experiment.")
H2("Grade heterogeneity: fixed effects vs. interactions")
P(paste("The class size effect is built in as a step function: −0.060 per pupil above 23 in grades K–2,",
  "−0.050 in grades 3–5, −0.040 in grades 6–8, and −0.030 in grades 9–12."))
BB("Model A, grade fixed effects: ", "test_score ~ grade_level + class_size + controls. One class_size slope for all grades: a weighted average that understates the K–2 effect and overstates the 9–12 effect.")
BB("Model B, grade × class size interaction: ", "test_score ~ grade_level * class_size + controls. Each grade gets its own slope, recovering the gradient.")
TB(data.frame(
  Specification = c("Naive OLS (no controls)", "+ SES controls", "+ Teacher controls only",
                    "+ Pretest + year FE", "Grade FE, pooled slope", "Grade × class size, K–2",
                    "Grade × class size, 9–12", "Teacher FE (feols)"),
  `Expected class_size coefficient` = c("Positive (+0.10 to +0.30)", "Negative (−0.10 to −0.20)",
    "Weakly negative or near zero", "Negative (−0.15 to −0.25)", "Negative (−0.10 to −0.20)",
    "More negative (−0.25 to −0.35)", "Near zero (0 to −0.10)", "Negative (−0.10 to −0.20)"),
  Why = c("SES confounding dominates", "SES channel blocked", "Teacher quality absorbs some variation",
          "Most confounding removed", "Weighted average of grade effects", "Stronger true effect in early grades",
          "Weaker true effect in secondary grades", "Within-teacher variation"),
  check.names = FALSE))
H2("Interpreting the magnitude")
P(paste("Test scores are centered at 50 with an SD of about 12–13 points. A coefficient of −0.15 means each",
  "extra pupil costs about 0.15 points, so moving from 15 to 25 pupils costs about 1.5 points, or roughly",
  "0.12 SD. That is in the range of Glass and Smith's predictions for the 15–25 range (0.05–0.13 SD) and",
  "below Shin and Chung's 0.20 for elementary grades."))
H2("Discussion questions")
NL("The naive regression gives a positive coefficient. Before running the models, which variables do you expect drive the reversal, and in what order would you control for them?")
NL("Pupil–teacher ratios fell for 35 years with no visible gain in aggregate scores. What confounders would reconcile that history with a genuine positive effect?")
NL("Adding grade fixed effects changes the class_size coefficient. Is the fixed-effects model identifying a different quantity from the pooled model? What must hold for each?")
NL("Compare the grade-FE coefficient with the average of the grade-specific slopes. When would they differ, and under what weighting would they be equal?")
NL("Published studies average d = 0.21 and unpublished 0.13. What mechanisms besides publication bias could produce the gap, given that most published effects come from STAR?")
NL("The teacher fixed-effects model uses within-teacher variation across years. What is the identifying assumption, and what threat to it exists in this panel?")

# ==================================================================
H1("References")
refs <- c(
  "Coleman, J. S. (1966). Equality of educational opportunity. U.S. Department of Health, Education, and Welfare.",
  "Finn, J. D., & Achilles, C. M. (1990). Answers and questions about class size: A statewide experiment. American Educational Research Journal, 27(3), 557–577.",
  "Finn, J. D., & Achilles, C. M. (1999). Tennessee's class size study: Findings, implications, misconceptions. Educational Evaluation and Policy Analysis, 21(2), 97–109.",
  "Glass, G. V., & Smith, M. L. (1979). Meta-analysis of research on class size and achievement. Educational Evaluation and Policy Analysis, 1(1), 2–16.",
  "Goldstein, H., & Blatchford, P. (1998). Class size and educational achievement: A review of methodology with particular reference to study design. British Educational Research Journal, 24(3), 255–268.",
  "Hanushek, E. A. (2002). Evidence, politics, and the class size debate. In L. Mishel & R. Rothstein (Eds.), The class size debate (pp. 37–65). Economic Policy Institute.",
  "Jepsen, C., & Rivkin, S. (2009). Class size reduction and student achievement: The potential tradeoff between teacher quality and class size. Journal of Human Resources, 44(1), 223–250.",
  "Krueger, A. B. (2002). Understanding the magnitude and effect of class size on student achievement. In L. Mishel & R. Rothstein (Eds.), The class size debate (pp. 7–35). Economic Policy Institute.",
  "Molnar, A., Smith, P., Zahorik, J., Palmer, A., Halbach, A., & Ehrle, K. (1999). Evaluating the SAGE program: A pilot program in targeted pupil-teacher reduction in Wisconsin. Educational Evaluation and Policy Analysis, 21(2), 165–177.",
  "Shin, I.-S., & Chung, J. Y. (2009). Class size and student achievement in the United States: A meta-analysis. KEDI Journal of Educational Policy, 6(2), 3–19.")
for (r in refs) P(r)

print(doc, target = "Class_Size_Evidence_Review.docx")
cat("written\n")
