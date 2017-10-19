
#' DESCRIPTION for a Muschelli Package
#'
#' @param fields A named list of fields to add to "DESCRIPTION",
#' passed to \code{\link{use_description}}
#' @importFrom usethis use_description use_gpl3_license
#' @export
muschelli_description = function(
  fields = muschelli_fields()
  ) {
  usethis::use_description(
    fields = fields)
  aut = fields$`Authors@R`

  if (!inherits(aut, "person")) {
    aut = eval(parse(text = aut))
  }
  main = format(aut, include = c("given", "family"))
  usethis::use_gpl3_license(name = main)
}
