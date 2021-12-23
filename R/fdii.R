#' @name fdii
#' @aliases fdii
#'
#' @title Get latest FII/DII data.
#'
#' @return Dataframe containing FII/DII data.
#' @author Nandan L. Patil \email{tryanother609@@gmail.com}
#' @details Data gathered from moneycontrol.
#'
#' @source <https://www.moneycontrol.com/stocks/marketstats/fii_dii_activity/index.php>
#' @seealso \code{\link[nser]{nseipo}}\code{\link[nser]{bhav}}\code{\link[nser]{fobhavtoday}}\code{\link[nser]{nseopen}}
#'
#' @import stats
#' @import tidyverse
#' @importFrom rvest read_html html_nodes html_table
#' @importFrom stringr str_extract
#' @export
#' @examples \dontrun{
#' # NSE IPO's
#' library(nser)
#' fdii()
#' }
#'
fdii = function(){

  url = 'https://www.moneycontrol.com/stocks/marketstats/fii_dii_activity/index.php'
  dat = url %>%
    read_html() %>%
    html_nodes(xpath='//*[@id="fidicash"]/div') %>%
    html_table()

  dat = dat[[1]]
  dat = as.data.frame(dat)
  dat = dat[-c(3,4,5),]
  nam = c("DATE", "FII Rs Crores" ,"FII Rs Crores" ,"FII Rs Crores" ,"DII Rs Crores", "DII Rs Crores" ,"DII Rs Crores")
  dat = `colnames<-`(dat, nam)
  DATE = str_extract(dat$DATE, '[^_\n]+')
  dat = dat[,-1]
  dat = cbind(DATE, dat)
  dat[1,1] = ""
  row.names(dat) <- NULL
  return(dat)
}
