#' Add Missing Column
#'
#' @description
#' Add a missing column to a data frame
#'
#'
#' @param d data frame
#' @param col column name to be added
#' @param type column type ('character','integer' or 'numeric', else defaults to 'logical')
#'
#' @return tibble
#' @import dplyr
#' @export
#'
#' @examples
#' # Add a new character column
#' tibble::tibble(a=1, b=2) |> add_missing_col(col='c',type='character')
#'
#' Trying to add a column that already exists returns the existing data frame
#' tibble::tibble(a=1, b=2) |> add_missing_col(col='a',type='character')
#'
add_missing_col <- function(d, col, type='logical') {

  if({{col}} %in% names(d)) {
    return(d)
  }

  if(type=='character') {
    d <- dplyr::mutate(d, {{col}} := NA_character_)
  } else if(type=='integer' | type=='int') {
    d <- dplyr::mutate(d, {{col}} := NA_integer_)
  } else if(type=='numeric') {
    d <- dplyr::mutate(d, {{col}} := NA_real_)
  } else {
    d <- dplyr::mutate(d, {{col}} := NA)
  }

  d
}






