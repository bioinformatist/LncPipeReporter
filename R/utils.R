#' Change the first letter of sentence/phrase to uppercase.
#'
#' @param x the sentence/phrase.
#'
#' @return The sentence/phrase converted.
toUpperFirstLetter <- function(x) {
  paste0(toupper(substr(x, 1, 1)), substring(x, 2))
}


#' Search the data folder recursively then determine their types.
#'
#' @param path path for searching.
#'
#' @return A list with types containing file absolute path in vector.
search_then_determine <- function(path = system.file(file.path("extdata", "demo_results"),package = "LncPipeReporter")) {
  # Initialize an empty list for storing file types
  type.list <- list()
  
  determine_type <- function(file.header, x.name) {
    # file.header <- paste(x[,1], x[,2])
    if (any(grepl(paste(c('known', 'novel', 'protein_coding'),collapse="|"), file.header))) {
      type.list[['lncRNA']] <<- x.name
    }
    if (any(grepl("Sample", file.header))) {
      type.list[['Design']] <<- x.name
    }
    if (any(grepl("ID", file.header))) {
      type.list[['RSEM']] <<- x.name
    }
  }
  
  parsing.list <-  sapply(list.files(path = path, recursive = TRUE), 
                          USE.NAMES = FALSE, 
                          function(x) paste0(path, .Platform$file.sep, x))
  
  file.headlines <- sapply(parsing.list, function(x) 
    tryCatch({fread(x, fill = TRUE, nrows = 1, header = FALSE)}, error = function(e) {}))
  
  lapply(names(file.headlines), function(x) determine_type(file.headlines[[x]], x))
  
  return(type.list)
}