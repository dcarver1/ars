# ##
# Dan Carver
# 6/15/2018
# This is just the testing script for starting to play around with the Seeds Of Success information
# ##

arsData <- read.csv("H:\\SOS_Project\\analysisData\\CWR_US_inventory_2013_7_10.csv")

#create a list of col names 
colNames <-colnames(arsData)
print(colNames)

# summary will produce a table that shows the count of all unique features 
testSum <- head(summary(arsData[1]))
testSum 

#unique will produce a list of all the un 
testName <-head(unique(arsData[1]))
print(testName)

#Find the total number of recorded entries 
totalSamples <- nrow(arsData)
print(totalSamples)


###
# this is really just an example of how to access the more specific sub species 
### 

## Determine the total number of unique SubSPECIES collect and the number of collection in each SubSPECIES 
subSpecies <- arsData[grep("subsp." ,arsData$Taxon),]# for some reason the ['colName'] structure does not seem
# work with the grep function
uniqueSub<- nrow(unique(subSpecies["Taxon"]))
print(uniqueSub)
summarySub <- summary(subSpecies["Taxon"])
print(summarySub)

## Determine the total number of unique varieties collected and the number of collections in each varieties 
varSpecies <- arsData[grep("var." ,arsData$Taxon),] # for some reason the ['colName'] structure does not seem
# work with the grep function
uniqueVar<- nrow(unique(varSpecies["Taxon"]))
print(uniqueVar)
summaryVar <- summary(varSpecies["Taxon"])
print(summaryVar)

