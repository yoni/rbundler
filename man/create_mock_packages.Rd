\name{create_mock_packages}
\alias{create_mock_packages}
\title{Creates a series of mock packages, useful for testing and experimentation.}
\usage{
  create_mock_packages(path, dependency,
    repos = getOption("repos"))
}
\arguments{
  \item{path}{the path in which to create the mock
  packages}

  \item{dependency}{the dependency to create in the mock
  packages}

  \item{repos}{the repositories to use for the contrib.url
  path}
}
\value{
  a list of named packages, each of which corresponds to
  the devtools `as.package` object
}
\description{
  Creates a series of mock packages, useful for testing and
  experimentation.
}
\examples{
path <- tempdir()
repos <- 'http://cran.rstudio.com'
dependency <- mock_dependency('RCurl', repos)
create_mock_packages(path, dependency, repos)
}

