#' Write Clipboard
#'
#' @description
#' Write data to the clipboard
#'
#'
#' @param df
#' @param size size of clipbaord to be used (default 32768)
#' @param sep separator, default '\t'
#' @param row.names default to FALSE
#'
#' @return
#' @export
#'
#' @examples
write_clipboard <- function(d, size=32768, sep='\t',row.names=FALSE) {
  write.table(d, file=paste0('clipboard-',size), sep=sep, row.names=row.names)
}
