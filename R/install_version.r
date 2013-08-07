#' Install specified version or relative version of a CRAN package.
#'
#' If you are installing an package that contains compiled code, you will
#' need to have an R development environment installed.  You can check
#' if you do by running \code{\link{has_devel}}.
#'
#' Note: This is an updated version of devtools `install_version`
#' It has been fixed to work with the latest CRAN repository and updated to support version comparisons (i.e. >, ==, <, etc.)
#'
#' @export
#' @family package installation
#' @param package package name
#' @param version If the specified version is NA or the same as the most
#'   recent version of the package, this function simply calls
#'   \code{\link{install}}. Otherwise, it looks at the list of
#'   archived source tarballs and tries to install an older version instead.
#' @param compare If specified, and if the version is specified, enforces comparison of the package version. Valid values: ==, <, >, >=, or <=
#' @param ... Other arguments passed on to \code{\link{install}}.
#' @inheritParams utils::install.packages
#' @author Jeremy Stephens
#' @author Yoni Ben-Meshulam
install_version <- function(package, version = NA, compare = NA, repos = getOption("repos"), type = getOption("pkgType"), ...) {

  contriburl <- contrib.url(repos, type)
  available <- available.packages(contriburl)

  validate_compare(compare)

  available_versions <- find_available_versions(package, repos, type)
  version_to_install <- determine_version_to_install(available_versions$version, version, compare)
  url <- available_versions[available_versions$version == version_to_install, 'url']

  install_url(url, ...)

}

#' Validates the compare clause.
#' @param compare the compare clause to validate.
validate_compare <- function(compare) {
  if(is.null(compare)) {
    stop("Compare clause cannot be NULL")
  }
  if (!(is.na(compare) || compare %in% c('==', '<', '>', '>=', '<='))) {
    stop(sprintf("Invalid compare clause: [%s]", compare))
  }
}

#' Determines the version to install by comparing available versions to the required version and compare.
#' @param available_versions a vector of version identifiers corresponding to all versions of this package
#' @param version the version requested
#' @param compare the compare requested
determine_version_to_install <- function(available_versions, version, compare) {

  if(is.na(compare)) {

    matching_versions <- available_versions

  } else {

    matching_version_indices <- sapply(
      available_versions,
      FUN = function(d) {
        eval(
          parse(
            text = sprintf(
              "'%s' %s '%s'",
              d,
              compare,
              version
            )
          )
        )
      }
    )

    matching_versions <- available_versions[matching_version_indices]

  }

  max(matching_versions)

}

#' Retrieves a list of available versions for a package.
#' @param package the package name
#' @inheritParams utils::install.packages
#' @export
find_available_versions <- function(package, repos = getOption('repos'), type = getOption('pkgType')) {

  contriburl <- contrib.url(repos, type)

  # Filter on everything except duplicates. That is, allow for multiple versions of available packages.
  # This allows us to support flat repositories, as well as CRAN-like repositories
  available <- as.data.frame(available.packages(contriburl, filters=c("R_version", "OS_type", "subarch")), stringsAsFactors=FALSE)

  root_versions <- data.frame(version=available[available$Package == package,]$Version, source='root', stringsAsFactors=FALSE)
  root_versions$url <- file.path(contriburl, paste(package, "_", root_versions$version, ".tar.gz", sep = ""))

  archive <- read_archive_rds(repos)
  if (length(archive) != 0) {
    package_tarball_path <- row.names(archive[[package]])
    archive_versions <- data.frame(version = sub('.*_(.*).tar.gz', '\\1', package_tarball_path), source='archive', stringsAsFactors=FALSE)
    archive_versions$url <- file.path(contriburl, 'Archive', package_tarball_path)

    versions <- merge(root_versions, archive_versions, all=TRUE)
  } else {

    versions <- root_versions

  }

  versions

}

#' Loads archive from CRAN-like repositories. Returns empty list for non-CRAN (i.e. flat) repositories.
#' @inheritParams utils::install.packages
read_archive_rds <- function(repos) {
  tryCatch({
      con <- gzcon(url(sprintf("%s/src/contrib/Meta/archive.rds", repos), "rb"));
      on.exit(close(con))
      archive <- readRDS(con)
      return(archive)
    }, warning = function(warning) {
      return(list())
    }, error = function(error) {
      return(list())
    }
  )
}

