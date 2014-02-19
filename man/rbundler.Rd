\docType{package}
\name{rbundler}
\alias{rbundler}
\alias{rbundler-package}
\title{A package dependency management utility.}
\description{
Rbundler is an R package dependency management utility.
}
\examples{
\dontrun{
# Run bundle in the current path:
bundle()
# Check for the new `.Rbundle` entry in `.libPaths`:
.libPaths()

lib <- file.path(tempdir(), 'my_bundle_lib')
# Run bundle in the current path, overriding the target library:
bundle('.', lib)
# Check for the new entry in `.libPaths`:
.libPaths()
}
}
\author{
Yoni Ben-Meshulam \email{yoni.bmesh@gmail.com}
}

