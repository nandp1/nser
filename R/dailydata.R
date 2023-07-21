#' Daily data of a stock
#'
#' Daily data of a stock with six columns.
#'
#'@docType data
#'
#'@usage data(dailydata)
#'
#' @format Daily data of a stock with six column
#' \describe{
#'  \item{SYMBOL}{SYMBOL of the stock}
#'  \item{OPEN}{Opening price for the day}
#'  \item{HIGH}{High price for the day}
#'  \item{LOW}{Low price for the day}
#'  \item{CLOSE}{Closing price for the day}
#'  \item{DATE}{Date for the given day}
#' }
#'
#'@seealso
#'    \code{\link{bhav}}
#'    ,\code{\link{bhavtoday}}
#'    ,\code{\link{nsetree}}
#'
#'@source https://www.nseindia.com/
#'
#' @examples \donttest{
#' library(nser)
#' data(dailydata)
#' daytoweek(dailydata)
#' }
#'

'dailydata'
