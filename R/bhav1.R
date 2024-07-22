#' @name bhav1
#' @aliases bhav1
#' @title Bhavcopy from NSE upto 05 July 2024
#'
#' @param x numeric date format
#'
#' @note The date should be strictly numerical and mentioned in quotation mark (refer examples). `bhav1` can be used to download bhavcopy from 1 Jan 2016 to 05 July 2024.
#' @return Bhavcopy for the given date.
#' @author Nandan L. Patil \email{tryanother609@@gmail.com}
#' @details Gets Bhavcopy from NSE from 1 Jan 2016 to 05 July 2024.
#' @source <https://www.nseindia.com/all-reports>
#' @seealso \code{\link[nser]{bhav}}\code{\link[nser]{bhavtoday}}
#'
#' @importFrom utils download.file read.csv unzip
#' @importFrom curl has_internet
#' @export
#'
#' @examples \donttest{
#' #Download Bhavcopy from NSE
#' report = bhav("01072021") # Download bhavcopy for 01 July 2021
#'
#' }
bhav = function(x){
  # First check internet connection
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

    if(mt == "01"){
      mt = "JAN"
    } else if(mt == "02"){
      mt = "FEB"
    } else if(mt == "03"){
      mt = "MAR"
    } else if(mt == "04"){
      mt = "APR"
    } else if(mt == "05"){
      mt = "MAY"
    } else if(mt == "06"){
      mt = "JUN"
    } else if(mt == "07"){
      mt = "JUL"
    } else if(mt == "08"){
      mt = "AUG"
    } else if(mt == "09"){
      mt = "SEP"
    } else if(mt == "10"){
      mt = "OCT"
    } else if(mt == "11"){
      mt = "NOV"
    } else if(mt == "12"){
      mt = "DEC"
    }

    baseurl = "https://archives.nseindia.com/content/historical/EQUITIES/"

    end = ".csv.zip"
    bhavurl = paste0(baseurl, yr, "/", mt, "/cm", dy, mt, yr, "bhav", end)
    zipname = paste0("cm", dy, mt, yr, "bhav", ".csv")

    bhav1 = function(x){
      temp <- tempfile()
      download.file(bhavurl, temp)
      file = read.csv(unz(temp, filename = zipname))
      unlink(temp)
      return(file)
    }

      df = bhav1()

    return(df)
  }
}
