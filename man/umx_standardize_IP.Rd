% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/misc_and_utility.r
\name{umx_standardize_IP}
\alias{umx_standardize_IP}
\title{umx_standardize_IP}
\usage{
umx_standardize_IP(fit)
}
\arguments{
\item{fit}{an \code{\link{umxIP}} model to standardize}
}
\value{
- standardized IP \code{\link{umxIP}} model
}
\description{
This function simply inserts the standardized IP components into the ai ci ei and as cs es matrices
}
\examples{
\dontrun{
fit = umx_standardize_IP(fit)
}
}
\references{
- \url{http://tbates.github.io}, \url{https://github.com/tbates/umx}
}
\seealso{
Other zAdvanced Helpers: \code{\link{umx_standardize_ACEcov}},
  \code{\link{umx_standardize_ACE}},
  \code{\link{umx_standardize_CP}}, \code{\link{umx}}
}
