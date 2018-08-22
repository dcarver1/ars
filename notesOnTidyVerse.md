8/22/2018
The first chapter seems to be a review of the dplyr package taking limited notes

#ggplot2
**foundation of ggplot**
three main components
- data
- aesthetic quality
- type of plot

```r
# data
ggplot(gapminder_1952,
#aesthetic
  aes(x = pop, y = gdpPercap)) +
#type of plot
  geom_point()
```

**log scale**
you can add scaling value within a +
```r
ggplot(gapminder_1952,
  aes(x = pop, y = gdpPercap)) +
  geom_point()+
  scale_x_log10()
```

**additional Aesthetic**
Color and size

``` r
# Add the size aesthetic to represent a country's gdpPercap
ggplot(gapminder_1952, aes(x = pop, y = lifeExp, color = continent,
size=gdpPercap)) +
  geom_point() +
  scale_x_log10()  
```
**faceting**
dividing plots into subplots
~ usually means by in R
```r
# Scatter plot comparing pop and lifeExp, faceted by continent
ggplot(gapminder_1952,
  aes(x=pop,
    y=lifeExp))+
    geom_point()+
    scale_x_log10()+
    facet_wrap(~continent)
#generated 5 unique plots based on individual continent
```
crazy data rich plot
```r
# Scatter plot comparing gdpPercap and lifeExp, with color representing continent
# and size representing population, faceted by year
# Scatter plot comparing pop and lifeExp, faceted by continent
ggplot(gapminder, aes(x=gdpPercap,y=lifeExp,color=continent, size=pop ))+
    geom_point()+
    scale_x_log10()+
    facet_wrap(~year)
```
