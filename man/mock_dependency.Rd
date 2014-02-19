\name{mock_dependency}
\alias{mock_dependency}
\title{Creates a mock dependency - corresponding to a real package - for use in testing and experimentation.}
\usage{
mock_dependency(name = "tempdisagg", repos = getOption("repos"))
}
\arguments{
  \item{name}{the name of the package dependency}

  \item{repos}{the repositories to use for the contrib.url
  path}
}
\value{
list with the name and version of the dependency
}
\description{
Creates a mock dependency - corresponding to a real package
- for use in testing and experimentation.
}

