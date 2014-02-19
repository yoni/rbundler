\name{read_archive_rds}
\alias{read_archive_rds}
\title{Loads archive from CRAN-like repositories. Returns empty list for non-CRAN (i.e. flat) repositories.}
\usage{
read_archive_rds(repos)
}
\arguments{
  \item{repos}{ character vector, the base URL(s) of the
  repositories to use, e.g., the URL of a CRAN mirror such
  as \code{"http://cran.us.r-project.org"}.

  Can be \code{NULL} to install from local files (with
  extension \file{.tar.gz} for source packages).  }
}
\description{
Loads archive from CRAN-like repositories. Returns empty
list for non-CRAN (i.e. flat) repositories.
}

