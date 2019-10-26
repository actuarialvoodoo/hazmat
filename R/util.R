#' Is Parenthized
#'
#' Determines if the input argument is surrounded by regexp grouping parentheses.
#' If the parathenses are imbalanced it throws an error.
#'
#' @param x a string, intended to be a `pattern` argument for regexp function
#'
#' @return boolean
is_parenthized <- function(x) {
    has_left_paren <- stringr::str_detect(x, "^\\(")
    has_right_paren <- stringr::str_detect(x, "(?<!\\\\)\\)$")

    if (xor(has_left_paren, has_right_paren)) {
        stop("Imbalanced parathenses in '", x, "'", call. = FALSE)
    }

    has_left_paren && has_right_paren
}
