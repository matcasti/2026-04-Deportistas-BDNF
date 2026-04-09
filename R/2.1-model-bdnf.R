# Prepare workspace -------------------------------------------------------

## Load libraries
library(data.table)
library(brms)

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

bdnf_hrv_time_model <- bf(bdnf_elisa ~
                            (hrv_pre_rmssd +
                             hrv_pre_sdnn +
                             hrv_pre_mean_rr) * (sex + edad + deporte_frecuencia + deporte_experienca_meses + if_bp_pam + if_bp_pp))

bdnf_hrv_freq_model <- bf(bdnf_elisa ~
                            (hrv_pre_hf +
                             hrv_pre_lf +
                             hrv_pre_vlf) * (sex + edad + deporte_frecuencia + deporte_experienca_meses + if_bp_pam + if_bp_pp))

# -------------------------------------------------------------------------

fit_bdnf_hrv_time_adj <- brm(
  formula = bdnf_hrv_time_model,
  data = m_data,
  family = gaussian(),
  prior = c(
    set_prior(prior = "normal(0,3)", class = "b"),
    set_prior(prior = "normal(0,3)", class = "sigma", lb = 0)
  ),
  chains = 4, cores = 4, iter = 5000, warmup = 2500,
  control = list(
    adapt_delta = 0.999,
    max_treedepth = 50
  ),
  file = "models/fit_bdnf_hrv_time_adj.rds"
)

conditional_effects(fit_bdnf_hrv_time_adj)

fit_bdnf_hrv_freq_adj <- brm(
  formula = bdnf_hrv_freq_model,
  data = m_data,
  family = gaussian(),
  prior = c(
    set_prior(prior = "normal(0,3)", class = "b"),
    set_prior(prior = "normal(0,3)", class = "sigma", lb = 0)
  ),
  chains = 4, cores = 4, iter = 5000, warmup = 2500,
  control = list(
    adapt_delta = 0.999,
    max_treedepth = 50
  ),
  file = "models/fit_bdnf_hrv_freq_adj.rds"
)

conditional_effects(fit_bdnf_hrv_freq_adj)
