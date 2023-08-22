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
  if (any(age < 0)) stop("Age must be non-negative")
  date - lubridate::years(age)
}