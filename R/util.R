is_parenthized <- function(x) {
    has_left_paren <- substring(x, 1, 1) == "("
    has_right_paren <- substring(x, nchar(x), nchar(x)) == ")"

    if (xor(has_left_paren, has_right_paren)) {
        stop("Imbalanced parathenses in '", x, "'", call. = FALSE)
    }

    has_left_paren && has_right_paren

}
