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
#' @examples \donttest{
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
    nlive1 = do.call(rbind.data.frame, nlive1)
    nlive1 = nlive1[, c(2,  5, 6, 7, 8, 9, 10, 11)]
    nlive1  = nlive1 %>% mutate_at(c('open', 'dayHigh', 'dayLow', 'lastPrice', 'previousClose', 'change', 'pChange'), as.numeric)
    nlive1 = nlive1 %>% mutate(symbol = unlist(nlive1$symbol) %>% as.vector())
    colnames(nlive1) <- c("SYMBOL", "OPEN", 'HIGH', 'LOW', 'LAST', 'CLOSE', 'Change', 'pChange')
    live = nlive1
    return(live)
  }
  else if(x == "fo"){
    x= reticulate::py_run_file(system.file("nlive.py", package = "nser"))
    nlive = x$dat2
    nlive = lapply(nlive, function(x) t(x))
    nlive = do.call(rbind.data.frame, nlive)
    nlive = nlive[, c(1, 4, 5, 6, 7, 8, 9, 10)]
    nlive  = nlive %>% mutate_at(c('open', 'dayHigh', 'dayLow', 'lastPrice', 'previousClose', 'change', 'pChange'), as.numeric)
    nlive = nlive %>% mutate(symbol = unlist(nlive$symbol) %>% as.vector())
    colnames(nlive) <- c("SYMBOL", "OPEN", 'HIGH', 'LOW', 'LAST', 'CLOSE', 'Change', 'pChange')
    live = nlive
    return(live)
  }
}
