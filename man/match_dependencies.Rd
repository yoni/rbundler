\name{match_dependencies}
\alias{match_dependencies}
\title{Matches available dependencies with required ones, reducing them to a single set of dependencies to use.}
\usage{
  match_dependencies(available, depends)
}
\arguments{
  \item{available}{a data.frame of available packages.
  Similar to the result of `available.packages`, except
  with some extra fields}

  \item{depends}{a data.frame of the package dependencies.
  similar top the result of devtools:::parse_deps, except
  with some extra fields}
}
\description{
  Matches available dependencies with required ones,
  reducing them to a single set of dependencies to use.
}

