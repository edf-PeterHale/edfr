
# create MTS password data set
library(tidyverse)

mts_pwd <- read_rds('C:/Users/hale05p/OneDrive - EDF/Projects/MTS/mts_pwd.rds')

mts_pwd_lookup <-
  rbind(
    mts_pwd |>
      filter(meterType == 'EDMIATLAS') |>
      filter(!is.na(plant_number), nchar(plant_number) > 5) |>
      mutate(chr = str_extract(plant_number, '(?<=E[0-9]{1,2})[A-Z]{1}')) |>
      mutate(chr = case_when(is.na(chr) ~ '0', TRUE ~ chr)) |>
      count(meterType,chr,password) |>
      group_by(meterType,chr) |>
      arrange(meterType,chr, desc(n)) |>
      edfr::add_prop() |>
      filter(row_number() <= 3, prop > 1) |>
      ungroup(),

    mts_pwd |>
      filter(grepl('^ELSTER',meterType)) |>
      mutate(
        chr = str_extract(serialNumber, '^[A-Z]{1,2}')
        #sn2 = str_extract(serialNumber, '(?<=[A-Z]{1,2}[0-9]{1,2})[A-Z]+')
      ) |>
      mutate(chr = case_when(is.na(chr) ~ '0', TRUE ~ chr)) |>
      count(meterType,chr,password) |>
      group_by(meterType,chr) |>
      arrange(meterType,chr, desc(n)) |>
      edfr::add_prop() |>
      filter(row_number() <= 10, prop > 1, n > 10) |>
      ungroup(),

    mts_pwd |>
      filter(meterType == 'EMLITECOP10') |>
      mutate(chr = ifelse(str_detect(serialNumber,'D'),'D','0')) |>
      count(meterType,chr,password) |>
      group_by(meterType,chr) |>
      arrange(meterType,chr, desc(n)) |>
      edfr::add_prop() |>
      filter(row_number() <= 3, prop > 1) |>
      ungroup(),

    mts_pwd |>
      filter(meterType == 'LG_DLMS') |>
      mutate(chr = '0') |>
      count(meterType,chr,password) |>
      group_by(meterType,chr) |>
      arrange(meterType,chr, desc(n)) |>
      edfr::add_prop() |>
      filter(row_number() <= 3, prop > 1) |>
      ungroup(),

    mts_pwd |>
      filter(meterType == 'PREMIERPRI') |>
      mutate(chr = str_extract(serialNumber, '[A-Z]{1}')) |>
      count(meterType,chr,password) |>
      group_by(meterType,chr) |>
      arrange(meterType,chr, desc(n)) |>
      edfr::add_prop() |>
      filter(row_number() <= 3, prop > 1) |>
      ungroup(),

    mts_pwd |>
      filter(grepl('^CEWE',meterType)) |>
      mutate(chr = str_extract(serialNumber, '^[A-Z]{2}')) |>
      mutate(chr = case_when(is.na(chr) ~ '0', TRUE ~ chr)) |>
      count(meterType,chr,password) |>
      group_by(meterType,chr) |>
      arrange(meterType,chr, desc(n)) |>
      edfr::add_prop() |>
      filter(row_number() <= 3, prop > 1) |>
      ungroup(),

    mts_pwd |>
      filter(grepl('^ISKRA',meterType)) |>
      mutate(chr = '0') |>
      count(meterType,chr,password) |>
      group_by(meterType,chr) |>
      arrange(meterType,chr, desc(n)) |>
      edfr::add_prop() |>
      filter(row_number() <= 3, prop > 1) |>
      ungroup()
  ) |>
  group_by(meterType, chr) |>
  arrange(meterType, chr, desc(n)) |>
  mutate(rn = row_number()) |>
  ungroup()

usethis::use_data(mts_pwd_lookup)

