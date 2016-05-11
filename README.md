# SurvSetup

Finds features of spells that are useful for estimating survival models.

[![Build Status](https://travis-ci.org/christophergandrud/SurvSetup.svg?branch=master)](https://travis-ci.org/christophergandrud/SurvSetup)

## Examples


```r
library(SurvSetup)

# Create fake data ----------------------------------------------
group_id <- c(rep('aa', 7), rep('bb', 4))
x <- c(rep('a', 4), rep('b', 3), 'c', rep('a', 2), 'c')
fake_data <- data.frame(group_id = group_id, spell = x)

head(fake_data)
```

```
##   group_id spell
## 1       aa     a
## 2       aa     a
## 3       aa     a
## 4       aa     a
## 5       aa     b
## 6       aa     b
```

```r
# Find spell features -------------------------------------------

## Non-grouped data
spell_features(fake_data, var = 'spell')
```

```
##    group_id spell spell_id spell_event spell_time1 spell_time2
## 1        aa     a        1           0           1           2
## 2        aa     a        1           0           2           3
## 3        aa     a        1           0           3           4
## 4        aa     a        1           1           4           5
## 5        aa     b        2           0           1           2
## 6        aa     b        2           0           2           3
## 7        aa     b        2           1           3           4
## 8        bb     c        3           1           1           2
## 9        bb     a        4           0           1           2
## 10       bb     a        4           1           2           3
## 11       bb     c        5           0           1           2
```

```r
## Grouped data
spell_features(fake_data, var = 'spell', group = 'group_id')
```

```
##    group_id spell spell_id spell_event spell_time1 spell_time2
## 1        aa     a        1           0           1           2
## 2        aa     a        1           0           2           3
## 3        aa     a        1           0           3           4
## 4        aa     a        1           1           4           5
## 5        aa     b        2           0           1           2
## 6        aa     b        2           0           2           3
## 7        aa     b        2           0           3           4
## 8        bb     c        1           1           1           2
## 9        bb     a        2           0           1           2
## 10       bb     a        2           1           2           3
## 11       bb     c        3           0           1           2
```

```r
## Last observation treated as an event (e.g. not right-censored)
spell_features(fake_data, var = 'spell', group = 'group_id',
               right_censored = FALSE)
```

```
##    group_id spell spell_id spell_event spell_time1 spell_time2
## 1        aa     a        1           0           1           2
## 2        aa     a        1           0           2           3
## 3        aa     a        1           0           3           4
## 4        aa     a        1           1           4           5
## 5        aa     b        2           0           1           2
## 6        aa     b        2           0           2           3
## 7        aa     b        2           1           3           4
## 8        bb     c        1           1           1           2
## 9        bb     a        2           0           1           2
## 10       bb     a        2           1           2           3
## 11       bb     c        3           1           1           2
```
