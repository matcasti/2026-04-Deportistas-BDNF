# Prepare workspace -------------------------------------------------------

## Load libraries
library(data.table)
library(brms)
library(datawizard)

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

m_data <-
  athletes[, .SD, .SDcols = select_cols] |>
  datawizard::standardise()

# -------------------------------------------------------------------------

hrv_time_cc_model <-
  bf(mvbind(hrv_pre_rmssd,
            hrv_pre_sdnn,
            hrv_pre_mean_rr) ~
       (cc_grasa_total + cc_musculo_total) *
       (sex +
          edad +
          deporte_frecuencia +
          deporte_experienca_meses) +
          if_bp_pam +
          if_bp_pp) +
  set_rescor(TRUE)

hrv_freq_cc_model <-
  bf(mvbind(hrv_pre_hf,
            hrv_pre_lf,
            hrv_pre_vlf) ~
       (cc_grasa_total + cc_musculo_total) *
       (sex +
          edad +
          deporte_frecuencia +
          deporte_experienca_meses) +
          if_bp_pam +
          if_bp_pp) +
  set_rescor(TRUE)

# -------------------------------------------------------------------------

fit_hrv_time_cc_adj <- brm(
  formula = hrv_time_cc_model,
  data = m_data,
  family = gaussian(),
  prior = c(
    set_prior(prior = "lkj(1)", class = "rescor"),
    set_prior(prior = "normal(0,3)", class = "b"),
    set_prior(prior = "normal(0,3)", class = "sigma", lb = 0, resp = c("hrvprermssd",
                                                                       "hrvpresdnn",
                                                                       "hrvpremeanrr"))
  ),
  chains = 4, cores = 4, iter = 5000, warmup = 2500,
  control = list(
    adapt_delta = 0.999,
    max_treedepth = 50
  ),
  file = "models/fit_hrv_time_cc_adj.rds"
)

conditional_effects(fit_hrv_time_cc_adj)

fit_hrv_freq_cc_adj <- brm(
  formula = hrv_freq_cc_model,
  data = m_data,
  family = gaussian(),
  prior = c(
    set_prior(prior = "lkj(1)", class = "rescor"),
    set_prior(prior = "normal(0,3)", class = "b"),
    set_prior(prior = "normal(0,3)", class = "sigma", lb = 0, resp = c("hrvprehf",
                                                                       "hrvprelf",
                                                                       "hrvprevlf"))
  ),
  chains = 4, cores = 4, iter = 5000, warmup = 2500,
  control = list(
    adapt_delta = 0.999,
    max_treedepth = 50
  ),
  file = "models/fit_hrv_freq_cc_adj.rds"
)

conditional_effects(fit_hrv_freq_cc_adj)
