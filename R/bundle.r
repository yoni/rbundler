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
#' @param bundle_path path to the bundle. Defaults to '.Rbundle' under the current working directory
#' @param ... commands to be passed to devtools::install
#' @importFrom devtools install
#' @importFrom devtools as.package
#' @export
bundle <- function(pkg = '.',
                   repos = getOption("repos"),
                   bundle_path = './.Rbundle',
                   ...
                   ) {

  package <- as.package(pkg)

  repositories <- getOption("repos")

  tryCatch({

    dir.create(bundle_path, recursive=TRUE, showWarnings = FALSE)

    temp_repositories <- repositories
    temp_repositories["CRAN"] <- repos

    options(repos = temp_repositories)

    r_libs_user = paste(Sys.getenv('R_LIBS_USER'), bundle_path, sep=':')

    update_renviron_file(
                         path = package$path,
                         r_libs_user = r_libs_user
                         )

    update_current_environment(
                               lib = bundle_path,
                               r_libs_user = r_libs_user
                               )

    message("Bundling package ", package$path, " dependencies into library ", bundle_path)
    install(package$path, ...)

  }, finally = {
    options(repos = repositories)
  })


  invisible()

}

#' Updates the current environment.
#' @export
#' @param lib the R library to add.
#' @param r_libs_user the new value of R_LIBS_USER
update_current_environment <- function(lib, r_libs_user) {

  Sys.setenv(R_LIBS_USER=r_libs_user)
  .libPaths(c(lib, .libPaths()))

  message("R_LIBS_USER=", r_libs_user)
  message(".libPaths() =", .libPaths())

  invisible()

}

#' Updates a .Renviron file in the given path.
#' @export
#' @param path to the .Renviron file
#' @param r_libs_user the new value of R_LIBS_USER
update_renviron_file <- function(path, r_libs_user) {

  renviron <- file(file.path(path, ".Renviron"))
  writeLines(sprintf("R_LIBS_USER='%s'", r_libs_user), renviron)
  close(renviron)

  invisible()

}
