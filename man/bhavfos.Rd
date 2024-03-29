% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bhavfos.R
\name{bhavfos}
\alias{bhavfos}
\title{Futures and Options (F&o) Bhavcopy through RSelenium}
\source{
<https://www.nseindia.com/all-reports>
}
\usage{
bhavfos(x, n = 0)
}
\arguments{
\item{x}{numeric date format (ddmmyyyy)}

\item{n}{time interval to delay in seconds. DEFAULT = 0}
}
\value{
Download F&O Bhavcopy zip file of the given date.
}
\description{
Futures and Options (F&o) Bhavcopy through RSelenium
}
\details{
Gets zip Bhavcopy from NSE for the given date.
}
\note{
The date should be strictly of numeric and of format 'ddmmyyyy' mentioned in quotation mark.  All the Bhavcopy's can be downloaded.
}
\examples{
\donttest{ # Start a selenium server and browser
# For Google Chrome (Update Chrome to latest version)
library(RSelenium)
#driver = rsDriver(browser = c("chrome"), port = 3163L, chromever = "91.0.4472.101")
#remDr = driver$client

# For Firefox
#driver = rsDriver(browser = c("firefox"), port = 3799L)

# Download Equity Bhavcopy zip file
#bhavfos("03012000", 3)

# Close the Browser
#remDr$close()
}

}
\seealso{
\code{\link[nser]{bhavpr}}\code{\link[nser]{bhavtoday}}\code{\link[nser]{bhav}}\code{\link[nser]{fobhav}}\code{\link[nser]{bhavs}}
}
\author{
Nandan L. Patil \email{tryanother609@gmail.com}
}
