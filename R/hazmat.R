has_rmls <- function(lines = NULL) {
    if (is.null(lines)) {
        stop("`lines` should be a character vector", call. = FALSE)
    }

    which(stringr::str_detect(lines, "rm\\(ls = ls\\(\\)\\)"))
}
