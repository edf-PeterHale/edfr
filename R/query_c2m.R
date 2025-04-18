#' Query C2M
#'
#' @param q query
#' @param dsn driver name, default 'C2M'
#' @param database database, default 'CISADM'
#' @param bigint how do we treat bigints, default 'integer'
#' @param LogLevel set to zero to avoid printing connection messages
#' @param params optional list of parameters to be passed to the query
#' @param show.query show the query being sent, default = FALSE
#'
#' @return tibble
#' @export
#'
query_c2m <- function(q, dsn = 'C2M', database = 'CISADM', bigint = 'integer',
                      LogLevel = 0, params = list(), show.query = FALSE) {

  conn <- DBI::dbConnect(drv = odbc::odbc(), dsn = dsn, database = database, bigint = bigint,
                         LogLevel = 0, PWD = Sys.getenv('C2MPWD'))

  iq <- DBI::sqlInterpolate(conn, q, .dots = params)
  if(show.query) {message(iq)}

  out <- DBI::dbGetQuery(conn, statement = iq) |> tibble::as_tibble()

  names(out) <- tolower(names(out))

  out
}



