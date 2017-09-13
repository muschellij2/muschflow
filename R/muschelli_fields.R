

#' Fields for a Muschelli Package
#'
#' @return A list of named fields
#' @param title Title of package
#' @param description Description of package.  Should be able to work with the
#' start of the sentence "The goal is to provide".
#'
#' @param given	a character vector with the given names, or a list thereof.
#' @param family a character string with the family name, or a list thereof.
#' @param email a character string (or vector) giving an e-mail address
#'  (each), or a list thereof.
#' @export
#'
#' @examples
#' muschelli_fields()
#' @importFrom utils capture.output
muschelli_fields = function(
  title = "",
  description = "",
  given = "John",
  family = "Muschelli",
  email = "muschellij2@gmail.com") {
  aut = c(person(given = given,
                 family = family,
                 email = email))
  main = format(aut, include = c("given", "family", "email"))
  aut = capture.output(
    dput(aut)
  )
  aut = paste(aut, collapse = "\n    ")

  list(
    Title = title,
    Description = description,
    Type = "Package",
    Version = "0.1.0",
    `Authors@R` = aut,
    Maintainer = main,
    Encoding = "UTF-8",
    LazyData = "true",
    Suggests = "knitr, rmarkdown, covr",
    VignetteBuilder = "knitr"
  )
}
