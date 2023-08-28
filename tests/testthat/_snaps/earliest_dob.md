# earliest_dob throws errors for invalid input

    Code
      earliest_dob("asdfa", as.Date("2016-10-02"))
    Error <rlang_error>
      `age` must be a numeric vector
      x You've supplied a a string

---

    Code
      earliest_dob(18, "asdfa")
    Error <rlang_error>
      `date` must be a Date vector
      x You've supplied a a string

