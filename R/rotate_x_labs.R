#' Rotate x labs
#'
#' @description
#' Rotate x labels to be vertical, centered and justified to the x axis
#'
#' @param angle Angle in \[0, 360\] (default = 90)
#' @param vjust Vertical justification in (0,1)
#' @param hjust Horizontal justification in (0,1)
#' @param ... Further named arguments for theme element \code{axis.text.x} passed to \code{ggplot2::element_text()}
#'
#' @importFrom ggplot2 theme
#' @export
rotate_x_labs <- function(angle = 90, vjust = 0.5, hjust = 1, ...){
  list(
    ggplot2::theme(
      axis.text.x =
        ggplot2::element_text(
          angle = angle,
          vjust = vjust,
          hjust = hjust,
          ...)))
}
