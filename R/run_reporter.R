#' Run the main reporting pipeline.
#'
#' @param input absolute path of input directory (results of up-stream analysis).
#' @param output index file name (In HTML format).
#' @param output_dir output directory (who holds all results and dependencies).
#' @param theme journal palette applied to all plots supplied by package [ggsci](../../ggsci/doc/ggsci.html).
#' @param cdf.percent percentage of values to display when calculating coding potential.
#' @param max.lncrna.len maximum length of lncRNAs to display when calculating distribution (percentage).
#' @param min.expressed.sample minimal percentage of expressed samples (percentage).
#' @param ask need set parameters with graphical user-interface in browser?
#' @param de.method which method should be used to perform differential expression analysis?
#' Could be 'edger'(default), 'noiseq' or 'deseq2'.
#'
#' @return None
#' @export
#' 
#' @details The function call a R markdown script internally by `rmarkdown::render`. 
#' There're also default paramter values in the script -- sometimes if the user try run it manually in *RStudio*,
#' *knitr* will bring him/her a graphical interface to choose/fill the value of paramters. 
#' Also you can use statement like `rmarkdown::render('./reporter.Rmd', params = 'ask')` to call the interface in browser.
#' 
#' @examples
#' \donttest{
#' # Below takes too long time for running, so ignore them in R CMD check.
#' run_reporter()
#' run_reporter(ask = TRUE)
#' run_reporter(input = system.file(paste0("extdata", .Platform$file.sep, "demo_results"),
#'              package = "LncPipeReporter"),
#'              output = 'reporter.html', theme = 'npg', cdf.percent = 10,
#'              max.lncrna.len = 10000, min.expressed.sample = 50, ask = FALSE)
#' }
run_reporter <- function(input = system.file(file.path("extdata", "demo_results"),package = "LncPipeReporter"),
                         output = 'reporter.html',
                         output_dir = path.expand('~/LncPipeReports'),
                         de.method = 'edger', 
                         theme = 'npg',
                         cdf.percent = 10,
                         max.lncrna.len = 10000,
                         min.expressed.sample = 50,
                         ask = FALSE) {
  origin <- getwd()
  setwd(normalizePath(input))
  input <- getwd()
  setwd(origin)
  dir.create(suppressWarnings(normalizePath(output_dir)), showWarnings = FALSE, recursive = TRUE)
  setwd(normalizePath(output_dir))
  output_dir <- getwd()
  
  if (ask) {
    rmarkdown::render(system.file(file.path('rmd', 'reporter.Rmd'),
                                  package = 'LncPipeReporter'),
                      output_dir = output_dir,
                      output_options = list(lib_dir = file.path(output_dir, 'libs')), params = 'ask')
  } else {
    rmarkdown::render(system.file(file.path('rmd', 'reporter.Rmd'),
                                  package = 'LncPipeReporter'),
                      output_dir = output_dir,
                      output_options = list(lib_dir = file.path(output_dir, 'libs')),
                      params = list(input = input,
                                    output = output,
                                    de.method = de.method,
                                    theme = theme,
                                    cdf.percent = cdf.percent,
                                    max.lncrna.len = max.lncrna.len,
                                    min.expressed.sample = min.expressed.sample))
  }
  
  figures.dir <-  file.path(output_dir, 'figures')
  tables.dir <- file.path(output_dir, 'tables')
  
  dir.create(figures.dir, showWarnings = FALSE)
  dir.create(tables.dir, showWarnings = FALSE)
  
  invisible(file.copy(Sys.glob(file.path(system.file(package = 'LncPipeReporter'), 'rmd', '*.csv')), tables.dir))
  invisible(file.copy(Sys.glob(file.path(system.file(package = 'LncPipeReporter'), 'rmd', '*.tiff')), figures.dir))
  invisible(file.copy(Sys.glob(file.path(system.file(package = 'LncPipeReporter'), 'rmd', '*.pdf')), figures.dir))
  invisible(file.remove(Sys.glob(file.path(system.file(package = 'LncPipeReporter'), 'rmd', '*.csv')),
                        Sys.glob(file.path(system.file(package = 'LncPipeReporter'), 'rmd', '*.tiff')),
                        Sys.glob(file.path(system.file(package = 'LncPipeReporter'), 'rmd', '*.pdf'))))
}

