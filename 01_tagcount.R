#load packages
library(tidyverse)

#load files
tag_count <- read_csv("all_tagcount.csv")
types <- read_csv("2_types.csv")
nominalization <- read_csv("3_nominalization.csv")
linking <- read_csv("4_linking.csv")
occ <- read_csv("5_occ_count.csv")

#tag count clean up

tag_count <- tag_count %>% 
  filter(as_written != 'as written') %>% 
  mutate(CALP_grade = case_when(CALP >= 4 ~ "Above", CALP <=3.5 ~ "Below", CALP < 4 & CALP >3.5 ~ "Average"))


#keep only raw counts
occ <- occ %>% 
  select(file, occ_count)

#join all files except tag count because the of the file name
scripts_count <- types %>% 
  left_join(nominalization, by = "file") %>% 
  left_join(linking, by = "file") %>% 
  left_join(occ, by = "file") %>% 
  select(file, nn, vb, adj, suffixes, conv, occ_count) %>% 
  mutate(file = tolower(file))



#select features on tag_count and change the norming to a 100
tag_count <- tag_count %>% 
  mutate(adv_total = emphatic + amplifr + hedge +adv + adv_time + adv_place + adv_down) %>% 
  mutate(jj_that = th_jj_att + th_jj_fact + th_jj_likely) %>%
  mutate(verb_wh = wh_comm_vb + wh_att_vb + wh_fact_vb + wh_likely_vb) %>%
  mutate(advl_clauses =  sub_conj_cond + sub_conj_caus + sub_conj_othr) %>% 
  select("file", nn_all, vb_all, adv_total, prep, jj_attr, jj_pred,
         th_vb, jj_that, verb_wh, advl_clauses, vb_progress,
         passive_all,coord_conj_cls, pro_1, pro_2, pro_3,
         nn_premod, that_rel, wh_rel_all, word_count,
         year, modality, register, child_ID, CALP, CALP_grade) %>% 
  mutate(nn_all = nn_all*.10) %>% 
  mutate(vb_all = vb_all*.10) %>% 
  mutate(adv_total = adv_total*.10) %>% 
  mutate(prep = prep*.10) %>% 
  mutate(jj_attr = jj_attr*.10) %>% 
  mutate(jj_pred = jj_pred*.10) %>% 
  mutate(th_vb = th_vb*.10) %>% 
  mutate(jj_that = jj_that*.10) %>% 
  mutate(verb_wh = verb_wh*.10) %>% 
  mutate(advl_clauses = advl_clauses*.10) %>% 
  mutate(vb_progress = vb_progress*.10) %>% 
  mutate(passive_all = passive_all *.10) %>%
  mutate(coord_conj_cls = coord_conj_cls *.10) %>%
  mutate(pro_1 = pro_1*.10) %>% 
  mutate(pro_2 = pro_2*.10) %>% 
  mutate(pro_3 = pro_3*.10) %>% 
  mutate(nn_premod = nn_premod*.10) %>% 
  mutate(that_rel = that_rel *.10) %>%
  mutate(wh_rel_all = wh_rel_all *.10)

##Join script count and tag count
all_counts <- tag_count %>%
  inner_join(scripts_count, by = "file") %>% 
  mutate(nn_type = nn) %>% 
  mutate(vb_type = vb) %>%
  mutate(adj_type = adj) %>% 
  mutate(suffixes_norm = ((suffixes/word_count)*100)) %>% 
  mutate(suffixes_norm = round(suffixes_norm, 2)) %>% 
  mutate(linking_conv_norm = ((conv/word_count)*100)) %>% 
  mutate(linking_conv_norm = round(linking_conv_norm, 2)) %>% 
  mutate(occ_norm = ((occ_count/word_count)*100)) %>% 
  mutate(occ_norm = round(occ_norm, 2)) %>% 
  select("file", nn_all, vb_all, adv_total, prep, jj_attr, jj_pred,
         th_vb, jj_that, verb_wh, advl_clauses, vb_progress,
         passive_all,coord_conj_cls, pro_1, pro_2, pro_3,
         nn_premod, that_rel, wh_rel_all, nn_type, vb_type, adj_type, suffixes_norm,
         linking_conv_norm, occ_norm, word_count,
         year, modality, register, child_ID, CALP, CALP_grade) 
  

write.table(all_counts, file = "all_counts.csv", sep= ",", quote = FALSE, row.names = FALSE)

