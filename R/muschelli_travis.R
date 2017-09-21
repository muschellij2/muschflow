#' Use Muschelli Travis file
#'
#' @param base_path Path to package root.
#' @param coverage_type CI tool to use.
#' Currently supports codecov and coveralls.
#'
#'
#' @return Invisible TRUE
#' @export
#' @importFrom yaml as.yaml yaml.load_file
#' @importFrom desc description
#' @importFrom git2r config
use_muschelli_travis = function(
  base_path = ".",
  coverage_type = "coveralls") {

  coverage_type = match.arg(
    coverage_type,
    choices =  c("codecov", "coveralls"))

  desc <- desc::description$new(base_path)
  out <- as.list(desc$get(desc$fields()))

  travis_file = file.path(base_path, ".travis.yml")
  travis = yaml::yaml.load_file(travis_file)
  travis$after_success = c(
    travis$after_success,
    paste0("Rscript -e 'covr::", coverage_type,
           "(type = \"all\")'"))

  travis$warnings_are_errors = TRUE
  travis$before_deploy = c(
    travis$before_deploy,
    'if [ "$TRAVIS_OS_NAME" == "osx" ]; then rm -f *.tar.gz; fi')
  travis$r_check_args = paste0(
    travis$r_check_args,
    "--as-cran --install-args=--build")

  res = git2r::config()
  gh_username = res$global$user.name

  travis$deploy = list(
    provider = "releases",
    skip_cleanup = TRUE,
    file_glob = TRUE,
    file =  paste0(out$Package, "*.t*gz"),
    on = list(
      tags = TRUE,
      repo = paste0(gh_username, "/", out$Package)
    )
  )
  travis = yaml::as.yaml(travis, indent.mapping.sequence = TRUE)
  writeLines(travis, con = travis_file)

  return(invisible(TRUE))
}