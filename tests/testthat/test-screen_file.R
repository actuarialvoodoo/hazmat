test_that("multiplication works", {
    expect_silent(res <- screen_file("testdata/test_file.R", quiet = TRUE))
    expect_s3_class(res, "tbl_df")
    expect_equal(nrow(res), 2)
})
