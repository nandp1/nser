#' @name bhavpr
#' @aliases bhavpr
#'
#' @title  Bhavcopy PR from NSE
#'
#' @param x numeric date format
#'
#' @note The date should be strictly numerical and mentioned in quotation mark.
#' @return List of Bhavcopy PR for the given date.
#' @author Nandan L. Patil \email{tryanother609@@gmail.com}
#' @details Gets Bhavcopy PR from NSE for the given date.
#'
#' @seealso \code{\link[nser]{bhav}}\code{\link[nser]{bhavtoday}}
#'
#' @import stats
#' @importFrom utils download.file read.csv unzip
#' @importFrom readr read_csv
#' @export
#'
#' @examples \dontrun{
#' # Equity Bhavcopy PR
#' library(nser)
#' report = bhavpr("01072021")
#' }
bhavpr = function(x){
  if(!nchar(gsub("[^0-9]+", "", x)) == 8){
    print("Check the date. It should be an Eight digit interger.")
  } else{
  x = as.character(x)
  dy = substr(x, start = 0, stop = 2)
  mt = substr(x, start = 3, stop = 4)
  yrt = substr(x, start = 7, stop = 8)
  baseurl = "https://archives.nseindia.com/archives/equities/bhavcopy/pr/"
  end = ".zip"
  bhavurl = paste0(baseurl, "PR", dy, mt, yrt, end)
  temp <- tempfile()
  download.file(bhavurl, temp)
  unzip(temp)
  files <- list.files(pattern = ".csv", full.names = T)
  tbl <- sapply(files, read_csv)
  unlink(temp)
  return(tbl)
  }
}
