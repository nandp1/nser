#' @name bhavtoday
#' @aliases bhavtoday
#'
#' @title Get Bhavcopy for the present day from NSE and BSE
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
#' @importFrom httr GET content add_headers
#'
#' @export
#' @examples \dontrun{
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

  month = format(Sys.time(), "%m")
  mt1 = month
  month = as.integer(month)
  month = month.abb[month]
  month = toupper(month)
  year = format(Sys.time(), "%Y")
  date = format(Sys.time(), "%d")

  nsebhav = function(){
    nseurl = paste0("https://nsearchives.nseindia.com/products/content/sec_bhavdata_full_", date, mt1, year, ".csv")
    #url <- "https://nsearchives.nseindia.com/products/content/sec_bhavdata_full_02012019.csv"
    UA <- paste('Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0)',
                'Gecko/20100101 Firefox/98.0')
    res <- GET(nseurl, add_headers(`User-Agent` = UA, Connection = 'keep-alive'))
    df1 = content(res)
    df1 = df1[,c(-10,-14, -15)]
    df1 = df1[,c(1,2,5,6,7,9,8,4,10,11,3,12)]
    df1$ISIN = ''
    df1$X = ''
    colnames(df1) <- c("SYMBOL","SERIES","OPEN","HIGH","LOW","CLOSE","LAST","PREVCLOSE" ,
                       "TOTTRDQTY","TOTTRDVAL","TIMESTAMP","TOTALTRADES" ,"ISIN","X")
    return(df1)
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
    df = tryCatch(nsebhav(), error=function(e) nsebhav(), warning = function(w) conditionMessage(w))
  }else if(se == 'BSE') df = tryCatch(bsebhav(), error = function(e) conditionMessage(e),
                                      warning = function(w) conditionMessage(w))

  return(df)
}
