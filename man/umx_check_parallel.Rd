% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/misc_and_utility.r
\name{umx_check_parallel}
\alias{umx_check_parallel}
\title{umx_check_parallel}
\usage{
umx_check_parallel(nCores = c(1, parallel::detectCores()/2),
  testScript = NULL, rowwiseParallel = TRUE, nSubjects = 1000)
}
\arguments{
\item{nCores}{How many cores to run (defaults to c(1, max/2). -1 = all available.}

\item{testScript}{A user-provided script to run (NULL)}

\item{rowwiseParallel}{Whether to parallel-ize rows (default) or gradient computation}

\item{nSubjects}{Number of rows to model (Default = 1000) Reduce for quicker runs.}
}
\value{
- NULL
}
\description{
Shows how many cores you are using, and runs a test script so user can check CPU usage
}
\examples{
\dontrun{
# On a fast machine, takes a minute with 1 core
umx_check_parallel()
}
}
\references{
- \url{http://tbates.github.io}, \url{https://github.com/tbates/umx}
}
\seealso{
Other Test: \code{\link{umx_check_OS}},
  \code{\link{umx_check_model}},
  \code{\link{umx_check_names}}, \code{\link{umx_check}},
  \code{\link{umx_has_CIs}},
  \code{\link{umx_has_been_run}},
  \code{\link{umx_has_means}},
  \code{\link{umx_has_square_brackets}},
  \code{\link{umx_is_MxData}},
  \code{\link{umx_is_MxMatrix}},
  \code{\link{umx_is_MxModel}}, \code{\link{umx_is_RAM}},
  \code{\link{umx_is_cov}},
  \code{\link{umx_is_endogenous}},
  \code{\link{umx_is_exogenous}},
  \code{\link{umx_is_ordered}}
}
