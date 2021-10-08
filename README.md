
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

Latest Version: `1.3.3`(07-10-2021)


## New functions `nsetree`, `bhavfos`

* `daytoweek` Convert daily data of a stock to weekly data.

* `nsetree` Get a treeplot plot of NSE NIFTY 50 and FO securities. 

* `bhavfos` Download historical F&O Bhavcopy zip file through RSelenium. 

### NOTE 
* `optnifty`, `optbanknifty` are deprecated.


# Introduction

Welcome to “nser” packge. 

The packge helps you to download historical bhavcopy of Equities and F&O, get live market data, plot treemap of movement in securities and a lot more...


Package website [nser](https://nandp1.github.io/nser/)

## Installation

Install `nser` from [CRAN](https://cloud.r-project.org/web/packages/nser/index.html) by:

``` r
install.packages("nser")
```

Also install development version from github by:

``` r
install.packages("devtools")
library(devtools)
install_github("nandp1/nser")
```
## Here are few examples to get started, 

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


## Example 4. Live F&O data.
``` r
library(nser)
nselive()
```

## Example 5. Pre market open data of F&O stocks
``` r
library(nser)
nseopen("fo")
```

## Example 6. Current and Upcoming IPO's
``` {r example}
library(nser)
nseipo()
```

## Example 7. RSelenium to Download Equity Bhavcopy
``` r
library(nser)
library(RSelenium)

# Start a selenium server and browser
# For Google Chrome (Update Chrome to latest version)

 driver <- rsDriver(browser = c("chrome"), port = 3163L, chromever = "91.0.4472.101")
 remDr <- driver$client

# or for Firefox
 driver <- rsDriver(browser = c("firefox"), port = 3799L)
 
# Download Equity Bhavcopy zip file
bhavs("03012000", 2)

# Close the Browser
remDr$close()

```

## Example 8. RSelenium to Download F&O Bhavcopy
``` r
library(nser)
library(RSelenium)

# Start a selenium server and browser
# For Google Chrome (Update Chrome to latest version)

 driver <- rsDriver(browser = c("chrome"), port = 3163L, chromever = "91.0.4472.101")
 remDr <- driver$client

# or for Firefox
 driver <- rsDriver(browser = c("firefox"), port = 3799L)
 
# Download Equity Bhavcopy zip file
bhavfos("03012000", 2)

# Close the Browser
remDr$close()

```

## Example 9. NSE Treemap 
``` r 
library(nser)
# NIFTY 50 stocks
nsetree()

# F&O stocks
nsetree("fo")
```


