#' Write Clipboard
#'
#' @description
#' Write data to the clipboard
#'
#' @param d object to be saved to clipboard
#' @param size size of clipbaord to be used (default 32768)
#' @param sep separator, default '\t'
#' @param row.names include row names? default to FALSE
#' @param quote surround with quotes? default to FALSE
#' @param ...
#'
#' @return clipboard object
#' @export
#'
write_clipboard <- function(d, size=32768, sep='\t',row.names=FALSE, quote=FALSE, ...) {
  write.table(d, file=paste0('clipboard-',size), sep=sep, row.names=row.names, quote=quote, ...)
}
