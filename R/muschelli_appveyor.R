#' Use Muschelli Travis file
#'
#'
#' @return Invisible TRUE
#' @export
#' @importFrom yaml as.yaml yaml.load_file
#' @importFrom usethis use_appveyor
use_muschelli_appveyor = function() {

  # desc <- desc::description$new()
  # out <- as.list(desc$get(desc$fields()))

  app_file = "appveyor.yml"
  if (!file.exists(app_file)) {
    usethis::use_appveyor()
  }
  app = yaml::yaml.load_file(app_file)

  environ = app$environment
  if (is.null(environ)) {
    environ = list(global = list())
  }
  environ$global$WARNINGS_ARE_ERRORS = 1
  environ$global$USE_RTOOLS = TRUE
  environ$global$R_CHECK_INSTALL_ARGS = paste0(
    environ$global$R_CHECK_INSTALL_ARGS,
    "--install-args=--build --no-multiarch"
  )
  app$environment = environ

  # remove tar.gz because this may overwrite the linux build for binary
  artifacts = app$artifacts
  if (length(artifacts) > 0) {
    path_tgz = function(x) {
      grepl("tar[.]gz$", tolower(x$path))
    }
    art_paths = vapply(artifacts, path_tgz, FUN.VALUE = logical(1))
    artifacts = artifacts[!art_paths]
  }
  app$artifacts = artifacts


  deploy = app$deploy
  secure = deploy$auth_token$secure
  if (is.null(secure)) {
    secure = Sys.getenv("APPVEYOR_GITHUB_PAT")
    # secure = ""
  }
  if (secure == "") {
    msg = paste0("Encrypt your GITHUB_PAT on Appveyor and set to ",
                 "APPVEYOR_GITHUB_PAT in ~/.Renviron")
    message(msg)
    if (interactive()) {
      utils::browseURL("https://ci.appveyor.com/tools/encrypt")
    }
  }
  deploy = list(provider = "GitHub",
                description = "Windows Binary",
                auth_token = list(secure = secure),
                draft = FALSE,
                prerelease = FALSE,
                "on" = list(appveyor_repo_tag = TRUE))
  app$deploy = deploy

  app = yaml::as.yaml(app, indent.mapping.sequence = TRUE)
  app = gsub(": yes\\s*$", ": true", app)
  app = gsub(": no\\s*$", ": false", app)
  writeLines(app, con = app_file)

  return(invisible(TRUE))
}