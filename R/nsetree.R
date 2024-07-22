#' @name nsetree
#' @aliases nsetree
#' @title Treemap for Nifty50 and F&O Securities
#'
#' @param x "n50" for NIFTY 50 Securities and "fo" for Futures and Options Securities.
#'
#' @return treemap A Treemap of recent percent change in value of securities.
#' @author Nandan L. Patil \email{tryanother609@@gmail.com}
#' @details Plot treemap representing per cent change in 'NIFTY50' and 'F&O' stocks.
#' @source <https://www.nseindia.com/market-data/live-market-indices>
#' @seealso \code{\link[nser]{bhavpr}}\code{\link[nser]{bhavtoday}}\code{\link[nser]{bhav}}\code{\link[nser]{fobhav}}
#'
#' @import graphics rvest xml2 reticulate
#' @importFrom googleVis gvisTreeMap
#' @importFrom dplyr mutate
#' @importFrom curl has_internet
#' @importFrom stringr str_extract
#' @export
#'
#' @examples \dontrun{
#' # Treemap of NIFTY50 securities
#'
#' library(nser)
#' nsetree()
#'
#' # Treemap of FO securities
#'
#' library(nser)
#' nsetree('fo')
#'}
nsetree = function(x = "n50"){
  # check internet connection
  if (!curl::has_internet()) {
    message("No internet connection.")
    return(invisible(NULL))
  }

  if(x == "n50"){
  dat = nselive()
  dat = dat[,c(1,8)]
  dat$parent = "NIFTY"
  dat$abs = abs(dat$pCHANGE)
  dat = dat %>% mutate(SYM = paste0(SYMBOL, " (", pCHANGE, ")"))
  dat$SYMBOL = as.factor(dat$SYMBOL)
  dat$parent = as.factor(dat$parent)
  dat_add <- data.frame(SYMBOL = c("NIFTY"), parent = c(NA), pCHANGE  = c(0), abs = c(0), SYM = "NIFTY")
  dat = rbind(dat, dat_add)

  url = 'https://www.moneycontrol.com/stocksmarketsindia/heat-map-advance-decline-ratio-nse-bse'
  adv = url %>%
    read_html() %>%
    html_nodes(xpath='//*[@id="adnse"]/div/div[1]/div[3]/ul/li[1]/div/div[2]/span[1]')
  adv = str_extract(as.character(adv), ("(?<=>)(.+)(?=\\<)"))
  dec = url %>%
    read_html() %>%
    html_nodes(xpath='//*[@id="adnse"]/div/div[1]/div[3]/ul/li[1]/div/div[2]/span[2]')
  dec = str_extract(as.character(dec), ("(?<=>)(.+)(?=\\<)"))

  heading = paste0("Futures and Options Securities",  " Advances-", adv, " Declines-", dec)

  maxColorValue = 100
  minColorValue = -100
  Tree <- gvisTreeMap(dat,  idvar="SYM", parentvar="parent", sizevar="abs", colorvar="pCHANGE",
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
    dat = dat[,c(1,8)]
    dat$parent = "FO"
    dat$abs = abs(dat$pCHANGE)
    dat = dat %>% mutate(SYM = paste0(SYMBOL, "(", pCHANGE, ")"))
    dat$SYMBOL = as.factor(dat$SYMBOL)
    dat$parent = as.factor(dat$parent)
    dat_add <- data.frame(SYMBOL = c("FO"), parent = c(NA), pCHANGE  = c(0), abs = c(0), SYM = "FO")
    dat = rbind(dat, dat_add)

    heading = paste0("Securities in Futures and Options ")

    maxColorValue = 100
    minColorValue = -100
    Tree <- gvisTreeMap(dat,  idvar="SYM", parentvar="parent", sizevar="abs", colorvar="pCHANGE",
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
