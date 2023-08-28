test_that("earliest_dob works", {
  # Should return tomorrow's date age years ago
  expect_equal(earliest_dob(18, as.Date("2016-10-02")), as.Date("1997-10-03"))
  expect_equal(earliest_dob(27, as.Date("2000-09-16")), as.Date("1972-09-17"))
  expect_equal(earliest_dob(0, as.Date("2016-10-02")), as.Date("2015-10-03"))
  expect_s3_class(earliest_dob(18, as.Date("2016-10-02")), "Date")
})

test_that("earliest_dob works with vector inputs", {
  result <- earliest_dob(c(18, 27), as.Date(c("2016-10-02", "2000-09-16")))
  expect_equal(result, as.Date(c("1997-10-03", "1972-09-17")))
})

test_that("earliest_dob has error if negative age", {
  expect_error(earliest_dob(-1, as.Date("2016-10-02")))
})

test_that("earliest_dob throws errors for invalid input", {
  expect_error(earliest_dob("asdfa", as.Date("2016-10-02")))
  expect_snapshot(earliest_dob("asdfa", as.Date("2016-10-02")), error = TRUE)
  expect_error(earliest_dob(18, "asdfa"))
  expect_snapshot(earliest_dob(18, "asdfa"), error = TRUE)
})
