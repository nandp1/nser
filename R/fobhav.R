#' @name fobhav
#' @aliases fobhav
#' @title Futures and Options Bhavcopy from NSE
#'
#' @param x numeric date format
#'
#' @note The date should be strictly numerical and mentioned in quotation mark (refer examples). `fobhav` can be used to download NSE bhavcopy from 1 Jan 2020 on wards.
#' @return F&O Bhavcopy for the given date.
#' @author Nandan L. Patil \email{tryanother609@@gmail.com}
#' @details Gets Futures and Options Bhavcopy from NSE for the given date.
#' @source <https://www.nseindia.com/all-reports>
#'
#' @seealso \code{\link[nser]{bhavpr}}\code{\link[nser]{bhavtoday}}
#'
#' @importFrom utils download.file read.csv unzip
#' @importFrom curl has_internet
#' @importFrom httr GET content add_headers
#'
#' @export
#'
#' @examples \dontrun{
#' report = fobhav("09122025") # Download F&O bhavcopy for 01 July 2021
#' }
fobhav = function(x){
  # check internet connection
  if (!curl::has_internet()) {
    message("No internet connection.")
    return(invisible(NULL))
  }

if(!nchar(gsub("[^0-9]+", "", x)) == 8){
  message("Check the date. It should be an Eight digit interger.")
} else{
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
       #writeBin(content(res), temp_file) # unzip CSV results to temporary file

      tryCatch(writeBin(content(res), temp_file), error=function(e) conditionMessage(e),
                     warning = function(w) conditionMessage(w))

       df <- read_csv(temp_file) # read in temporary csv file to dataframe
       file.remove(temp_file)

      return(df)

  }
}

