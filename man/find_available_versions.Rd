\name{find_available_versions}
\alias{find_available_versions}
\title{Retrieves a list of available versions for a package.}
\usage{
  find_available_versions(package,
    repos = getOption("repos"),
    type = getOption("pkgType"))
}
\arguments{
  \item{package}{the package name}

  \item{repos}{ character vector, the base URL(s) of the
  repositories to use, e.g., the URL of a CRAN mirror such
  as \code{"http://cran.us.r-project.org"}.

  Can be \code{NULL} to install from local files (with
  extension \file{.tar.gz} for source packages).  }

  \item{type}{character, indicating the type of package to
  download and install.

  Possible values are \code{"source"},
  \code{"mac.binary.leopard"} and \code{"win.binary"}: the
  binary types can be listed and downloaded but not
  installed on other platforms.

  The default is the appropriate binary type on Windows and
  on the CRAN binary Mac OS X distribution, otherwise
  \code{"source"}.  For the platforms where binary packages
  are the default, an alternative is \code{"both"} which
  means \sQuote{try binary if available, otherwise try
  source}.  (This will only choose the binary package if
  its version number is no older than the source version.
  In interactive use it will ask before attempting to
  install source packages.)  }
}
\description{
  Retrieves a list of available versions for a package.
}

