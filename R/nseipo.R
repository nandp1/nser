#' @name nseipo
#' @aliases nseipo
#'
#' @title Current and Upcoming IPO's on NSE.
#'
#' @return A dataframe of IPO's on NSE.
#' @author Nandan L. Patil \email{tryanother609@@gmail.com}
#' @details List of upcoming and current IPO's on NSE gathered from Moneycontrol.
#' @source <https://www.moneycontrol.com/ipo/ipo-snapshot/issues-open.html>
#' @seealso \code{\link[nser]{bhavpr}}\code{\link[nser]{bhav}}\code{\link[nser]{fobhavtoday}}\code{\link[nser]{nseopen}}
#'
#' @importFrom rvest read_html html_nodes html_table
#'
#' @importFrom curl has_internet
#'
#' @export
#' @examples \dontrun{
#' # NSE IPO's
#' library(nser)
#' nseipo()
#' }
nseipo = function(){
  url = 'https://www.moneycontrol.com/ipo/ipo-snapshot/issues-open.html'
  dat = url %>%
    read_html() %>%
    html_table()

  dat2 = dat[[2]]
  dat3 = dat[[3]]
  nam = names(dat2)
  dat3 = `names<-`(dat3, nam)
  dat = rbind(dat2, dat3)
  return(dat)
}
