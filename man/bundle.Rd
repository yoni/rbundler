\name{bundle}
\alias{bundle}
\title{Bundles a package and it's dependencies into a library.}
\usage{
bundle(pkg = ".", bundle_path = file.path(pkg, ".Rbundle"),
  overwrite = FALSE, dependencies = c("Depends", "Imports", "LinkingTo",
  "Suggests"))
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.}

  \item{bundle_path}{path to the bundle. Defaults to
  '.Rbundle' under the package directory}

  \item{overwrite}{whether to delete the existing bundle
  library and re-install all packages. This can be
  necessary when upgrading or downgrading package
  dependencies. Defaults to FALSE}

  \item{dependencies}{which package dependencies to
  install. Defaults to c("Depends", "Imports", "LinkingTo",
  "Suggests")}
}
\description{
Dependencies are installed into the package's bundle
library. The library is also added to this session's
.libPaths.
}
\details{
Note that repository and pkgType options are temporarily
overridden, according to the user's options, and set back
to their previous values after bundle completes.
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

