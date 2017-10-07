.search_then_determin_type <- function(x, x.name) {
  judge <- paste(x[,1], x[,2])
  if (grepl("Left", judge)) {
    type.list[['Tophat2']] <<- x.name
  } else if (grepl("LINC", judge)) {
    type.list[['Classification']] <<- x.name
  } else if (grepl("value", judge)) {
    type.list[['CDF']] <<- x.name
  } else if (grepl("Started", judge)) {
    if (is.null(type.list[['STAR']])) {
      type.list[['STAR']] <<- x.name
    } else {
      type.list[['STAR']][length(type.list[['STAR']]) + 1] <<- x.name
    }
  } else if (grepl(":", judge)) {
    type.list[['Design']] <<- x.name
  } else if (grepl("chr", judge)) {
    type.list[['LncRNA']] <<- x.name
  } else if (grepl("ID", judge)) {
    type.list[['RSEM']] <<- x.name
  } else if (grepl("reads", judge)) {
    if (is.null(type.list[['Hisat2']])) {
      type.list[['Hisat2']] <<- x.name
    } else {
      type.list[['Hisat2']][length(type.list[['Hisat2']]) + 1] <<- x.name
    }
  }
}
