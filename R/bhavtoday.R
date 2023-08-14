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
#' @source <https://www.nseindia.com/all-reports>, <https://www.bseindia.com/markets/marketinfo/BhavCopy.aspx>
#'
#' @seealso \code{\link[nser]{bhavpr}}\code{\link[nser]{bhav}}
#'
#' @importFrom utils download.file read.csv unzip
#' @importFrom curl has_internet
#'
#' @export
#' @examples \donttest{
#'
#' #Todays NSE Equity Bhavcopy, the data would be available usually after 6.30 PM.
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
    df = tryCatch(nsebhav(), error=function(e) conditionMessage(w),
                  warning = function(w) conditionMessage(w))
  }else if(se == 'BSE') df = tryCatch(bsebhav(), error = function(e) conditionMessage(e),
                                      warning = function(w) conditionMessage(w))

  return(df)
}
