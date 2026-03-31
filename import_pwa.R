library(here)
library(haven)
library(tidyverse)

data_folder <- here("Data", "Parenting With Anxiety")
list.files(data_folder)

data <- haven::read_dta(here(data_folder, "pwa_parents_share.dta"))
processed_data <- data |> 
  select(
    id, 
    intervention, 
    sex = birthgender_demog,
    age_grp,
    child_age_rnd,
    indexchildgender_ch,
    ptpanxietytx_t1_demog, # parent anxiety treatment
    childanxietytx_t1q88_ch, # child anxiety treatment
    childdevdis_ch, # developmental disability
    psc_score_t1,
    scared_a_overall_score_t1, # has subscales
    #scas_all_pa_score_pos_t1, # high levelsof missing data
    scas_all_sa_score_pos_t1,
    scas_all_pif_score_pos_t1,
    scas_all_sp_score_pos_t1,
    scas_all_oc_score_pos_t1,
    scas_all_ga_score_pos_t1,
    scas_score_all_stand_t1, # has subscales
    cpbq_cb_score_t1,
    cpbq_o_score_t1,
    cpbq_w_score_t1,
    cpbq_neg_score_t1,
    cpbq_nd_score_t1,
    cpbq_pd_score_t1,
    swemwbs_score_t1,
    scas_score_all_stand_t2,
    eq5dyp_6_t1_ch
  ) 

get_labels <- function(data){
  data %>% map_chr(~attributes(.)$label)
}

get_labels(processed_data)

processed_data |> saveRDS(here(data_folder, "pwa_data.rds"))
complete_data <- processed_data |> drop_na()

complete_data |> saveRDS(here(data_folder, "pwa_complete_data.rds"))