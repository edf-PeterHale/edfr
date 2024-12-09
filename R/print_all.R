#' Print All
#'
#' @param df dataframe
#' @param n  Rows to print, default is all rows
#'
#' @return tibble
#' @export
#'
#' @examples
#' tibble::tibble(x=1:30) |> print_all()
print_all <- function(df, n=NULL) {
  print(df, n = ifelse(is.null(n), nrow(df), n))
}

