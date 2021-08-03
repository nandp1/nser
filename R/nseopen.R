#' @name nseopen
#' @aliases nseopen
#'
#' @title NSE Pre Open Market
#'
#' @param x "fo" for F&O stocks, "all" for all the stocks. Default is "n50" for NIFTY 50 stocks.
#'
#' @note NSE market opening time is 9.00 AM (IST). The NSE pre market closes at 9.08 AM (IST).
#' @return A dataframe with NSE Pre open market data.
#' @author Nandan L. Patil \email{tryanother609@@gmail.com}
#' @details Get NSE Pre open market data.
#' @source <https://www1.nseindia.com/live_market/dynaContent/live_watch/pre_open_market/pre_open_market.htm>
#' @seealso \code{\link[nser]{bhavpr}}\code{\link[nser]{bhav}}\code{\link[nser]{fobhavtoday}}
#'
#' @import stats
#' @importFrom jsonlite fromJSON
#' @export
#' @examples \dontrun{
#' # NSE Pre market open data of Nifty 50 stocks
#' library(nser)
#' nseopen("n50")
#'
#' # Pre market for F&O stocks
#' nseopen("fo")
#' }
nseopen = function(x = "n50"){
  if(x == "n50"){
dat = fromJSON('https://www1.nseindia.com/live_market/dynaContent/live_analysis/pre_open/nifty.json')
open = dat[["data"]]
open = open[,-c(2,3,4,14,15,16,17)]
open = `colnames<-`(open, c("SYMBOL", "Price", "Change", "%Change", "Prev.Close", "Quantity", "Value(in lakhs)", "FFM Caps(crs.)", "52 Week High", "52 Week Low"))
adv = dat[["advances"]]
dec = dat[["declines"]]
nc = dat[["noChange"]]
message("\nAdvances - ", adv, "\n",
        "\nDeclines - ", dec, "\n",
        "\nNo Change - ", nc, "\n")
return(open)
  }
  else if(x == "fo"){
    dat = fromJSON('https://www1.nseindia.com/live_market/dynaContent/live_analysis/pre_open/fo.json')
    open = dat[["data"]]
    open = open[,-c(2,3,4,14,15,16,17)]
    open = `colnames<-`(open, c("SYMBOL", "Price", "Change", "%Change", "Prev.Close", "Quantity", "Value(in lakhs)", "FFM Caps(crs.)", "52 Week High", "52 Week Low"))
    adv = dat[["advances"]]
    dec = dat[["declines"]]
    nc = dat[["noChange"]]
    message("\nAdvances - ", adv, "\n",
            "\nDeclines - ", dec, "\n",
            "\nNo Change - ", nc, "\n")
    return(open)
  }
  else if(x == "all"){
    dat = fromJSON('https://www1.nseindia.com/live_market/dynaContent/live_analysis/pre_open/all.json')
    open = dat[["data"]]
    open = open[,-c(2,3,4,14,15,16,17)]
    open = `colnames<-`(open, c("SYMBOL", "Price", "Change", "%Change", "Prev.Close", "Quantity", "Value(in lakhs)", "FFM Caps(crs.)", "52 Week High", "52 Week Low"))
    adv = dat[["advances"]]
    dec = dat[["declines"]]
    nc = dat[["noChange"]]
    message("\nAdvances - ", adv, "\n",
            "\nDeclines - ", dec, "\n",
            "\nNo Change - ", nc, "\n")
    return(open)
    }
}
