test_that("estimate_dob returns correctly", {
  result <- estimate_dob(
    c(18, 19),
    as.Date(c("2016-10-02", "2016-11-11"), tz = "UTC")
  )
  expect_s4_class(result, "Interval")
  expect_equal(lubridate::int_start(result), as.POSIXct("1997-10-03", tz = "UTC"))
  expect_equal(lubridate::int_end(result), as.POSIXct("1997-11-11", tz = "UTC"))
})

test_that("estimate_dob calculates exact date of birth", {
  # If age increments on consecutive days, we know the exact date of birth
  result <- estimate_dob(
    c(20, 21),
    as.Date(c("2016-10-02", "2016-10-03"), tz = "UTC")
  )
  expect_equal(lubridate::int_start(result), as.POSIXct("1995-10-03", tz = "UTC"))
  expect_equal(lubridate::int_end(result), as.POSIXct("1995-10-03", tz = "UTC"))
})

test_that("estimate_dob works with multiple dates", {
  # Actual DOB is 1990-02-03
  ages <- c(20, 20, 20, 21, 21, 22, 22)
  dates <- as.Date(c(
    "2010-04-21",
    "2010-08-30",
    "2011-01-01",
    "2011-02-06",
    "2011-12-21",
    "2012-02-27",
    "2013-01-15"
  ))
  result <- estimate_dob(ages, dates)
  # Earliest observed after increment is 02-06
  expect_equal(lubridate::int_end(result), as.POSIXct("1990-02-06", tz = "UTC"))
  # Latest observed prior to increment is 01-15
  expect_equal(lubridate::int_start(result), as.POSIXct("1990-01-16", tz = "UTC"))
})
