
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dobEstimator

<!-- badges: start -->

[![R-CMD-check](https://github.com/bairdj/dobEstimator/actions/workflows/check-standard.yaml/badge.svg)](https://github.com/bairdj/dobEstimator/actions/workflows/check-standard.yaml)
[![codecov](https://codecov.io/gh/bairdj/dobEstimator/graph/badge.svg?token=3IZA9U35ZY)](https://codecov.io/gh/bairdj/dobEstimator)
<!-- badges: end -->

The goal of dobEstimator is to allow the estimation of an individual’s
date of birth, when only their ages at a set of dates are known. For
example, you may have a dataset like this:

    #>   age       date
    #> 1  20 2010-03-05
    #> 2  20 2010-05-06
    #> 3  21 2010-07-08
    #> 4  23 2012-06-23
    #> 5  23 2013-01-01

From this data, it can be deduced that the individual’s 21st birthday
occurred at some point between 2010-05-07 and 2010-07-08, thus their
birth date must be between 1990-05-07 and 1990-07-08. It is also known
that the individual’s 23rd birthday occurred at or before 2012-06-23,
therefore their birth date window can be narrowed.

The `dobEstimator` package leverages this approach to accurately
pinpoint the time interval in which an individual’s date of birth must
fall.

The package works best when there are a large number of age observations
per person, especially when these are spread throughout the year and
where there are \> 1 distinct ages recorded. If only a single
observation is available, the date of birth interval will be one year
wide. It is only possible to identify a specific date of birth where two
distinct ages are recorded on consecutive calendar dates.

## Use cases

Once `dobEstimator` has estimated an individual’s date of birth
interval, it could be used for:

- Imputing missing age observations
- To improve the accuracy of age matching in case-control studies
- To estimate a distribution of dates of birth for a population

### Re-identification in anonymised datasets

This package **should not be used to attempt to re-identify individuals
in anonymised datasets**. Doing so is likely to breach privacy laws in
many jurisdictions, and is likely to be against the terms of use of the
dataset. Users are strongly urged to adhere to all relevant privacy laws
and ethical guidelines when utilising this package.

## Installation

You can install the development version of dobEstimator from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("bairdj/dobEstimator")
```

## Example

Basic example of the \[estimate_dob()\] function using the above
dataset:

``` r
library(dobEstimator)

print(age_dataset)
#>   age       date
#> 1  20 2010-03-05
#> 2  20 2010-05-06
#> 3  21 2010-07-08
#> 4  23 2012-06-23
#> 5  23 2013-01-01

estimate_dob(age_dataset$age, age_dataset$date)
#> [1] 1989-05-07 UTC--1989-06-23 UTC
```

Note that \[estimate_dob()\] should only be used with data for a single
individual.

If you need to calculate dates of births for multiple individuals, you
should split the age and date vectors by person first.

For example:

``` r
print(multi_dataset)
#>   person_id age       date
#> 1         A  20 2010-01-04
#> 2         A  21 2010-05-03
#> 3         A  21 2010-12-25
#> 4         B  24 2012-04-05
#> 5         B  24 2012-08-02
#> 6         B  26 2014-07-03

library(dplyr, warn.conflicts = FALSE)
multi_dataset %>%
  group_by(person_id) %>%
  summarise(dob = estimate_dob(age, date))
#> # A tibble: 2 × 2
#>   person_id dob                           
#>   <chr>     <Interval>                    
#> 1 A         1989-01-05 UTC--1989-05-03 UTC
#> 2 B         1987-08-03 UTC--1988-04-05 UTC
```
