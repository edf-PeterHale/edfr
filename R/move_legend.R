#' Move Legend
#'
#' @description
#' Move the ggplot2 legend
#'
#'
#' @param position the position of legends ("none", "left", "right", "bottom", "top", or two-element numeric vector) defaults to "none"
#' @importFrom ggplot2 theme
#' @export
move_legend <- function(position = "none"){
  ggplot2::theme(legend.position = position)
}
