# Prepare workspace -------------------------------------------------------

## Load libraries
library(data.table)
library(correlation)

## Load data
data("athletes")

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

tbl_corr <- athletes[, .SD, .SDcols = select_cols]

# -------------------------------------------------------------------------

corr <- correlation(tbl_corr, method = "spearman", p_adjust = "none")

## Significant results
corr |>
  subset(p <= 0.05)

#> Parameter1              |                 Parameter2 |     r |         95% CI |      t | df |         p
#> -------------------------------------------------------------------------------------------------------
#> edad                    |           if_bp_diastolica |  0.60 | [ 0.32,  0.78] |   4.13 | 31 | < .001***
#> edad                    |                  if_bp_pam |  0.56 | [ 0.27,  0.76] |   3.81 | 31 | < .001***
#> ...
#> deporte_frecuencia      |            if_bp_sistolica |  0.44 | [ 0.11,  0.68] |   2.71 | 31 | 0.011*
#> deporte_frecuencia      |               if_fc_reposo | -0.45 | [-0.69, -0.12] |  -2.80 | 31 | 0.009**
#> deporte_frecuencia      |              hrv_pre_rmssd |  0.44 | [ 0.08,  0.69] |   2.53 | 27 | 0.018*
#> deporte_frecuencia      |               hrv_pre_sdnn |  0.39 | [ 0.03,  0.66] |   2.20 | 27 | 0.036*
#> deporte_frecuencia      |            hrv_pre_mean_rr |  0.51 | [ 0.17,  0.74] |   3.06 | 27 | 0.005**
#> deporte_frecuencia      |             hrv_pre_stress | -0.43 | [-0.69, -0.07] |  -2.47 | 27 | 0.020*
#> ...
#> if_bp_sistolica         |           if_bp_diastolica |  0.50 | [ 0.19,  0.72] |   3.20 | 31 | 0.003**
#> if_bp_sistolica         |                  if_bp_pam |  0.79 | [ 0.62,  0.89] |   7.26 | 31 | < .001***
#> if_bp_sistolica         |                   if_bp_pp |  0.73 | [ 0.52,  0.86] |   6.01 | 31 | < .001***
#> if_bp_sistolica         |               if_fc_reposo | -0.37 | [-0.63, -0.03] |  -2.21 | 31 | 0.035*
#> ...
#> if_bp_sistolica         |           cc_musculo_total |  0.54 | [ 0.24,  0.75] |   3.55 | 30 | 0.001**
#> if_bp_sistolica         |     cc_musculo_apendicular |  0.50 | [ 0.18,  0.72] |   3.13 | 30 | 0.004**
#> ...
#> if_bp_sistolica         |                     cc_ime |  0.42 | [ 0.08,  0.68] |   2.53 | 29 | 0.017*
#> if_bp_sistolica         |                    cc_agua |  0.39 | [ 0.05,  0.64] |   2.34 | 31 | 0.026*
#> if_bp_sistolica         |               cc_masa_osea |  0.54 | [ 0.24,  0.74] |   3.57 | 31 | 0.001**
#> ...
#> if_bp_sistolica         | temperatura_piel_deltoides |  0.39 | [ 0.05,  0.65] |   2.35 | 30 | 0.025*
#> ...
#> if_bp_diastolica        |                  if_bp_pam |  0.89 | [ 0.79,  0.95] |  10.93 | 31 | < .001***
#> if_bp_diastolica        |     cc_musculo_apendicular |  0.38 | [ 0.04,  0.65] |   2.28 | 30 | 0.030*
#> if_bp_diastolica        |                hrv_pre_vlf | -0.57 | [-0.77, -0.25] |  -3.56 | 27 | 0.001**
#> ...
#> if_bp_pam               |                    cc_peso |  0.36 | [ 0.02,  0.63] |   2.17 | 31 | 0.038*
#> if_bp_pam               |           cc_musculo_total |  0.47 | [ 0.14,  0.70] |   2.91 | 30 | 0.007**
#> if_bp_pam               |     cc_musculo_apendicular |  0.49 | [ 0.17,  0.72] |   3.09 | 30 | 0.004**
#> if_bp_pam               |                     cc_ime |  0.38 | [ 0.03,  0.65] |   2.24 | 29 | 0.033*
#> if_bp_pam               |               cc_masa_osea |  0.46 | [ 0.14,  0.70] |   2.90 | 31 | 0.007**
#> ...
#> if_bp_pp                |               if_fc_reposo | -0.43 | [-0.67, -0.10] |  -2.66 | 31 | 0.012*
#> ...
#> if_bp_pp                |             cc_grasa_total | -0.37 | [-0.63, -0.03] |  -2.22 | 31 | 0.034*
#> if_bp_pp                |           cc_musculo_total |  0.40 | [ 0.06,  0.66] |   2.37 | 30 | 0.024*
#> if_bp_pp                |                    cc_agua |  0.40 | [ 0.06,  0.65] |   2.40 | 31 | 0.023*
#> if_bp_pp                |               cc_masa_osea |  0.38 | [ 0.05,  0.64] |   2.31 | 31 | 0.028*
#> ...
#> if_bp_pp                |              hrv_pre_rmssd |  0.46 | [ 0.11,  0.71] |   2.69 | 27 | 0.012*
#> if_bp_pp                |               hrv_pre_sdnn |  0.37 | [ 0.00,  0.65] |   2.06 | 27 | 0.049*
#> if_bp_pp                |            hrv_pre_mean_rr |  0.41 | [ 0.05,  0.68] |   2.34 | 27 | 0.027*
#> if_bp_pp                |                 hrv_pre_hf |  0.43 | [ 0.07,  0.69] |   2.46 | 27 | 0.021*
#> if_bp_pp                |                hrv_pre_vlf |  0.43 | [ 0.07,  0.69] |   2.46 | 27 | 0.020*
#> if_bp_pp                |             hrv_pre_stress | -0.40 | [-0.67, -0.04] |  -2.27 | 27 | 0.031*
#> if_bp_pp                | temperatura_piel_deltoides |  0.43 | [ 0.09,  0.68] |   2.60 | 30 | 0.014*
#> ...
#> cc_agua                 |            hrv_pre_mean_rr |  0.40 | [ 0.04,  0.67] |   2.28 | 27 | 0.031*
#> cc_agua                 | temperatura_piel_deltoides |  0.42 | [ 0.09,  0.67] |   2.57 | 30 | 0.015*
#>
#> Observations: 28-33

corr |>
  subset(Parameter1 %like% "bdnf" | Parameter2 %like% "bdnf") |>
  (function(x) {
    x[order(x$p),]
  })()
