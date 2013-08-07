#' Retrieves a list of URLs form which to install packages. Uses the
#' DESCRIPTION Depends, Suggests, and Imports fields to determine which
#' package versions to install.
#'
#' Combine available packages with dependencies, and then runs the comparison
#' against them, to find which package versions adhere to the requirements.
#'
#' Of all the versions which match, grabs the latest release by alphanumeric sorting.
#' Constructs package install URLs for the resulting packages.
#' @param package the package. see `devtools::as.package`
#' @param repos character vector, the base URLs of the repositories to use
#' @return vector of URLs for dependencies
#' @export
dependency_urls <- function(package, repos = getOption("repos")) {

  available <- load_available_packages(repos)
  available$available_version <- available$Version

  depends <- devtools:::parse_deps(package$depends)

  if(is.null(depends) || nrow(depends) == 0) {

    urls <- c()

  } else {

    depends$depends_version <- depends$version
    matching_versions <- match_dependencies(available, depends)

    if(nrow(matching_versions) == 0) {
      urls <- c()
    } else {
      packages_to_install <- aggregate(
        available_version ~ Package,
        matching_versions,
        function(x) x[which.max(x)]
      )
      urls <- file.path(contrib.url(repos), sprintf('%s_%s.tar.gz', packages_to_install$Package, packages_to_install$available_version))
    }

  }

  urls

}

#' Matches available dependencies with required ones, reducing them to a single set of dependencies to use.
#' @param available a data.frame of available packages. Similar to the result of `available.packages`, except with some extra fields
#' @param depends a data.frame of the package dependencies. similar top the result of devtools:::parse_deps, except with some extra fields
match_dependencies <- function(available, depends) {

  versions <- merge(available, depends, by.x = 'Package', by.y = 'name')

  matching_version_indices <- apply(
    versions,
    1,
    FUN = function(d) {
      is.na(d['compare']) ||
      eval(
        parse(
          text = sprintf(
            "'%s' %s '%s'",
            d['available_version'],
            d['compare'],
            d['depends_version']
          )
        )
      )
    }
  )

  versions[matching_version_indices,]

}

