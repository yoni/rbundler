#' Generates a path to a package's bundle library.
#' @param pkg the path to the package
#' @return path to a package's bundle library
#' @export
bundle_library <- function(pkg='.') {
  file.path(pkg, '.Rbundle')
}
