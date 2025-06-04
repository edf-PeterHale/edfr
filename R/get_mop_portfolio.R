#' Get MOP Portfolio
#'
#' @description
#' Query the live MOP portfolio
#'
#'
#' @param supp Include supplementary fields, Default is FALSE
#'
#' @return tibble
#' @export
#'
get_mop_portfolio <- function(supp=FALSE) {

  if(supp) {
    q_ <- "select
           mp.*,
           sup.* exclude(RECORD_ID, MPAN, METER_TYPE, MOP_START, MOP_END, SUPPLIER_TIER, SUPPLIER, MTS_METER_TYPE, SERIAL_NO, DATA_REFRESHED)
          from WORKINGDB_ALTERYX_EBS_PRD.PRD_CORE_MO.IFS_MOP_PORTFOLIO mp
          left join WORKINGDB_ALTERYX_EBS_PRD.PRD_CORE_MO.IFS_MOP_PORTFOLIO_SUPPLEMENTARY sup using(record_id)"
  } else {
    q_ <- "select * from WORKINGDB_ALTERYX_EBS_PRD.PRD_CORE_MO.IFS_MOP_PORTFOLIO"
  }

  edfr::query_sf(q_)
}

