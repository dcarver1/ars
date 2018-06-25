# #####
# The goal of this document is to select all SOS accessons that coincide with wild crop relatives and other
# useful plants defined by the GRIN economic quality 
# once connected comparitive statistics will be performed 
# #####

# read in the SOS data 
sosData <- read.csv("H:\\SOS_Project\\analysisData\\SOSdata_20180614_forARS.csv")

# Replace the name column of the sos data so that the "ssp." notation is replaced with "subsp." as defined
# by the grin Data base 
# created a new column that has the same col name as the WEP data set. I will use the col to join on 
sosData$Taxon <- gsub("ssp.","subsp.", sosData$NAME) 

#detemine the total number of taxon in dataset 
sosTotalUnique <- nrow(unique(sosData[1]))


# read in the WEP data 
WEPData <- read.csv("H:\\SOS_Project\\analysisData\\EconomicUseCategoriesOfSpecies.csv")

## Rename the name column to match the newly created column from the SOS data 
colnames(WEPData)[2] <- "Taxon"
colnames(WEPData)

#detemine the total number of taxon in dataset 
WEPTotalUnique <- nrow(unique(WEPData$taxonomy_species_id))



# ####
# this plyr packages allows for one to many joins. in this case I need to apply the single row of the WEP data
# to every unique row of the SOS data. 
# ####
install.packages('plyr')
library(plyr)
# join the data sets
combinedData <- join(sosData, WEPData, by='Taxon', type='left', match='all')

#trim the data so that taxon that do not have values for the WEP specific data columns are dropped. 
trimCombinedData <- combinedData[!is.na(combinedData$economic_usage_code), ]

###
# What ticky about this that that the join is a many to many. I need to find a way to colaspe all economic uses into a single column so
# all that information is contained but the join is one to one at the end of the day 
# testing group_by and summarize from the Dplyr library 
### 

### this package looks very promising, I should start working with asap 
install.packages("dplyr")
library(dplyr)

#generate a copy to preserve the original data 
testWEPData <- WEPData

### 
# this stuff is new so i'm still figuring it out. It's not producing exactly what I'm interested in but it's a start and might work until we get some 
# more feedback on the process

### 
# %>% applies the value on the left to the first arguement of the function on the right 
# testWEPData %>% groupby(Taxon)  === group_by(testWEPData, Taxon)
# this allows for the chaining of fucntions, which is pretty cool. 
###
# the summarise function creates a new dateframe 
# Define a column name "numEco" 
# n() and n_distinct() due the same thing as writen with n_distict being more exclusive
slimWEP <- testWEPData %>% group_by(Taxon) %>% summarise(numEco = n())
slimWEP2 <-testWEPData %>% group_by(Taxon) %>% summarise(numEco = n_distinct(economic_usage_code))
WEPTotalUnique <- nrow(slimWEP)


###
# with this trimmed data I'm gonig to complete a 1 to many join with the SOS data and produce my summary stats on the new DF
# this should not have duplicates 
### 

joinedSOS_WEP <- left_join(sosData,slimWEP,by="Taxon")
head(joinedSOS_WEP)
slimJoin <- filter(joinedSOS_WEP, numEco >= 1)
head(slimJoin)
nrow(slimJoin)


#unique will produce a list of all the un 
testName <-unique(slimJoin[1])
numUnique <- nrow(testName)
print(paste( "There are a total of ",
             numUnique, " unique taxons collected by SOS that are also",
             "defined as World Econimic Plants."))
print(testName)

## compare the number of samples against the total number from the SOS and WEP data
percentSOS <- signif((100 * (numUnique/sosTotalUnique)),4) 
percentWEP <- signif((100 * (numUnique/WEPTotalUnique)),4)

print(paste( "There are a total of ",
             numUnique, " unique taxons collected by SOS that are also",
             "defined as World Econimic Plants.."))


print(paste( percentSOS, "percent of all the SOS collections are reconized as",
             "defined as World Econimic Plants."))


print(paste( percentWEP, "percent of all the WEP collections of that",
             " have been collected by the SOS program."))



## Construct a dataframe to summarize the relationship between the total number of collections and what is shared across data sources 
labelsWEP_SOS <- c("total Taxons", "total collected SOS", "percent of total" )
labelsColumns <- c('WEP Taxons', "SOS Taxons")
WEPInfo <- matrix(c(WEPTotalUnique, numUnique, percentWEP))
sosInfo <- matrix(c(sosTotalUnique, numUnique, percentSOS))
values2 <- data.frame(WEPInfo,sosInfo,row.names =labelsWEP_SOS)
colnames(values2) <- labelsColumns
values2


## Determine the total number of unique SubSPECIES collect and the number of collection in each SubSPECIES
subSpecies <- slimJoin[grep("subsp." ,slimJoin$Taxon),]# 
# work with the grep function
uniqueSub<- nrow(unique(subSpecies["Taxon"]))
print(uniqueSub)
summarySub <- summary(subSpecies["Taxon"]) # the swummary tool here does not seem to be functioning the way I execpt it to
print(summarySub)

## Determine the total number of unique varieties collected and the number of collections in each varieties 
varSpecies <- slimJoin[grep("var." , slimJoin$Taxon),] # for some reason the ['colName'] structure does not seem
# work with the grep function
uniqueVar<- nrow(unique(varSpecies["Taxon"]))
print(uniqueVar)
summaryVar <- summary(varSpecies["Taxon"])# the swummary tool here does not seem to be functioning the way I execpt it to
print(summaryVar)


print(paste("Of the ", numUnique, " unique taxa which are world econimic plants that are "
            , uniqueSub, " unique subspecies and "
            , uniqueVar, " unique variaties."))

### 
# Complete a quick summary to calculate the total number of species and collections for each economic group  
###

# create a count of list of all the economic classes 
ecoClasses <- dplyr::count(trimCombinedData,economic_usage_code )
ecoClasses$economic_usage_code <- as.character(ecoClasses$economic_usage_code)

# add total number of WEP taxa collected by the SOS program 


ecoClasses[nrow(ecoClasses) + 1,] = list("WEP Taxons", WEPTotalUnique)
ecoClasses[nrow(ecoClasses) + 1,] = list("SOS Taxons", sosTotalUnique)
ecoClasses[nrow(ecoClasses) + 1,] = list("Shared Taxons", numUnique)
colnames(ecoClasses) <- c("Class", "Number of Collections")
print(ecoClasses)
