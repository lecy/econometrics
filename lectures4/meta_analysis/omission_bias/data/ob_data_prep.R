# ===============================================================
# OMISSION BIAS META-ANALYSIS: DATA PREP
# ===============================================================
# Yeung, S. K., Yay, T., & Feldman, G. (2022). Action and inaction in
#   moral judgments and decisions: Meta-analysis of omission bias
#   omission-commission asymmetries. Personality and Social Psychology
#   Bulletin, 48(10), 1499-1515.
#
# Purpose: split the authors' one-workbook coding sheet into a set of
# small, sanitized CSV tables, one per stage of the review:
#
#   ob_01_search_terms.csv        Search tab       - queries and hit counts
#   ob_02_article_list.csv        Article list tab - 76 full-text articles
#   ob_03_coding_decisions.csv    Coding decisions - study-level exclusions
#   ob_04_excluded_effects.csv    Excluded tab     - effect rows coded, then dropped
#   ob_05_effect_descriptors.csv  Effect codings   - sample, design, DV (49 rows)
#   ob_06_effect_statistics.csv   Effect codings   - reported statistics (49 rows)
#   ob_07_moderators.csv          Effect codings   - moderator codes (49 rows)
#   ob_08_author_contacts.csv     Authors tab      - contact counts per article
#
# Sanitizing means: (1) drop empty columns and the empty "Proportions"
# block, (2) drop coder names and coding dates, (3) drop every e-mail
# address, personal web page, and the Google Docs link, and (4) keep
# only per-article counts from the author contact log.
#
# Input: the OSF archive (https://osf.io/9fcqm/, "Download as zip"),
#   saved as ../original/9fcqm-osfstorage-archive.zip. The script pulls
#   Coding and analyses/Omission-Bias-Coding-Sheet-Meta-v6-G.xlsx out of it.
#   The archive stays out of git: its Authors tab has e-mail addresses.
#
# Run from this folder (omission_bias/data); the CSVs are written here.
# Companion guide: ../omission-bias-replication-data-prep.html
# Next step:       ../analysis/omission-bias-analysis.Rmd
# ===============================================================

library(readxl)
library(cellranger)   # letter_to_num(): refer to columns by their Excel letter

zip   <- "../original/9fcqm-osfstorage-archive.zip"
sheet <- "Coding and analyses/Omission-Bias-Coding-Sheet-Meta-v6-G.xlsx"
xlsx  <- unzip(zip, files = sheet, exdir = tempdir())
out   <- "."

## Read a tab as text with no header, so that row and column numbers in R
## match what you see in Excel (row 1 = Excel row 1, column "B" = 2).
read_tab <- function(sheet) {
  suppressMessages(read_excel(xlsx, sheet = sheet, col_names = FALSE,
                              col_types = "text", .name_repair = "minimal"))
}

## Pull columns by Excel letter and name them.
pick <- function(tab, rows, cols) {
  x <- as.data.frame(tab[rows, letter_to_num(cols)])
  names(x) <- names(cols)
  x[] <- lapply(x, function(v) trimws(gsub("[\r\n]+", " ", v)))
  x
}

num <- function(v) suppressWarnings(as.numeric(v))

## Excel stores dates as days since 1899-12-30.
xl_date <- function(v) format(as.Date(num(v), origin = "1899-12-30"))

write_out <- function(x, file) {
  write.csv(x, file.path(out, file), row.names = FALSE, na = "")
  cat(sprintf("%-30s %3d rows x %2d cols\n", file, nrow(x), ncol(x)))
}


# ===============================================================
# STEP 1. SEARCH TERMS (tab "Search terms")
# ===============================================================
## Rows 3-17: eight first-round Google Scholar queries and a reference-list
## step. Row 23: the final combined query reported in the paper (p. 1502).

st <- read_tab("Search terms")
search <- data.frame(
  round = c(rep("First round", 9), "Final"),
  step  = c(1:9, 10),
  query = c(unlist(st[c(3, 5, 7, 9, 11, 13, 15, 17, 19), 3]), unlist(st[23, 2])),
  hits  = c(unlist(st[c(3, 5, 7, 9, 11, 13, 15, 17, 19), 17]), unlist(st[23, 17]))
)
search$hits[search$hits == "x"] <- NA
search$hits <- num(search$hits)
search$note <- ifelse(search$step == 9, "Hand search of reference lists; no hit count",
               ifelse(search$step == 10, "Syntax reported in the paper; 2,570 records (Figure 1)", ""))
write_out(search, "ob_01_search_terms.csv")


# ===============================================================
# STEP 2. ARTICLE LIST (tab "Article list")
# ===============================================================
## Row 1 is the header; rows 2-78 are articles numbered 1-77 in column E
## (no. 65 is blank). Columns A-D (serial no., date, search terms,
## database) were never filled in and are dropped. The full-text screen
## decision is column F, "Included?".

al <- read_tab("Article list")
articles <- pick(al, 2:nrow(al), c(
  article_no = "E", screened_in = "F", link = "G",
  a1 = "H", a2 = "I", a3 = "J", a4 = "K", a5 = "L", a6 = "M", a7 = "N", a8 = "O",
  year = "P", title = "Q", short_name = "R", journal = "S", abstract = "T",
  k1 = "U", k2 = "V", k3 = "W", k4 = "X", k5 = "Y", k6 = "Z", k7 = "AA", k8 = "AB",
  n_studies = "AC", type = "AD", apa_reference = "AE", remarks = "AF"))
articles <- articles[!is.na(articles$a1), ]

paste_cols <- function(df, cols, sep) {
  apply(df[cols], 1, function(r) paste(r[!is.na(r) & r != ""], collapse = sep))
}
articles$authors  <- paste_cols(articles, paste0("a", 1:8), ", ")
articles$keywords <- paste_cols(articles, paste0("k", 1:8), "; ")
articles$first_author <- articles$a1
articles$remarks[articles$remarks %in% c(".", "")] <- NA

## Personal pages and ResearchGate profiles are not needed; keep DOIs and
## publisher links only.
articles$link[grepl("researchgate|academia\\.edu|~", articles$link)] <- NA


# ===============================================================
# STEP 3. CODING DECISIONS (tab "Coding decisions")
# ===============================================================
## One row per decision: which experiments in an article were dropped,
## and why. Rows after "Additional articles (from authors via mail)" came
## from the call for unpublished work.

cd <- read_tab("Coding decisions")
decisions <- pick(cd, 2:nrow(cd), c(article = "A", decision_no = "B",
                                     article_no = "C", decision = "D"))
batch_row <- which(decisions$article == "Additional articles (from authors via mail)")
decisions$source <- ifelse(seq_len(nrow(decisions)) > batch_row,
                           "Author call (2017, 2020)", "Database search")
decisions <- decisions[!is.na(decisions$decision), c("decision_no", "article_no",
                                                       "article", "source", "decision")]
write_out(decisions, "ob_03_coding_decisions.csv")


# ===============================================================
# STEP 4. EXCLUDED EFFECT ROWS (tab "Excluded")
# ===============================================================
## Rows 2-81 are effect rows that were fully coded and then dropped.
## Column A holds a free-text reason. We add `criterion`, our own mapping
## of that reason onto the paper's inclusion (B1, B2) and exclusion
## (C1-C4) criteria in Figure 1.

ex <- read_tab("Excluded")
excluded <- pick(ex, 2:81, c(
  reason = "A", article = "B", article_no = "C", study = "D", sample = "E",
  subgroup = "F", dv_no = "G", row_description = "H", setting = "N",
  population = "O", country = "P", n = "R", design_type = "AD",
  dv_title = "AP", dv_type = "AQ"))

criterion_of <- function(r) {
  r <- tolower(r)
  if (grepl("norm-theory|status-quo", r)) return("C2 action-effect / status quo / norm theory")
  if (grepl("correlation|not an experiment", r)) return("C1 not an experiment")
  if (grepl("wrong stats|main stats of interest", r)) return("C3 needed statistics not reported")
  if (grepl("moral dv|cheating|punishment|disease and vaccine|with and without knowledge", r))
    return("B2 DV is not morality, blame, or decision")
  return("B1 no clean action-inaction contrast")
}
excluded$criterion <- vapply(excluded$reason, criterion_of, "")
excluded$n <- num(excluded$n)
excluded <- excluded[, c("article_no", "article", "study", "sample", "subgroup", "dv_no",
                         "criterion", "reason", "row_description", "design_type",
                         "dv_title", "dv_type", "setting", "population", "country", "n")]
write_out(excluded, "ob_04_excluded_effects.csv")


# ===============================================================
# STEP 5. EFFECT CODINGS (tab "Study effect codings")
# ===============================================================
## Rows 1-3 are section banners and instructions; row 4 is the header;
## rows 5-53 are the 49 effect sizes. The tab has 155 columns. We split it
## into three tables that share the key `effect_id`:
##   descriptors (who, where, what design, which DV),
##   statistics  (the numbers each effect size is built from), and
##   moderators  (the codes used in the moderator analyses).
## Columns dropped: coder and dates (K-O), empty gender and proportion
## columns, and the empty "Proportions" block (DB-DY).

ec   <- read_tab("Study effect codings")
rows <- 5:53
eid  <- sprintf("E%02d", seq_along(rows))

descriptors <- cbind(effect_id = eid, pick(ec, rows, c(
  article = "B", published = "C", article_no = "D", study = "E", sample = "F",
  subgroup = "G", dv_no = "H", vaccination = "I", row_description = "J",
  setting = "P", population = "Q", country = "R",
  n_gross = "S", n = "T", exclusions = "U",
  age_mean = "V", age_sd = "W", n_female = "X", n_male = "Y",
  pct_female = "AA", pct_male = "AB",
  original_design = "AD", design_change = "AE", design_type = "AF",
  iv = "AH", action_condition = "AJ", inaction_condition = "AK",
  collapsed = "AL", collapse_note = "AM",
  dv_title = "AR", dv_type = "AS", dv_group = "AT", dv_explanation = "AU",
  dv_is_prop = "AV", dv_is_count = "AW", dv_is_scale = "AX")))

## One column for the DV format instead of three yes/no columns.
descriptors$dv_format <- ifelse(descriptors$dv_is_count == "Yes", "counts",
                         ifelse(descriptors$dv_is_prop  == "Yes", "proportions", "scale"))
descriptors$dv_is_prop <- descriptors$dv_is_count <- descriptors$dv_is_scale <- NULL
for (v in c("n_gross", "n", "age_mean", "age_sd", "n_female", "n_male",
            "pct_female", "pct_male")) descriptors[[v]] <- round(num(descriptors[[v]]), 2)

## Five rows (DeScioli 2011, Hayashi 2015 adults, Connolly & Reb) hold values
## like 42967 as the mean age. Excel turned whatever was typed there into a
## date serial (42967 = 2017-08-20). Blank any age that cannot be an age.
bad_age <- which(descriptors$age_mean > 120)
cat("Blanked impossible mean ages in rows:", descriptors$effect_id[bad_age], "\n")
descriptors$age_mean[bad_age] <- NA

stats <- cbind(effect_id = eid, pick(ec, rows, c(
  n_action = "AN", n_inaction = "AO", n_source = "AP",
  m_action = "BA", sd_action = "BB", m_inaction = "BD", sd_inaction = "BE",
  mean_diff = "BG", means_page = "AZ",
  f = "BM", f_df = "BN", t = "BO", t_df = "BP", p = "BQ", p_tails = "BR",
  stats_page = "BL",
  reported_d = "BU", calc_d = "BV",
  count_action = "CE", count_inaction = "CF", chisq = "CU", counts_page = "CD",
  conversion = "EG", tool = "EH", reverse = "EI", reverse_why = "EJ",
  best_estimate = "EK")))
num_cols <- c("n_action", "n_inaction", "m_action", "sd_action", "m_inaction",
              "sd_inaction", "mean_diff", "f", "t", "t_df", "p", "reported_d",
              "calc_d", "count_action", "count_inaction", "chisq", "best_estimate")
stats[num_cols] <- lapply(stats[num_cols], function(v) signif(num(v), 7))
stats$n <- descriptors$n

## Which statistic did the authors' code actually use? Their R code runs a
## series of loops in which later loops overwrite earlier ones. The final
## winner is, in order of precedence:
##   1. group means, SDs, and Ns for both conditions  -> metafor::escalc("SMD")
##   2. a chi-square from counts                      -> compute.es::chies()
##   3. otherwise the "Best effect estimate" column, which the coders had
##      computed by hand from a t, an F, or a reported d.
has_means <- with(stats, !is.na(m_action) & !is.na(sd_action) & !is.na(n_action) &
                         !is.na(m_inaction) & !is.na(sd_inaction) & !is.na(n_inaction))
stats$es_input <- ifelse(has_means, "group means",
                  ifelse(!is.na(stats$chisq), "chi-square",
                  ifelse(!is.na(stats$t), "t statistic",
                  ifelse(!is.na(stats$f), "F statistic", "reported d"))))
stats$dv_format <- descriptors$dv_format

stats <- stats[, c("effect_id", "dv_format", "es_input", "n", "n_action", "n_inaction",
                   "n_source", "m_action", "sd_action", "m_inaction", "sd_inaction",
                   "mean_diff", "t", "t_df", "f", "f_df", "p", "p_tails",
                   "count_action", "count_inaction", "chisq", "reported_d", "calc_d",
                   "best_estimate", "reverse", "reverse_why", "conversion", "tool",
                   "means_page", "stats_page", "counts_page")]

moderators <- cbind(effect_id = eid, pick(ec, rows, c(
  familiarity = "EL", familiarity_sub = "EM", familiarity_note = "EN",
  responsibility = "EO", responsibility_note = "EP",
  outcome = "EQ", outcome_sub = "ER", outcome_note = "ES",
  self_other = "ET", self_other_note = "EU",
  stat_info = "EV", stat_info_note = "EW",
  harm_specified = "EX", harm_specified_note = "EY")))

write_out(descriptors, "ob_05_effect_descriptors.csv")
write_out(stats,       "ob_06_effect_statistics.csv")
write_out(moderators,  "ob_07_moderators.csv")


# ===============================================================
# STEP 6. BACK TO THE ARTICLE LIST: WHERE DID EACH ARTICLE END UP?
# ===============================================================
## The "Included?" column records only the full-text screen. Twenty
## articles passed it; 13 reached the analysis. `outcome` traces each
## article through the later tabs.

inc_no <- unique(descriptors$article_no)
exc_no <- unique(excluded$article_no)
dec_no <- unique(decisions$article_no)
articles$outcome <- ifelse(articles$article_no %in% inc_no, "Included: effects coded",
                    ifelse(articles$article_no %in% exc_no, "Dropped after coding (Excluded tab)",
                    ifelse(articles$article_no %in% dec_no, "Dropped at full text (Coding decisions)",
                                                            "Dropped at full text")))
articles$k_effects <- as.integer(table(factor(descriptors$article_no,
                                              levels = articles$article_no)))

articles <- articles[, c("article_no", "short_name", "first_author", "authors", "year",
                         "title", "journal", "type", "n_studies", "screened_in",
                         "outcome", "k_effects", "keywords", "remarks", "abstract",
                         "apa_reference", "link")]
write_out(articles, "ob_02_article_list.csv")


# ===============================================================
# STEP 7. AUTHOR CONTACT LOG (tab "Authors"), REDUCED TO COUNTS
# ===============================================================
## The tab lists names, e-mail addresses, affiliations, and dates of each
## e-mail. None of that is needed to reproduce the review, so we keep only
## how many authors each article has in the log, how many had an address on
## file, and how many replies were logged with a date.

au <- read_tab("Authors")
au <- pick(au, 2:nrow(au), c(article_no = "A", author = "B", email = "C", reply = "H"))
au <- au[!is.na(au$author) & !is.na(au$article_no), ]
au$email_on_file <- !is.na(au$email) & grepl("@", au$email)
au$reply_logged  <- !is.na(au$reply)
contacts <- aggregate(cbind(authors = 1, email_on_file, reply_logged) ~ article_no,
                      data = au, FUN = sum)
contacts <- contacts[order(num(contacts$article_no)), ]
write_out(contacts, "ob_08_author_contacts.csv")


# ===============================================================
# STEP 8. CHECKS AGAINST THE PAPER
# ===============================================================
stopifnot(
  nrow(articles) == 76,                          # Figure 1: 76 full texts assessed
  length(inc_no) == 13,                          # 13 articles
  nrow(descriptors) == 49,                       # 49 effect sizes
  nrow(unique(descriptors[, c("article", "study", "sample")])) == 21  # 21 samples
)
cat("\nAll checks passed: 76 articles -> 13 included, 21 samples, 49 effects.\n")
