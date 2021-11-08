library(tidyverse)
library(dplyr)
library(plyr)

##Load files for oral corpus
tag_count_oral <- read_csv("1_oral_tagcount.csv") %>% 
  mutate(file = tolower(file)) %>% 
  filter(word_count > 50)

tag_count_writte <- read_csv("1_written_tagcount.csv") %>% 
  mutate(file = tolower(file)) %>% 
  filter(word_count > 30)

tag_count <- tag_count_writte %>% 
  full_join(tag_count_oral)

documentation <- read_csv("ALPS_Documentation.csv") %>% 
  mutate(file = tolower(file))

#Join files for oral corpus
tag_count_all <- tag_count %>% 
  left_join(documentation)



#write out tag count with documentation
write.table(tag_count_all, file = "all_tagcount.csv", sep= ",", quote = FALSE, row.names = FALSE)
