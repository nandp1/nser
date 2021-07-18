
<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- badges: start -->

[![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/nser)](https://cran.r-project.org/package=nser)
[![cran
checks](https://cranchecks.info/badges/summary/nser)](https://cran.r-project.org/web/checks/check_results_nser.html)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable-1)
![Downloads](http://cranlogs.r-pkg.org/badges/nser)
[![](https://cranlogs.r-pkg.org/badges/grand-total/nser)](https://cran.r-project.org/package=nser)
<!-- badges: end -->

# Introduction

“nser” helps you to download historical bhavcopy of Equities and F\&O
segment easily.

Package website [nser](https://nandp1.github.io/nser/)

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

## Example 1. Downloading Historical Equity Bhavcopy

``` r
library(nser)
# Download Bhavcopy of 1st July 2021
report1 = bhav("01072021")
```

## Example 2. Downloading Historical F\&O Bhavcopy

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
