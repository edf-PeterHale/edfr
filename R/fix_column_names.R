#' Fix Column Names
#'
#' @param d dataframe
#' @param lower_case Convert to lower case (dafault TRUE)
#'
#' @return dataframe
#' @export
#'
fix_col_names <- function(d, lower_case=TRUE) {
  names(d) <- stringr::str_replace_all(names(d), '[[[:punct:]]|[ ]]+', '_')
  if(lower_case) {names(d) <- tolower(names(d))}
  d
}
