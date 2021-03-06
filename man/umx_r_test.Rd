% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/misc_and_utility.r
\name{umx_r_test}
\alias{umx_r_test}
\title{umx_r_test}
\usage{
umx_r_test(data = NULL, vars = vars, alternative = c("two.sided",
  "greater", "less"))
}
\arguments{
\item{data}{the dataset}

\item{vars}{the 4 vars needed: "j & k" and "h & m"}

\item{alternative}{two (default) or one-sided (greater less) test}
}
\value{
-
}
\description{
umx_r_test is a wrapper around the cocor test of difference between correlations.
}
\details{
Currently it handles the test of whether r.jk and r.hm differ in magnitude.
i.e, two nonoverlapping (no variable in common) correlations in the same dataset.
In the future it will be expanded to handle overlapping correlations, and to take corelation matrices as input.
}
\examples{
vars = c("mpg", "cyl", "disp", "hp")
umx_r_test(mtcars, vars)
}
