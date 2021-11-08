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

#load file
all_counts<- read_csv("all_counts.csv")

#delete average students
all_counts <- all_counts %>% 
  filter(CALP_grade == "Above"|CALP_grade == "Below") %>% 
  filter(year == "2"|year == "3")

#Year
mode <- describeBy(all_counts, group = "modality")
#Print table for year
write.table(mode[["Oral"]], file = "oral.csv", sep= ",", quote = FALSE, row.names = FALSE)
write.table(mode[["Written"]], file = "written.csv", sep= ",", quote = FALSE, row.names = FALSE)


#CALP_grade
grade <- describeBy(all_counts, group = "CALP_grade")
write.table(grade[["Above"]], file = "above.csv", sep= ",", quote = FALSE, row.names = FALSE)
write.table(grade[["Average"]], file = "averager.csv", sep= ",", quote = FALSE, row.names = FALSE)
write.table(grade[["Below"]], file = "below.csv", sep= ",", quote = FALSE, row.names = FALSE)

# register
register <- describeBy(all_counts, group = "register")
write.table(register[["Expository"]], file = "expository.csv", sep= ",", quote = FALSE, row.names = FALSE)
write.table(register[["Narrative"]], file = "narrative.csv", sep= ",", quote = FALSE, row.names = FALSE)


#year*grade
grade_year_register <- describeBy(all_counts, list(all_counts$CALP_grade, all_counts$modality, all_counts$register))
dt_list <- map(grade_year_register, as.data.table)
dt <- rbindlist(dt_list, fill = TRUE, idcol = T)
write.table(dt, file = "grade_mode_register.csv", sep= ",", quote = FALSE, row.names = FALSE)
