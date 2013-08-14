\name{validate_installed_package}
\alias{validate_installed_package}
\title{Checks whether a package has already been installed. If it has, and if the version corresponds to the
required package version, then it returns TRUE. If it has been installed and the version does
not correspond to the required version, then it throws an exception. Otherwise, it returns false.}
\usage{
  validate_installed_package(package, version, compare)
}
\arguments{
  \item{package}{the package to check}

  \item{version}{the required version}

  \item{compare}{the comparison operator}
}
\value{
  whether we should install the package
}
\description{
  Checks whether a package has already been installed. If
  it has, and if the version corresponds to the required
  package version, then it returns TRUE. If it has been
  installed and the version does not correspond to the
  required version, then it throws an exception. Otherwise,
  it returns false.
}

