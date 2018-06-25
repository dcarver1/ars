# ##
# Dan Carver
# 6/15/2018
# This is just the testing script for starting to play around with the Seeds Of Success information
# ##

wepData <- read.csv("H:\\SOS_Project\\analysisData\\EconomicUseCategoriesOfSpecies.csv")

#create a list of col names 
colNames <-colnames(wepData)
print(colNames)

# summary will produce a table that shows the count of all unique features 
testSum <- sort(table(wepData$name), decreasing = TRUE)
head(testSum) 
# hist(testSum, 
#      main="Number of ", 
#      xlab="Number of Accessions", 
#      border="blue", 
#      ylim = c(1,250),
#      xlim=c(5,500),
#      col="green",
#      breaks=50)

testSum[1:100]

plot(testSum,
     type =  "h",
     main = "Distribution of the number of Accessions Collected for wep Taxa",
     xlab = "Taxa",
     ylab = "Number of Accessions")



#unique will produce a list of all the unique names 
testName <-unique(wepData$name)
print(testName[1:15])
numTaxon <- length(testName)

table(wepData$name)
#Find the total number of recorded entries 
totalSamples <- nrow(wepData)
print(totalSamples)

aveEcoPerSpecies <-(totalSamples/numTaxon)

print(paste("There are a total of ",numTaxon, " plant taxon that have at least 1 defined economic value. The were a total of",
totalSamples," which implies that each species has on average ", aveEcoPerSpecies," sources of economic significance."  ))

# At the end of the day this is going to be a report that we hand off. As a results this should be at the minimun a markdown
# doc, ideally it would be a shiney app so the user could build their own querys. I bring this up here because the
# material below is very repeative and could easily be ran as a function

#Determine the total number of unique families collect and the number of collection in each family 


## Determine the total number of unique SubSPECIES collect and the number of collection in each SubSPECIES 
subSpecies <- wepData[grep("subsp." ,wepData$name),]# for some reason the ['colName'] structure does not seem
# work with the grep function
uniqueSub<- nrow(unique(subSpecies["name"]))
print(uniqueSub)
summarySub <- summary(subSpecies["name"])
print(summarySub)

## Determine the total number of unique varieties collected and the number of collections in each varieties 
varSpecies <- wepData[grep("var." ,wepData$name),] # for some reason the ['colName'] structure does not seem
# work with the grep function
uniqueVar<- nrow(unique(varSpecies["name"]))
print(uniqueVar)
summaryVar <- summary(varSpecies["name"])
print(summaryVar)


print(paste( "From the ",numTaxon, " unique taxa there are a total of"
             ,uniqueSub, " unique sub species and a total of "
             ,uniqueVar, "unique varieties within this collection"))




