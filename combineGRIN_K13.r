# #####
# The goal of this document is to select all SOS accessons that are stored by ARS and coincide with wild crop relatives and other
# useful plants defined by the GRIN economic quality 
# once connected comparitive statistics will be performed 
# #####

# read in the SOS data 
grinData <- read.csv("H:\\SOS_Project\\analysisData\\sosAccessions.csv")


#detemine the total number of taxon in dataset 
grinTotalUnique <- nrow(unique(grinData[1]))


# read in the K13 data 
K13Data <- read.csv("H:\\SOS_Project\\analysisData\\CWR_US_inventory_2013_7_10.csv")

#detemine the total number of taxon in dataset 
K13TotalUnique <- nrow(unique(K13Data[1]))



# ####
# this plyr packages allows for one to many joins. in this case I need to apply the single row of the K13 data
# to every unique row of the grin data. 
# ####
install.packages('plyr')
library(plyr)
# join the data sets
combinedData <- join(grinData, K13Data, by='Taxon', type='left', match='all')

#trim the data so that taxon that do not have values for the K13 specific data columns are dropped. 
trimCombinedData <- combinedData[!is.na(combinedData$Taxon_w_author), ]

### 
# This trimCombinedData contains all the grin collections that share a name with an Economically valuable plant or a wild crop relative
#  - this data can be used to query against the GRIN data to determine exaclty how many of these grin samples are stored in a K13 facility 
# Below I will work on summarizing the unique number of Taxon and sub species, as well can graphically represnting the data. 
###


#unique will produce a list of all the un 
testName <-unique(trimCombinedData[1])
numUnique <- nrow(testName)
print(paste( "There are a total of ",
             numUnique, " unique taxons collected by SOS that are stored by ARS and are either",
             "Wild Crop Relvatives or Econmically Important Species."))
print(testName)

## compare the number of samples against the total number from the grin and K13 data
percentgrin <- signif((100 * (numUnique/grinTotalUnique)),4) 
percentK13 <- signif((100 * (numUnique/K13TotalUnique)),4)

print(paste( "There are a total of ",
             numUnique, " unique taxons collected by SOS that are either",
             "Wild Crop Relvatives or Econmically Important Species."))


print(paste( percentgrin, "percent of all the SOS collections as reconized as either",
             "Wild Crop Relvatives or Econmically Important Species."))


print(paste( percentK13, "percent of all the K13 collections of that are defined as ",
             "Wild Crop Relvatives or Econmically Important Species have been collected by the SOS program."))

#Find the total number of recorded entries 
totalSamples <- nrow(trimCombinedData)
print(totalSamples)

## Construct a dataframe to summarize the relationship between the total number of collections and what is shared across data sources 
labelsK13_grin <- c("total Taxons", "total collected SOS", "percent of total" )
labelsColumns <- c('K13 Taxons', "SOS Taxons")
K13Info <- matrix(c(K13TotalUnique, numUnique, percentK13))
grinInfo <- matrix(c(grinTotalUnique, numUnique, percentgrin))
values2 <- data.frame(K13Info,grinInfo,row.names =labelsK13_grin)
colnames(values2) <- labelsColumns
values2


## Determine the total number of unique SubSPECIES collect and the number of collection in each SubSPECIES 
subSpecies <- trimCombinedData[grep("subsp." ,trimCombinedData$Taxon),]# for some reason the ['colName'] structure does not seem
# work with the grep function
uniqueSub<- nrow(unique(subSpecies["Taxon"]))
print(uniqueSub)
summarySub <- summary(subSpecies["Taxon"]) # the swummary tool here does not seem to be functioning the way I execpt it to
print(summarySub)

## Determine the total number of unique varieties collected and the number of collections in each varieties 
varspecies <- trimCombinedData[grep("var." ,trimCombinedData$Taxon),] # for some reason the ['colName'] structure does not seem
# work with the grep function
uniqueVar<- nrow(unique(varspecies["Taxon"]))
print(uniqueVar)
summaryVar <- summary(varspecies["Taxon"])# the swummary tool here does not seem to be functioning the way I execpt it to
print(summaryVar)

### 
# Repeating the process but looking at the total number of Wild Crop Relatives and Econmically valuable plants 
###

K13NumWUS <- nrow(subset(K13Data, K13Data['Type'] == 'WUS'))
K13NumCWR <- nrow(subset(K13Data, K13Data['Type'] == 'CWR'))
K13NumWUS
K13NumCWR

wusSamples <- subset(trimCombinedData, trimCombinedData['Type'] == 'WUS')
uniqueWUS <- nrow(unique(wusSamples["Taxon"]))

cwrSamples <- subset(trimCombinedData, trimCombinedData['Type'] == 'CWR')
uniqueCWR <- nrow(unique(cwrSamples["Taxon"]))

## compare the number of CWR WUS taxon collected against the total number of CWR and WUS taxons defined by the K13 data
wusPercent <- signif((100 * (uniqueWUS/K13NumWUS)),4) 
cwrPercent <- signif((100 * (uniqueCWR/K13NumCWR)),4)
wusPercent
cwrPercent
print(paste( wusPercent, " of all wild utilized species taxons defined by the K13 have been collected by the Seeds of Success program and are store in ARS."))
print(paste( cwrPercent, " of all crop wild relative taxons defined by the K13 have been collected by the Seeds of Success program and are store in ARS.."))

## Construct a table to help summarize the relationship between the the collections and WUS and CWRs 
labelsWUS_CWR <- c("total known by K13", "total collected SOS", "percent of total" )
labelsCol <- c('Wild Utulized Species', "Crop Wild Relatives")
wusInfo <- matrix(c(K13NumWUS, uniqueWUS, wusPercent))
cwrInfo <- matrix(c(K13NumCWR, uniqueCWR, cwrPercent))
values <- data.frame(wusInfo,cwrInfo,row.names =labelsWUS_CWR)
colnames(values) <- labelsCol
values

