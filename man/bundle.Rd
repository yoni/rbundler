\name{bundle}
\alias{bundle}
\title{Bundles a package's dependencies for development workflows.}
\usage{
  bundle(pkg = ".", lib = file.path(pkg, ".Rbundle"),
    repos = getOption("repos"))
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.}

  \item{lib}{library in which to install the package and
  it's dependencies.}

  \item{repos}{character vector, the base URLs of the
  repositories to use, e.g., the URL of a CRAN mirror such
  as '"http://cran.us.r-project.org"'.

  Can be 'NULL' to install from local files (with extension
  '.tar.gz' for source packages).}
}
\description{
  Dependencies are installed into the package's bundle
  library.
}
\details{
  Note that repository and pkgType options are temporarily
  overridden, according to the user's options, and set back
  to the
}
\examples{
# From within the package root, run 'bundle' to instll the package, along with it's dependencies:
bundle(system.file(package='rbundler', 'tests', 'no-dependencies'))
bundle(system.file(package='rbundler', 'tests', 'simple-dependencies'))
}

