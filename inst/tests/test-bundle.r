context("A developer can bundle all a package and it's dependencies.")

#' Ensures that a pcakage and it's dependencies are installed when running 'bundle'
#' @param desc a description of the test
#' @param pkg The package to test
#' @param expected_dependencies A vector of dependencies which must be installed
test_bundle <- function(desc, pkg, expected_dependencies) {
  test_that(
            desc,
            {

              full_path <- system.file(file.path('tests', pkg), package='rbundler')
              message("Full path to the package: [%s]", full_path)
              package <- as.package(full_path)

              lib <- file.path(
                               full_path,
                               sprintf(".Rbundle.%s", as.numeric(Sys.time()))
                               )

              bundle(pkg = package$path, bundle_path = lib, repos=c("http://cran.us.r-project.org"))

              expect_true(
                          file.exists(lib),
                          sprintf("Bundler library [%s] was not created.", lib)
                          )

              bundle_package_path <- file.path(lib, package$package)

              expect_true(
                          file.exists(bundle_package_path),
                          sprintf(
                                  "Package was not successfully installed into bundler library: [%s]",
                                  bundle_package_path
                                  )
                          )

              for(dependency in expected_dependencies) {

                bundle_dependency_path <- file.path(lib, dependency)
                message("Expecting dependency [%s] in path [%s]", dependency, bundle_dependency_path)

                expect_true(
                            file.exists(bundle_dependency_path),
                            sprintf(
                                    "Dependency was not successfully installed into bundler library: [%s]",
                                    bundle_dependency_path
                                    )
                            )

              }

              # Note: we're checking that only the basename of the library is in libPaths, due to an issue with OS X
              # having '/var' point to '/private/var'. R thinks it's using 'var', when in reality, .libPaths
              # points to '/private/var'.
              expect_match(basename(lib), basename(.libPaths()), all=FALSE, info=sprintf("Did not find [%s] in .libPaths().", lib))

              unlink(lib, recursive=TRUE)

            }
            )
}

test_bundle(
            desc = "Bundling a package with no dependencies creates a bundle directory with the project installed and no dependencies installed.",
            pkg = 'no-dependencies',
            expected_dependencies = c()
            )

test_bundle(
            desc = "Bundling a package with dependencies creates a bundle directory with the project installed and all dependencies installed.",
            pkg = "simple-dependencies",
            expected_dependencies=c('PerformanceAnalytics')
            )

