#' Query Snowflake
#'
#' @description
#' Query Snowflake.
#'
#' Some useful databases/schemas:
#'
#' \itemize{
#'   \item FLK_DUB_DB_DATALAKE_PRD.DIMENSIONAL_IAC
#'   \item WORKINGDB_EBS_PRD.METERING_OPERATIONS_TEST
#'   \item WORKINGDB_EBS_PRD.METERING_OPERATIONS_PUBLISH
#'   \item BIGCHANGE2175EDFENERGYLTD.BIGCHANGE_2175_EDF_ENERGY_LTD
#'   \item WORKINGDB_ALTERYX_EBS_DEV.DEV_CORE_MO
#' }
#'
#' Useful roles:
#'
#' \itemize{
#'   \item FLK_DUB_ROL_DATALAKEBUSINESSANALYST_PRD
#'   \item ROL_ENGINEER_METERING_EBS
#' }
#'
#' @param q query
#' @param dsn driver name, default SnowFlake
#' @param database database, default FLK_DUB_DB_DATALAKE_PRD.
#' @param schema schema, default DIMENSIONAL_IAC
#' @param role Snowflake role, default FLK_DUB_ROL_DATALAKEBUSINESSANALYST_PRD.
#' @param bigint how do we treat bigints, default 'integer'
#' @param LogLevel set to zero to avoid printing connection messages
#' @param tracing level of error messages to be displayed
#' @param params optional list of parameters to be passed to the query
#' @param show.query show the query being sent, default = FALSE
#'
#' @return tibble
#' @export
#'
#' @examples
#' query_sf("select * from dimservicepoint limit 1", show.query = TRUE)
#'
#' @examples
#' query_sf("select * from dimservicepoint where sk_servicepointid in (?id_)",
#'           params = list(id_ = DBI::SQL(paste(951495858:951495862, collapse=','))),
#'           show.query = TRUE)
#'
#' @examples
#' query_sf("
#' with a as (
#' select value as x, *
#' from table(flatten(input => to_array([?my_values])))
#' )
#' select * from a",
#' params = list(my_values = DBI::SQL(paste(1:10, collapse=','))),
#' show.query = TRUE)
#'
#' @examples
#' query_sf("with a as (
#' -- create a column (x) with the numbers 1-5
#' select value as x from table(flatten(input => to_array([1,2,3,4,5])))
#' )
#' -- select from a filtering to even numbers
#' select * from a
#' where a.x in (?my_values)",
#' params = list(
#' # example shows a tibble column being extracted and passed through pasteSQL()
#' my_values=pasteSQL(tibble(v=c(2,4,6,8,10)) |> pull(v)))
#' )
#'
query_sf <- function(q="select 1 as test", dsn = 'SnowFlake', database = 'FLK_DUB_DB_DATALAKE_PRD', schema = 'DIMENSIONAL_IAC',
                     role = "FLK_DUB_ROL_DATALAKEBUSINESSANALYST_PRD", bigint = 'integer',
                     LogLevel = 0, params = list(), tracing=0, show.query = FALSE) {

  conn <- DBI::dbConnect(drv = odbc::odbc(), dsn = dsn, database = database, schema = schema,
                         role = role, bigint = bigint, LogLevel=LogLevel, tracing=tracing)

  iq <- DBI::sqlInterpolate(conn, q, .dots = params)
  if(show.query) {message(iq)}

  out <- DBI::dbGetQuery(conn, statement = iq, tracing=tracing) |> tibble::as_tibble()

  names(out) <- tolower(names(out))

  out
}
