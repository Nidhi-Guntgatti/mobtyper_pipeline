# --------------------------------------------
# MOB-SUITE (mobtyper) Summary and Visualization Script
# --------------------------------------------

library(dplyr)
library(tidyr)
library(ggplot2)
library(readr)

# 1. Load data -----------------------------------------------------------
df <- read_csv("mobtyper_merged.csv", show_col_types = FALSE)

# Clean names
names(df) <- gsub("\\.", "_", names(df))

# 2. SUMMARY TABLES ------------------------------------------------------

# Replicon summary
rep_summary <- df %>%
  count(rep_type_s_, name = "count") %>%
  arrange(desc(count))

write_tsv(rep_summary, "replicon_summary.tsv")

# Relaxase summary
rel_summary <- df %>%
  count(relaxase_type_s_, name = "count") %>%
  arrange(desc(count))

write_tsv(rel_summary, "relaxase_summary.tsv")

# MPF system summary
mpf_summary <- df %>%
  count(mpf_type, name = "count") %>%
  arrange(desc(count))

write_tsv(mpf_summary, "mpf_summary.tsv")


# 3. BARPLOTS (saved as PNG files) ----------------------------------------

# Replicon plot
ggplot(rep_summary, aes(x=reorder(rep_type_s_, -count), y=count)) +
  geom_bar(stat="identity") +
  labs(title="Replicon Type Distribution", x="Replicon Type", y="Count") +
  theme_bw() +
  theme(axis.text.x = element_text(angle=45, hjust=1))
ggsave("replicon_plot.png", width=10, height=5)

# Relaxase plot
ggplot(rel_summary, aes(x=reorder(relaxase_type_s_, -count), y=count)) +
  geom_bar(stat="identity") +
  labs(title="Relaxase Type Distribution", x="Relaxase Type", y="Count") +
  theme_bw() +
  theme(axis.text.x = element_text(angle=45, hjust=1))
ggsave("relaxase_plot.png", width=10, height=5)

# MPF plot
ggplot(mpf_summary, aes(x=reorder(mpf_type, -count), y=count)) +
  geom_bar(stat="identity") +
  labs(title="MPF Type Distribution", x="MPF Type", y="Count") +
  theme_bw() +
  theme(axis.text.x = element_text(angle=45, hjust=1))
ggsave("mpf_plot.png", width=10, height=5)

# 4. PRINT MESSAGE --------------------------------------------------------

print("Analysis complete: TSV tables + PNG figures generated.")
