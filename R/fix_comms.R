#' Fix Comms
#'
#' @param df dataframe
#' @param col column to be fixed, default = `comms`
#'
#' @return tibble
#' @export
#'
#' @examples
#' tibble::tibble(x = c('77123','447456','003451','u192.168.1.1')) |> fix_comms(col=x)
#'
fix_comms <- function(df, col=comms) {
  col = rlang::enquo(col)
  df |>
    dplyr::mutate(
      {{col}} := iconv({{col}}, to = "ASCII", sub = ""),  # remove ASCII characters
      {{col}} := stringr::str_replace({{col}}, '^[\\+\\(\\)]', ''),  # remove + ( )
      {{col}} := stringr::str_replace_all({{col}}, '[\\/\\;]+', ':'), # fix IP addresses
      {{col}} := stringr::str_remove_all({{col}}, '\t'),  # remove + ( )
      {{col}} := stringr::str_replace({{col}}, '^TE[0]{0,1}7', '07'), #remove TE from mobile numbers
      {{col}} := dplyr::case_when(  # fix comms numbers
        grepl('^44[0-9]+$',{{col}}) ~ stringr::str_replace({{col}}, '^44','0'),
        grepl('^7[0-9]+',{{col}}) ~ stringr::str_replace({{col}}, '^7','07'),
        grepl('^00345[0-9]+',{{col}}) ~ stringr::str_replace({{col}}, '^00345','345'),
        grepl('^(?i)u[0-9]{1,3}\\..*',{{col}}) ~ stringr::str_replace({{col}}, '^(?i)u',''),
        TRUE ~ {{col}}),
      {{col}} := trimws({{col}})
    )
}



