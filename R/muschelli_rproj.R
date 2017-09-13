#' Use Muschelli RProject file
#'
#' @param base_path Path to package root.
#'
#' @return Invisible TRUE
#' @export
muschelli_rproj = function(base_path = ".") {
  desc = desc::description$new(base_path)
  out = as.list(desc$get(desc$fields()))
  pack_name = out$Package
  # configure the Rproj file
  rproj_file = file.path(base_path, paste0(pack_name, ".Rproj"))
  rproj = yaml::yaml.load_file(rproj_file)
  rproj$PackageCheckArgs = "--as-cran"
  rproj$PackageRoxygenize = "rd,collate,namespace,vignette"
  rproj$PackageUseDevtools = TRUE
  rproj = yaml::as.yaml(rproj)
  writeLines(rproj, rproj_file)
  invisible(TRUE)
}