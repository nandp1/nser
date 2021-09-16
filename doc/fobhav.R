## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----example------------------------------------------------------------------
# Example: Lets download the bhavcopy of 1 July 2021 for Derivatives (F&O). 
library(nser)
report = fobhav("01072021")
head(report)

