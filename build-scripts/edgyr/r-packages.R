#! /usr/bin/env Rscript

source("~/.Rprofile")
Sys.setenv(MAKE = paste0("make --jobs=", parallel::detectCores()))
install.packages(c(
  "caracas",
  "data.table",
  "flexdashboard",
  "learnr",
  "miniUI",
  "remotes",
  "renv",
  "reticulate",
  "shiny",
  "V8",
  "webshot"
), quiet = TRUE)
warnings()

# test V8
cat("\ntesting V8\n")
library(V8)
ct <- v8()
ct$eval("var foo = 123")
ct$eval("var bar = 456")
if (ct$eval("foo + bar") != 579) {
  stop(paste0(ct$eval("foo + bar"), " wrong value - should be 579"))
} else {
  cat("\nV8 is working\n\n")
}
