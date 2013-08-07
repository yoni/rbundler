context("A developer can bundle a package and it's dependencies.")

repos <- 'http://cran.rstudio.com'
CONTRIB_URL <- contrib.url(repos)

#' Ensures that a package and it's dependencies are installed when running 'bundle'
#' @param desc a description of the test
#' @param package the package to test
#' @param expected_dependencies A vector of dependencies which must be installed
test_bundle <- function(desc, package, expected_dependencies) {
  test_that(
            desc,
            {

              lib <- file.path(package$path, ".Rbundle")

              bundle(pkg = package$path, bundle_path = lib, repos = repos)

              expect_true(
                          file.exists(lib),
                          info=sprintf("Bundler library [%s] was not created.", lib)
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

            }
            )
}

test_path <- file.path(tempdir(), '..', sprintf('bundle-test-%s', as.numeric(Sys.time())))
dir.create(test_path)
mock_packages <- create_mock_packages(test_path, repos)

test_bundle(
            desc = "Bundling a package with no dependencies creates a bundle directory with the project installed and no dependencies installed.",
            package = mock_packages[['nodependencies']],
            expected_dependencies = c()
            )

test_bundle(
            desc = "Bundling a package with dependencies creates a bundle directory with the project installed and all dependencies installed.",
            package = mock_packages[["simpledependencies"]],
            expected_dependencies=c('ggplot2')
            )

test_bundle(
            desc = "Bundling a package with versioned dependencies creates a bundle directory with the project installed, all dependencies installed, and correct dependency versions.",
            package = mock_packages[["versioneddependencies"]],
            expected_dependencies=c('ggplot2')
            )
