#' @name bhavtoday
#' @aliases bhavtoday
#'
#' @title Get Bhavcopy for the present day
#'
#' @note The date should be strictly numerical and mentioned in quotation mark.The present days Bhavcopy would usually available in the evening
#' @return Todays's Bhavcopy.
#' @author Nandan L. Patil \email{tryanother609@@gmail.com}
#' @details Gets todays bhavcopy from NSE.
#'
#' @seealso \code{\link[nser]{bhavpr}}\code{\link[nser]{bhav}}
#'
#' @import stats
#' @importFrom utils download.file read.csv unzip
#' @export
#' @examples \dontrun{
#' #Todays Equity Bhavcopy
#' library(nser)
#' report = bhavtoday()
#' }
bhavtoday = function()
{
  baseurl = "https://archives.nseindia.com/content/historical/EQUITIES/"
  end = ".csv.zip"
  month = format(Sys.time(), "%m")
  month = as.integer(month)
  month = month.abb[month]
  month = toupper(month)
  year = format(Sys.time(), "%Y")
  date = format(Sys.time(), "%d")

  bhavurl = paste0(baseurl, year, "/", month, "/cm", date, month, year, "bhav", end)
  name = paste0(date, month, year)
  zipname = paste0("cm", date, month, year, "bhav", ".csv")

  temp <- tempfile()
  download.file(bhavurl, temp)
  file <-  read.csv(unz(temp, filename = zipname))
  unlink(temp)
  assign(name, file)
  return(file)
}
