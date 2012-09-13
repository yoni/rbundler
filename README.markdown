Rbundler is an R package dependency management utility.

Usage
-----

    library(rbundler)
    help(rbundler)

Description
-----------

The `bundle` function installs the package and all of it's dependencies into a
bundle library under `<project_root>/.Rbundle` and generates an `.Renviron` 
script which sets R_LIBS_USER `<project_root>/.Rbundle`.

