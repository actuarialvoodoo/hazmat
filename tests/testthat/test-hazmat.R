
check_hazmat <- function(patt) {
    check_lines <- c(
        "hello <- function(x, y){",
        "    z <- x + y",
        "    old_wd <- setwd(foobar)",
        "    rm(ls = ls())",
        "    return(z)",
        "}"
        )
    identify_hazard(check_lines, patt)
}

test_that("identify rm(ls = ls())", {
    expect_silent(res <- check_hazmat("(rm\\(ls = ls\\(\\)\\))"))
    expect_s3_class(res, "tbl_df")
    expect_equal(nrow(res), 1)
    expect_equal(nchar(crayon::strip_style(res$text)), 17)

    expect_silent(res <- check_hazmat("rm\\(ls = ls\\(\\)\\)"))
    expect_s3_class(res, "tbl_df")
    expect_equal(nrow(res), 1)
    expect_equal(nchar(crayon::strip_style(res$text)), 17)
})

test_that("identify setwd()", {
    expect_silent(res <- check_hazmat("(setwd\\([^)]+\\))"))
    expect_s3_class(res, "tbl_df")
    expect_equal(nrow(res), 1)
    expect_equal(nchar(crayon::strip_style(res$text)), 27)

    expect_silent(res <- check_hazmat("setwd\\([^)]+\\)"))
    expect_s3_class(res, "tbl_df")
    expect_equal(nrow(res), 1)
    expect_equal(nchar(crayon::strip_style(res$text)), 27)
})

test_that("no match returns empty tibble", {
    expect_silent(res <- check_hazmat("foo\\(bar\\)"))
    expect_s3_class(res, "tbl_df")
    expect_equal(nrow(res), 0)
})
