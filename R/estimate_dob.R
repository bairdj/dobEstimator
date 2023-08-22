#' Estimate date of birth from ages at known dates
#'
#' @param age Numeric vector of ages
#' @param date Date vector of observation dates
#' @return Interval from earliest to latest possible date of birth
#' @export
estimate_dob <- function(age, date) {
  intervals <- to_interval(age, date)

  purrr::reduce(intervals, lubridate::intersect)
}


to_interval <- function(age, date) {
  lubridate::interval(
    earliest_dob(age, date),
    latest_dob(age, date)
  )
}
