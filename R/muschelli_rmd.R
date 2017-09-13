
#' Muschelli README Rmd File
#'
#' @param base_path Path to package root.
#' @param coverage_type CI tool to use.
#' Currently supports codecov and coveralls.
#'
#' @return Invisible TRUE
#' @export
use_muschelli_readme_rmd = function(
  base_path = ".",
  coverage_type = "coveralls") {

  coverage_type = match.arg(
    coverage_type,
    choices =  c("codecov", "coveralls"))

  res = git2r::config()
  gh_username = res$global$user.name

  desc <- desc::description$new(base_path)
  out <- as.list(desc$get(desc$fields()))
  pack_name = out$Package
  repo = paste0(gh_username, "/", pack_name)

  start = c(
    "---", "  output: github_document", "---",
    "")
  badges = c(travis_badge(gh_username = gh_username, base_path = base_path),
             appveyor_badge(gh_username = gh_username, base_path = base_path),
             coverage_badge(gh_username = gh_username, base_path = base_path,
                            coverage_type = coverage_type)
  )
  rmd_header = c(
    "<!-- README.md is generated from README.Rmd. Please edit that file -->",
    "",
    "```{r setup, include = FALSE}",
    "knitr::opts_chunk$set(",
    "  collapse = TRUE,",
    '  comment = "#>",',
    '  fig.path = "man/figures/README-"',
    ")",
    "```"
  )

  dd = out$Description
  if (!is.null(dd)) {
    substr(dd, 1,1) = tolower( substr(dd, 1,1))
  }
  titling = c(
    paste0("# ", pack_name, " Package: ", out$itle),
    paste0("The goal of `", pack_name, "` is to provide ", dd),
    "")

  installation = c(
    "## Installation",
    "",
    paste0("You can install `", pack_name, "` from GitHub with:"),
    "",
    "```{r gh-installation, eval = FALSE}",
    '# install.packages("remotes")',
    paste0('remotes::install_github("', repo, '")'),
    "```"
  )

  rmd_cat = c(start, badges, rmd_header, titling, installation)
  outfile = file.path(base_path, "README.Rmd")
  writeLines(rmd_cat, con = outfile)
  invisible(TRUE)
}

