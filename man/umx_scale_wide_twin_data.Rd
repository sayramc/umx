\name{umx_scale_wide_twin_data}
\alias{umx_scale_wide_twin_data}
\title{umx_scale_wide_twin_data}
\usage{
umx_scale_wide_twin_data(df, varsToScale, suffixes)
}
\arguments{
  \item{df}{a wide dataframe}

  \item{varsToScale}{the base names of the variables
  ("weight" etc)}

  \item{suffixes}{the suffix that distinguishes each case
  (T1, T2 etc.)}
}
\value{
- new dataframe with scaled variables
}
\description{
Scale wide data across all cases: currently twins
}
\examples{
data(twinData)
df = umx_scale_wide_twin_data(twinData, varsToScale = c("ht", "wt"), suffixes = c("1","2") )
plot(wt1 ~ wt2, data = df)
}
\references{
- \url{http://www.github.com/tbates/umx}
}
\seealso{
- \code{\link{umxLabel}}, \code{\link{umxRun}}, \code{\link{umxValues}}

Other umx data helpers: \code{\link{umxHetCor}};
  \code{\link{umx_lower2full}}; \code{\link{umx_scale}}
}
