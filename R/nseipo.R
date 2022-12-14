#' @name nseipo
#' @aliases nseipo
#'
#' @title Current and Upcoming IPO's on NSE.
#'
#' @return A dataframe of IPO's on NSE.
#' @author Nandan L. Patil \email{tryanother609@@gmail.com}
#' @details List of upcoming and current IPO's on NSE gathered from moneycontrol.
#'
#' @seealso \code{\link[nser]{bhavpr}}\code{\link[nser]{bhav}}\code{\link[nser]{fobhavtoday}}\code{\link[nser]{nseopen}}
#'
#' @import stats
#' @import tidyverse
#' @importFrom rvest read_html html_nodes html_table
#' @importFrom stringr str_remove_all
#'
#' @importFrom curl has_internet
#'
#' @export
#' @examples \donttest{
#' # NSE IPO's
#' library(nser)
#' nseipo()
#' }
nseipo = function(){
  # First check internet connection
  if (!curl::has_internet()) {
    message("No internet connection.")
    return(invisible(NULL))
  }
  url = 'https://www.moneycontrol.com/ipo/ipo-snapshot/issues-open.html'
  dat = url %>%
    read_html() %>%
    html_nodes(xpath='//*[@id="mytable"]') %>%
    html_table()
  dat = dat[[1]]
  dat = as.data.frame(dat)
  nam = str_remove_all(dat$`Equity /IPO Name`, "\t")
  nam = str_remove_all(nam, "\r")
  nam = str_remove_all(nam, "\n")
  nam = str_remove_all(nam, "View Profile")
  dat$`Equity /IPO Name` = nam
  return(dat)
}
