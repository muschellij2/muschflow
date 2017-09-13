#' Use Muschelli Travis file
#'
#' @param base_path Path to package root.
#'
#' @return Invisible TRUE
#' @export
#' @importFrom yaml as.yaml yaml.load_file
use_muschelli_appveyor = function(
  base_path = ".") {

  # desc <- desc::description$new(base_path)
  # out <- as.list(desc$get(desc$fields()))

  app_file = file.path(base_path, "appveyor.yml")
  app = yaml::yaml.load_file(app_file)

  environ = app$environment
  if (is.null(environ)) {
    environ = list(global = list())
  }
  environ$global$WARNINGS_ARE_ERORRS = 1
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
    secure = ""
  }

  deploy = list(provider = "GitHub",
                description = "Windows Binary",
                auth_token = list(secure = secure),
                draft = FALSE,
                prerelease = FALSE,
                "on" = list(appveyor_repo_tag = TRUE))
  app$deploy = deploy

  app = yaml::as.yaml(app, indent.mapping.sequence = TRUE)
  writeLines(app, con = app_file)

  return(invisible(TRUE))
}