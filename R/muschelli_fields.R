

#' Fields for a Muschelli Package
#'
#' @return A list of named fields
#' @export
#'
#' @examples
#' muschelli_fields()
muschelli_fields = function() {
  list(
    Title = "",
    Description = ""
    Type = "Package"
    Version = "0.1.0",
    `Authors@R` = c(person(given = "John",
                           family = "Muschelli",
                           role = c("aut", "cre"),
                           email = "muschellij2@gmail.com")),
    Maintainer = "John Muschelli <muschellij2@gmail.com>",
    License = "GPL-2",
    Encoding ="UTF-8",
    LazyData = "true",
    Suggests = "knitr, rmarkdown, covr",
    VignetteBuilder = "knitr"
  )

}

#' @rdname muschelli_fields
#' @param ... arguments to pass to \code{\link{use_description}}
#' @importFrom usethis use_description
#' @export
muschelli_description = function(fields = muschelli_fields(), ...) {
  usethis::use_description(fields = fields, ...)
}
#
# muschelli_workflow = function() {
#   usethis::use_git()
#   usethis::use_rstudio()
#
#   usethis::use_readme_rmd()
#   usethis::use_vignette("bad-vignette")
#   usethis::use_testthat()
#   usethis::use_appveyor()
#   usethis::use_travis()

desc <- desc::description$new(base_path)
out <- as.list(desc$get(desc$fields()))
"---", "  output: github_document", "---"

[![Travis build status](https://travis-ci.org/muschellij2/jhudsl.svg?branch=master)](https://travis-ci.org/muschellij2/jhudsl)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/muschellij2/jhudsl?branch=master&svg=true)](https://ci.appveyor.com/project/muschellij2/jhudsl)
[![Coverage status](https://coveralls.io/repos/github/muschellij2/jhudsl/badge.svg?branch=master)](https://coveralls.io/r/muschellij2/jhudsl?branch=master)


<!-- README.md is generated from README.Rmd. Please edit that file -->

  ```{r setup, include = FALSE}
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.path = "man/figures/README-"
)
```
# jhudsl

The goal of jhudsl is to provide ools for Johns Hopkins Data Science Lab members so that they can brand and organize their packages based on the lab principles. ...

## Installation

You can install jhudsl from github with:

  ```{r gh-installation, eval = FALSE}
# install.packages("devtools")
devtools::install_github("muschellij2/jhudsl")
```


#   travis = yaml::yaml.load_file(".travis.yml")
#
#   "after_success:", "  - Rscript -e 'covr::codecov()'"
#   usethis::use_coverage(type = "coveralls")
#
# }