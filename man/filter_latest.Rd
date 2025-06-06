% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/filter_latest.R
\name{filter_latest}
\alias{filter_latest}
\title{Filter Latest}
\usage{
filter_latest(d, grp, ord)
}
\arguments{
\item{d}{data frame}

\item{grp}{grouping columns}

\item{ord}{ordering columns}
}
\value{
tibble
}
\description{
Filter a data frame (per group(s)) to the first row (by descending order)
}
\examples{
data.frame(a = rep(1:5, each=2), b = 1:10) |>
filter_latest(grp = a, ord = b)

data.frame(a = rep(1:5, each=2), b = 1:10) |>
filter_latest(grp = c(a,b), ord = b)

}
