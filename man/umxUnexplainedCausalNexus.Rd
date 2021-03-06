% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fit_and_reporting.r
\name{umxUnexplainedCausalNexus}
\alias{umxUnexplainedCausalNexus}
\title{umxUnexplainedCausalNexus}
\usage{
umxUnexplainedCausalNexus(from, delta, to, model)
}
\arguments{
\item{from}{A variable in the model that you want to imput the effect of a change}

\item{delta}{A the amount to simulate changing \"from\" by.}

\item{to}{The dependent variable that you want to watch changing}

\item{model}{The model containing from and to}
}
\description{
umxUnexplainedCausalNexus report the effect of a change (delta) in a variable (from) on an output (to)
}
\examples{
\dontrun{
umxUnexplainedCausalNexus(from="yrsEd", delta = .5, to = "income35", model)
}
}
\references{
- http://www.github.com/tbates/umx/
}
\seealso{
- \code{\link{umxRun}}, \code{\link{mxCompare}}

Other Modify or Compare Models: \code{\link{umxAdd1}},
  \code{\link{umxDrop1}}, \code{\link{umxEquate}},
  \code{\link{umxFixAll}}, \code{\link{umxMI}},
  \code{\link{umxSetParameters}}, \code{\link{umx}}
}
