library(tidyverse)


WDB <- read_rds(here::here('data','edf_cs_ram_panel.rds')) %>%
  rename(TAC = catch,
         ram = ram_region,
         fao = primary_fao_region_name,
         cat = isscaap,
         age = age_50_mat,
         max = max_length)



WDB[is.na(WDB)] <- "."

foreign::write.dta(WDB, "data/WDB.dta")








