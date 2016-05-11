# SurvSetup

Finds features of spells that are useful for estimating survival models.

[![Build Status](https://travis-ci.org/christophergandrud/SurvSetup.svg?branch=master)](https://travis-ci.org/christophergandrud/SurvSetup)

## Examples


```r
library(SurvSetup)

# Create fake data ----------------------------------------------
group_id <- c(rep('aa', 7), rep('bb', 4))
x <- c(rep('a', 4), rep('b', 3), 'c', rep('a', 2), 'c')
fake_data <- data.frame(group_id = group_id, spell = x,
                   value = rnorm(n = length(x)))

head(fake_data)
```

```
##   group_id spell        value
## 1       aa     a -0.329548223
## 2       aa     a -0.162285625
## 3       aa     a -0.006050911
## 4       aa     a -0.253953710
## 5       aa     b  1.225356518
## 6       aa     b  0.123245441
```

```r
# Find spell features -------------------------------------------

## Non-grouped data
spell_features(fake_data, var = 'spell')
```

```
##    group_id spell        value spell_id spell_event spell_time1
## 1        aa     a -0.329548223        1           0           1
## 2        aa     a -0.162285625        1           0           2
## 3        aa     a -0.006050911        1           0           3
## 4        aa     a -0.253953710        1           1           4
## 5        aa     b  1.225356518        2           0           1
## 6        aa     b  0.123245441        2           0           2
## 7        aa     b -0.234360960        2           1           3
## 8        bb     c  0.755472324        3           1           1
## 9        bb     a  1.932812846        4           0           1
## 10       bb     a  0.203686984        4           1           2
## 11       bb     c  0.313942287        5           0           1
##    spell_time2
## 1            2
## 2            3
## 3            4
## 4            5
## 5            2
## 6            3
## 7            4
## 8            2
## 9            2
## 10           3
## 11           2
```

```r
## Grouped data
spell_features(fake_data, var = 'spell', group = 'group_id')
```

```
##    group_id spell        value spell_id spell_event spell_time1
## 1        aa     a -0.329548223        1           0           1
## 2        aa     a -0.162285625        1           0           2
## 3        aa     a -0.006050911        1           0           3
## 4        aa     a -0.253953710        1           1           4
## 5        aa     b  1.225356518        2           0           1
## 6        aa     b  0.123245441        2           0           2
## 7        aa     b -0.234360960        2           0           3
## 8        bb     c  0.755472324        1           1           1
## 9        bb     a  1.932812846        2           0           1
## 10       bb     a  0.203686984        2           1           2
## 11       bb     c  0.313942287        3           0           1
##    spell_time2
## 1            2
## 2            3
## 3            4
## 4            5
## 5            2
## 6            3
## 7            4
## 8            2
## 9            2
## 10           3
## 11           2
```

```r
## Last observation treated as an event (e.g. not right-censored)
spell_features(fake_data, var = 'spell', group = 'group_id',
               right_censored = FALSE)
```

```
##    group_id spell        value spell_id spell_event spell_time1
## 1        aa     a -0.329548223        1           0           1
## 2        aa     a -0.162285625        1           0           2
## 3        aa     a -0.006050911        1           0           3
## 4        aa     a -0.253953710        1           1           4
## 5        aa     b  1.225356518        2           0           1
## 6        aa     b  0.123245441        2           0           2
## 7        aa     b -0.234360960        2           1           3
## 8        bb     c  0.755472324        1           1           1
## 9        bb     a  1.932812846        2           0           1
## 10       bb     a  0.203686984        2           1           2
## 11       bb     c  0.313942287        3           1           1
##    spell_time2
## 1            2
## 2            3
## 3            4
## 4            5
## 5            2
## 6            3
## 7            4
## 8            2
## 9            2
## 10           3
## 11           2
```
