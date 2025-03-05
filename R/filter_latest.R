#' Filter Latest
#'
#' @description
#' Filter a data frame (per group(s)) to the first row (by descending order)
#'
#' @param d data frame
#' @param grp grouping columns
#' @param ord ordering columns
#'
#' @return
#' @export
#'
#' @examples
#' data.frame(a = rep(1:5, each=2), b = 1:10) |>
#' filter_latest(grp = a, ord = b)
#'
#' data.frame(a = rep(1:5, each=2), b = 1:10) |>
#' filter_latest(grp = c(a,b), ord = b)
#'
filter_latest <- function(d, grp, ord) {
  d |>
    dplyr::group_by(dplyr::pick({{grp}})) |>
    dplyr::arrange(dplyr::pick({{grp}}), desc(dplyr::pick({{ord}}))) |>
    dplyr::filter(dplyr::row_number() == 1) |>
    dplyr::ungroup()
}
