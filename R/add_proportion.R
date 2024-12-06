#' Add Proportion
#'
#' @param df dataframe
#' @param col column to be evaluated, default `n`
#' @param digits number of decimal places returned, default 1
#'
#' @return tibble
#' @export
#'
#' @examples
#' tibble::tibble(x=c(2,4,6,8,10)) |> add_prop(x, digits = 2)
#'
add_prop <- function(df, col=`n`, digits=1) {
  col <- enquo(col)
  dplyr::mutate(df, prop := round(100*!!col/sum(!!col), digits))
}
