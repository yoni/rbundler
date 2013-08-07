context("A developer can retrieve the dependency urls for a package.")


repos <- 'http://cran.rstudio.com'
CONTRIB_URL <- contrib.url(repos)

#' Ensures that a package's dependency URLs are correctly retrieved.
#' @param desc a description of the test
#' @param package the package to test
#' @param expected_dependency_urls A vector of dependency URLs which should be returned
test_dependency_urls <- function(desc, package, expected_urls) {
  test_that(
            desc,
            {

              actual_urls <- dependency_urls(package, repos = repos)

              expect_equal(length(actual_urls), length(expected_urls))

              for(expected_url in expected_urls) {
                full_expected_url <- file.path(CONTRIB_URL, expected_url)

                expect_true(
                            full_expected_url %in% actual_urls,
                            sprintf(
                                    "Dependency url [%s] was not found in [%s]",
                                    full_expected_url,
                                    paste(actual_urls, collapse=',')
                                    )
                            )

              }

            }
            )
}

test_path <- file.path(tempdir(), sprintf('dependency-url-test-%s', as.numeric(Sys.time())))
dir.create(test_path)
mock_packages <- create_mock_packages(test_path, repos)

test_dependency_urls(
            desc = "Can retrieve dependency urls for a package with no dependencies.",
            package = mock_packages[['nodependencies']],
            expected_urls = c()
            )

test_dependency_urls(
            desc = "Can retrieve dependency urls for a package with simple dependencies.",
            package = mock_packages[["simpledependencies"]],
            expected_urls = c('ggplot2_0.9.3.1.tar.gz')
            )

test_dependency_urls(
            desc = "Can retrieve dependency urls for a package with versioned dependencies.",
            package = mock_packages[["versioneddependencies"]],
            expected_urls = c('ggplot2_0.9.3.1.tar.gz')
            )

