#' @name nseopen
#' @aliases nseopen
#'
#' @title NSE Pre Open Market data
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
#' @import reticulate dplyr
#' @importFrom curl has_internet
#'
#' @export
#' @examples \dontrun{
#' # NSE Pre market open data of Nifty 50 stocks
#' library(nser)
#' nseopen("n50")
#'
#' # Pre open market data of F&O stocks
#' nseopen("fo")
#' }

nseopen = function(x = "n50"){
  if(x == "n50"){
    x= reticulate::py_run_file(system.file("npo.py", package = "nser"))
    npo = x$dat2
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
  else if(x == "fo"){
    x= reticulate::py_run_file(system.file("npo.py", package = "nser"))
    npo = x$dat1
    npo1 = lapply(npo,`[[`, 1)
    npo1 = lapply(npo1, function(x)
      t(x))
    npo1 = do.call(rbind.data.frame, npo1)
    npo1 = npo1[c("symbol", "lastPrice", "change",'pChange', 'previousClose', 'iep')]
    po <- npo1 %>% mutate_at(c('symbol'), as.character)
    po <- po %>% mutate_at(c('lastPrice', 'change', 'pChange', 'previousClose', 'iep'), as.numeric)
    po  = po %>% mutate_at(c('symbol'), as.character())
    colnames(po) <- c("SYMBOL", "Price","Change", "pChange", "Prev.Close", 'IEP')
    po = po %>% mutate_if(is.numeric, ~round(., 2))
    return(po)
  }
  else if(x == "all"){
    x= reticulate::py_run_file(system.file("npo.py", package = "nser"))
    npo = x$dat3
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
}
