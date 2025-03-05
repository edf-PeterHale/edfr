#' pasteSQL
#'
#' @description
#' Collapse a vector into a DBI::SQL character vector (comma separated)
#'
#'
#' @param vec
#'
#' @return DBI::SQL vector
#' @export
#'
#' @examples
#' pasteSQL(letters[c(1:5)])
#'
pasteSQL <- function(vec) {
  DBI::SQL(paste0('\'',paste(vec, collapse='\',\''),'\''))
}
