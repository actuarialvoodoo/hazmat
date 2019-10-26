
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
    expect_equal(nrow(res), 1)
    expect_equal(nchar(crayon::strip_style(res$text)), 17)

    expect_silent(res <- check_hazmat("rm\\(ls = ls\\(\\)\\)"))
    expect_equal(nrow(res), 1)
    expect_equal(nchar(crayon::strip_style(res$text)), 17)
})

test_that("identify setwd()", {
    expect_silent(res <- check_hazmat("(setwd\\([^)]+\\))"))
    expect_equal(nrow(res), 1)
    expect_equal(nchar(crayon::strip_style(res$text)), 27)

    expect_silent(res <- check_hazmat("setwd\\([^)]+\\)"))
    expect_equal(nrow(res), 1)
    expect_equal(nchar(crayon::strip_style(res$text)), 27)
})
