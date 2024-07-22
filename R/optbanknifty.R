#' @name optbanknifty
#' @aliases optbanknifty
#' @title Option Chain of NSE BANKNIFTY (current expiry date).
#'
#' @return A dataframe containing option chain of NSE BANKNIFT current expiry date.
#' @author Nandan L. Patil \email{tryanother609@@gmail.com}
#' @details Option chain of BANKNIFTY for the current expiry.
#' @source <https://www.nseindia.com/option-chain>
#' @seealso \code{\link[nser]{optnifty}}\code{\link[nser]{bhavtoday}}\code{\link[nser]{nselive}}\code{\link[nser]{nsetree}}\code{\link[nser]{nseipo}}
#'
#' @import reticulate
#' @importFrom dplyr bind_rows
#' @export
#'
#' @examples  \dontrun{ # Example: BANKNIFTY option chain
#' optbanknifty()
#' }
optbanknifty = function(){
  #  check internet connection
  if (!curl::has_internet()) {
    message("No internet connection.")
    return(invisible(NULL))
  }

  x= reticulate::py_run_file(system.file("nseoption.py", package = "nser"))
  dat2 = x$dat2

  aa = lapply(dat2, function(x) x[-c(1,2)])
  aa = lapply(aa, function(x) data.frame(x))
  aa = bind_rows(aa)
  aa = aa[,-c(4, 7, 19, 20, 21, 22, 23, 26)]
  colnames(aa)[c(1:3,30)] <- c("Strike Price", "Expiry Date", "INDEX", "Current Value")
  aa = aa[,c(2:3, 30, 4:16, 1, 17:29)]
  return(aa)
}
