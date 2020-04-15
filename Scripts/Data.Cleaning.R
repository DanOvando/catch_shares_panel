library(tidyverse)


WDB <- read_rds(here::here('data','edf_cs_ram_panel.rds')) %>%
  rename(ram = ram_region,
         fao = primary_fao_region_name,
         cat = isscaap,
         age = age_50_mat,
         max = max_length,
         multi = multiple_cs_progs)



WDB[is.na(WDB)] <- "."

foreign::write.dta(WDB, "data/WDB.dta")


asd <- WDB %>% group_by(stock_cs_id) %>%
  summarize(max = length(unique(age)))



WDB %>% filter(stock_cs_id ==)




length((unique(WDB$stock_cs_id)))
