% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/misc_and_utility.r
\name{umx_string_to_algebra}
\alias{umx_string_to_algebra}
\title{umx_string_to_algebra}
\usage{
umx_string_to_algebra(algString, name = NA, dimnames = NA)
}
\arguments{
\item{algString}{a string to turn into an algebra}

\item{name}{of the returned algebra}

\item{dimnames}{of the returned algebra}
}
\value{
- \code{\link{mxAlgebra}}
}
\description{
This is useful because it lets you use paste() and rep() to quickly and easily insert values from R variables into the string, then parse the string as an mxAlgebra argument. The use case this time was to include a matrix exponent (that is A %*% A %*% A %*% A...) with a variable exponent.
}
\examples{
\dontrun{
alg = umx_string_to_algebra(paste(rep("A", nReps), collapse = " \%*\% "), name = "test_case")
}
}
\references{
- \url{http://www.github.com/tbates/umx}
}
\seealso{
Other Misc: \code{\link{umxEval}},
  \code{\link{umx_APA_model_CI}},
  \code{\link{umx_add_variances}}, \code{\link{umx_apply}},
  \code{\link{umx_default_option}},
  \code{\link{umx_get_bracket_addresses}},
  \code{\link{umx_object_as_str}}, \code{\link{umx}}
}
