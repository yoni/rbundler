#' Bundles a package and it's dependencies into a library.
#'
#' Dependencies are installed into the package's bundle library. The
#' library is also added to this session's .libPaths.
#'
#' Note that repository and pkgType options are temporarily overridden,
#' according to the user's options, and set back to the 
#' @param pkg package description, can be path or package name.
#' @param repos character vector, the base URLs of the repositories to use,
#'        e.g., the URL of a CRAN mirror such as
#'        '"http://cran.us.r-project.org"'.
#'
#'        Can be 'NULL' to install from local files (with extension
#'        '.tar.gz' for source packages).
#' @param ... commands to be passed to devtools::install
#' @importFrom devtools install
#' @importFrom devtools as.package
#' @export
bundle <- function(pkg='.',
                   repos = getOption("repos"),
                   ...
                   ) {

  package <- as.package(pkg)

  lib <- file.path(package$path, '.Rbundle')
  repositories <- getOption("repos")

  tryCatch({

    temp_repositories <- repositories
    temp_repositories["CRAN"] <- repos

    options(repos = temp_repositories)

    dir.create(lib, recursive=TRUE, showWarnings = FALSE)
    Sys.setenv(R_LIBS_USER=lib)
 
    renvironFileConnection <- file(file.path(package$path, ".Renviron"))
    writeLines(sprintf("R_LIBS_USER='%s'", basename(lib)), renvironFileConnection)
    close(renvironFileConnection)

    message("Bundling package ", package$path, " dependencies into library ", lib)
    install(package$path, ...)

  }, finally = {
    options(repos = repositories)
  })


  invisible()

}
