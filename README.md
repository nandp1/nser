<!-- badges: start -->
[![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/nser)](https://cran.r-project.org/package=nser)
[![cran checks](https://cranchecks.info/badges/summary/nser)](https://cran.r-project.org/web/checks/check_results_nser.html)
[![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable-1)
![Downloads](http://cranlogs.r-pkg.org/badges/nser)
[![](https://cranlogs.r-pkg.org/badges/grand-total/nser)](https://cran.r-project.org/package=nser)
<!-- badges: end -->

# Introduction

"nser" helps you to download historical bhavcopy and get live market data of Equities and F&O segment easily. 

## New functions
* `nselive` Get live NSE market data
* `nseopen` Get Pre open market data
* `nseindex` Get Live report of NSE Indices
* `nseipo` Current and Upcoming IPO's on NSE

Package website [nser](https://nandp1.github.io/nser/)

## Installation

Install "nser" from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("nser")
```
Install it from github by:
``` r
install.packages("devtools")
library(devtools)
install_github("nandp1/nser")
```

## Example 1. Downloading Historical Equity Bhavcopy 

```{r example}
library(nser)
# Download Bhavcopy of 1st July 2021
report1 = bhav("01072021")
```

## Example 2. Downloading Historical F&O Bhavcopy 

```{r example}
library(nser)
# Download Bhavcopy of 1st July 2021
report2 = fobhav("01072021")
```
## Example 3. Downloading today's Equity and F&O Bhavcopy 
```{r example}
library(nser)
report3 = bhavtoday()
report4 = fobhavtoday()
```

## Example 4. Live F&O data.
```{r example}
library(nser)
nselive()
```

## Example 5. Pre market open data of F&O stocks
```{r example}
library(nser)
nseopen("fo")
```

## Example 6. Current and Upcoming IPO's
```{r eaxample}
library(nser)
nseipo()
```
