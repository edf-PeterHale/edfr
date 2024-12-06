#' Fix Comms
#'
#' @param df
#'
#' @return tibble
#' @export
#'
fix_comms <- function(df) {
  df |>
    dplyr::mutate(
      comms = iconv(comms, to = "ASCII", sub = ""),  # remove ASCII characters
      comms = stringr::str_replace(comms, '^[\\+\\(\\)]', ''),  # remove + ( )
      comms = stringr::str_replace(comms, '\\/', ':'), # fix IP addresses
      comms = dplyr::case_when(  # fix comms numbers
        grepl('^44[0-9]+$',comms) ~ stringr::str_replace(comms, '^44','0'),
        grepl('^7[0-9]+',comms) ~ stringr::str_replace(comms, '^7','07'),
        grepl('^00345[0-9]+',comms) ~ stringr::str_replace(comms, '^00345','345'),
        grepl('^(?i)u[0-9]{1,3}\\..*',comms) ~ stringr::str_replace(comms, '^(?i)u',''),
        TRUE ~ comms)
    )
}
