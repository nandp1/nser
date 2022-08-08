#' @name bhavtoday
#' @aliases bhavtoday
#'
#' @title Get Bhavcopy for the present day
#'
#' @param se Stock Exchange either 'NSE' or 'BSE'. Default is 'NSE'.
#'
#' @note The date should be strictly numerical and mentioned in quotation mark.The present days Bhavcopy would usually available in the evening
#' @return Todays's Bhavcopy.
#' @author Nandan L. Patil \email{tryanother609@@gmail.com}
#' @details Gets todays bhavcopy from NSE. The function tries to get the bhavcopy from two sources Old and New website of NSE.
#'
#' @source <https://www1.nseindia.com/products/content/all_daily_reports.htm>, <https://www.bseindia.com/markets/marketinfo/BhavCopy.aspx>
#'
#' @seealso \code{\link[nser]{bhavpr}}\code{\link[nser]{bhav}}
#'
#' @import stats
#' @importFrom utils download.file read.csv unzip
#' @importFrom curl has_internet
#'
#' @export
#' @examples \dontrun{
#' #Todays NSE Equity Bhavcopy
#' library(nser)
#' report = bhavtoday()
#'
#' #Todays BSE Equity Bhavcopy
#' report = bhavtoday('BSE')
#' }
bhavtoday = function(se = 'NSE')
{
  if (!curl::has_internet()) {
    message("No internet connection.")
    return(invisible(NULL))
  }

  baseurl = "https://archives.nseindia.com/content/historical/EQUITIES/"
  end = ".csv.zip"
  month = format(Sys.time(), "%m")
  mt1 = month
  month = as.integer(month)
  month = month.abb[month]
  month = toupper(month)
  year = format(Sys.time(), "%Y")
  date = format(Sys.time(), "%d")

  bhavurl = paste0(baseurl, year, "/", month, "/cm", date, month, year, "bhav", end)
  name = paste0(date, month, year)
  zipname = paste0("cm", date, month, year, "bhav", ".csv")

  nsebhav = function(x){
  temp = tempfile()
  download.file(bhavurl, temp)
  df = read.csv(unz(temp, filename = zipname))
  unlink(temp)
  return(df)
  }

  dy = date
  yr1 = substr(year, start = 3, stop = 4)


  bseurl = paste0('https://www.bseindia.com/download/BhavCopy/Equity/EQ_ISINCODE_', dy, mt1, yr1, '.zip')
  bsezip = paste0('EQ_ISINCODE_', dy, mt1, yr1, '.CSV')

  #BSE bhavcopy
  bsebhav = function(x){
  temp = tempfile()
  download.file(bseurl, temp)
  df = read.csv(unz(temp, filename = bsezip))
  unlink(temp)
  return(df)
  }

  if(se == 'NSE'){
    df = nsebhav()
  }else if(se == 'BSE') df = bsebhav()

  return(df)
}
