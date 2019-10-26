test_that("is_parathized returns expected conditions", {
    expect_true(is_parenthized("(abc)"))
    expect_false(is_parenthized("abc"))
    expect_error(is_parenthized("(abc"), "Imbalanced")
    expect_error(is_parenthized("abc)"), "Imbalanced")
    expect_false(is_parenthized(""))
})
