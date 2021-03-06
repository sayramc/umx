% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/misc_and_utility.r
\name{umx_standardize_ACEcov}
\alias{umx_standardize_ACEcov}
\title{umx_standardize_ACEcov}
\usage{
umx_standardize_ACEcov(fit)
}
\arguments{
\item{fit}{an \code{\link{umxACEcov}} model to standardize}
}
\value{
- Standardized \code{\link{umxACEcov}} model
}
\description{
Standardize an ACE model with covariates
}
\examples{
require(umx)
data(twinData)
twinData$age1 = twinData$age2 = twinData$age
selDVs  = c("bmi")
selCovs = c("age")
selVars = umx_paste_names(c(selDVs, selCovs), sep = "", suffixes= 1:2)
mzData = subset(twinData, zyg == 1, selVars)[1:80, ]
dzData = subset(twinData, zyg == 3, selVars)[1:80, ]
m1 = umxACEcov(selDVs = selDVs, selCovs = selCovs, dzData = dzData, mzData = mzData, 
	 suffix = "", autoRun = TRUE)
fit = umx_standardize_ACEcov(m1)
}
\references{
- \url{http://tbates.github.io}, \url{https://github.com/tbates/umx}
}
\seealso{
Other zAdvanced Helpers: \code{\link{umx_standardize_ACE}},
  \code{\link{umx_standardize_CP}},
  \code{\link{umx_standardize_IP}}, \code{\link{umx}}
}
