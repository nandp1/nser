.onAttach <- function(libname, pkgname) {
  invisible(suppressPackageStartupMessages(
    sapply(c("dplyr", "googleVis", "jsonlite"),
           requireNamespace, quietly = TRUE)
  ))
}

