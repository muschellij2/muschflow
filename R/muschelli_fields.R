

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
#' @param role Role of the people (author/creator)
#' @param comment Additional comments (usually for ORCID ID)
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
  email = "muschellij2@gmail.com",
  role = c("aut", "cre"),
  comment = c(ORCID = "0000-0001-6469-1750")
  ) {

  role = capture.output(
    dput(role)
  )
  comment = capture.output(
    dput(comment)
  )
  aut = paste0('c(person(given = "', given, '",',
               'family = "', family, '",',
               'email = "', email, '",',
               'role = ', role, ',',
               'comment = ', comment, '))')

  # main = format(aut, include = c("given", "family", "email"))
  # aut = capture.output(
  #   dput(aut)
  # )
  # aut = paste(aut, collapse = "\n    ")

  list(
    Type = "Package",
    Title = title,
    Description = description,
    Version = "0.1.0",
    `Authors@R` = aut,
    # Maintainer = main,
    Encoding = "UTF-8",
    LazyData = "true",
    Suggests = "knitr, rmarkdown, covr",
    VignetteBuilder = "knitr"
  )
}
