test_that("latest_dob works", {
  # Should return same date age years ago
  expect_equal(latest_dob(18, as.Date("2016-10-02")), as.Date("1998-10-02"))
  expect_equal(latest_dob(27, as.Date("2000-09-16")), as.Date("1973-09-16"))
  expect_equal(latest_dob(0, as.Date("2016-10-02")), as.Date("2016-10-02"))
  expect_s3_class(latest_dob(18, as.Date("2016-10-02")), "Date")
})

test_that("latest_dob works with vector inputs", {
  result <- latest_dob(c(18, 27), as.Date(c("2016-10-02", "2000-09-16")))
  expect_equal(result, as.Date(c("1998-10-02", "1973-09-16")))
})

test_that("latest_dob has error if negative age", {
  expect_error(latest_dob(-1, as.Date("2016-10-02")))
})

test_that("latest_dob throws errors for invalid input", {
  expect_error(latest_dob("asdfa", as.Date("2016-10-02")))
  expect_snapshot(latest_dob("asdfa", as.Date("2016-10-02")), error = TRUE)
  expect_error(latest_dob(18, "asdfa"))
  expect_snapshot(latest_dob(18, "asdfa"), error = TRUE)
})
