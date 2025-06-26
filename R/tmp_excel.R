#' Write Temp XLSX File
#'
#' @description
#' Write data to a temporary .xlsx file and open the file. Useful when you need to share a data set with others.
#'
#'
#' @param df Dataframe to be opened in Excel
#'
#' @return Excel file
#' @import writexl
#' @export
#'
tmp_excel <- function(df) {
  f <- paste0(tempfile(),'.xlsx')
  writexl::write_xlsx(df, f)
  shell.exec(f)
}
