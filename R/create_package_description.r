#' A Utility function for creating rbundler scenarios.
#' @param name the name of the package to create
#' @param title the title of the package to create
#' @param dependencies a data.frame with dependency package, compare, and version set.
#' @export
#' @examples
#'
#' name <- 'simpledependency'
#' title <- 'A mock package with a single dependency.'
#' dependencies <- data.frame(package=c('foo', 'bar'),compare=c(NA, '=='), version=c(NA, '1'))
#' description <- create_package_description(name, title, dependencies)
#'
#' write(description, file='') # Write the output to the console
create_package_description <- function(name, title, dependencies) {
  heading <- sprintf("Package: %s
Title: %s
License: GPL-2
Description:
Author: Foo Bar <foo.bar@gmail.com>
Maintainer: Foo Bar <foo.bar@gmail.com>
Version: 0.1",
    name,
    title
  )

  footer <- sprintf("Collate:
    ''
")

  if(length(dependencies) == 0) {
    sprintf("%s\n%s", heading, footer)
  } else {
    sprintf("%s\nDepends:\n%s\n%s",
      heading,
      depends_clause(dependencies),
      footer
    )
  }
}

#' Creates the `Depends:` clause by concatenating individual packages and adding their compare clauses.
#' @param dependencies a data.frame with dependency package, compare, and version set.
depends_clause <- function(dependencies) {
  paste(
    ifelse(
      is.na(dependencies$version),
      sprintf('    %s', dependencies$package),
      sprintf('    %s (%s %s)', dependencies$package, dependencies$compare, dependencies$version)
    ),
    collapse=',\n'
  )
}
