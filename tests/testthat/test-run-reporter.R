context("Run reporter")

test_that("If there'll be any error during running reporter", {
  # For testing multipe sample case
  expect_message(run_reporter(), regexp = 'Output created:')
  # For testing lacking certain parts case
  expect_message(run_reporter(input = system.file(file.path("extdata",
                                                            "demo_results_lack_part"),
                                                  package = "LncPipeReporter")), regexp = 'Output created:')
  # For testing single sample case
  expect_message(run_reporter(input = system.file(file.path("extdata",
                                                            "demo_results_single_sample"),
                                                  package = "LncPipeReporter")), regexp = 'Output created:')
})