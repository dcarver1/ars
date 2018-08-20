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

Tidy data
- all columns are variables and all rows are observations
- this allow for the 5 primary functions of Dplyr to work
** Select, Mutate, arrange, filter, summarize **
- Select and mutate work with variables
- arrange and filter work with observations
- summarize works with both

```{r}
select(df, group, sum)
```
You can call all specific columns

all dplyr functions return a copy of a dataframe so the original data is preserved.

```{r}
select(df, var1, var2)
#or
select(df, 1:4, -2)
```
1:4 is inclusive
negative sign '-' removes features

Examples of selections
using the colname:colname is a pretty nice way to index
```{r}

# Print out a tbl with the four columns of hflights related to delay
select(hflights, ActualElapsedTime, AirTime, ArrDelay, DepDelay)

# Print out the columns Origin up to Cancelled of hflights
select(hflights, Origin:Cancelled)

# Answer to last question: be concise!
select(hflights, -(DepTime:AirTime))
```

You can incorporate multiple helper function to help slim down the selections

starts_with("X"): every name that starts with "X",
ends_with("X"): every name that ends with "X",
contains("X"): every name that contains "X",
matches("X"): every name that matches "X", where "X" can be a regular expression,
num_range("x", 1:5): the variables named x01, x02, x03, x04 and x05,
one_of(x): every name that appears in x, which should be a character vector.

Multiple of these can be used. they work as OR statements really
```r
select(hflights, UniqueCarrier, ends_with("Num"), starts_with("Cancel"))
```

7/27/2018

**Mutate**
calculates a new variable based on information already in a dataset ]
mutate returns new dataframe that contains all the new variable
you can add multiple columns at once using commas
```r
mutate(my_df, x = a + b, y = x + c)
```
8/20/2018
**Filter**
provide a tbl  and a conditional statement
?comparison opens a help page for R operators

```r
# hflights is already available in the workspace
glimpse(hflights)
# Select the flights that had JFK as their destination: c1
c1 <- filter(hflights, Dest %in% "JFK")

# Combine the Year, Month and DayofMonth variables to create a Date column: c2
c2 <- mutate(c1, Date = paste(Year, Month ,DayofMonth, sep="-"))
glimpse(c2)
# Print out a selection of columns of c2
select(c2, Date, DepTime, ArrTime, TailNum)
```
**Arrange**
order rows based on the content of rows
multiple rows can be sorted, the second works as the tie breaker

```r
# Arrange dtc so that cancellation reasons are grouped
arrange(dtc, CancellationCode)

# Arrange dtc according to carrier and departure delays
arrange(dtc, UniqueCarrier, DepDelay)

# Arrange flights by total delay (normal order).
arrange(hflights, DepDelay + ArrDelay )

```
