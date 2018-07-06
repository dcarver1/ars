# #####
# The goal of this document is to select all SOS accessons that coincide with wild crop relatives and other
# useful plants defined by the GRIN economic quality 
# once connected comparitive statistics will be performed 
# #####

# read in the SOS data 
sosData <- read.csv("H:\\SOS_Project\\analysisData\\SOSdata_20180614_forARS.csv")

# Replace the name column of the sos data so that the "ssp." notation is replaced with "subsp." as defined
# by the grin Data base 
# created a new column that has the same col name as the K13 data set. I will use the col to join on 
sosData$Taxon <- gsub("ssp.","subsp.", sosData$NAME) 

#detemine the total number of taxon in dataset 
sosTotalUnique <- nrow(unique(sosData[1]))


# read in the K13 data 
K13Data <- read.csv("H:\\SOS_Project\\analysisData\\CWR_US_inventory_2013_7_10.csv")

#detemine the total number of taxon in dataset 
K13TotalUnique <- nrow(unique(K13Data[1]))



# ####
# this plyr packages allows for one to many joins. in this case I need to apply the single row of the K13 data
# to every unique row of the SOS data. 
# ####
install.packages('plyr')
library(plyr)
# join the data sets
combinedData <- join(sosData, K13Data, by='Taxon', type='left', match='all')

#trim the data so that taxon that do not have values for the K13 specific data columns are dropped. 
trimCombinedData <- combinedData[!is.na(combinedData$Taxon_w_author), ]

### 
# This trimCombinedData contains all the SOS collections that share a name with an Economically valuable plant or a wild crop relative
#  - this data can be used to query against the GRIN data to determine exaclty how many of these SOS samples are stored in a K13 facility 
# Below I will work on summarizing the unique number of Taxon and sub species, as well can graphically represnting the data. 
###

# summary will produce a table that shows the count of all unique features 
testSum <- summary(trimCombinedData[1],maxsum = 25)
head(testSum) 
testSum



#unique will produce a list of all the unique taxons 
testName <-unique(trimCombinedData[1])
numUnique <- nrow(testName)
print(paste( "There are a total of ",
             numUnique, " unique taxons collected by SOS that are either",
             "Wild Crop Relvatives or Econmically Important Species."))
print(testName)

## compare the number of samples against the total number from the SOS and K13 data
percentSOS <- signif((100 * (numUnique/sosTotalUnique)),4) 
percentK13 <- signif((100 * (numUnique/K13TotalUnique)),4)

print(paste( "There are a total of ",
             numUnique, " unique taxons collected by SOS that are either",
             "Wild Crop Relvatives or Econmically Important Species."))


print(paste( percentSOS, "percent of all the SOS collections as reconized as either",
             "Wild Crop Relvatives or Econmically Important Species."))


print(paste( percentK13, "percent of all the K13 collections of that are defined as ",
             "Wild Crop Relvatives or Econmically Important Species have been collected by the SOS program."))

#Find the total number of recorded entries 
totalSamples <- nrow(trimCombinedData)
print(totalSamples)

## Construct a dataframe to summarize the relationship between the total number of collections and what is shared across data sources 
labelsK13_SOS <- c("total Taxons", "total collected SOS", "percent of total" )
labelsColumns <- c('K13 Taxons', "SOS Taxons")
K13Info <- matrix(c(K13TotalUnique, numUnique, percentK13))
sosInfo <- matrix(c(sosTotalUnique, numUnique, percentSOS))
values2 <- data.frame(K13Info,sosInfo,row.names =labelsK13_SOS)
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
uniqueVar<- nrow(unique(varSpecies["Taxon"]))
print(uniqueVar)
summaryVar <- summary(varSpecies["Taxon"])# the swummary tool here does not seem to be functioning the way I execpt it to
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
print(paste( wusPercent, " of all wild utilized species taxons defined by the K13 have been collected by the Seeds of Success program."))
print(paste( cwrPercent, " of all crop wild relative taxons defined by the K13 have been collected by the Seeds of Success program."))

## Construct a table to help summarize the relationship between the the collections and WUS and CWRs 
labelsWUS_CWR <- c("total known by K13", "total collected SOS", "percent of total" )
labelsCol <- c('Wild Utulized Species', "Crop Wild Relatives")
wusInfo <- matrix(c(K13NumWUS, uniqueWUS, wusPercent))
cwrInfo <- matrix(c(K13NumCWR, uniqueCWR, cwrPercent))
values <- data.frame(wusInfo,cwrInfo,row.names =labelsWUS_CWR)
colnames(values) <- labelsCol
values

