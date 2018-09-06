library(dplyr)


Cucurbita <- read.csv("E:\\DEVELOP\\ars\\cucurbita\\orginalData\\Cucurbita_total_2018_8_31 - Cucurbita.csv")


setwd("E:\\DEVELOP\\ars\\cucurbita\\analysisData")

glimpse(Cucurbita)
View(Cucurbita)
names(Cucurbita)

startRow <- nrow(Cucurbita)
#remove features that do not have a lat long 
cucurbita <- Cucurbita %>%
  filter(!is.na(latitude) & !is.na(longitude)) %>% 
  group_by(Taxon_final) %>%
  filter(improvement %in% c('wild', 'WILD'))
  distinct()
endRow <- nrow(cucurbita)
print(paste("A total of ", startRow, " occurances were collected. Of which ", endRow, " contained the above assumptions" ))



counts <- cucurbita %>% 
  group_by(Taxon_final) %>%
  summarise(total = n()) %>%
  arrange(desc(total))
View(counts)


cucurbitaSet1 <- filter(cucurbita, Taxon_final %in% c("Cucurbita_foetidissima","Cucurbita_lundelliana"))
cucurbitaSet2 <- filter(cucurbita, Taxon_final %in% c("Cucurbita_palmata","Cucurbita_argyrosperma_subsp._sororia", "Cucurbita_okeechobeensis_subsp._martinezii"))
cucurbitaSet3 <- filter(cucurbita, !Taxon_final %in% c("Cucurbita_foetidissima","Cucurbita_lundelliana","Cucurbita_palmata","Cucurbita_argyrosperma_subsp._sororia",
                                                       "Cucurbita_okeechobeensis_subsp._martinezii", "Cucurbita_maxima","Cucurbita_ficifolia", "Cucurbita_moschata",
                                                       "Cucurbita_pepo", "Cucurbita_pepo_subsp._ovifera", "Cucurbita_pepo_subsp._ovifera_var._ovifera", 
                                                       "Cucurbita_pepo_subsp._pepo", "Cucurbita_argyrosperma", "Cucurbita_argyrosperma_subsp._argyrosperma"))

glimpse(cucurbitaSet3)

write.csv(cucurbita, file = "cucurbitaAllWild.csv")

write.csv(cucurbitaSet1, file = "cucurbitaWildSet1.csv")
write.csv(cucurbitaSet2, file = "cucurbitaWildSet2.csv")
write.csv(cucurbitaSet3, file = "cucurbitaWildSet3.csv")
