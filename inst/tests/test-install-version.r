context('rbundler can install a specific version of a package')

repos <- 'http://cran.rstudio.com'
options(repos=repos)
options(pkgType = 'source')

old_versions <- c('1', '2')
available_versions <- c(old_versions, '3')

expect_version_to_install <- function(expected, version, comparator) {
  version_to_install <- determine_version_to_install(available_versions, version, comparator)
  expect_equal(
    version_to_install,
    expected,
    info = sprintf('Expected version [%s] but got [%s]', expected, paste(version_to_install, collapse=','))
  )
}

test_that('the correct version for installation can be determined',{

  for(version in available_versions) {
    expect_version_to_install('3', version, NA)
  }

  for(version in available_versions) {
    expect_version_to_install(version, version, '==')
    expect_version_to_install(version, version, '<=')
  }

  for(version in old_versions) {
    expect_version_to_install('3', version, '>=')
    expect_version_to_install('3', version, '>')
  }

  expect_version_to_install('1', '2', '<')
  expect_version_to_install('2', '3', '<')

})

test_that('can validate compare clause', {
  expect_that({validate_compare(NULL)}, throws_error())
})

test_that('can read archive from both cran and non-cran-like repsitories', {
  read_archive_rds('http://cran.rstudio.com') # Check that there are no errors
  expect_equal(read_archive_rds('http://cran.does.not.exist'), list())
})

test_that('can install an old package version', {

  # Create a temporary library to use for testing:
  lib <- file.path(tempdir(), 'library', as.numeric(Sys.time()))

  dir.create(lib, recursive=TRUE)
  .libPaths(lib)
  dependency <- mock_dependency(repos=repos)
  install_version(dependency$name, dependency$version, '==')

  expected_path <- file.path(lib, dependency$name)
  package <- as.package(expected_path)

  expect_true(file.exists(expected_path))
  expect_equal(package$version, dependency$version)

})

