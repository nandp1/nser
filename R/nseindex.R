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
#' @import dplyr reticulate
#' @importFrom dplyr mutate_at
#' @importFrom dplyr mutate_if
#' @importFrom curl has_internet
#'
#' @export
#' @examples \donttest{
#' #Live status of Nifty Indices
#' library(nser)
#' nseindex()
#' }
nseindex = function(){
  # First check internet connection
  if (!curl::has_internet()) {
    message("No internet connection.")
    return(invisible(NULL))
  }
  x= reticulate::py_run_file(system.file("nindex.py", package = "nser"))
  nindex = x$dat4

  nindex = lapply(nindex,`[`, c('index', 'last', 'variation', 'percentChange', 'open', 'high', 'low', 'previousClose',
                                'previousDay'))
  nindex = lapply(nindex, function(x) t(x))
  nindex = do.call(rbind.data.frame, nindex)

  po <- nindex %>% mutate_at(c('index'), as.character)
  po <- po %>% mutate_at(c('last', 'variation', 'percentChange', 'open', 'high', 'low', 'previousClose',
                           'previousDay'), as.numeric)
  po = po %>% mutate_if(is.numeric, ~round(., 2))
  return(po)
}
