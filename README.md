
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
bhav("01072021")
```

## Example 2. Downloading Historical F\&O Bhavcopy

``` r
library(nser)
# Download Bhavcopy of 1st July 2021
fobhav("01072021")
```

## Example 3. Downloading today’s Equity and F\&O Bhavcopy

``` r
library(nser)
bhavtoday()
fobhavtoday()
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
# NIFTY 50 stocks (26/10/2021)
nsetree()
```
<img src="nsetree.png" style="display: block; margin: auto;" />

### F&O stocks  (26/10/2021)
```
nsetree("fo") 
```
<img src="nsetreefo.png" style="display: block; margin: auto;" />

## Example 10. Daily data to Weelkly data
``` r 
library(nser)
data(dailydata)
daytoweek(dailydata)
    SYMBOL   OPEN   HIGH    LOW  CLOSE weekstartdate weekenddate
1     SBIN 250.10 262.00 244.35 260.95    2019-10-09  2019-10-11
2     SBIN 256.95 271.35 254.00 255.45    2019-10-14  2019-10-18
3     SBIN 270.40 284.95 248.65 270.50    2019-10-22  2019-10-27
4     SBIN 283.15 317.80 278.55 280.65    2019-10-29  2019-11-01
5     SBIN 316.00 323.30 312.35 314.30    2019-11-04  2019-11-08
6     SBIN 314.70 323.70 299.70 318.25    2019-11-11  2019-11-15
7     SBIN 324.00 333.80 322.10 325.10    2019-11-18  2019-11-22
8     SBIN 329.00 351.00 328.35 336.10    2019-11-25  2019-11-29
9     SBIN 343.90 344.60 318.00 338.50    2019-12-02  2019-12-06
10    SBIN 318.95 333.45 308.00 316.70    2019-12-09  2019-12-13
11    SBIN 335.95 339.50 324.50 331.85    2019-12-16  2019-12-20
```


