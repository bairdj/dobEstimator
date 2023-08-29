#' Calculate latest possible date of birth given an age and date
#'
#' @details
#' The latest possible date of birth is if the person turned this age
#' today.
#'
#' @param age Numeric vector of ages
#' @param date Date vector of observation dates
#' @return Date vector of latest possible dates of birth
#' @export
latest_dob <- function(age, date) {
  check_age_arg(age)
  check_date_arg(date)
  if (any(age < 0)) stop("Age must be non-negative")
  lubridate::add_with_rollback(
    date,
    lubridate::years(-age)
  )
}
