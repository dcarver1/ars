# notes from the Data camp course on Dpylr

```r
library(dpylr)
library(hflights)

hflights <- tbl_df(hflights)
hflights
```

the TBL object is a dplyr dataframe that allows for the easy printing and interpretation of the data.  It is recommended to convert all dataframes to the tbl format

```r
glimpse()
```
this function is similar to summary but designed to work with tbl data type it does a good job are printing clearing and avoiding wrap around
