# taken from devtools
github_pat = function(quiet = FALSE) {
  pat <- Sys.getenv("GITHUB_PAT")
  if (nzchar(pat)) {
    if (!quiet) {
      message("Using GitHub PAT from envvar GITHUB_PAT")
    }
    return(pat)
  }
  return(NULL)
}

#
#' Full workflow for John Muschelli Packages
#'
#' @param title Title of package
#' @param description Description of package.  Should be able to work with the
#' start of the sentence "The goal is to provide".
#' @param base_path Path to package root.
#' @param fields Default fields of the DESCRIPTION file
#' @param coverage_type CI tool to use.
#' Currently supports codecov and coveralls.
#' @param protocol transfer protocol, either "ssh" (the default)
#' or "https", passed to \code{\link{use_github}}
#' @param auth_token  personal access token (PAT)
#' passed to \code{\link{use_github}}
#' @param ... arguments to pass to \code{\link{use_github}}
#'
#' @return Invisible TRUE
#' @export
#'
#' @importFrom usethis use_git use_rstudio use_readme_rmd use_vignette
#' @importFrom usethis use_testthat use_appveyor use_coverage use_github
#' @importFrom desc description
#' @importFrom git2r config
#' @importFrom utils person browseURL
#' @importFrom yaml yaml.load_file as.yaml
muschelli_workflow = function(
  title = "",
  description = "",
  base_path = ".",
  fields = muschelli_fields(title = title, description = description),
  coverage_type = "coveralls",
  protocol = "https",
  auth_token = NULL,
  ...) {

  r_folder = file.path(base_path, "R")
  dir.create(r_folder, showWarnings = FALSE, recursive = TRUE)

  man_folder = file.path(base_path, "man")
  dir.create(man_folder, showWarnings = FALSE, recursive = TRUE)

  usethis::use_git(base_path = base_path)
  usethis::use_rstudio(base_path = base_path)
  muschelli_description(fields = fields, base_path = base_path)

  # desc = desc::description$new(base_path)
  # out = as.list(desc$get(desc$fields()))
  # pack_name = out$Package
  muschelli_rproj(base_path = base_path)
  muschelli_description(fields = fields, base_path = base_path)



  usethis::use_readme_rmd(base_path = base_path)
  usethis::use_vignette("bad-vignette", base_path = base_path)
  usethis::use_testthat(base_path = base_path)

  protocol = match.arg(protocol, choices = c("https", "ssh"))
  if (is.null(auth_token)) {
    auth_token = github_pat()
  }
  if (is.null(auth_token)) {
    if (protocol == "https") {
      stop(paste0(
        "If using GitHub, you need to provide auth_token",
        " or set GITHUB_PAT environment variable")
      )
    }
  }
  usethis::use_github(
    base_path = base_path,
    protocol = protocol,
    auth_token = auth_token,
    ...)

  coverage_type = match.arg(
    coverage_type,
    choices =  c("codecov", "coveralls"))
  usethis::use_appveyor(base_path = base_path)
  usethis::use_travis(base_path = base_path)
  if (interactive()) {
    utils::browseURL("https://ci.appveyor.com/projects/new")
  }
  usethis::use_coverage(type = coverage_type)

  # res = git2r::config()
  # gh_username = res$global$user.name
  # repo = paste0(gh_username, "/", pack_name)
  travis_cli = Sys.which("travis")
  if (is.null(travis_cli)) {
    have_travis_cli = FALSE
    message("You must")
    head_msg = c("When you do, y")
  } else {
    have_travis_cli = file.exists(travis_cli)
    head_msg = c("Y")
  }
  message(paste0(head_msg,
                 "ou must run travis setup releases",
                 " to setup deployment keys for Travis")
  )

  use_muschelli_travis(
    base_path = base_path,
    coverage_type = coverage_type)

  use_muschelli_appveyor(
    base_path = base_path
  )
  use_muschelli_readme_rmd(
    base_path = base_path,
    coverage_type = coverage_type)


  invisible(TRUE)
}




