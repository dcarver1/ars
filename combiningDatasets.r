# #####
# The goal of this document is to select all SOS accessons that coincide with wild crop relatives and other
# useful plants defined by the GRIN economic quality 
# once connected comparitive statistics will be performed 
# #####

# read in the SOS data 
sosData <- read.csv("H:\\SOS_Project\\analysisData\\SOSdata_20180614_forARS.csv")

# Replace the name column of the sos data so that the "ssp." notation is replaced with "subsp." as defined
# by the grin Data base 
# created a new column that has the same col name as the ARS data set. I will use the col to join on 
sosData$Taxon <- gsub("ssp.","subsp.", sosData$NAME) 


# read in the ARS data 
arsData <- read.csv("H:\\SOS_Project\\analysisData\\CWR_US_inventory_2013_7_10.csv")


# ####
# this plyr packages allows for one to many joins. in this case I need to apply the single row of the ARS data
# to every unique row of the SOS data. 
# ####
install.packages('plyr')
library(plyr)
# join the data sets
combinedData <- join(sosData, arsData, by='Taxon', type='left', match='all')

#trim the data so that taxon that do not have values for the ARS specific data columns are dropped. 
trimCombinedData <- combinedData[!is.na(combinedData$Taxon_w_author), ]

