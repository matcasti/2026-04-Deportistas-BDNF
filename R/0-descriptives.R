
# Prepare workspace -------------------------------------------------------

## Load libraries
library(data.table)
library(gtsummary)
library(gt)
library(skimr)

## Load data
data("athletes")

# -------------------------------------------------------------------------

skim(athletes)

# -------------------------------------------------------------------------

select_cols <- c("sex", "edad", "deporte_frecuencia", "deporte_experienca_meses",
                 "if_bp_sistolica", "if_bp_diastolica", "if_bp_pam", "if_bp_pp", "if_fc_reposo",
                 "cc_peso", "cc_talla", "cc_imc", "cc_grasa_total", "cc_musculo_total",
                 "cc_musculo_apendicular", "cc_ime", "cc_agua", "cc_masa_osea",
                 "hrv_pre_rmssd", "hrv_pre_sdnn", "hrv_pre_mean_rr",
                 "hrv_pre_hf","hrv_pre_lf", "hrv_pre_vlf", "hrv_pre_stress",
                 "temperatura_timpanica", "temperatura_piel_frente",
                 "temperatura_piel_pecho", "temperatura_piel_deltoides",
                 "temperatura_piel_mano", "temperatura_piel_pie")

tbl_data <- athletes[, .SD, .SDcols = select_cols]

tbl_1 <- tbl_summary(tbl_data,
            by = sex,
            type = everything() ~ "continuous",
            statistic = all_continuous() ~ "{mean} ± {sd}",
            digits = all_continuous() ~ 1,
            label = list(
              edad ~ "Age (years old)",
              cc_peso ~ "Body weight (kg)",
              cc_talla ~ "Height (cm)",
              cc_imc ~ "Body mass index (kg/m²)",
              deporte_frecuencia ~ "Sport practice frequency (times per week)",
              deporte_experienca_meses ~ "Sport practice experience (months)",
              temperatura_timpanica ~ "Tympanic temperature (º)",
              temperatura_piel_frente ~ "Forehead skin temperature (º)",
              temperatura_piel_pecho ~ "Chest skin temperature (º)",
              temperatura_piel_deltoides ~ "Shoulder skin temperature (º)",
              temperatura_piel_mano ~ "Hand skin temperature (º)",
              temperatura_piel_pie ~ "Foot skin temperature (º)",
              cc_grasa_total ~ "Body fat (%)",
              cc_musculo_total ~ "Muscle mass (kg)",
              cc_musculo_apendicular ~ "Apendicular muscle mass (kg)",
              cc_ime ~ "Skeletal muscle index (kg/m²)",
              cc_agua ~ "Body water (%)",
              cc_masa_osea ~ "Bone mineral mass (kg)",
              if_bp_sistolica ~ "Systolic blood pressure (mmHg)",
              if_bp_diastolica ~ "Diastolic blood pressure (mmHg)",
              if_bp_pam ~ "Mean arterial pressure (mmHg)",
              if_bp_pp ~ "Pulse pressure (mmHg)",
              if_fc_reposo ~ "Resting heart rate (bpm)",
              hrv_pre_rmssd ~ "RMSSD (ms)",
              hrv_pre_sdnn ~ "SDNN (ms)",
              hrv_pre_mean_rr ~ "Mean RR (ms)",
              hrv_pre_hf ~ "HF (ms²)",
              hrv_pre_lf ~ "LF (ms²)",
              hrv_pre_vlf ~ "VLF (ms²)",
              hrv_pre_stress ~ "Stress index (c.u.)"
            ),
            missing = "no") |>
  add_overall() |>
  add_difference(
    test = all_continuous() ~ "smd"
  ) |>
  remove_footnote_header() |>
  remove_abbreviation() |>
  as_gt()

tbl_1 <- tbl_1 |>
  opt_stylize(style = 5) |>
  tab_spanner(label = "Sex", columns = 8:9) |>
  tab_spanner(label = "SMD", columns = 10:13) |>
  tab_style(locations = gt::cells_column_labels(), style = gt::cell_text(weight = "bold")) |>
  tab_style(locations = gt::cells_column_spanners(), style = gt::cell_text(weight = "bold"))

save(tbl_1, file = "output/tbl_1.RData")
