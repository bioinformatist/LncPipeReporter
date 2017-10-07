run_reporter <- function(input = system.file(paste0("extdata", .Platform$file.sep, "demo_results"),
                                             package = "LncPipeReporter"),
                         output = 'reporter.html',
                         theme = 'npg',
                         cdf.percent = 10,
                         max.lncrna.len = 10000,
                         min.expressed.sample = 50) {
  rmarkdown::render(system.file(paste0('rmd', .Platform$file.sep, 'reporter.Rmd'), package = 'LncPipeReporter'),
                    params = list(input = input,
                                  output = output,
                                  theme = theme,
                                  cdf.percent = cdf.percent,
                                  max.lncrna.len = max.lncrna.len,
                                  min.expressed.sample = min.expressed.sample))
}

