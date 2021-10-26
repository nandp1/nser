#' @name daytoweek
#' @aliases daytoweek
#' @title Convert Daily data of a stock to Weekly data
#'
#' @param x dataframe containing stock data with columns SYMBOL, OPEN, HIGH, LOW, CLOSE & DATE.
#'
#' @note The dataframe should contain six columns named SYMBOL, OPEN, HIGH, LOW, CLOSE & DATE.
#' @return Dataframe with Weekly data.
#' @author Nandan L. Patil \email{tryanother609@@gmail.com}
#' @details Converts the Daily data of a stock to Weekly data.
#' @seealso \code{\link[nser]{bhavpr}}\code{\link[nser]{bhavtoday}}\code{\link[nser]{bhav}}
#'
#' @import stats
#' @importFrom utils download.file read.csv unzip head tail
#' @importFrom lubridate dmy ymd isoweek
#' @importFrom dplyr arrange mutate
#' @importFrom purrr reduce
#' @export
#' @examples \dontrun{
#' data(dailydata)
#' daytoweek(dailydata)
#' }
#'
daytoweek = function(x){
    dat = x
    dat$DATE = dmy(dat$DATE)
    dat = arrange(dat, DATE)
    a1 = data.frame(date = ymd(dat$DATE))
    a1 = a1 %>% mutate(week = cut.Date(a1$date, breaks = "1 week", labels = FALSE)) %>% arrange(a1$date)
    dat2 = cbind.data.frame(dat, a1)
    dat2 = dat2 %>% mutate(week = as.factor(dat2$week))
    dat2 = dat2 %>% mutate(weekno = isoweek(ymd(dat2$DATE)))
    dat2 = dat2 %>% mutate(year = year(ymd(dat2$date)))
    dat3 = split(dat2, dat2$week)

    op = lapply(dat3, function(x) head(x$OPEN, 1))
    op = unlist(op)

    cl = lapply(dat3, function(x) head(x$CLOSE, 1))
    cl = unlist(cl)

    hp = lapply(dat3, function(x) max(x$HIGH))
    hp = unlist(hp)

    lp = lapply(dat3, function(x) min(x$LOW))
    lp = unlist(lp)

    weekstartdate = lapply(dat3, function(x) head(x$DATE,1))
    weekstartdate = weekstartdate %>% purrr::reduce(c)
    weekenddate = lapply(dat3, function(x) tail(x$DATE, 1))
    weekenddate = weekenddate %>% purrr::reduce(c)
    sym = head(dat$SYMBOL, 1)

    dat4  = cbind.data.frame(SYMBOL = rep(sym), OPEN = op, HIGH = hp, LOW = lp, CLOSE = cl, weekstartdate = weekstartdate, weekenddate = weekenddate)
    return(dat4)
}
