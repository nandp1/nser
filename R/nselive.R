#' @name nselive
#' @aliases nselive
#'
#' @title NSE Live Market data
#'
#' @param x "n50" and "fo" for nifty 50 and F&O. DEFAULT value is "n50".
#'
#' @note NSE pre-open market 09.00 hrs to 9.08 hrs (IST). Regular Trading Session 09.15 hrs to 15.30 hrs (IST)
#' @return A dataframe with NSE Live market data.
#' @author Nandan L. Patil \email{tryanother609@@gmail.com}
#' @details Get live NSE market data of Nifty 50 and Futures & Options
#' @source <https://www.nseindia.com/market-data/live-market-indices>
#' @seealso \code{\link[nser]{bhavpr}}\code{\link[nser]{bhav}}\code{\link[nser]{fobhavtoday}}\code{\link[nser]{nseindex}}\code{\link[nser]{nseopen}}
#'
#' @import reticulate dplyr
#' @importFrom curl has_internet
#'
#' @export
#' @examples \dontrun{
#' # NSE Live market data for Nifty 50 stocks
#' library(nser)
#' nselive()
#'
#' # Live market for F&O stocks
#' nselive("fo")
#' }
nselive = function(x = "n50"){
  #  check internet connection
  if (!curl::has_internet()) {
    message("No internet connection.")
    return(invisible(NULL))
  }

  if(x == "n50"){

    x= reticulate::py_run_file(system.file("nlive.py", package = "nser"))
    nlive = x$dat1
    nlive = lapply(nlive, function(x) t(x))
    nlive1 = nlive[-1]
    nlive1 = cbind.data.frame(
      SYMBOL = unname(sapply(nlive1, `[[`, 2)),
      OPEN  = unname(sapply(nlive1, `[[`, 5)),
      HIGH  = unname(sapply(nlive1, `[[`, 6)),
      LOW  = unname(sapply(nlive1, `[[`, 7)),
      LAST   = unname(sapply(nlive1, `[[`, 8)),
      previousCLOSE   = unname(sapply(nlive1, `[[`, 9)),
      CHANGE    = unname(sapply(nlive1, `[[`, 10)),
      pCHANGE    = unname(sapply(nlive1, `[[`, 11)),
      totalVOLUME    = unname(sapply(nlive1, `[[`, 12)),
      totalVALUE    = unname(sapply(nlive1, `[[`, 13))
    )
    nlive1 = nlive1 %>% mutate_at(c("OPEN", "HIGH", "LOW",
                                  "LAST", "previousCLOSE", "CHANGE", "pCHANGE", "totalVOLUME", "totalVALUE"),
                                as.numeric)
    live = nlive1
    return(live)
  }
  else if(x == "fo"){
    x= reticulate::py_run_file(system.file("nlive.py", package = "nser"))
    nlive = x$dat2
    nlive = lapply(nlive, function(x) t(x))

    nlive = cbind.data.frame(
      SYMBOL = unname(sapply(nlive, `[[`, 1)),
      OPEN  = unname(sapply(nlive, `[[`, 4)),
      HIGH  = unname(sapply(nlive, `[[`, 5)),
      LOW  = unname(sapply(nlive, `[[`, 6)),
      LAST   = unname(sapply(nlive, `[[`, 7)),
      previousCLOSE   = unname(sapply(nlive, `[[`, 8)),
      CHANGE    = unname(sapply(nlive, `[[`, 9)),
      pCHANGE    = unname(sapply(nlive, `[[`, 10)),
      totalVOLUME    = unname(sapply(nlive, `[[`, 11)),
      totalVALUE    = unname(sapply(nlive, `[[`, 12))
    )
    nlive = nlive %>% mutate_at(c("OPEN", "HIGH", "LOW",
                                  "LAST", "previousCLOSE", "CHANGE", "pCHANGE", "totalVOLUME", "totalVALUE"),
                                as.numeric)
    live = nlive
    return(live)
  }
}
