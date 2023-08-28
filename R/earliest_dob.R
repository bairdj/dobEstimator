#' Calculate earliest possible date of birth given an age and date
#'
#' @details
#' The earliest possible date of birth is if this is the person's last day
#' as an `age` year old. Therefore, the earliest possible date is tomorrow's
#' date minus `age + 1` years.
#'
#' @param age Numeric vector of ages
#' @param date Date vector of observation dates
#' @return Date vector of earliest possible dates of birth
#' @export
earliest_dob <- function(age, date) {
  check_age_arg(age)
  check_date_arg(date)
  if (any(age < 0)) stop("Age must be non-negative")
  date + lubridate::days(1) - lubridate::years(age + 1)
}
