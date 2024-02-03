#' @name optnifty
#' @aliases optnifty
#' @title Option Chain of NSE Nifty 50.
#'
#' @return A dataframe containing option chain of NSE Nifty 50.
#' @author Nandan L. Patil \email{tryanother609@@gmail.com}
#' @details Get visual friendly display of Option chain of NIFTY 50 for the current expiry.
#' @source <https://www.nseindia.com/option-chain>
#' @seealso \code{\link[nser]{optbanknifty}}\code{\link[nser]{bhavtoday}}\code{\link[nser]{bhavfos}}\code{\link[nser]{nsetree}}\code{\link[nser]{nseipo}}
#'
#' @import reticulate
#' @importFrom dplyr bind_rows
#' @export
#'
#' @examples  \dontrun{# Example: NIFTY 50 option chain
#' optnifty()
#' }
optnifty = function(){
  #  check internet connection
  if (!curl::has_internet()) {
    message("No internet connection.")
    return(invisible(NULL))
  }
  x= reticulate::py_run_file(system.file("nseoption.py", package = "nser"))
  dat1 = x$dat1
  dat2 = x$dat2

  aa = lapply(dat1, function(x) x[-c(1,2)])
  aa = lapply(aa, function(x) data.frame(x))
  aa = bind_rows(aa)
  aa = aa[,-c(4, 7, 19, 20, 21, 22, 23, 26)]
  colnames(aa)[c(1:3,30)] <- c("Strike Price", "Expiry Date", "INDEX", "Current Value")
  aa = aa[,c(2:3, 30, 4:16, 1, 17:29)]
  return(aa)
}




