% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/xmu.r
\name{xmuLabel_MATRIX_Model}
\alias{xmuLabel_MATRIX_Model}
\title{xmuLabel_MATRIX_Model (not a user function)}
\usage{
xmuLabel_MATRIX_Model(model, suffix = "", verbose = TRUE)
}
\arguments{
\item{model}{a matrix-style mxModel to label}

\item{suffix}{a string to append to each label}

\item{verbose}{how much feedback to give}
}
\value{
- The labeled \code{\link{mxModel}}
}
\description{
This function will label all the free parameters in a (non-RAM) OpenMx \code{\link{mxModel}}
nb: We don't assume what each matrix is for. Instead, the function just sticks labels like "a_r1c1" into each cell
i.e., matrixname _ r rowNumber c colNumber
}
\details{
End users should just call \code{\link{umxLabel}}
}
\examples{
require(umx)
data(demoOneFactor)
m2 <- mxModel("One Factor",
	mxMatrix("Full", 5, 1, values = 0.2, free = TRUE, name = "A"), 
	mxMatrix("Symm", 1, 1, values = 1, free = FALSE, name = "L"), 
	mxMatrix("Diag", 5, 5, values = 1, free = TRUE, name = "U"), 
	mxAlgebra(A \%*\% L \%*\% t(A) + U, name = "R"), 
	mxExpectationNormal("R", dimnames = names(demoOneFactor)),
	mxFitFunctionML(),
	mxData(cov(demoOneFactor), type = "cov", numObs = 500)
)
m3 = umx:::xmuLabel_MATRIX_Model(m2)
m4 = umx:::xmuLabel_MATRIX_Model(m2, suffix = "male")
# explore these with omxGetParameters(m4)
}
\seealso{
Other xmu internal not for end user: \code{\link{umxModel}},
  \code{\link{xmuHasSquareBrackets}},
  \code{\link{xmuLabel_Matrix}},
  \code{\link{xmuLabel_RAM_Model}}, \code{\link{xmuMI}},
  \code{\link{xmuMakeDeviationThresholdsMatrices}},
  \code{\link{xmuMakeOneHeadedPathsFromPathList}},
  \code{\link{xmuMakeTwoHeadedPathsFromPathList}},
  \code{\link{xmuMaxLevels}}, \code{\link{xmuMinLevels}},
  \code{\link{xmuPropagateLabels}},
  \code{\link{xmu_check_levels_identical}},
  \code{\link{xmu_dot_make_paths}},
  \code{\link{xmu_dot_make_residuals}},
  \code{\link{xmu_start_value_list}}
}
