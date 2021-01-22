.onLoad <- function(libname, pkgname) {
  rJava::.jpackage(pkgname, lib.loc=libname)
  op <- options()
  op.devtools <- list(
    devtools.path = "~/R-dev",
    devtools.install.args = "",
    devtools.name = "Farnaz Fouladi; Jack Young",
    devtools.desc.author = "Farnaz Fouldi [aut, cre]; Jack Young [aut, cre]",
    devtools.desc.license = "MIT",
    devtools.desc.suggests = NULL,
    devtools.desc = list()
  )
  toset <- !(names(op.devtools) %in% names(op))
  if(any(toset)) options(op.devtools[toset])

  invisible()
}
