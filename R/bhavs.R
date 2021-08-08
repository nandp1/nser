#' @name bhavs
#' @aliases bhavs
#' @title Equity Bhavcopy through RSelenium
#'
#' @param x numeric date format (ddmmyyyy)
#' @param n  time interval to delay in seconds. DEFAULT = 0
#'
#' @note The date should be strictly numerical of format 'ddmmyyyy' and mentioned in quotation mark.
#'
#' @return Download Equity Bhavcopy zip file of the given date.
#'
#' @author Nandan L. Patil \email{tryanother609@@gmail.com}
#'
#' @details Gets zip Bhavcopy from NSE for the given date.
#' @source <https://www1.nseindia.com/products/content/equities/equities/archieve_eq.htm>
#' @seealso \code{\link[nser]{bhavpr}}\code{\link[nser]{bhavtoday}}\code{\link[nser]{bhav}}\code{\link[nser]{fobhav}}
#'
#' @import stats
#' @import RSelenium
#' @importFrom utils download.file read.csv unzip
#'
#' @export
#'
#' @examples \dontrun{#
#'# Start a selenium server and browser
#'# For Google Chrome (Update Chrome to latest version)
#' driver = rsDriver(browser = c("chrome"), port = 3163L, chromever = "91.0.4472.101")
#' remDr = driver$client
#'
#'# For Firefox
#' driver = rsDriver(browser = c("firefox"), port = 3799L)
#'
#'# Download Equity Bhavcopy zip file
#' bhavs("03012000", 3)
#'
#' # Close the Browser
#' remDr$close()
#'}

bhavs = function(x, n = 0){
  Sys.sleep(n)
  x = as.character(x)
  dy = substr(x, start = 0, stop = 2)
  mt = substr(x, start = 3, stop = 4)
  yr = substr(x, start = 5, stop = 8)
  baseurl = "https://www1.nseindia.com/ArchieveSearch?h_filetype=eqbhav&date="
  end = "&section=EQ"
  bhavurl = paste0(baseurl, dy, "-", mt, "-", yr, end)
  zipname = paste0("cm", dy, mt, yr, "bhav", ".csv", ".zip")

  remDr$navigate(bhavurl)
  address_element1 <- remDr$findElement(using ="xpath", '/html/body/table/tbody/tr/td/a[1]')
  Sys.sleep(n)
  address_element1$clickElement()
}
