context("Can match available packages with package dependencies")

test_that("rbundler can match available packages with package dependencies", {

    available <- data.frame(
      Package=c('foo', 'foo', 'foo'),
      available_version=c('1', '2', '3'),
      stringsAsFactors=FALSE
    )

    depends <- data.frame(
      name=c('foo'),
      depends_version=c('1'),
      compare=c('=='),
      stringsAsFactors=FALSE
    )

    expected <- data.frame(
      Package=c('foo'),
      available_version=c('1'),
      depends_version=c('1'),
      compare=c('=='),
      stringsAsFactors=FALSE
    )

    matching <- match_dependencies(available, depends)

    expect_equal(matching, expected)
  }
)
