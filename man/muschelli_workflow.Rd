% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/muschelli_workflow.R
\name{muschelli_workflow}
\alias{muschelli_workflow}
\title{Full workflow for John Muschelli Packages}
\usage{
muschelli_workflow(title = "", description = "",
  fields = muschelli_fields(title = title, description = description),
  coverage_type = "codecov", protocol = "https", auth_token = NULL,
  ...)
}
\arguments{
\item{title}{Title of package}

\item{description}{Description of package.  Should be able to work with the
start of the sentence "The goal is to provide".}

\item{fields}{Default fields of the DESCRIPTION file}

\item{coverage_type}{CI tool to use.
Currently supports codecov and coveralls.}

\item{protocol}{transfer protocol, either "ssh" (the default)
or "https", passed to \code{\link{use_github}}}

\item{auth_token}{personal access token (PAT)
passed to \code{\link{use_github}}}

\item{...}{arguments to pass to \code{\link{use_github}}}
}
\value{
Invisible TRUE
}
\description{
Full workflow for John Muschelli Packages
}
