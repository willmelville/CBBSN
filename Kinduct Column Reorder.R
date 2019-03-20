library(dplyr)
library(tidyr)
library(readr)
library(readxl)
library(reshape2)
require(reshape)
library(tibble)

#Read File
Data <- read_xlsx("~/Downloads/CBScout-Export-Full.xlsx")
Data = separate(data = Data, col = Name, into = c("Last", "First"), sep = "\\, ")
n<-dim(Data)[1]
Data<-Data[1:(n-1),]

#Reorder vars according to import sheet (Column Names were being fussy,
#so just reordered by number)
KinductHitter <- Data[c(3,2,1,24,84,73,25,
                        27,53,118,74,75,8,108,
                        68,67,38,13,11,12,7,72,
                        116,54,78,87,76,16,60,66,102,
                        23,100,65,101,22,99,110,
                        50,46,48,51,47,49,4,107,
                        31,82,62,17,59,32,5,40,115,
                        81,83,39,64)]
KinductPitcher <- Data[c(3,2,1,24,84,73,25,
                         27,53,117,74,75,108,8,
                         68,67,38,63,55,79,88,116,
                         90,92,89,91,61,41,34,109,
                         71,93,6,33,56,57,58,29,28,
                         30,112,96,19,44,15,14,10,
                         111,95,18,43,106,105,104,
                         114,98,21,52,37,36,35,113,97,
                         20,45,82,62,17,70,32,5,115,
                         81,83,39,64)]

#Removes all pitchers from hitter df
KinductHitter <- KinductHitter %>%
  filter(!grepl('P', POSITION1))

#keeps only pitchers on pitcher df
KinductPitcher <- KinductPitcher %>% 
  filter(grepl('P', POSITION1))

#files are written as csv
write.csv(KinductHitter,"~/Desktop/KinductHitter.csv")
write.csv(KinductPitcher,"~/Desktop/KinductPitcher.csv")
