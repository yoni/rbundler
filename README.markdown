# rbundler
[![Travis CI Build](https://api.travis-ci.org/opower/rbundler.png "Travis CI Build")](https://travis-ci.org/opower/rbundler)

rbundler is an R package dependency management utility.

### Usage

1. Fire up R from your project directory.
2. From the R shell:

```
library(rbundler)
bundle()
```

All dependencies will be installed into `<project_root>/.Rbundle`, and an `<project_root>/.Renviron` file will be created with the following contents:

    R_LIBS_USER='.Rbundle'

Any R operations run from within this project directory will adhere to the project-speciic library and package dependencies. Note that, while this method uses the package DESCRIPTION to define dependencies, it needn't have an actual package structure. Thus, `rbundler` becomes a general tool for managing an R project, whether it be a simple script or a full-blown package.

For more information, run `help`:

    library(rbundler)
    help(rbundler)

### Background

The R programming environment does not include a dependency management tool to facilitate project-specific dependencies. Something akin to Java's maven, Ruby's bundler, Python's virtualenv, Node's npm, etc. has been beyond the reach of R programmers. For a comprehensive analysis of dependeny versioning in R, see [Possible Directions for Improving Dependency Versioning in R](http://arxiv.org/abs/1303.2140).

Wouldn't it be nice if one could simply check out a project and run a single command to build and test the project? The command would install any required packages into a project-specific library without affecting the global R installation. E.g.:

    my_project/.Rlibs/*


Enter [rbundler](http://cran.r-project.org/web/packages/rbundler/index.html). It installs project dependencies into a project-specific subdirectory (e.g. `<PROJECT>/.Rbundle`), allowing the user to avoid using global libraries.

 * [rbundler](https://github.com/opower/rbundler) on Github
 * [rbundler](http://cran.r-project.org/web/packages/rbundler/index.html) on CRAN

We've been using `rbundler` at Opower since October 2012, and have seen improvements in developer workflows and maintainability of internal packages. Combined with our internal package repository and Jenkins, our continous integration server, we have been able to stabilize development of a dozen or so packages for use in production applications.

