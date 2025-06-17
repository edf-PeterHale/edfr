#' Latest MTS Success per Meter
#'
#' @param mts_location Folder location of MTS MTS_success_testid.rds file
#'
#' @return tibble
#' @export
#'
mts_latest_success <- function(mts_location = 'C:/Users/hale05p/OneDrive - EDF/Projects/MTS/data/') {

  mts_success <- readr::read_rds(paste0(mts_location,'MTS_success_testid.rds'))

  mts_latest <-
    mts_success |>
    dplyr::select(meter=serialNumber,comms=remoteAddress,testId,completedTimestamp,meterType,sim_number) |>
    rbind(
      mts_success |> dplyr::select(meter=plant_number,comms=remoteAddress,testId,completedTimestamp,meterType,sim_number)
    ) |>
    dplyr::filter(!(is.na(comms) | comms == '' | is.na(meter) | meter == '-')) |>
    edfr::filter_latest(meter,completedTimestamp) #edfr::fix_comms()

  mts_latest
}


