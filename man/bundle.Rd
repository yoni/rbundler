\name{bundle}
\alias{bundle}
\title{Bundles a package and it's dependencies into a library.}
\usage{
  bundle(pkg = ".", repos = getOption("repos"), ...)
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.}

  \item{repos}{character vector, the base URLs of the
  repositories to use, e.g., the URL of a CRAN mirror such
  as '"http://cran.us.r-project.org"'.

  Can be 'NULL' to install from local files (with extension
  '.tar.gz' for source packages).}

  \item{...}{commands to be passed to devtools::install}
}
\description{
  Dependencies are installed into the package's bundle
  library. The library is also added to this session's
  .libPaths.
}
\details{
  Note that repository and pkgType options are temporarily
  overridden, according to the user's options, and set back
  to the
}

