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
#' @source <https://www1.nseindia.com/live_market/dynaContent/live_watch/equities_stock_watch.htm?cat=N>
#' @seealso \code{\link[nser]{bhavpr}}\code{\link[nser]{bhav}}\code{\link[nser]{fobhavtoday}}\code{\link[nser]{nseindex}}\code{\link[nser]{nseopen}}
#'
#' @import stats
#' @importFrom jsonlite fromJSON
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
  if(x == "n50"){
    dat = fromJSON('https://www1.nseindia.com/live_market/dynaContent/live_watch/stock_watch/niftyStockWatch.json')
    live = dat[["data"]]
    live = live[,-c(9,11,14, 15, 16, 17, 20, 21)]
    live = `colnames<-`(live, c("SYMBOL", "OPEN", "HIGH", "LOW", "LTP", "Change", "pChange", "Volume (lacs)", "Turnover (crs)", "52 week High", "52 week Low", "Previous CLOSE", "CLOSE", "52 week % Change", "30 day % Change"))
    num = sapply(live[,(2:15)], function(x) as.numeric(gsub(",","",x)))
    num = as.data.frame(num)
    num$SYMBOL = live$SYMBOL
    num = num[,c(15,1:14)]
    adv = dat[["advances"]]
    dec = dat[["declines"]]
    time = dat[["time"]]
    message("\nAdvances ", adv, "\n",
            "\nDeclines ", dec, "\n",
            "\nTime ", time, "\n")
    return(num)
  }
  else if(x == "fo"){
    dat = fromJSON('https://www1.nseindia.com/live_market/dynaContent/live_watch/stock_watch/foSecStockWatch.json')
    live = dat[["data"]]
    live = live[,-c(9,11,14, 15, 16, 17, 20, 21)]
    live = `colnames<-`(live,c("SYMBOL", "OPEN", "HIGH", "LOW", "LTP", "Change", "pChange", "Volume (lacs)", "Turnover (crs)", "52 week High", "52 week Low", "52 week % Change", "30 day % Change"))
    num = sapply(live[,(2:13)], function(x) as.numeric(gsub(",","",x)))
    num = as.data.frame(num)
    num$SYMBOL = live$SYMBOL
    num = num[,c(13,1:12)]
    adv = dat[["adv"]]
    dec = dat[["dec"]]
    time = dat[["time"]]
    message("\nAdvances ", adv, "\n",
            "\nDeclines ", dec, "\n",
            "\nTime ", time, "\n")
    return(num)
  }
}
