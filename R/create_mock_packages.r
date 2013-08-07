#' Creates a series of mock packages, useful for testing and experimentation.
#' @param path the path in which to create the mock packages
#' @param repos the repositories to use for the contrib.url path
#' @return a list of named packages, each of which corresponds to the devtools `as.package` object
#' @export
#' @examples
#' path <- tempdir()
#' create_mock_packages(path, repos='http://cran.rstudio.com')
create_mock_packages <- function(path, repos=getOption('repos')) {

  # Grab the latest ggplot dependency and use it for our mock package dependnecies.
  available <- as.data.frame(available.packages(contrib.url(repos)), stringsAsFactors=FALSE)
  ggplot2_version <- available[available$Package == 'ggplot2',]$Version[[1]]

  list(
    nodependencies = create_package(
      name='nodependencies',
      title='A mock package for testing that a package with no dependencies can be bundled.',
      dependencies=data.frame(),
      path=path
    ),
    simpledependencies = create_package(
      name='simpledependencies',
      title='A mock package for testing that a package with basic dependencies can be bundled.',
      dependencies=data.frame(package=c('ggplot2'), compare=c(NA), version=c(NA)),
      path=path
    ),
    versioneddependencies= create_package(
      name='versioneddependencies',
      title='A mock package for testing that a package with versioned dependencies can be bundled.',
      dependencies=data.frame(package=c('ggplot2'), compare=c('=='), version=c(ggplot2_version)),
      path=path
    )
  )

}

