\name{create_package_description}
\alias{create_package_description}
\title{A Utility function for creating rbundler scenarios.}
\usage{
create_package_description(name, title, dependencies)
}
\arguments{
  \item{name}{the name of the package to create}

  \item{title}{the title of the package to create}

  \item{dependencies}{a data.frame with dependency type,
  package, compare, version set.}
}
\description{
A Utility function for creating rbundler scenarios.
}
\examples{
name <- 'simpledependency'
title <- 'A mock package with a single dependency.'
dependencies <- data.frame(type = c('Depends', 'Suggests'), package=c('foo', 'bar'),
                           compare=c(NA, '=='), version=c(NA, '1'))
description <- create_package_description(name, title, dependencies)

write(description, file='') # Write the output to the console
}

