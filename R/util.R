check_age_arg <- function(x) {
  if (!is.numeric(x)) {
    cli::cli_abort(c(
      "{.var age} must be a numeric vector",
      "x" = "You've supplied a {.obj_type_friendly {x}}"
    ))
  }
}

check_date_arg <- function(x) {
  if (!lubridate::is.Date(x)) {
    cli::cli_abort(c(
      "{.var date} must be a Date vector",
      "x" = "You've supplied a {.obj_type_friendly {x}}"
    ))
  }
}
