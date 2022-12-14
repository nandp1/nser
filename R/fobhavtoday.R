#' @name fobhavtoday
#' @aliases fobhavtoday
#'
#' @title Get F&O Bhavcopy for the present day
#'
#' @note The date should be strictly numerical and mentioned in quotation mark.The present days Bhavcopy would usually available in the evening.
#' @return Todays's F&O Bhavcopy.
#' @author Nandan L. Patil \email{tryanother609@@gmail.com}
#' @details Gets todays Futures and Options bhavcopy from NSE.
#'
#' @seealso \code{\link[nser]{bhavpr}}\code{\link[nser]{bhav}}
#'
#' @import stats
#' @importFrom utils download.file read.csv unzip
#' @importFrom curl has_internet
#'
#' @export
#' @examples \donttest{
#' #Todays F&O Bhavcopy
#' library(nser)
#' report = fobhavtoday()
#' }
fobhavtoday = function()
{
  # First check internet connection
  if (!curl::has_internet()) {
    message("No internet connection.")
    return(invisible(NULL))
  }

  baseurl = "https://archives.nseindia.com/content/historical/DERIVATIVES/"
  end = ".csv.zip"
  month = format(Sys.time(), "%m")
  month = as.integer(month)
  month = month.abb[month]
  month = toupper(month)
  year = format(Sys.time(), "%Y")
  date = format(Sys.time(), "%d")

  bhavurl = paste0(baseurl, year, "/", month, "/fo", date, month, year, "bhav", end)
  name = paste0(date, month, year)
  zipname = paste0("fo", date, month, year, "bhav", ".csv")

  temp <- tempfile()
  download.file(bhavurl, temp)
  file <-  read.csv(unz(temp, filename = zipname))
  unlink(temp)
  return(file)
}


