\name{create_package}
\alias{create_package}
\title{Creates a package matching the given description and dependencies.}
\usage{
create_package(name, title, dependencies, path = ".")
}
\arguments{
  \item{name}{the package name}

  \item{title}{the package title}

  \item{dependencies}{a data.frame of package dependencies,
  including the package names, comparators, and versions}

  \item{path}{the path in which to create the package.
  Defaults to the current path}
}
\value{
the package, as constructed using the `devtools`
`as.package` function
}
\description{
Creates a package matching the given description and
dependencies.
}
\examples{
# Create a simple package with no dependencies:
path <- tempdir()
name <- 'simplepackage'
package <- create_package(name, 'A simple mock package', data.frame(), path)
}

