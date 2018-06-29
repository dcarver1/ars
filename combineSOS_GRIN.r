# ###
# The goal of this script is to combine SOS dat with all the data we have on the GRIN Global Database 
# FRom this we can tie specific collections to storage facilities 
# We want to know how much of the SOS data is distributed and how much is backed up ar NLGRP 
# ###
#import Libraries 
library(dplyr)

############ THIS IS NOT NEEDED AT THE MOMENT.The join column used was likely incomplete so errors we're arising 


# read in the SOS data 
sosData <- read.csv("H:\\SOS_Project\\analysisData\\SOSdata_20180614_forARS.csv")
# ensure that the ACC_NUM is a unique ID 
totalSamples <- nrow(sosData)
totalACC_NUM <- dplyr::n_distinct(sosData$ACC_NUM)
print(paste("There are a total of ", totalSamples, "accession colected by sos and "
            , totalACC_NUM, "unique ids"))


# read in GRIN Accessions 
grinData <- read.csv("H:\\SOS_Project\\analysisData\\sosAccessions.csv")

# ensure that the ACC_NUM is a unique ID 
totalSamplngG <- nrow(grinData)
totalName <- dplyr::n_distinct(grinData$Name)
print(paste("There are a total of ", totalSamplngG, "accession colected by sos and "
            , totalName, "unique ids"))
# Add column to match name data with "ACC_NUM
grinData$ACC_NUM <- grinData$Name

# Join dataset based on matching "ACC_NUM" and "NAME" 
combinedData <- left_join(sosData, grinData, by='ACC_NUM')

trimCombinedData <- combinedData[!is.na(combinedData$Accession.Number), ]
numARS_SOS <- nrow(trimCombinedData)
totalBackedUp <- totalName <- dplyr::count(trimCombinedData, Is.Backed.Up.)
 
print(paste("Of the ",totalSamples, " accessions collected by SOS "
            , numARS_SOS, " accession have been processed by ARS and "
            , totalBackedUp[2,2] , " accession have been back up in a long term storage facility."))

# Write out the joined layers 
write.csv(trimCombinedData, file = "H:\\SOS_Project\\analysisData\\joinGRIN_SOS.csv")
