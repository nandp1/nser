
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Introduction

“nser” helps you to download historical bhavcopy of Equities and F\&O
segment easily.

## Installation

You can install “nser” from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("nser")
```

You can also install it from github by:

``` r
install.packages("devtools")
library(devtools)
install_github("nandp1/nser")
```

## Example 1. Downloading Equity Bhavcopy

``` r
library(nser)
# Download Bhavcopy of 1st July 2021
report1 = bhav("01072021")
```

## Example 2. Downloading F\&O Bhavcopy

``` r
library(nser)
# Download Bhavcopy of 1st July 2021
report2 = fobhav("01072021")
```

## Example 3. Downloading today’s Equity and F\&O Bhavcopy

``` r
library(nser)
report3 = bhavtoday()
report4 = fobhavtoday()
```
