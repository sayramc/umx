% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/misc_and_utility.r
\name{umx_reorder}
\alias{umx_reorder}
\title{umx_reorder}
\usage{
umx_reorder(old, newOrder)
}
\arguments{
\item{old}{a square matrix of correlation or covariances to reorder}

\item{newOrder}{Variables you want in the order you wish to have}
}
\value{
- the re-ordered/resized matrix
}
\description{
Reorder the variables in a correlation matrix. Can also remove one or more variables from a matrix using this function
}
\examples{
oldMatrix = cov(mtcars)
umx_reorder(oldMatrix, newOrder = c("mpg", "cyl", "disp")) # first 3
umx_reorder(oldMatrix, newOrder = c("hp", "disp", "cyl")) # subset and reordered
umx_reorder(oldMatrix, "hp") # edge-case of just 1-var
}
\references{
- \url{http://www.github.com/tbates/umx}
}
\seealso{
Other Data Functions: \code{\link{umxCovData}},
  \code{\link{umxFactor}}, \code{\link{umxHetCor}},
  \code{\link{umxPadAndPruneForDefVars}},
  \code{\link{umx_as_numeric}},
  \code{\link{umx_cont_2_quantiles}},
  \code{\link{umx_cov2raw}}, \code{\link{umx_lower2full}},
  \code{\link{umx_make_MR_data}},
  \code{\link{umx_make_TwinData}},
  \code{\link{umx_make_bin_cont_pair_data}},
  \code{\link{umx_make_fake_data}},
  \code{\link{umx_merge_CIs}},
  \code{\link{umx_read_lower}},
  \code{\link{umx_residualize}}, \code{\link{umx_round}},
  \code{\link{umx_scale_wide_twin_data}},
  \code{\link{umx_scale}}, \code{\link{umx_swap_a_block}},
  \code{\link{umx_twin_long2wide}}, \code{\link{umx}}
}
