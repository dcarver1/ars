###
# Takes the joined data between the SOS and ARS programs and 
# compares it against all delivered products from ARS 
# summarize total number and the unique deliver end points 
###




#import Libraries 
library(dplyr)


# read in the SOS data 
joinData <- read.csv("H:\\SOS_Project\\analysisData\\joinGRIN_SOS.csv")


# read in GRIN delivery Data  
grinData <- read.csv("H:\\SOS_Project\\analysisData\\sosActiveOrders.csv")


#### the trouble here is that there is now way to join these tables because there is not a unique value between them. 

deliveryData <-read.csv("H:\\SOS_Project\\analysisData\\sosOrdersTotal.csv")
print(deliveryData)

# select all rows that were delivered to ARS locations 
ars <- filter(deliveryData, category_code == "UARS")
