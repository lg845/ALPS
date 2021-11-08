##Load libraries
library(tidyverse)
library(dplyr)
library(plyr)
library(psych)
library(ggplot2)
library(pwr2)
library(jsonlite)
library(purrr)
library(data.table)

#Load all counts (see 01_tagcount)
all_counts<- read_csv("all_counts.csv")


#delete average students
all_counts <- all_counts %>% 
  filter(CALP_grade == "Above"|CALP_grade == "Below") %>% 
  filter(year == "2"|year == "3")


##ANOVAs for spoken

#that_rel
interaction_rel_that = aov(that_rel ~ modality + CALP_grade + register + 
                             modality:CALP_grade:register, data=all_counts)
summary(interaction_rel_that)
effectsize::eta_squared(interaction_rel_that, partial = FALSE)
summary(lm(that_rel ~ modality*CALP_grade*register, data=all_counts))

#suffixes
suffixes = aov(suffixes_norm ~ modality + CALP_grade + register + 
                 modality:CALP_grade:register, data=all_counts)
summary(suffixes)
effectsize::eta_squared(suffixes, partial = FALSE)
summary(lm(suffixes_norm ~ modality*CALP_grade*register, data=all_counts))


#wh_rel
interaction_rel_wh = aov(wh_rel_all ~ modality + CALP_grade + register 
                         + modality:CALP_grade:register, data=all_counts)
summary(interaction_rel_wh)
effectsize::eta_squared(interaction_rel_wh, partial = FALSE)
summary(lm(wh_rel_all ~ modality*CALP_grade*register, data=all_counts))

#zero_rel
interaction_rel_zero = aov(zero_rel_norm ~ modality + CALP_grade + register 
                           + modality:CALP_grade:register, data=all_counts)
summary(interaction_rel_zero)
effectsize::eta_squared(interaction_rel_zero, partial = FALSE)
summary(lm(zero_rel_norm ~ modality*CALP_grade*register, data=all_counts))

#types of nouns
interaction_nn_types = aov(nn_type ~ modality + CALP_grade + register 
                           + modality:CALP_grade:register, data=all_counts)
summary(interaction_nn_types)
effectsize::eta_squared(interaction_nn_types, partial = FALSE)
summary(lm(nn_type ~ modality*CALP_grade*register, data=all_counts))


#types of verbs
interaction_vb_types = aov(vb_type ~ modality + CALP_grade + register 
                           + modality:CALP_grade:register, data=all_counts)
summary(interaction_vb_types)
effectsize::eta_squared(interaction_vb_types, partial = FALSE)
summary(lm(vb_type ~ modality*CALP_grade*register, data=all_counts))

#types of adjectives
interaction_jj_types = aov(adj_type ~ modality + CALP_grade + register 
                           + modality:CALP_grade:register, data=all_counts)
summary(interaction_jj_types)
effectsize::eta_squared(interaction_jj_types, partial = FALSE)
summary(lm(adj_type ~ modality*CALP_grade*register, data=all_counts))

# first person pronoun
interaction_pro_1 = aov(pro_1 ~ modality + CALP_grade + register 
                        + modality:CALP_grade:register, data=all_counts)
summary(interaction_pro_1)
effectsize::eta_squared(interaction_pro_1, partial = FALSE)
summary(lm(pro_1 ~ modality*CALP_grade*register, data=all_counts))


# second person pronoun
interaction_pro_2 = aov(pro_2 ~ modality + CALP_grade + register 
                        + modality:CALP_grade:register, data=all_counts)
summary(interaction_pro_2)
effectsize::eta_squared(interaction_pro_2, partial = FALSE)
summary(lm(pro_2 ~ modality*CALP_grade*register, data=all_counts))

# third person pronoun
interaction_pro_3 = aov(pro_3 ~ modality + CALP_grade + register 
                        + modality:CALP_grade:register, data=all_counts)
summary(interaction_pro_3)
effectsize::eta_squared(interaction_pro_3, partial = FALSE)
summary(lm(pro_3 ~ modality*CALP_grade*register, data=all_counts))

# nominalizations
interaction_nom_norm = aov(nom_norm ~ modality + CALP_grade + register 
                           + modality:CALP_grade:register, data=all_counts)
summary(interaction_nom_norm)
effectsize::eta_squared(interaction_nom_norm, partial = FALSE)
summary(lm(nom_norm ~ modality*CALP_grade*register, data=all_counts))

# occ
interaction_occ_norm = aov(occ_norm ~ modality + CALP_grade + register 
                           + modality:CALP_grade:register, data=all_counts)
summary(interaction_occ_norm)
effectsize::eta_squared(interaction_occ_norm, partial = FALSE)
summary(lm(occ_norm ~ modality*CALP_grade*register, data=all_counts))

# premodifying nouns
interaction_nn_premod = aov(nn_premod ~ modality + CALP_grade + register 
                            + modality:CALP_grade:register, data=all_counts)
summary(interaction_nn_premod)
effectsize::eta_squared(interaction_nn_premod, partial = FALSE)
summary(lm(nn_premod ~ modality*CALP_grade*register, data=all_counts))

#linking adverbials conversation
interaction_linking_conv= aov(linking_conv_norm ~ modality + CALP_grade + register 
                              + modality:CALP_grade:register, data=all_counts)
summary(interaction_linking_conv)
effectsize::eta_squared(interaction_linking_conv, partial = FALSE)
summary(lm(linking_conv_norm ~ modality*CALP_grade*register, data=all_counts))

# passives
interaction_passive_all = aov(passive_all ~ modality + CALP_grade + register 
                              + modality:CALP_grade:register, data=all_counts)
summary(interaction_passive_all)
effectsize::eta_squared(interaction_passive_all, partial = FALSE)
summary(lm(passive_all ~ modality*CALP_grade*register, data=all_counts))

# clausal coordination
interaction_coord_conj_cls= aov(coord_conj_cls ~ modality + CALP_grade + register 
                                + modality:CALP_grade:register, data=all_counts)
summary(interaction_coord_conj_cls)
effectsize::eta_squared(interaction_coord_conj_cls, partial = FALSE)
summary(lm(coord_conj_cls ~ modality*CALP_grade*register, data=all_counts))

# that relative clauses
interaction_that_rel = aov(that_rel ~ modality + CALP_grade + register 
                           + modality:CALP_grade:register, data=all_counts)
summary(interaction_that_rel)
effectsize::eta_squared(interaction_that_rel, partial = FALSE)
summary(lm(that_rel ~ modality*CALP_grade*register,  data=all_counts))

# progressive aspect
interaction_vb_progress = aov(vb_progress ~ modality + CALP_grade + register 
                              + modality:CALP_grade:register, data=all_counts)
summary(interaction_vb_progress)
effectsize::eta_squared(interaction_vb_progress, partial = FALSE)
summary(lm(vb_progress ~ modality*CALP_grade*register,  data=all_counts))

# wh verb complement clauses
interaction_verb_wh = aov(verb_wh ~ modality + CALP_grade + register 
                          + modality:CALP_grade:register, data=all_counts)
summary(interaction_verb_wh)
effectsize::eta_squared(interaction_verb_wh, partial = FALSE)
summary(lm(verb_wh ~ modality*CALP_grade*register,  data=all_counts))

#all advl clauses
interaction_advl_clauses = aov(advl_clauses ~ modality + CALP_grade + register 
                               + modality:CALP_grade:register, data=all_counts)
summary(interaction_advl_clauses)
effectsize::eta_squared(interaction_advl_clauses, partial = FALSE)
summary(lm(advl_clauses ~ modality*CALP_grade*register, data=all_counts))

# that verb complement clauses
interaction_th_vb = aov(th_vb ~ modality + CALP_grade + register 
                        + modality:CALP_grade:register, data=all_counts)
summary(interaction_th_vb)
effectsize::eta_squared(interaction_th_vb, partial = FALSE)
summary(lm(th_vb ~ modality*CALP_grade*register, data=all_counts))

# that adjective complement clauses
interaction_jj_that = aov(jj_that~ modality + CALP_grade + register 
                          + modality:CALP_grade:register, data=all_counts)
summary(interaction_jj_that)
effectsize::eta_squared(interaction_jj_that, partial = FALSE)
summary(lm(jj_that ~ modality*CALP_grade*register, data=all_counts))

# nouns
interaction_nn_all = aov(nn_all ~ modality + CALP_grade + register 
                         + modality:CALP_grade:register, data=all_counts)
summary(interaction_nn_all)
effectsize::eta_squared(interaction_nn_all, partial = FALSE)
summary(lm(nn_all ~ modality*CALP_grade*register, data=all_counts))

# verbs
interaction_vb_all = aov(vb_all ~ modality + CALP_grade + register 
                         + modality:CALP_grade:register, data=all_counts)
summary(interaction_vb_all)
effectsize::eta_squared(interaction_vb_all, partial = FALSE)
summary(lm(vb_all ~ modality*CALP_grade*register,  data=all_counts))

# all adverbs
interaction_adv_total = aov(adv_total ~ modality + CALP_grade + register 
                            + modality:CALP_grade:register, data=all_counts)
summary(interaction_adv_total)
effectsize::eta_squared(interaction_adv_total, partial = FALSE)
summary(lm(adv_total ~ modality*CALP_grade*register,  data=all_counts))

# prepositions
interaction_prep = aov(prep ~ modality + CALP_grade + register 
                       + modality:CALP_grade:register, data=all_counts)
summary(interaction_prep)
effectsize::eta_squared(interaction_prep, partial = FALSE)
summary(lm(prep ~ modality*CALP_grade*register, data=all_counts))

#attributive adjectives
interaction_jj_attr = aov(jj_attr ~ modality + CALP_grade + register 
                          + modality:CALP_grade:register, data=all_counts)
summary(interaction_jj_attr)
effectsize::eta_squared(interaction_jj_attr, partial = FALSE)
summary(lm(jj_attr ~ modality*CALP_grade*register, data=all_counts))

# predicative adjectives
interaction_jj_pred = aov(jj_pred ~ modality + CALP_grade + register 
                          + modality:CALP_grade:register, data=all_counts)
summary(interaction_jj_pred)
effectsize::eta_squared(interaction_jj_pred, partial = FALSE)
summary(lm(jj_pred ~ modality*CALP_grade*register, data=all_counts))

