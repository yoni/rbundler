\name{dependency_urls}
\alias{dependency_urls}
\title{Retrieves a list of URLs form which to install packages. Uses the
DESCRIPTION Depends, Suggests, and Imports fields to determine which
package versions to install.}
\usage{
  dependency_urls(package, repos = getOption("repos"))
}
\arguments{
  \item{package}{the package. see `devtools::as.package`}

  \item{repos}{character vector, the base URLs of the
  repositories to use}
}
\value{
  vector of URLs for dependencies
}
\description{
  Combine available packages with dependencies, and then
  runs the comparison against them, to find which package
  versions adhere to the requirements.
}
\details{
  Of all the versions which match, grabs the latest release
  by alphanumeric sorting. Constructs package install URLs
  for the resulting packages.
}

