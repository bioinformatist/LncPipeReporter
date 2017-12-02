Sys.setenv("R_TESTS" = "")

library(testthat)
library(LncPipeReporter)

test_check("LncPipeReporter")
