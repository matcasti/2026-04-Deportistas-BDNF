# Prepare workspace -------------------------------------------------------

## Load libraries
library(data.table)
library(brms)
library(datawizard)
library(gt)

## Load data
data("athletes")

## Load models
fit_time <- readRDS("models/fit_hrv_time_cc_adj.rds")
fit_freq <- readRDS("models/fit_hrv_freq_cc_adj.rds")

## Load functions
source("R/_functions.R")

# -------------------------------------------------------------------------

select_cols <- c("sex", "edad", "deporte_frecuencia", "deporte_experienca_meses",
                 "if_bp_sistolica", "if_bp_diastolica", "if_bp_pam", "if_bp_pp", "if_fc_reposo",
                 "cc_peso", "cc_talla", "cc_imc", "cc_grasa_total", "cc_musculo_total",
                 "cc_musculo_apendicular", "cc_ime", "cc_agua", "cc_masa_osea",
                 "hrv_pre_rmssd", "hrv_pre_sdnn", "hrv_pre_mean_rr",
                 "hrv_pre_hf","hrv_pre_lf", "hrv_pre_vlf", "hrv_pre_stress",
                 "temperatura_timpanica", "temperatura_piel_frente",
                 "temperatura_piel_pecho", "temperatura_piel_deltoides",
                 "temperatura_piel_mano", "temperatura_piel_pie", "bdnf_elisa")

m_data <-
  athletes[, .SD, .SDcols = select_cols] |>
  datawizard::standardise()

rm(select_cols)

# -------------------------------------------------------------------------

fit_time_results <- summary_model(fit_time)[var %like% "^b_" & pd > 0.8]
fit_freq_results <- summary_model(fit_freq)[var %like% "^b_" & pd > 0.8]

fit_results <- rbind(fit_time_results, fit_freq_results)

## Create a column with the response variable
fit_results[, response := fcase(
  grepl("^b_hrvprermssd", var), "RMSSD",
  grepl("^b_hrvpresdnn", var), "SDNN",
  grepl("^b_hrvpremeanrr", var), "Mean RR",
  grepl("^b_hrvprehf", var), "HF",
  grepl("^b_hrvprelf", var), "LF",
  grepl("^b_hrvprevlf", var), "VLF"
)][]

## Remove the response prefix
fit_results[, var := gsub(
  pattern = "b_hrvprermssd_|b_hrvpresdnn_|b_hrvpremeanrr_|b_hrvprehf_|b_hrvprelf_|b_hrvprevlf_",
  replacement = "",
  x = var
  )][]

## Add a clear 'x' simbol for interactions terms
fit_results[, var := gsub(
  pattern = ":",
  replacement = " ⨉ ",
  x = var
)][]

## Remove variable prefixes
fit_results[, var := gsub(
  pattern = "cc_|if_|bp_",
  replacement = "",
  x = var
)][]

## Remove unitary descriptors
fit_results[, var := gsub(
  pattern = "_total",
  replacement = "",
  x = var
)][]

tbl_results <- fit_results[, .SD, .SDcols = estimate:bf, keyby = list(var, response)]

tbl_results[, var := gsub("deporte_experienca_meses", "[Sport practice experience (months)]", var)][]
tbl_results[, var := gsub("deporte_frecuencia", "[Sport practice frequency (weekly)]", var)][]
tbl_results[, var := gsub("edad", "[Age (years old)]", var)][]
tbl_results[, var := gsub("grasa", "[Body fat (%)]", var)][]
tbl_results[, var := gsub("musculo", "[Muscle mass (kg)]", var)][]
tbl_results[, var := gsub("pam", "[Mean arterial pressure (mmHg)]", var)][]

names(tbl_results) <- c("Parameter", "Response", "Std. Effect", "95% CI", "pd", "ps", "BF")

fwrite(tbl_results, file = "output/model_estimates.csv")

tbl_2 <- gt(tbl_results, groupname_col = "Response", row_group_as_column = TRUE) |>
  opt_stylize(style = 5) |>
  gt::tab_spanner(label = "Estimates", columns = 3:4) |>
  tab_style(locations = gt::cells_column_labels(), style = gt::cell_text(weight = "bold")) |>
  tab_style(locations = gt::cells_row_groups(), style = gt::cell_text(weight = "bold")) |>
  tab_style(locations = gt::cells_column_spanners(), style = gt::cell_text(weight = "bold"))

save(tbl_2, file = "output/tbl_2.RData")
