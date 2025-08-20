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
#' @importFrom utils download.file read.csv unzip
#' @importFrom curl has_internet
#'
#' @export
#' @examples \donttest{
#' #Todays F&O Bhavcopy
#' library(nser)
#' try(stop(report = fobhavtoday()))
#' }
fobhavtoday = function()
{
  # First check internet connection
  if (!curl::has_internet()) {
    message("No internet connection.")
    return(invisible(NULL))
  }

  x = as.character(x)
  dy = substr(x, start = 0, stop = 2)
  mt = substr(x, start = 3, stop = 4)
  yr = substr(x, start = 5, stop = 8)

  # NSE Bhavcopy
  nseurl = paste0("https://nsearchives.nseindia.com/content/fo/BhavCopy_NSE_FO_0_0_0_", yr, mt, dy, "_F_0000.csv.zip")
  #url <- "https://nsearchives.nseindia.com/content/fo/BhavCopy_NSE_FO_0_0_0_20240809_F_0000.csv.zip"
  UA <- paste('Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0)',
              'Gecko/20100101 Firefox/98.0')
  res <- GET(nseurl, add_headers(`User-Agent` = UA, Connection = 'keep-alive'))

  temp_file <- tempfile() # create temporary file
  writeBin(content(res), temp_file) # unzip CSV results to temporary file
  df <- read_csv(temp_file) # read in temporary csv file to dataframe
  file.remove(temp_file)

  return(df)
}


