% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fit_and_reporting.r
\name{umxPlotCP}
\alias{umxPlotCP}
\alias{plot.MxModel.CP}
\title{umxPlotCP}
\usage{
umxPlotCP(x = NA, file = "name", digits = 2, means = FALSE,
  std = TRUE, showMeans = "deprecated", ...)
}
\arguments{
\item{x}{The Common Pathway \code{\link{mxModel}} to display graphically}

\item{file}{The name of the dot file to write: NA = none; "name" = use the name of the model}

\item{digits}{How many decimals to include in path loadings (defaults to 2)}

\item{means}{Whether to show means paths (defaults to FALSE)}

\item{std}{Whether to standardize the model (defaults to TRUE)}

\item{showMeans}{deprecated: replace with just 'means'}

\item{...}{Optional additional parameters}
}
\value{
- Optionally return the dot code
}
\description{
Draw a graphical figure for a Common Pathway model
}
\examples{
\dontrun{
plot(yourCP_Model) # no need to remember a special name: plot works fine!
}
}
\references{
- \url{http://tbates.github.io}
}
\seealso{
- \code{\link{plot}()}, \code{\link{umxSummary}()} work for IP, CP, GxE, SAT, and ACE models.

Other Plotting functions: \code{\link{plot.MxModel}},
  \code{\link{umxPlotACEcov}}, \code{\link{umxPlotACE}},
  \code{\link{umxPlotGxE}}, \code{\link{umxPlotIP}}

Other Reporting functions: \code{\link{RMSEA.MxModel}},
  \code{\link{RMSEA.summary.mxmodel}}, \code{\link{RMSEA}},
  \code{\link{extractAIC.MxModel}}, \code{\link{loadings}},
  \code{\link{logLik.MxModel}}, \code{\link{plot.MxModel}},
  \code{\link{residuals.MxModel}},
  \code{\link{umxCI_boot}}, \code{\link{umxCI}},
  \code{\link{umxCompare}}, \code{\link{umxConfint}},
  \code{\link{umxExpCov}}, \code{\link{umxExpMeans}},
  \code{\link{umxFitIndices}}, \code{\link{umxPlotACEcov}},
  \code{\link{umxPlotACE}}, \code{\link{umxPlotGxE}},
  \code{\link{umxPlotIP}},
  \code{\link{umxSummary.MxModel}},
  \code{\link{umxSummaryACE}}, \code{\link{umx_drop_ok}},
  \code{\link{umx_standardize_RAM}}

Other Twin Modeling Functions: \code{\link{plot.MxModel}},
  \code{\link{umxACESexLim}}, \code{\link{umxACEcov}},
  \code{\link{umxACE}}, \code{\link{umxCF_SexLim}},
  \code{\link{umxCP}}, \code{\link{umxGxE_window}},
  \code{\link{umxGxE}}, \code{\link{umxIP}},
  \code{\link{umxPlotACEcov}}, \code{\link{umxPlotGxE}},
  \code{\link{umxPlotIP}}, \code{\link{umxSummaryACEcov}},
  \code{\link{umxSummaryACE}}, \code{\link{umxSummaryCP}},
  \code{\link{umxSummaryGxE}}, \code{\link{umxSummaryIP}},
  \code{\link{umx}}
}
