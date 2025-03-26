#' Query AFMS
#'
#' @param q query
#' @param dsn driver name, default 'AFMS'
#' @param bigint how do we treat bigints, default 'integer'
#' @param params optional list of parameters to be passed to the query
#' @param show.query show the query being sent, default = FALSE
#'
#' @return tibble
#' @export
#'
query_afms <- function(q, dsn = 'AFMS', bigint = 'integer',
                       params = list(), show.query = FALSE) {

  conn <- DBI::dbConnect(drv = odbc::odbc(), dsn = dsn, bigint = bigint,
                         USR = Sys.getenv('AFMS_USER'), PWD = Sys.getenv('AFMS_PWD'))

  iq <- DBI::sqlInterpolate(conn, q, .dots = params)
  if(show.query) {message(iq)}

  out <- DBI::dbGetQuery(conn, statement = iq) |> tibble::as_tibble()

  names(out) <- tolower(names(out))

  out
}
