#' Use Muschelli RProject file
#'
#'
#' @return Invisible TRUE
#' @export
muschelli_rproj = function() {
  desc = desc::description$new()
  out = as.list(desc$get(desc$fields()))
  pack_name = out$Package
  # configure the Rproj file
  rproj_file = paste0(pack_name, ".Rproj")
  rproj = yaml::yaml.load_file(rproj_file)
  rproj$PackageCheckArgs = "--as-cran"
  rproj$PackageRoxygenize = "rd,collate,namespace,vignette"
  rproj$PackageUseDevtools = TRUE
  rproj = yaml::as.yaml(rproj)
  writeLines(rproj, rproj_file)
  invisible(TRUE)
}