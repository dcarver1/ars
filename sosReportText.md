---
title: 'Seeds of Success - Diversity and impact of collections conserved in the USDA
  National Plant Germplasm System'
author: Daniel Carver, Colin Khoury, Stephanie Greene, (potentially additional authors
  from Pullman, BLM)
date: "June 22, 2018"
output:
  html_document:
    code_folding: hide
    df_print: paged
    highlight: tango
    number_sections: yes
    theme: yeti
    toc: yes
    toc_depth: 2
    toc_float:
      collapsed: no
      smooth_scroll: no
  pdf_document:
    toc: yes
  word_document:
    toc: yes
---

```{r, echo=FALSE, message=FALSE, warning=FALSE}
#import all necessary libraries
#install.packages("dplyr", "lemon", "ggplot2", "plyr",'tidyr' #Keep this commented out to knit: look into how to get around this.
#if(!require(installr)) { install.packages("installr"); require(installr)} #load / install+load installr
#install.pandoc()
#install.packages('knitr')
library(dplyr)
#library(lemon)
library(ggplot2)
library(plyr)
library(tidyr)
#install.packages('devtools')
#library(devtools)
#install_version("rmarkdown",version=1.8)

```

# Abstract {-}

Summarize the relationship between the BLM Seeds Of Success(SOS) program and the USDA ARS division. These two organizations are leading the nation in collecting, conserving, and preserving the native plants present on public lands.

# Introduction
```{r echo=FALSE, tidy=TRUE, message=FALSE, warning=FALSE}
#import SOS data
sosData <- read.csv("H:\\SOS_Project\\analysisData\\SOSdata_20180614_forARS.csv")

#Find the total number of recorded entries
totalSamples <- nrow(sosData)

```


The Seeds of Success program was established in 2001 to facilitate the collection of native seeds. To make use of the seeds collected, the SOS program partners with land management agencies to support the re-vegetation of areas, academic and professional partners to promote and advance scientific research, and the United States Department of Agriculture for the long term preservation of species genetic diversity.

 - fill this out to capture aims

 - continue to add content to this as I learn more; ask Colin, Stephanie, and others to add to this background


```{r echo=FALSE, tidy=TRUE, message=FALSE, warning=FALSE , caption="Number of Collections per Family from the SOS program." }
# histogram with added parameters
ggplot(sosData, aes(COLL_YR))+
  geom_histogram(binwidth = 1,
                 col="white",
                 fill="blue",
                 alpha = 0.5) +
  labs(title = "Number of Collections")+
  labs(x = "Collection Year", y= "Number of Accessions") +
  xlim(c(2000,2018))+
  ylim(c(0,3500))+
  scale_x_continuous(breaks = seq(2000,2018, 2))+
  scale_y_continuous(breaks = seq(0,3500, 500))+
  theme_minimal()

```


Detailed collection methodologies mean that SOS accessions have information about the species collected, the region it was collected from, the land management agency where that collection occurred, and positional data in the form of latitude, longitude, and elevation. This data provides information about the seeds collected but does not tell us anything about what happened to the seeds after the collection occurs. The article is meant to create those connections and tell the full story of how these seeds are providing services to the landscape and understanding of the species.
This will be done by accessing how many of these collections represent economically useful and/or crop wild relatives at both the national and international scale. The relationship between the SOS collections and the ARS collection will be examined to determine how many collections are in long term storage and who is using the seeds outside of the ARS and for what purpose.

- this can be added to. It's the first time we talk about CWR and there need more of an introductions Specific the two datasets used

# Methods
- data acquisition
  - SOS BLM: Information regarding the SOS collection was provide as a csv file by the Seeds of Success Program National Collection Curator in June of 2018. This dataset is updated as more field collecting occurs. All data from the years 2017 and earlier is assumed to be correct and complete. The data collected by the SOS program contains a rich set of specific information regarding the plant from which seed is collected as well as the geography region and ecosystem that the plant was found with. **Is the blm data a public dataset? How can people access this data**
  - GRIN GLOBAL : The USDA's National Plant Germplasm System has utilized the Germplasm Resource Information Network(GRIN) to provide public  access to informing regarding the accession maintained by the USDA. The data is public available through the desktop software program, [GRIN-Global](https://www.grin-global.org/). This data can also be accessed through a web site hosted by Crop Trust, Biodiversity International, and the USDA that allows for the querying of the GRIN-global database. The website can be found [here](https://npgsweb.ars-grin.gov/gringlobal/taxon/taxonomysearch.aspx) All datasets containing information from on the USDA accession were retrieved from the GRIN global databased and stored as csvs.
  - Pullman office: Before assessing the datasets a meeting of individuals involved with the management of the SOS accession was held to identify the primary questions, define the process of transferring the collections between the agencies, and understand the processing and management of the collections once they enter the USDA long term storage system. **should we reference some of the individuals from pullman here**

- data processing
  - rmarkdown : The datasets were processed, joined, and query using the statistically programming language R. Specific libraries that were use include: plyr, tidyr, dplyr, and ggplot2.  The report is compiled as an RMarkdown document to help with the reproducibility of the content as the relationship between the two organizations continues to develop. **will this stay an in house document or will it be make public.**


# Results

## Diversity
The SOS program collects a diverse
```{r echo=FALSE, tidy=TRUE, message=FALSE, warning=FALSE}
#Determine the total number of unique families collect and the number of collection in each family
uniqueFam <- dplyr::summarise(sosData,n_distinct(sosData$FAMILY))
uniqueFam1 <- dplyr::count(sosData,FAMILY) #keep this in hear incase we want to display it

## Determine the total number of unique GENUS collect and the number of collection in each GENUS
uniqueGen <-  dplyr::summarise(sosData,n_distinct(sosData$GENUS))
uniqueGen1 <- dplyr::count(sosData, GENUS)

## Determine the total number of unique SPECIES collect and the number of collection in each SPECIES
uniqueSpe <-  dplyr::summarise(sosData,n_distinct(sosData$SPECIES))
uniqueSpe1 <- dplyr::count(sosData, SPECIES)

uniqueTaxa <- summarise(sosData,n_distinct(sosData$NAME))
uniqueTaxa1 <- dplyr::count(sosData, NAME)

## DEfeine row and column names
labelsRow1 <- c("SOS Collection")
labelsCol1 <- c('All Accessions', "Total Number of Families", "Total Number of Genera", "Total Number of Taxa")

#Initiate an empty dataframe
sosSummary <- data.frame()

# create the first row of the dataframe
sosDataSum <- c(totalSamples, uniqueFam, uniqueGen, uniqueTaxa)

#bind the two df together
sosSummary <- tbl_df(rbind(sosSummary, sosDataSum))
#define column names and row names
colnames(sosSummary) <- labelsCol1
rownames(sosSummary) <- labelsRow1
sosSummary
```




This Seeds of Success program has collected a total of `r totalSamples` seed samples. Of which `r uniqueFam[1,]` plant families
`r uniqueGen[1,]`  plant genus and `r uniqueSpe[1,]` unique sub species are represented.

- this are interesting numbers but some knowledge on how they relate to the total number of species present in the country might make the factoids stand out some more



An accession is a collection of seeds from a single sampling location. There are enough seeds in each accession to split the collection for short term storage, long term preservation, and distribution. Out of the `r uniqueFam[1,]` families collected half of the total accessions collected come from just 5 families. The commonality and number of species represented by the top 5 collected families may explain this observed relationship.

```{r echo=FALSE, tidy=TRUE, message=FALSE, warning=FALSE, caption="Number of Collections per Family from the SOS program.", rows.print=10}
families <- dplyr::arrange(uniqueFam1, desc(n))
colnames(families) <- c("Family", "Total Number of Accessions")
families

```



## Crop wild relatives and other economic plants"

The importance of this collection is increased by the fact that many of the seed taxa that were collected by the SOS program are defined as either Crop Wild Relatives or World Economic Plants. Crop Wild Relatives (CWR) are the genetic predecessors of modern crops and are found throughout the diverse ecological and bio physiological environments of the world. The variability in growing conditions and potential geographic isolation between stands has shown that CWRs contain a higher level of genetic diversity (*reference this*) . The subsequent traits found within CWR are used to add to the resistance, quality, and breeding efficiency of modern crops (*reference this*).

- add a bit about the various economic use categories define by GRIN

- talk about the WEP data set; how it was developed and why we are using it
*get reference for the WEP dataset received from Daniel*.

- expand upon the k13 data source a bit to explain why we are using it.

- add genus by accession - CWR WUS WEP top 20 or 50 chart/table


This study is using dataset complied by  Khoury et al 2013 and Wiersema and Leon 20?? to identify species that are considered CWR, WUS, or WEP. These dataset will be joined to the SOS dataset based on taxa name to identify how many of the SOS accession are considered CWR, WUS, and or WEP. The chart below is defining the primary acronyms that are used in the remainder of this document

```{r echo=FALSE, tidy=TRUE, message=FALSE, warning=FALSE}
#aycromn referecne dataframe
#acronymDF <- data.frame()

# create the first column of the dataframe
abbrevNames <- c("SOS", "GRIN", "NLGRP", "WUS", "K13", "CWR", "WEP")
#create the meaning of acronym
nameMeaninng <- c("Seeds of Success", "Germplasm Resource Information Network", "National Laboratory Genetic Resource Presevation", "Wild Utilize Species", "Khoury et al 2013", "Crop Wild Relative", "World Economic Plants")

#define column names and row names
acronymDF <-data_frame("Acronym" = abbrevNames, "Meaning" = nameMeaninng)
acronymDF

```




```{r echo=FALSE, tidy=TRUE, message=FALSE, warning=FALSE}

###
# Create a summary chart showing the total number of accession, total taxa, # of CWR NA, # eco NA, # of economic WEP
# this may be added to also include the data about what's managed by the usda and what's at the NLGRP
#

# Replace the name column of the sos data so that the "ssp." notation is replaced with "subsp." as defined
# by the grin Data base
#import SOS data
sosData <- read.csv("H:\\SOS_Project\\analysisData\\SOSdata_20180614_forARS.csv")
# created a new column that has the same col name as the K13 data set. I will use the col to join on
sosData$Taxon <- sosData$NAME

#detemine the total number of taxon in dataset
sosTotalUnique <- uniqueTaxa

# read in the K13 data
K13Data <- read.csv("H:\\SOS_Project\\analysisData\\CWR_US_inventory_2013_7_10.csv")
#detemine the total number of taxon in dataset
K13TotalUnique <- K13Data %>% n_distinct("Taxon")
# join the data sets and trim the data so that taxon that do not have values for the K13 specific data columns are dropped.
trimCombinedData <- left_join(sosData, K13Data, by='Taxon', type='left', match='all') %>%
  filter(!is.na(Taxon_w_author))

typeSum <- trimCombinedData %>%
  group_by(Type) %>%
  dplyr::summarise(uniqueNumber = n_distinct(Taxon), percentType = signif(100*(n_distinct(Taxon) / totalSamples),3), uniqueGenus = n_distinct(GENUS))


###
# read in the WEP data and Rename the name column to match the newly created column from the SOS data
WEPData <- tbl_df(read.csv("H:\\SOS_Project\\analysisData\\EconomicUseCategoriesOfSpecies.csv")) %>%
  dplyr::rename(Taxon = name)

#Unique Join
### the WEP data has repeats of features if they have more then 1 economic use. I'm joining again here so the taxa are only represented once.
single <- WEPData %>%
  distinct(Taxon)

new1 <-left_join(single,WEPData, by="Taxon")


combinedData2a <- inner_join(sosData, new1, by='Taxon', type='left', match='all') %>%
  filter(!is.na(economic_usage_code)) %>%
  dplyr::summarise(uniqueNumber = n_distinct(Taxon), percentType = signif(100*(n_distinct(Taxon) / totalSamples),3),  uniqueGenus = n_distinct(GENUS)) %>%
  mutate(Type = "wep")

endDf <- bind_rows(typeSum, combinedData2a)

#calculate total number of species from each dataset
uniqueWEP <- endDf[[3,2]]
uniqueWUS <- endDf[[2,2]]
uniqueCWR <- endDf[[1,2]]
#percent of sos in this class per dataset
percentWEP<- endDf[[3,3]]
percentWUS <-endDf[[2,3]]
percentCWR <-endDf[[1,3]]
#total number of genus per dataset
genusWEP <- endDf[[3,4]]
genusWUS <- endDf[[2,4]]
genusCWR <- endDf[[1,4]]

```

The table below illustrates the diversity of genus and taxa represented with the various datasets. The SOS and K13 data sets reference plants found in **North America or US** the World Economic Plants is a world wide data set and hence has significantly more diversity. In the case of preservation it is important to understand the total diversity represented as well as the sample size of that diversity.

```{r echo=FALSE, tidy=TRUE, message=FALSE, warning=FALSE}

#Initiate an empty dataframe
allDataSummary <- data.frame()

# create the first row of the dataframe
sosData <- c( uniqueGen, uniqueSpe)

wusSamples <- K13Data %>% filter(Type=="WUS")
cwrSamples <-K13Data %>% filter(Type=="CWR")

# create K13 WEP/CWR
K13wus <- c( n_distinct(wusSamples$Genus), n_distinct(wusSamples$Taxon))
K13cwr <- c( n_distinct(cwrSamples$Genus), n_distinct(cwrSamples$Taxon))

### Just testing to relationship between
# cwrSamples %>%
#   group_by(Genus) %>%
#   dplyr::summarise(count = n()) %>%
#   arrange(desc(count))
#
# wusSamples %>%
#   group_by(Genus) %>%
#   dplyr::summarise(count = n()) %>%
#   arrange(desc(count))
#

## create same for world Economic plants takes some more work
# remove duplicates and separate based on full name into genus and species
wepSum <- WEPData %>% distinct(Taxon) %>% separate(Taxon, c("GENUS", "SPECIES"))
# subset data exclude all features with x as species
wepSum1 <- filter(wepSum, SPECIES != "x")
# preform the oppisite to pull all the avoids values out, needed a differtent method
wepX <- filter(WEPData, grepl(" x ", Taxon))
# seperate name then exclude xcolumn to construct a new dataframe
wepX1 <-  wepX %>% separate(Taxon, c("GENUS", "x", "SPECIES")) %>% select(GENUS, SPECIES)
# combine the two datasets to get a complete listing of genus and species
WEPgs <- bind_rows(wepSum1, wepX1)
# constuct a vector with the needed values
WEP <- c( as.numeric(n_distinct(WEPgs$GENUS)), as.numeric(n_distinct(WEPData$Taxon)))



#bind the two df together
dataSummary <- rbind(allDataSummary, sosData, K13wus, K13cwr, WEP)
#define column names and row names
colnames(dataSummary) <- c(  "Total Number of Genus", "Total Number of Species")
rownames(dataSummary) <- c("SOS", "WUS in K13", "CWR in K13", "WEP")
dataSummary
## I dont think I want to lose the row data by arranging it
#arrange(dataSummary, dataSummary$`Total Number of Genus`)


```

We can test that by observing what proportion of the accessions collected by SOS are classified are a Wild Utilized Species, Crop Wild Relative, or a World Economic Plant. The chart below shows the number of species that are found within the K13 and WEP databased and were collected by the SOS program as well as the proportion of the total SOS accessions. The high number of taxa collected and the low proportion of the accession imply that the SOS program is collection many of the WUS, CWR, and WEP species in low number of accessions.


```{r  echo=FALSE, tidy=TRUE, message=FALSE, warning=FALSE , caption="Summary of the SOS collection relative to Econmically Useful and Wild Crop Relatives.", rows.print=15}
#Initiate an empty dataframe
sosSummary2 <- data.frame()

# create the first row of the dataframe
sosCollection <- c(totalSamples, sosTotalUnique, uniqueWUS, percentWUS, uniqueCWR, percentCWR, uniqueWEP, percentWEP)

#bind the two df together
sosSummary2 <- rbind(sosSummary2, sosCollection)

#define column names and row names
rownames(sosSummary2) <- c("SOS Collection")
colnames(sosSummary2) <- c('Total Accessions', "Total Number Taxa", "Taxa that are WUS per K13", "Percent of SOS Accessions that are WUS per K13", "Taxa that are CWR per K13", "Percent of SOS Accessions that are CWR per K13", "Taxa that are WEP" , "Percentage of SOS Accessions that are WEP")

sosSummary2t <- t(sosSummary2)

### look up column that the unique number of taxa is being called on should be full name
### get the reference paper for WEP

genusWEP <- endDf[[3,4]]
genusWUS <- endDf[[2,4]]
genusCWR


# create the first row of the dataframe
sosCollection <- data.frame(totalSamples, sosTotalUnique, uniqueWUS, percentWUS, genusWUS, uniqueCWR, percentCWR, genusCWR, uniqueWEP, percentWEP, genusWEP)
#bind the two df together
sosSummary2 <- t(sosCollection)

#define column names and row names
colnames(sosSummary2) <- c("SOS Collection")
labels<- t(data.frame('Total Accessions', "Total Number Taxa", "Taxa that are WUS per K13", "Percent of SOS Accessions that are WUS per K13", "Genus that are WUS per K13", "Taxa that are CWR per K13", "Percent of SOS Accessions that are CWR per K13", "Genus that are CWR per K13","Taxa that are WEP" , "Percentage of SOS Accessions that are WEP", "Genus that are WEP"))

sosSummary2t <- bind_cols(tbl_df(labels), tbl_df(sosSummary2)) %>%
  dplyr::rename( label = "V1" )

### look up column that the unique number of taxa is being called on should be full name
### get the reference paper for WEP

sosSummary2t


```





## Conservation

The Seeds of Success program provides the boots on the ground effort in the collection of seed resources. The program partners with the Agricultural Research Service of the USDA to store, maintain, and distribute the seeds collected. The Pullman, Washington section of the ARS is the group responsible for the initial on boarding and entering of the seeds into the Genetic Resource Inventory Network (GRIN) as well as maintaining the seeds in environments that support preservation.
Just as was shown above the table below shows the relationship between the SOS accession that have made it into the GRIN global database and the WUS,CWR, and WEP species. Not all SOS accession make it into the ARS and GRIN systems as a result the total taxa and percent of SOS accession that are representative of a useful plant.


### stored within ARS system
```{r echo=FALSE, tidy=TRUE, message=FALSE, warning=FALSE , caption="Summary of SOS and GRIN Relative to CWR and WEP", rows.print=15}
# read in GRIN Accessions
grinData <- tbl_df(read.csv("H:\\SOS_Project\\analysisData\\sosAllAccessions.csv")) %>%
  mutate(NewTaxon = Taxon) %>%
  separate(NewTaxon, c("genus", "species", "other1", "Other2", "other3"))
glimpse(grinData)
# calcualte the total number of features and the total number of taxon
totalSamplesGRIN <- nrow(grinData)# why would these two numbers be different? Question for Renee
totalTaxon <- dplyr::n_distinct(grinData$Taxon)

# join the the GRIN data with the K13 Dataset
combinedData3 <- left_join(grinData, K13Data, by='Taxon', type='left', match='all') %>%
  filter(!is.na(Taxon_w_author))
names(combinedData3)
#group by WEP and CWR and derive number of taxon and percent of sos that are those taxa
typeSum <- combinedData3 %>%
  group_by(Type) %>%
  dplyr::summarise(uniqueNumber = n_distinct(Taxon), percentType = signif(100*(n_distinct(Taxon) / totalSamples),3), uniqueGenus = n_distinct(genus))
typeSum
#complete the process again for Wp Taxa
combinedData3a <- inner_join(grinData, new1, by='Taxon', type='left', match='all') %>%
  filter(!is.na(economic_usage_code))%>%
  dplyr::summarise(uniqueNumber = n_distinct(Taxon), percentType = signif(100*(n_distinct(Taxon) / totalSamples),3), uniqueGenus = n_distinct(genus)) %>%
  mutate(Type = "WEP")

combinedData3a

#generate a new df with all the values
endDf1 <- bind_rows(typeSum, combinedData3a)
endDf1
#calculate total number of species from each dataset
uniqueWEP1 <- endDf1[[3,2]]
uniqueWUS1 <- endDf1[[2,2]]
uniqueCWR1 <- endDf1[[1,2]]
#percent of sos in this class per dataset
percentWEP1<- endDf1[[3,3]]
percentWUS1 <-endDf1[[2,3]]
percentCWR1 <-endDf1[[1,3]]
#total number of genus per dataset
genusWEP1 <- endDf1[[3,4]]
genusWUS1 <- endDf1[[2,4]]
genusCWR1 <- endDf1[[1,4]]


# create the first row of the dataframe
grinCollection <- c(totalSamplesGRIN, totalTaxon, uniqueWUS1, percentWUS1, genusWUS1, uniqueCWR1, percentCWR1, genusCWR1, uniqueWEP1, percentWEP1, genusWEP1)

#bind the two df together
sosSummary3 <- bind_cols(sosSummary2t, tbl_df(grinCollection)) %>%
  dplyr::rename('SOS in GRIN Global' = value)

sosSummary3
```

The difference in the total number of accessions collected by SOS and the number of accessions recorded in  GRIN is significant. Part of this can be explained by a potential backlog of samples within the ARS and a lag in delivery time between collection and distribution. It generally takes a year from when the seeds are collect to when they are received by the ARS.

```{r}
sosData <- read.csv("H:\\SOS_Project\\analysisData\\SOSdata_20180614_forARS.csv")

# filter based on year collected and get a count on the number of unique accessions
sosPre2017 <- sosData %>%
  filter(COLL_YR < 2017) %>%
  nrow()

percentAtARS = signif(100*(totalSamplesGRIN/sosPre2017),4)


```

For example, a total of `r sosPre2017` accessions were brought into the SOS collection before 2017. The ARS is still processing SOS data from 2017. Therefore, `r percentAtARS` percent of the samples collected by SOS have been brought into the ARS and GRIN Global system.

This graph illustrates the date that a accession was collected by the SOS program, when it was sent to ARS, and when it was backed up at NSSL. There is generally a lag time between the collection period and when ARS receives the accessions. The bar graph does show both the actually collection time and the time at which the accessions made it to the ARS. The lag effect can be seen with between the SOS(green) and ARS received (grey) in 2018. No new SOS accessions have been added but the ARS is still receiving accessions that were collected in previous years. A similar relationship can be seen between the receiving of Accessions at the ARS and the backing up of those accessions at the NLGRP (blue). While many samples were received in 2017 non of them have made it into long term back up at this point.



```{r ,message=FALSE, warning=FALSE, echo=FALSE, caption="The grey histogram shows the total number of accessions collected by SOS. The green histograms shows what proportions of the collection has not made it into the ARS system."}
# # calculate the year the Accession was received
# grinDates <- grinData %>%
#   separate(Received.Date, c("M", "D", "Y"))%>%
#   mutate(year = as.numeric(Y))%>%
#   mutate(count = as.numeric(1))
# grinDates
# #filter for accession that are backed up
# nsslDates <-grinDates %>%
#   filter(Backup.Location.1 == "NSSL")
#
#
# # plot the three historgrams
# ggplot(sosData, aes(COLL_YR))+
#   geom_histogram(binwidth = 1,
#                  col="white",
#                  fill="dark green",
#                  alpha = 1) +
#   labs(title = "Accessions collected by SOS that are not in ARS or GRIN",
#        x = "Collection Year",
#        y= "Number of Accession Collected",
#        caption = "") +
#   xlim(c(2000,2018))+
#   ylim(c(0,3500))+
#   scale_x_continuous(breaks = seq(2000,2018, 2))+
#   scale_y_continuous(breaks = seq(0,3500, 500))+
#   theme_minimal()+
#   geom_histogram(data= grinDates,
#                  aes(grinDates$year),
#                  binwidth = 1,
#                  col="white",
#                  fill= "grey",
#                  alpha = 0.8) +
#   geom_histogram(data= nsslDates,
#                  aes(nsslDates$year),
#                  binwidth = 1,
#                  col="white",
#                  fill= "blue",
#                  alpha = 0.5)
#


#check out the site for more [information](https://stackoverflow.com/questions/6957549/overlaying-histograms-with-ggplot2-in-r)

### Add the NLGRP data
### the ticky thing here is that the dates in GRIN reflect when the date was received

```





### How much is at NLGRP for long term backup

Once within the ARS system the quality of the seed collections are accessed and samples that are deemed beneficial to preserve over an extended period of time are transfer to the National Laboratory for Genetic Resource Preservation in Fort Collins, Colorado. The NLRGP specializes in the long term storage of genetic resources. If a set of seeds is stored at NLGRP it can be assured that it is protect and preserved to the highest standard. The coordinating efforts to bring seeds into the long term storage is essential to the longevity of the genetic material store within the seeds.

```{r , echo=FALSE, tidy=TRUE, message=FALSE, warning=FALSE, rows.print=15}
#filter based on the "is backuped" column.
backedUp <- dplyr::filter(grinData, Is.Backed.Up. == 'Y' )
totaledBackedUp <-nrow(backedUp)

#filter based on the backup location being NLGRP
nlgrpData <- filter(backedUp, Backup.Location.1 == 'NSSL' )
totalBackedUp <- nrow(nlgrpData)

## Example of the backed up features that are missing a backup location????
#### does this mean an error in data entry, can we assume
#MissingBackup <- (backedUp$Backup.Location.1 )


#define the total number of species present in backup
totalTaxonNLGRP <- n_distinct(nlgrpData$Taxon)

# join the the GRIN data with the K13 Dataset
combinedData4 <- left_join(nlgrpData, K13Data, by='Taxon', type='left', match='all') %>%
  filter(!is.na(Taxon_w_author))

#group by WEP and CWR and derive number of taxon and percent of sos that are those taxa
typeSum4 <- combinedData4 %>%
  group_by(Type) %>%
  dplyr::summarise(uniqueNumber = n_distinct(Taxon), percentType = signif(100*(n_distinct(Taxon) / totalSamples),3),uniqueGenus = n_distinct(genus))

#complete the process again for Wp Taxa
combinedData4a <- inner_join(nlgrpData, new1, by='Taxon', type='left', match='all') %>%
  filter(!is.na(economic_usage_code)) %>%
  dplyr::summarise(uniqueNumber = n_distinct(Taxon), percentType = signif(100*(n_distinct(Taxon) / totalSamples),3),uniqueGenus = n_distinct(genus)) %>%
  mutate(Type = "WEP")

#generate a new df with all the values
endDf2 <- bind_rows(typeSum4, combinedData4a)

#calculate total number of species from each dataset
uniqueWEP2 <- endDf2[[3,2]]
uniqueWUS2 <- endDf2[[2,2]]
uniqueCWR2 <- endDf2[[1,2]]
#percent of sos in this class per dataset
percentWEP2 <- endDf2[[3,3]]
percentWUS2 <- endDf2[[2,3]]
percentCWR2 <- endDf2[[1,3]]
#total number of genus per dataset
genusWEP2 <- endDf2[[3,4]]
genusWUS2 <- endDf2[[2,4]]
genusCWR2 <- endDf2[[1,4]]

# create the first row of the dataframe
nlgrpCollection <- c(totalBackedUp, totalTaxonNLGRP, uniqueWUS2, percentWUS2, genusWUS2, uniqueCWR2, percentCWR2, genusCWR2, uniqueWEP2, percentWEP2, genusWEP2)

#bind the two df together
sosSummary4 <- bind_cols(sosSummary3, tbl_df(nlgrpCollection)) %>%
  dplyr::rename('SOS in NLGRP' = value)
sosSummary4
#define column names and row names

```

The line graph below shows the the number of accessions maintained by the SOS, GRIN, and ARS over time.


```{r message=FALSE, warning=FALSE, echo=FALSE}
# # ### attempt at a cumulative chart
library(dplyr)

# calculate the year the Accession was received
grinDates <- grinData %>%
  separate(Received.Date, c("M", "D", "Y"))%>%
  mutate(year = as.numeric(Y))%>%
  mutate(count = as.numeric(1))

#filter for accession that are backed up
nsslDates <-grinDates %>%
  filter(Backup.Location.1 == "NSSL")

#create a count column for sos data
sosCount <- sosData %>%
  mutate(count = as.numeric(1))


sosCuml <- sosCount%>%
  group_by(COLL_YR) %>%
  dplyr::summarise(total = n())%>%
  mutate(dataset = 'SOS') %>%
  dplyr::rename(year = "COLL_YR") %>%
  mutate(cumsum = cumsum(total))


grinCuml <- grinDates %>%
  group_by(year)%>%
  dplyr::summarise(total = n())%>%
  mutate(dataset = 'GRIN')%>%
  mutate(cumsum = cumsum(total))


arsCuml <-grinDates %>%
  filter(Backup.Location.1 == "NSSL") %>%
  group_by(year)%>%
  dplyr::summarise(total = n()) %>%
  mutate(dataset = 'NLGRP')%>%
  mutate(cumsum = cumsum(total))


allCuml <- bind_rows(sosCuml, grinCuml, arsCuml)



trend <- ggplot(allCuml, aes(x=year, y=cumsum, color= dataset)) +
    labs(title = "Accumulation of Accessions Over Time ",
       x = "Collection Year",
       y= "Number of Accession Collected",
       caption = "") +
  xlim(c(2000,2018))+
  scale_x_continuous(breaks = seq(2000,2018, 2))+
  theme_minimal()+
  geom_line()

trend

```





## Where are Accession Maintained

The challenge of coordinating the preservation of these seeds is seen in part by how my samples become orphaned within the system. Orphaned seeds are those which do not fit into any of the existing collections. As a results seed curators need to assess how the seeds can best be integrated and is it worth incorporating that sample. While this decision making process is occurring the seeds are not being backed up and are not grown out to plants to replenish the existing seed population.

```{r}
# call in sosAccessions: summaries by maintaince site or owned by ***check with Colin or Renee on this one***
# produce a table showing number of successions and proportion of total


#group by location and derive number of taxon
sosAccTaxa <- grinData %>%
  group_by(Accession.Prefix) %>%
  dplyr::summarise(uniqueNumber = n_distinct(Taxon)) %>%
  dplyr::rename(Facility = "Accession.Prefix", UniqueTaxa = "uniqueNumber" )

library(plyr)
# subet columns needed.
sosOwner <- count(grinData$Accession.Prefix)%>%
  arrange(desc(freq))%>%
  dplyr::rename(Facility = x, NumberOfAccessions = freq)%>%
  mutate(FacilityName = c("Western Regional Plant Introduction Station, Washington", "Ornamental Plant Germplasm Center, Ohio", "National Animal Disease Center, Iowa",
                          "Plant Introduction Research, Iowa", "NSL unknown" , "Plant Genetic Resources Conservation Unit, Georgia", "SARU unknown Plants from alaska??", "Missing Data"))

#join the two datasets
sosOwner2 <- left_join(sosOwner, sosAccTaxa, by='Facility', type='left', match='all') %>%
  dplyr::rename(FacilityAcronym = "Facility") %>%
  select(FacilityName, FacilityAcronym, NumberOfAccessions, UniqueTaxa)

sosOwner2
```
The majority of the SOS collection is maintained by the ARS in Pullman, Washington (W6). This is where the native plant collection is based. Accession that are maintained at other locations are there due to the request of other curators. The are accession that are very unlikely to be orphaned. It is different to determine from data alone how many of the accession at W6 an being actively store but not regenerated.


## Viability of SOS seeds

Collection and storage are only part of the story. Germination and the ability to grow out the plant to collect new seeds is a large part of what the ARS supports. The troublesome fact about the SOS seeds is that these species have not often been collected and maintained in seed banks before the initiation of the SOS program. Often little is known about the conditions required to germinate the seeds.
```{r echo=FALSE, tidy=TRUE, message=FALSE, warning=FALSE}
viability <- read.csv("H:\\SOS_Project\\analysisData\\generaAverageGermination.csv")
viability <- tbl_df(viability)
uniqueGenus <- n_distinct(viability$Genus)
percentGenus <- signif(100*(uniqueGenus/uniqueGen),4)
```

An experiment was developed and performed by Annette Miller of NLGRP. Annette tested the viability of seeds to germinate for `r uniqueGenus` unique genus. This accounts for `r percentGenus[1,]` percent of all the genus collected by the SOS program. The data generated by this study illustrates what to expect when working with these plants in the future. The table below shows that percentage of seeds that were tested that were successfully geminated. The histogram groups those


```{r caption="Listing of Seed Viability by Genus", rows.print=10}
colnames(viability) <- c('Genus', 'percentViable' )
arrange(viability, desc(percentViable))

```




```{r , echo=FALSE, tidy=TRUE, message=FALSE, warning=FALSE, caption="Viability of Seeds Collected by the SOS progam."}
# histogram with added parameters
hist(viability$percentViable,
  main="Seed Germination Viability",
  xlab="Proportion of Seeds that Germinated",
  ylab="Number of Genus",
  col="light green",
  border="white",
  las=1, #defien the orientation of the label
  breaks=20
)

```

This distribution shows that the majority of the species collected by the SOS can be germinated given the current level of understanding. Species that had a very low germination success rate will require more research to understand what are the necessary conditions to promote successful germination. Until those methods are understood it may not be possible to maintain the population.

## Distribution of SOS Materials

The ARS systems stores and distributes the seeds that are collected by SOS. Seeds are distributed for a number of reasons including academic research studies and educational demonstrations. Many of the distributions take place within the ARS when seeds are sent to and from various seed labs. The distribution of seeds is end user driven and a result the volume of seeds transferred fluctuates over time.

```{r echo=FALSE, tidy=TRUE, message=FALSE, warning=FALSE, caption="Distribution of seeds over time", rows.print=15}
activeOrders <- read.csv("H:\\SOS_Project\\analysisData\\sosActiveOrders.csv")
date <- separate(activeOrders, Ordered.Date, into = c("month","day", "year"), sep = "/")
# histogram with added parameters
hist(as.numeric(date$year),
  main="Distributions of SOS accessions over time by order",
  xlab="Year",
  ylab="Number of Orders",
  col="grey",
  border="white",
  las=1 #defines the orientation of the label
)

```

The seeds can be used for multiple reasons but by far Research and Education are the top two requests. The first bin on this graph is 2005 and the last is 2017.

```{r echo=FALSE, tidy=TRUE, message=FALSE, warning=FALSE ,rows.print=5}
orderType <- count(activeOrders$Intended.Use)
arrange(orderType, desc(freq)) %>% `colnames<-`(c("Reason for Distribution", "Individual Shipments"))
```
These values are written in by individuals who place the order so while this shows trends there are many unique options that do not fall into a group because of the extra text.

```{r echo=FALSE, tidy=TRUE, message=FALSE, warning=FALSE}
#
speciesOr2 <- activeOrders %>%
  filter(Intended.Use %in% c('Education' , "Research", "Other", "Home Gardening", ""))%>%
  separate( Ordered.Date, into = c("month","day", "year"),sep = "/")%>%
  subset(nchar(as.character(year)) <= 4)%>%
  group_by(Intended.Use, year)%>%
  dplyr::summarise(number =n())


ggplot(speciesOr2, aes(x=year,  y=number, color = Intended.Use)) +
  geom_point(size=3)+
  labs(x="Year", y="Number of Orders",color = "Intended Use", title = 'Orders for Intended Use Over Time')+
  scale_color_manual(labels = c("undefined","education","home gardening", "other", "research") , values=c("#e41a1c","#377eb8","#4daf4a","#984ea3","#ff7f00"))

```

If we take a look at the deliveries over time we can see there is some distinct variability over time. The undefined variable is present because before 2015 the reason for distribution was not recorded.



```{r echo=FALSE, tidy=TRUE, message=FALSE, warning=FALSE}
#read in feature
distribution <- read.csv("H:\\SOS_Project\\analysisData\\SOSOrdersTaxa.csv")

#summarize by genus and sum the total number of packets sent per Genus
genusSum <- distribution %>%
  group_by(genus_name)%>%
  dplyr::summarise(genusSum = sum(COUNT))%>%
  arrange(desc(genusSum))%>%
  dplyr::rename(Genus = genus_name  ,IndividualSampleSent = genusSum)

#calculate the total number of seeds sent
totalSeedsSent <- sum(distribution$COUNT)
```


Table illustrating the total number of seeds sent per genus. There has been a total of `r totalSeedsSent` seeds distributed by the ARS that were collected by the SOS program.
*At the same time I'm a little wary of this data count. why would someone order a single seed. 2/3 of all order are under 10 seeds. Does that make sense* This will be a good question for the other individuals more familiar with the delivery process.

```{r, echo=FALSE, tidy=TRUE, message=FALSE, warning=FALSE}

K13Data$genus_name <- K13Data$Genus

#Call in the WUP/CWR data, summarize by Genus, join to distribution data by genus
K13genus <- K13Data %>%
  group_by(genus_name) %>%
  summarise_()%>%
  inner_join(distribution,by="genus_name")

numberGenus <- n_distinct(K13genus$genus_name)

# calculated the total number of seeds sent
totalWUSSet <- sum(K13genus$COUNT)

#define the unique number of genus and seeds sent to enitity groups
reciever <- distribution %>%
  group_by(title) %>%
  dplyr::summarise(numberOfGenus = n_distinct(genus_name), numberOfSeeds = sum(COUNT)) %>%
  arrange(desc(numberOfGenus))%>%
  dplyr::rename(EntityRecievingSeeds = 'title'  ,NumberOfGenusDistributed = 'numberOfGenus', SamplesDistributed = 'numberOfSeeds')

reciever

```
There are a total of `r totalSeedsSent` seeds that have been distributed by the ARS. Of that `r totalWUSSet`, are considered to be either Wild Utilized Plants or Crop Wild Relatives. This is representing `r numberGenus` unique genus




This chart shows the number of times an order was place for a specific accession.

```{r, echo=FALSE, tidy=TRUE, message=FALSE, warning=FALSE}
# call in data on the distribution of species
speciesOrdered <- distinct(read.csv("H:\\SOS_Project\\analysisData\\sosOrderItems.csv"))
speciesOrdered <- mutate(speciesOrdered, Order.Request.ID = as.factor(order_request_id))


# one to main join with activeOrders based on "Order.Request.ID"
speciesOr <- full_join(speciesOrdered, distinct(activeOrders), by="Order.Request.ID") %>%
  distinct()


accessionsSent <- arrange(count(speciesOr$accession_number) , desc(freq)) %>% `colnames<-`(c("Accession", "Accessions Pulled From"))
accessionsSent

```
This chart shows the number of times an order was place for a specific accession.

<br>
<br>

This chart shows the number of times a specific taxa was has been delivered. These deliveries could come from multiple accessions.

```{r,echo=FALSE, tidy=TRUE, message=FALSE, warning=FALSE}
#totalSent -- not super relavent because it is the number of time indiviudal species were sent
taxaSent1 <- speciesOr %>%
  filter(!is.na(as.numeric(as.character(speciesOr$Item.Count))))%>%
  group_by(Taxon)%>%
  dplyr::summarise( count = n(), sum = max(as.numeric(Item.Count)))%>%
  arrange(desc(count))
taxaSent1 %>% arrange(desc(count)) %>% `colnames<-`(c("Taxon", "Total Delivered", "Total Packets??"))

```
<br>
<br>

This graphic shows which location is receiving the greatest diversity of taxon

```{r, echo=FALSE, tidy=TRUE, message=FALSE, warning=FALSE}
# who is receiving deliveries
resquestor1 <- speciesOr %>%
  filter(!is.na(as.numeric(as.character(speciesOr$Item.Count))))%>%
  group_by(Requestor)%>%
  dplyr::summarise( taxa = n_distinct(Taxon), count = n(), sum = max(as.numeric(Item.Count)))%>%
  arrange(desc(count))


resquestor1 %>% arrange(desc(count)) %>% `colnames<-`(c("Taxon", "Total Taxon", "Total Delivered", "Total Packets??"))

```

# to Do

- Investigate reasons for use- narrative description in GRIN Global
- How many are CWR and impacts

# Discussion

- W6 doesn't have the resources to manage seeds indefinitely
- Constraints / challenges to adopting more wild plants
- Constraints with regard to getting materials into long term storage
- Challenge of not having seed testing techniques/rules worked out for species
