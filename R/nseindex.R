#' @name nseindex
#' @aliases nseindex
#'
#' @title NSE Nifty Indices
#'
#' @return A dataframe containing last price and % change of Nifty Indices.
#' @author Nandan L. Patil \email{tryanother609@@gmail.com}
#' @details Live report of Nifty Indices
#' @source <https://www1.nseindia.com/live_market/dynaContent/live_watch/live_index_watch.htm>
#' @seealso \code{\link[nser]{bhavpr}}\code{\link[nser]{bhav}}\code{\link[nser]{fobhavtoday}}\code{\link[nser]{nseopen}}\code{\link[nser]{nselive}}
#'
#' @import stats
#' @importFrom jsonlite fromJSON
#' @export
#' @examples \dontrun{
#' #Live status of Nifty Indices
#' library(nser)
#' nseindex()
#' }
nseindex = function(){
  dat = fromJSON('https://www1.nseindia.com/homepage/Indices1.json')
  live = dat[["data"]]
  live = live[,-5]
  live = `colnames<-`(live, c("NAME", "Last Price", "Change", "% Change"))
  time = dat[["time"]]
  status = dat[["status"]]
  message("\n", status, "\n",
          "\nTime ", time, "\n")
  return(live)
}
