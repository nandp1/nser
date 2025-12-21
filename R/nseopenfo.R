#' @name nseopenfo
#' @aliases nseopenfo
#'
#' @title NSE Derivatives Pre Open Market of current month's future stock.
#'
#' @param x "fo" for F&O stocks,
#'
#' @note NSE market opening time is 9.00 AM (IST). The NSE pre market closes at 9.08 AM (IST).
#' @return A dataframe with Derivatives Pre Open Market of current month's future stock.
#' @author Nandan L. Patil \email{tryanother609@@gmail.com}
#' @details Get Derivatives Pre Open Market of current month's future stock.
#' @source <https://www1.nseindia.com/live_market/dynaContent/live_watch/pre_open_market/pre_open_market.htm>
#' @seealso \code{\link[nser]{bhavpr}}\code{\link[nser]{bhav}}\code{\link[nser]{fobhavtoday}}
#'
#' @import reticulate dplyr
#' @importFrom curl has_internet
#'
#' @export
#' @examples \dontrun{
#'
#' # Pre open market data of Current Months Futures of F&O stocks
#' library(nser)
#' nseopenfo()
#' }

nseopenfo = function(x = "fo"){
    x= reticulate::py_run_file(system.file("npofo.py", package = "nser"))
    npo = x$dat1
    npo1 = lapply(npo,`[[`, 1)
    npo1 = lapply(npo1, function(x)
      t(x))
    npo1 = do.call(rbind.data.frame, npo1)
    npo1 = npo1[c("symbol", "lastPrice", "change",'pChange', 'previousClose', 'iep')]
    po <- npo1 %>% mutate_at(c('symbol'), as.character)
    po <- po %>% mutate_at(c('lastPrice', 'change', 'pChange', 'previousClose', 'iep'), as.numeric)
    po = po %>% mutate(symbol = unlist(po$symbol) %>% as.vector())
    colnames(po) <- c("SYMBOL", "Price","Change", "pChange", "Prev.Close", 'IEP')
    po = po %>% mutate_if(is.numeric, ~round(., 2))
    return(po)
}
