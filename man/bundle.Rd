\name{bundle}
\alias{bundle}
\title{Bundles a package's dependencies for development workflows.}
\usage{
  bundle(pkg = ".")
}
\arguments{
  \item{pkg}{package description, can be path or package
  name.}
}
\description{
  Dependencies are installed into the package's bundle
  library. See bundle_library.
}
\examples{
# From within the package root, run 'bundle' to instll the package, along with it's dependencies:
bundle(system.file(package='rbundler', 'tests', 'no-dependencies'))
bundle(system.file(package='rbundler', 'tests', 'simple-dependencies'))
}

