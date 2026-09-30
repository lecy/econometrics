# ===============================================================
# BUILD THE DATA PREP GUIDE: ../omission-bias-replication-data-prep.html
# ===============================================================
# The page is hand-written HTML (data-prep-page-template.html) with the
# eight tidy tables embedded as JSON for the scrollable table widgets.
# Rerun this after ob_data_prep.R changes the CSVs or after editing the
# template. Run from this folder (omission_bias/analysis).
#
# Each table spec lists the columns to show as c(key, label, class),
# where class is "num" (right-aligned), "mid", or "long" (clamped to
# three lines, click to expand). `marks` names the highlighted rows and
# the badge each one gets; the text of the page refers to those badges.
# ===============================================================

library(jsonlite)

rd <- function(f) read.csv(file.path("../data", f), na.strings = c("", "NA"),
                           check.names = FALSE, stringsAsFactors = FALSE)

spec <- function(df, cols, key = NULL, marks = NULL) {
  keys <- vapply(cols, `[`, "", 1)
  df <- df[, keys, drop = FALSE]
  for (k in keys) if (is.numeric(df[[k]])) df[[k]] <- ifelse(is.na(df[[k]]), NA, signif(df[[k]], 4))
  list(cols = lapply(cols, function(x) list(k = x[1], l = x[2], c = x[3])),
       rows = df, key = key, marks = marks)
}

st <- rd("ob_01_search_terms.csv")
al <- rd("ob_02_article_list.csv")
cd <- rd("ob_03_coding_decisions.csv")
ex <- rd("ob_04_excluded_effects.csv")
de <- rd("ob_05_effect_descriptors.csv")
sx <- rd("ob_06_effect_statistics.csv")
mo <- rd("ob_07_moderators.csv")
ac <- rd("ob_08_author_contacts.csv")

ex$row <- sprintf("X%02d", seq_len(nrow(ex)))
lab <- setNames(de$article, de$effect_id)
sx$article <- lab[sx$effect_id]; mo$article <- lab[mo$effect_id]

DATA <- list(
  search = spec(st, list(c("step", "Step", "num"), c("round", "Round", ""),
                         c("query", "Query", "long"), c("hits", "Hits", "num"), c("note", "Note", "mid"))),
  articles = spec(al, list(c("article_no", "No.", "num"), c("short_name", "Article", "mid"),
                           c("year", "Year", ""), c("type", "Type", ""), c("n_studies", "Studies", "num"),
                           c("screened_in", "Included?", ""), c("outcome", "Where it ended up", "mid"),
                           c("k_effects", "Effects", "num"), c("remarks", "Remarks", "mid"),
                           c("keywords", "Keywords", "mid"), c("abstract", "Abstract", "long"),
                           c("journal", "Journal", "mid")),
                  key = "article_no", marks = list("4" = "A", "5" = "B", "28" = "C")),
  decisions = spec(cd, list(c("decision_no", "Dec.", "num"), c("article_no", "Art.", "num"),
                            c("article", "Article", "mid"), c("source", "Found by", ""),
                            c("decision", "Decision", "long")),
                   key = "decision_no", marks = list("1" = "A", "2" = "A", "3" = "A", "4" = "A", "13" = "B")),
  excluded = spec(ex, list(c("row", "Row", ""), c("article_no", "Art.", "num"), c("article", "Article", "mid"),
                           c("study", "Study", "num"), c("sample", "Sample", "num"), c("subgroup", "Sub.", "num"),
                           c("criterion", "Criterion (our mapping)", "mid"), c("reason", "Reason given by coders", "long"),
                           c("row_description", "Row description", "long"), c("design_type", "Design", ""),
                           c("dv_title", "DV", "mid"), c("n", "N", "num")),
                  key = "row", marks = list(X36 = "C", X03 = "D")),
  descriptors = spec(de, list(c("effect_id", "ID", ""), c("article", "Article", "mid"), c("published", "Publ.", ""),
                              c("study", "Study", "num"), c("sample", "Sample", "num"), c("dv_no", "DV #", "num"),
                              c("population", "Population", ""), c("country", "Country", ""),
                              c("n", "N", "num"), c("age_mean", "Age", "num"), c("n_female", "Female", "num"),
                              c("design_type", "Design", ""), c("collapse_note", "Collapse note", "long"), c("dv_group", "DV group", ""),
                              c("dv_format", "DV format", ""), c("dv_title", "DV title", "mid"),
                              c("action_condition", "Action condition", "long"),
                              c("inaction_condition", "Inaction condition", "long"),
                              c("row_description", "Row description", "long")),
                     key = "effect_id", marks = list(E01 = "1", E39 = "2")),
  statistics = spec(sx, list(c("effect_id", "ID", ""), c("article", "Article", "mid"),
                             c("dv_format", "DV format", ""), c("es_input", "Route", ""),
                             c("n", "N", "num"), c("n_action", "n act", "num"), c("n_inaction", "n inact", "num"),
                             c("m_action", "M act", "num"), c("sd_action", "SD act", "num"),
                             c("m_inaction", "M inact", "num"), c("sd_inaction", "SD inact", "num"),
                             c("t", "t", "num"), c("t_df", "df", "num"), c("f", "F", "num"),
                             c("chisq", "χ²", "num"), c("reported_d", "Reported d", "num"),
                             c("best_estimate", "Best estimate", "num"), c("reverse", "Reverse?", ""),
                             c("conversion", "How converted", "long"), c("stats_page", "Page", "mid")),
                    key = "effect_id", marks = list(E39 = "1", E01 = "2", E34 = "3", E22 = "4", E49 = "5")),
  moderators = spec(mo, list(c("effect_id", "ID", ""), c("article", "Article", "mid"),
                             c("familiarity", "Familiarity", "mid"), c("responsibility", "Responsibility", "mid"),
                             c("responsibility_note", "Why", "long"),
                             c("outcome", "Outcome", "mid"), c("self_other", "Target", ""),
                             c("self_other_note", "Why", "long"), c("harm_specified", "Harm odds", "mid")),
                    key = "effect_id", marks = list(E49 = "1", E46 = "2")),
  contacts = spec(ac, list(c("article_no", "Article no.", "num"), c("authors", "Authors in log", "num"),
                           c("email_on_file", "Address on file", "num"), c("reply_logged", "Reply logged", "num")))
)

json <- toJSON(DATA, dataframe = "rows", na = "null", auto_unbox = TRUE, digits = NA)
json <- gsub("</", "<\\/", json)   # never close the <script> early

tpl <- readLines("data-prep-page-template.html", encoding = "UTF-8", warn = FALSE)
tpl[tpl == "/*__DATA__*/"] <- paste0("const DATA = ", json, ";")
out <- "../omission-bias-replication-data-prep.html"
con <- file(out, open = "w", encoding = "UTF-8"); writeLines(tpl, con); close(con)
cat("wrote", out, round(file.size(out) / 1024), "KB\n")
