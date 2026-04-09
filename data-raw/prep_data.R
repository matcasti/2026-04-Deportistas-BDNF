
# Prepare workspace -------------------------------------------------------

## Load libraries
library(data.table)

## Load data
data_raw <- fread("data-raw/raw_data.csv")


# -------------------------------------------------------------------------

## Remove columns with only NAs
cols_to_preserve <- sapply(data_raw, function(x) !all(is.na(x)))
data_raw <- data_raw[, .SD, .SDcols = cols_to_preserve]

## Remove columns with single value
cols_to_preserve <- grep("complete", names(data_raw), invert = TRUE)
data_raw <- data_raw[, .SD, .SDcols = cols_to_preserve]

## Add sex
data_raw <- fread("data-raw/participants_sex.csv")[data_raw, on = "record_id"]

## Remove identification variables
data_raw[, `:=`(
  record_id = rleid(record_id),
  nombre = NULL, apellido = NULL, rut = NULL,
  correo = NULL, telefono = NULL, fecha_nacimiento = NULL,
  deporte = NULL
)][]


# -------------------------------------------------------------------------

data_raw[, `:=`(
  record_id = factor(record_id),
  sex = factor(sex, levels = c("M","F"), labels = c("Male", "Female"))
)][]

athletes <- copy(data_raw)

rm(data_raw, cols_to_preserve)

# -------------------------------------------------------------------------

save(athletes, file = "data/athletes.RData")

