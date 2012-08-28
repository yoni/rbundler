#' Bundles a package's dependencies for development workflows.
#'
#' Dependencies are installed into the package's bundle library. See bundle_library.
#' @param pkg package description, can be path or package name.
#' @importFrom devtools install
#' @export
#' @examples
#' 
#' # From within the package root, run 'bundle' to instll the package, along with it's dependencies:
#' bundle(system.file(package='rbundler', 'tests', 'no-dependencies'))
#' bundle(system.file(package='rbundler', 'tests', 'simple-dependencies'))
bundle <- function(pkg='.') {

  lib <- bundle_library(pkg)
  dir.create(lib, recursive=TRUE, showWarnings = FALSE)
  .libPaths(lib)

  message("Bundling package ", pkg, " dependencies into library ", lib)
  install(pkg)

  invisible()

}
