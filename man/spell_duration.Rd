% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/parts.R
\name{spell_duration}
\alias{spell_duration}
\title{Find spell durations (assuming observations have equal time spacing)}
\usage{
spell_duration(x)
}
\arguments{
\item{x}{a time ordered vector with values identifying a spell. It is
assumed that when a value in this vector changes that the spell has ended.}
}
\value{
a vector of spell durations for each observation in \code{x}.
}
\description{
Find spell durations (assuming observations have equal time spacing)
}
\details{
Note that the function assumes that supplied observations are time
ordered and equally spaced in time.
}
\examples{
x <- c(rep('a', 4), rep('b', 3), 'c', rep('a', 2), 'c')
spell_duration(x)

}

