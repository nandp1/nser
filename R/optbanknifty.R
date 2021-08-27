#' @name optbanknifty
#' @aliases optbanknifty
#' @title Option Chain for NSE BANKNIFTY.
#'
#' @param raw_data If TRUE, the output is a raw dataframe of the option chain. Default FALSE.
#'
#' @return datatable The option chain of BANKNIFTY for the current expiry.
#' @author Nandan L. Patil \email{tryanother609@@gmail.com}
#' @details Get visual friendly display of Option chain of BANKNIFTY for the current expiry.
#' @source <https://www.nseindia.com/option-chain>
#' @seealso \code{\link[nser]{bhavpr}}\code{\link[nser]{bhavtoday}}\code{\link[nser]{bhavfos}}\code{\link[nser]{nsetree}}\code{\link[nser]{optbanknifty}}
#'
#' @import stats gt magrittr
#' @importFrom dplyr across
#' @importFrom jsonlite fromJSON
#' @importFrom scales comma
#' @export
#'
#' @examples  \dontrun{ # Example: BANKNIFTY option chain
#' optbanknifty()
#' }
  optbanknifty = function(raw_data = FALSE){
  if(raw_data == FALSE){
  opt= fromJSON("https://www.nseindia.com/api/option-chain-indices?symbol=BANKNIFTY")
  dat = opt[["filtered"]][["data"]]
  ce = dat[,4]
  pe = dat[,3]
  sp = dat$strikePrice
  ed = dat$expiryDate
  tim = opt[["records"]][["timestamp"]]
  cenam = c("strikePrice"   ,        "expiryDate"     ,       "underlying"      ,      "identifier"     ,       "openInterest.CE"       ,
            "changeinOI.CE"  ,"pChangeOI.CE", "Volume.CE"  ,   "IV.CE" ,    "LTP.CE"  ,
            "change.CE"         ,       "pChange.CE"           ,    "BuyQuantity.CE"    ,  "SellQuantity.CE" ,    "bidQty.CE"     ,
            "bidprice.CE"   ,           "askQty.CE"    ,            "askPrice.CE"       ,       "underlyingValue.CE")
  ce1 = `colnames<-`(ce, cenam)
  ce2 = ce1[,-c(1:4)]
  ce2 = ce2[,c(1:5, 9:15 ,8:6)]
  ce2 = ce2[,-12]
  penam = c("strikePrice"   ,        "expiryDate"     ,       "underlying"      ,      "identifier"     ,       "openInterest.PE"       ,
            "changeinOI.PE"  ,"pChangeOI.PE", "Volume.PE"  ,   "IV.PE" ,    "LTP.PE"  ,
            "change.PE"         ,       "pChange.PE"           ,    "BuyQuantity.PE"    ,  "SellQuantity.PE" ,    "bidQty.PE"     ,
            "bidprice.PE"   ,           "askQty.PE"    ,            "askPrice.PE"       ,       "underlyingValue.PE")
  pe1 = `colnames<-`(pe, penam)
  pe2 = pe1[,-c(1:4)]
  pe2 = pe2[,c(6:8, 15:9, 5:1)]
  pe2 = pe2[,-12]

  # Final table
  final = cbind(ce2, "Strike.Price" = sp, pe2 )
  final = final %>% mutate(across(starts_with("pCha"), round, 2))

  ceoi = comma(opt[["filtered"]][["CE"]][["totOI"]])
  cevol = comma(opt[["filtered"]][["CE"]][["totVol"]])
  peoi = comma(opt[["filtered"]][["PE"]][["totOI"]])
  pevol = comma(opt[["filtered"]][["PE"]][["totVol"]])

  # Table View using `gt`
  final %>% gt() %>%
    data_color(
      columns = c(pChange.CE, pChange.PE, pChangeOI.PE, pChangeOI.CE),
      colors = scales::col_bin(
        bins = c(-Inf,  0, Inf),
        palette = c("red", "green"),)) %>%
    data_color(
      columns = Strike.Price,
      colors = scales::col_bin(
        bins = c(-Inf,  0, Inf),
        palette = c("red", "#87CEFA"),)) %>%
    tab_header(
      title =md("**OPTION CHAIN BANKNIFTY**"),
      subtitle = md(paste("*EXPIRY DATE*", dat$expiryDate[1], "( Time", tim, ")"))
    ) %>%
    tab_spanner(
      label = paste("CALLS", "(OI:", ceoi, "Vol:",  paste0(cevol,")") ),

      columns = c(colnames(ce2))
    ) %>%
    tab_spanner(
      label =  paste("PUTS", "(OI:", peoi, "Vol:",  paste0(pevol,")") ),
      columns = c(colnames(pe2))
    ) %>%
    tab_source_note(
      source_note = "Source : https://www.nseindia.com/option-chain"
    ) %>%
    cols_align(
      align = "center",
      columns = c(colnames(final))
    ) %>%
    tab_style(
      style = cell_text(weight = "bold"),
      locations = cells_body(
        columns = c(LTP.CE, LTP.PE, openInterest.CE, openInterest.PE)
      )
    ) %>%
    tab_style(
      style = list(
        cell_text(weight = "bold")
      ),
      locations = cells_column_labels(columns = everything())
    )
  }
  else if(raw_data == TRUE){
    opt= fromJSON("https://www.nseindia.com/api/option-chain-indices?symbol=BANKNIFTY")
    dat = opt[["filtered"]][["data"]]
    ce = dat[,3]
    pe = dat[,4]
    sp = dat$strikePrice
    ed = dat$expiryDate
    tim = opt[["records"]][["timestamp"]]
    cenam = c("strikePrice"   ,        "expiryDate"     ,       "underlying"      ,      "identifier"     ,       "openInterest.CE"       ,
              "changeinOI.CE"  ,"pChangeOI.CE", "Volume.CE"  ,   "IV.CE" ,    "LTP.CE"  ,
              "change.CE"         ,       "pChange.CE"           ,    "BuyQuantity.CE"    ,  "SellQuantity.CE" ,    "bidQty.CE"     ,
              "bidprice.CE"   ,           "askQty.CE"    ,            "askPrice.CE"       ,       "underlyingValue.CE")
    ce1 = `colnames<-`(ce, cenam)
    ce2 = ce1[,-c(1:4)]
    ce2 = ce2[,c(1:5, 9:15 ,8:6)]
    ce2 = ce2[,-12]
    penam = c("strikePrice"   ,        "expiryDate"     ,       "underlying"      ,      "identifier"     ,       "openInterest.PE"       ,
              "changeinOI.PE"  ,"pChangeOI.PE", "Volume.PE"  ,   "IV.PE" ,    "LTP.PE"  ,
              "change.PE"         ,       "pChange.PE"           ,    "BuyQuantity.PE"    ,  "SellQuantity.PE" ,    "bidQty.PE"     ,
              "bidprice.PE"   ,           "askQty.PE"    ,            "askPrice.PE"       ,       "underlyingValue.PE")
    pe1 = `colnames<-`(pe, penam)
    pe2 = pe1[,-c(1:4)]
    pe2 = pe2[,c(6:8, 15:9, 5:1)]
    pe2 = pe2[,-12]
    # Final table
    final = cbind(ce2, "Strike.Price" = sp, pe2 )
    final = final %>% mutate(across(starts_with("pCha"), round, 2))
    return(final)
  }
}
