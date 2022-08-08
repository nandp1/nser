#' @name nsetree
#' @aliases nsetree
#' @title Treemap for Nifty50 and F&O Securities
#'
#' @param x "n50" for NIFTY 50 Securities and "fo" for Futures and Options Securities.
#'
#' @return treemap A Treemap of recent percent change in value of securities.
#' @author Nandan L. Patil \email{tryanother609@@gmail.com}
#' @details The function plots a treemap eith the recent change in price of securities.
#' @source <https://www1.nseindia.com/live_market/dynaContent/live_watch/equities_stock_watch.htm?cat=N>
#' @seealso \code{\link[nser]{bhavpr}}\code{\link[nser]{bhavtoday}}\code{\link[nser]{bhavs}}\code{\link[nser]{bhavfos}}
#'
#' @import stats graphics
#' @importFrom jsonlite fromJSON
#' @importFrom googleVis gvisTreeMap
#' @importFrom dplyr mutate
#' @importFrom curl has_internet
#'
#' @export
#'
#' @examples  \dontrun{ # Treemap of NIFTY50 securities
#' nsetree()
#'
#' # Treemap of F&O securities
#' nsetree("fo")
#' }
#'
nsetree = function(x = "n50"){
  # check internet connection
  if (!curl::has_internet()) {
    message("No internet connection.")
    return(invisible(NULL))
  }

  if(x == "n50"){
  dat = nselive()
  dat = dat[,c(1,7)]
  dat$parent = "NIFTY"
  dat$abs = abs(dat$pChange)
  dat = dat %>% mutate(SYM = paste0(SYMBOL, "(", pChange, ")"))
  dat$SYMBOL = as.factor(dat$SYMBOL)
  dat$parent = as.factor(dat$parent)
  dat_add <- data.frame(SYMBOL = c("NIFTY"), parent = c(NA), pChange  = c(0), abs = c(0), SYM = "NIFTY")
  dat = rbind(dat, dat_add)

  dat1 = fromJSON('https://www1.nseindia.com/live_market/dynaContent/live_watch/stock_watch/niftyStockWatch.json')
  adv = dat1[["advances"]]
  dec = dat1[["declines"]]
  heading = paste0("Futures and Options Securities",  " Advances-", adv, " Declines-", dec)

  maxColorValue = 100
  minColorValue = -100
  Tree <- gvisTreeMap(dat,  idvar="SYM", parentvar="parent", sizevar="abs", colorvar="pChange",
                      options=list(title = heading,
                                   titleTextStyle="{color:'blue',
                                              fontSize:24}",
                                   width=1800, height=800,
                                   fontSize=12,
                                   headerHeight=16,
                                   fontColor='black',
                                   showScale=TRUE))
  plot(Tree)
  }
  else if(x == "fo"){
    dat = nselive("fo")
    dat = dat[,c(1,7)]
    dat$parent = "FO"
    dat$abs = abs(dat$pChange)
    dat = dat %>% mutate(SYM = paste0(SYMBOL, "(", pChange, ")"))
    dat$SYMBOL = as.factor(dat$SYMBOL)
    dat$parent = as.factor(dat$parent)
    dat_add <- data.frame(SYMBOL = c("FO"), parent = c(NA), pChange  = c(0), abs = c(0), SYM = "FO")
    dat = rbind(dat, dat_add)

    dat1 = fromJSON('https://www1.nseindia.com/live_market/dynaContent/live_watch/stock_watch/foSecStockWatch.json')
    adv = dat1[["adv"]]
    dec = dat1[["dec"]]
    heading = paste0("Futures and Options Securities",  " Advances-", adv, " Declines-", dec)

    maxColorValue = 100
    minColorValue = -100
    Tree <- gvisTreeMap(dat,  idvar="SYM", parentvar="parent", sizevar="abs", colorvar="pChange",
                        options=list(title = heading,
                                     titleTextStyle="{color:'blue',
                                              fontSize:24}",
                                     width=1800, height=800,
                                      fontSize=12,
                                      headerHeight=16,
                                      fontColor='black',
                                      showScale=TRUE))
    plot(Tree)
  }
}
