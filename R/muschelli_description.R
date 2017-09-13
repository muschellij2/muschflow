
#' DESCRIPTION for a Muschelli Package
#'
#' @param ... arguments to pass to \code{\link{use_description}}
#' @param fields A named list of fields to add to "DESCRIPTION",
#' passed to \code{\link{use_description}}
#' @param base_path path to package root directory
#' @importFrom usethis use_description use_gpl3_license
#' @export
muschelli_description = function(
  fields = muschelli_fields(),
  base_path = ".", ...) {
  usethis::use_description(
    fields = fields,
    base_path = base_path, ...)
  aut = fields$`Authors@R`
  main = format(aut, include = c("given", "family"))
  usethis::use_gpl3_license(name = main, base_path = base_path)

}
