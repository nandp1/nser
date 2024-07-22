#' @name bhav
#' @aliases bhav
#' @title Bhavcopy from NSE and BSE
#'
#' @param x numeric date format
#' @param se Stock Exchange either 'NSE' or 'BSE'. Default is 'NSE'.
#'
#' @note The date should be strictly numerical and mentioned in quotation mark (refer examples). `bhav` can be used to download NSE bhavcopy from 1 Jan 2020 on wards.
#' @return Bhavcopy for the given date.
#' @author Nandan L. Patil \email{tryanother609@@gmail.com}
#' @details Gets Bhavcopy from NSE and BSE for the given date.
#' @source <https://www.nseindia.com/all-reports>, <https://www.bseindia.com/markets/marketinfo/BhavCopy.aspx>
#' @seealso \code{\link[nser]{bhavpr}}\code{\link[nser]{bhavtoday}}
#'
#' @importFrom utils download.file read.csv unzip
#' @importFrom curl has_internet
#' @importFrom httr GET content add_headers
#' @export
#'
#' @examples \donttest{
#' #Download Bhavcopy from NSE
#' report = bhav("01072024") # Download bhavcopy for 01 July 2024
#'
#' #Download bhavcopy from BSE
#' report = bhav("01072024", 'BSE')
#' }
bhav = function(x, se = 'NSE'){
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

    # NSE Bhavcopy

    nsebhav = function(){
          nseurl = paste0("https://nsearchives.nseindia.com/products/content/sec_bhavdata_full_", x, ".csv")
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

    #####   BSE Bhavcopy
    yr1 = substr(x, start = 7, stop = 8)
    mt1 = substr(x, start = 3, stop = 4)

    bseurl = paste0('https://www.bseindia.com/download/BhavCopy/Equity/EQ_ISINCODE_', dy, mt1, yr1, '.zip')
    bsezip = paste0('EQ_ISINCODE_', dy, mt1, yr1, '.CSV')

    bsebhav = function(x){
      temp <- tempfile()
      download.file(bseurl, temp)
      file = read.csv(unz(temp, filename = bsezip))
      unlink(temp)
      return(file)
    }

    if(se == 'NSE'){
      df = tryCatch(nsebhav(), error=function(e) nsebhav(), warning = function(w) conditionMessage(w))
    }else if(se == 'BSE') df = tryCatch(bsebhav(), error = function(e) conditionMessage(e),
                                        warning = function(w) conditionMessage(w))

    return(df)
  }
}
