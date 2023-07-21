#' @name daytomonth
#' @aliases daytomonth
#' @title Convert Daily data of a stock to Monthly data
#'
#' @param x dataframe containing stock data with columns SYMBOL, OPEN, HIGH, LOW, CLOSE & DATE.
#'
#' @note The dataframe should contain six columns named SYMBOL, OPEN, HIGH, LOW, CLOSE & DATE.
#' @return OHLC data in monthly format.
#' @author Nandan L. Patil \email{tryanother609@@gmail.com}
#' @details Converts the Daily data of a stock to Monthly data.
#' @seealso \code{\link[nser]{bhavpr}}\code{\link[nser]{bhavtoday}}\code{\link[nser]{bhav}}\code{\link[nser]{daytoweek}}
#'
#' @importFrom utils download.file read.csv unzip head tail
#' @importFrom lubridate dmy ymd isoweek
#' @importFrom dplyr arrange mutate
#' @export
#' @examples \donttest{
#' data(dailydata)
#' daytomonth(dailydata)
#' }
#'
daytomonth = function(x){
  dat = x
  dat$DATE = dmy(dat$DATE)
  dat = arrange(dat, DATE)
  a1 = data.frame(date = ymd(dat$DATE))
  a1 = a1 %>% mutate(week = cut.Date(a1$date, breaks = "1 month", labels = FALSE)) %>% arrange(a1$date)
  dat2 = cbind.data.frame(dat, a1)
  dat2 = dat2 %>% mutate(week = as.factor(dat2$week))
  dat2 = dat2 %>% mutate(weekno = isoweek(ymd(dat2$DATE)))
  dat2 = dat2 %>% mutate(year = year(ymd(dat2$date)))
  dat2 = dat2 %>% mutate(month = months(date))
  dat2 = dat2 %>% mutate(dd = paste0(month, '-', year))
  dat3 = split(dat2, dat2$week)

  op = lapply(dat3, function(x) head(x$OPEN, 1))
  op = unlist(op)

  cl = lapply(dat3, function(x) tail(x$CLOSE, 1))
  cl = unlist(cl)

  hp = lapply(dat3, function(x) max(x$HIGH))
  hp = unlist(hp)

  lp = lapply(dat3, function(x) min(x$LOW))
  lp = unlist(lp)

  sym = head(dat$SYMBOL, 1)

  dd = lapply(dat3, function(x) head(x$dd, 1))
  dd = unlist(dd)

  dat4  = cbind.data.frame(SYMBOL = rep(sym), OPEN = op, HIGH = hp, LOW = lp, CLOSE = cl, MONTH = dd)
  return(dat4)
}
