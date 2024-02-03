.onAttach <- function(libname, pkgname) {
  invisible(suppressPackageStartupMessages(
    sapply(c("dplyr", "googleVis", "jsonlite"),
           requireNamespace, quietly = TRUE)
  ))
}

foo <- NULL

.onLoad <- function(libname, pkgname) {
  foo <<- import("requests", delay_load = TRUE)
}
