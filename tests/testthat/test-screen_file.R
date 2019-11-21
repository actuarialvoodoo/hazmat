test_that("scan of file with hazards works", {
    expect_silent(res <- screen_file("testdata/test_file.R", quiet = TRUE))
    expect_s3_class(res, "tbl_df")
    expect_equal(nrow(res), 2)
})

test_that("screen of file with no hazards works", {
    expect_silent(res <- screen_file("testdata/test_file_case.r", quiet = TRUE))
    expect_s3_class(res, "tbl_df")
    expect_equal(nrow(res), 0)
})

test_that("missing file fails with expected error", {
    expect_error(screen_file(), "valid file path")
})


test_that("screen of folder works", {
    expect_silent(res <- screen_folder("testdata", quiet = TRUE))
    expect_s3_class(res, "tbl_df")
    expect_equal(nrow(res), 4)
})
