# ##
# Dan Carver
# 6/15/2018
# This is just the testing script for starting to play around with the Seeds Of Success information
# ##

sosData <- read.csv("H:\\SOS_Project\\analysisData\\SOSdata_20180614_forARS.csv")

####test 
## this is a process for preforming a find and replace within a dataframe in R 
## use this process before attempting to merge the two dataframes 
#### 
group <- sosData
group1 <- gsub("ssp.","subsp.", group$NAME) 


#create a list of col names 
colNames <-colnames(sosData)
print(colNames)

# summary will produce a table that shows the count of all unique features 
testSum <- sort(table(sosData$NAME), decreasing = TRUE)
head(testSum) 
hist(testSum, 
     main="Histogram for Air Passengers", 
     xlab="Number of Accessions", 
     border="blue", 
     ylim = c(1,250),
     xlim=c(5,500),
     col="green",
     breaks=50)

testSum[1:100]

plot(testSum,
     type =  "h",
     main = "Distribution of the number of Accessions Collected for SOS Taxa",
     xlab = "Taxa",
     ylab = "Number of Accessions")
     


#unique will produce a list of all the un 
testName <-head(unique(sosData[1]))
print(testName)

#Find the total number of recorded entries 
totalSamples <- nrow(sosData)
print(totalSamples)

###
# quick histogram of the collection time frame 
# this is kinda just to get some ploting framework down 
### 

# histogram with added parameters
collectionYears <- sosData$COLL_YR
hist(collectionYears,
     main="Accessions collected by SOS",
     xlab="Collection Year",
     xlim = c(2000,2018),
     ylab="Relative Abundance",
     col="darkmagenta",
     freq=FALSE
)



# At the end of the day this is going to be a report that we hand off. As a results this should be at the minimun a markdown
# doc, ideally it would be a shiney app so the user could build their own querys. I bring this up here because the
# material below is very repeative and could easily be ran as a function

#Determine the total number of unique families collect and the number of collection in each family 
uniqueFam <- nrow(unique(sosData["FAMILY"]))
print(uniqueFam)
summaryFam <- summary(sosData["FAMILY"])
print(summaryFam)
familyPlot <- sort(table(sosData$FAMILY), decreasing = TRUE)

hist(familyPlot,
     main="Accessions collected by SOS",
     xlab="Collection Year",
     ylab="Relative Abundance",
     col="darkmagenta"
)
## Determine the total number of unique GENUS collect and the number of collection in each GENUS 
uniqueGen <- nrow(unique(sosData["GENUS"]))
print(uniqueGen)
summaryGen <- summary(sosData["GENUS"])
print(summaryGen)

## Determine the total number of unique SPECIES collect and the number of collection in each SPECIES 
uniqueSpe <- nrow(unique(sosData["SPECIES"]))
print(uniqueSpe)
summarySpe <- summary(sosData["SPECIES"])
print(summarySpe)

## Determine the total number of unique SubSPECIES collect and the number of collection in each SubSPECIES 
subSpecies <- sosData[grep("ssp." ,sosData$NAME),]# for some reason the ['colName'] structure does not seem
# work with the grep function
uniqueSub<- nrow(unique(subSpecies["NAME"]))
print(uniqueSub)
summarySub <- summary(subSpecies["NAME"])
print(summarySub)

## Determine the total number of unique varieties collected and the number of collections in each varieties 
varSpecies <- sosData[grep("var." ,sosData$NAME),] # for some reason the ['colName'] structure does not seem
# work with the grep function
uniqueVar<- nrow(unique(varSpecies["NAME"]))
print(uniqueVar)
summaryVar <- summary(varSpecies["NAME"])
print(summaryVar)


print(paste( "This data set contains a total of "
             ,totalSamples, "samples. Of which "
             ,uniqueFam," plant families, "
             , uniqueGen, " plant genus and "
             ,uniqueSpe, " unique species are contained" ) )

print(paste( "From the ",uniqueSpe, " unique species that are a total of"
             ,uniqueSub, " unique sub species and a total of "
             ,uniqueVar, "unique varieties within this collection"))



####
# Geospatial data 
####

## The number of sample that have coordinates assocaited with them 
spatialVar <- nrow(subset(sosData, sosData["LATITUDE"] != ''))
percentSpatial <- 100*(spatialVar/totalSamples)
print(percentSpatial)

## Determine the total number of unique GPS_DATUM collect and the number of collection in each GPS_DATUM 
uniqueGeo <- nrow(unique(sosData["GPS_DATUM"]))
print(uniqueGeo)
summaryGeo <- summary(sosData["GPS_DATUM"])
print(summaryGeo)


