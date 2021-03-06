% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/misc_and_utility.r
\name{umx_get_bracket_addresses}
\alias{umx_get_bracket_addresses}
\title{get mat[r,c] style cell address from an mxMatrix}
\usage{
umx_get_bracket_addresses(mat, free = NA, newName = NA)
}
\arguments{
\item{mat}{an mxMatrix to get address labels from}

\item{free}{how to filter on free (default = NA: take all)}

\item{newName}{= NA}
}
\value{
- a list of bracket style labels
}
\description{
Sometimes you want these :-) This also allows you to change the matrix name: useful for using mxMatrix addresses in an mxAlgebra.
}
\examples{
require(umx)
data(demoOneFactor)
latents  = c("G")
manifests = names(demoOneFactor)
m1 <- mxModel("One Factor", type = "RAM", 
	manifestVars = manifests, latentVars = latents, 
	mxPath(from = latents, to = manifests),
	mxPath(from = manifests, arrows = 2),
	mxPath(from = latents, arrows = 2, free = FALSE, values = 1.0),
	mxData(cov(demoOneFactor), type = "cov", numObs = 500)
)
umx_get_bracket_addresses(m1$matrices$A, free= TRUE)
}
\references{
- \url{http://tbates.github.io}, \url{https://github.com/tbates/umx}
}
\seealso{
Other Misc: \code{\link{umxEval}},
  \code{\link{umx_APA_model_CI}},
  \code{\link{umx_add_variances}}, \code{\link{umx_apply}},
  \code{\link{umx_default_option}},
  \code{\link{umx_object_as_str}},
  \code{\link{umx_string_to_algebra}}, \code{\link{umx}}
}
