# SurvSetup

Finds features of spells that are useful for estimating survival models.

[![Build Status](https://travis-ci.org/christophergandrud/SurvSetup.svg?branch=master)](https://travis-ci.org/christophergandrud/SurvSetup)

## Examples


```r
library(SurvSetup)

# Create fake data ----------------------------------------------
group_id <- c(rep('aa', 7), rep('bb', 4))
x <- c(rep('a', 4), rep('b', 3), 'c', rep('a', 2), 'c')
Data <- data.frame(group_id = group_id, spell = x,
                   value = rnorm(n = length(x)))

head(data)
```

```
##                                                                      
## 1 function (..., list = character(), package = NULL, lib.loc = NULL, 
## 2     verbose = getOption("verbose"), envir = .GlobalEnv)            
## 3 {                                                                  
## 4     fileExt <- function(x) {                                       
## 5         db <- grepl("\\\\.[^.]+\\\\.(gz|bz2|xz)$", x)              
## 6         ans <- sub(".*\\\\.", "", x)
```

```r
# Find spell features -------------------------------------------

## Non-grouped data
spell_features(Data, var = 'spell')
```

```
##    group_id spell       value spell_id spell_event spell_time1 spell_time2
## 1        aa     a -0.59329062        1           0           1           2
## 2        aa     a  1.84648212        1           0           2           3
## 3        aa     a -0.05868480        1           0           3           4
## 4        aa     a  0.59308643        1           1           4           5
## 5        aa     b -0.25422386        2           0           1           2
## 6        aa     b -1.28468170        2           0           2           3
## 7        aa     b  1.45748650        2           1           3           4
## 8        bb     c  1.14350936        3           1           1           2
## 9        bb     a -0.78757794        4           0           1           2
## 10       bb     a  1.17341460        4           1           2           3
## 11       bb     c -0.05000087        5           0           1           2
```

```r
## Grouped data
spell_features(Data, var = 'spell', group = 'group_id')
```

```
##    group_id spell       value spell_id spell_event spell_time1 spell_time2
## 1        aa     a -0.59329062        1           0           1           2
## 2        aa     a  1.84648212        1           0           2           3
## 3        aa     a -0.05868480        1           0           3           4
## 4        aa     a  0.59308643        1           1           4           5
## 5        aa     b -0.25422386        2           0           1           2
## 6        aa     b -1.28468170        2           0           2           3
## 7        aa     b  1.45748650        2           0           3           4
## 8        bb     c  1.14350936        1           1           1           2
## 9        bb     a -0.78757794        2           0           1           2
## 10       bb     a  1.17341460        2           1           2           3
## 11       bb     c -0.05000087        3           0           1           2
```

```r
## Last observation treated as an event (e.g. not right-censored)
spell_features(Data, var = 'spell', group = 'group_id',
               right_censored = FALSE)
```

```
##    group_id spell       value spell_id spell_event spell_time1 spell_time2
## 1        aa     a -0.59329062        1           0           1           2
## 2        aa     a  1.84648212        1           0           2           3
## 3        aa     a -0.05868480        1           0           3           4
## 4        aa     a  0.59308643        1           1           4           5
## 5        aa     b -0.25422386        2           0           1           2
## 6        aa     b -1.28468170        2           0           2           3
## 7        aa     b  1.45748650        2           1           3           4
## 8        bb     c  1.14350936        1           1           1           2
## 9        bb     a -0.78757794        2           0           1           2
## 10       bb     a  1.17341460        2           1           2           3
## 11       bb     c -0.05000087        3           1           1           2
```
