has_rmls <- function(lines = NULL) {
    if (is.null(lines)) {
        stop("`lines` should be a character vector", call. = FALSE)
    }

    which(stringr::str_detect(lines, "rm\\(ls = ls\\(\\)\\)"))
}

identify_hazmat <- function(lines, pattern, color, emoji){
    if (!is.call(color)) {
        stop("`color` must be a fuction. It should modify its string argument",
             call. = FALSE)
    }

    if (!is_parenthized(pattern)) {
        pattern <- paste0("(", pattern, ")")
    }

    idx <- stringr::str_detect(lines, pattern)
    marked_lines <- stringr::str_replace_all(lines,
                                             pattern = pattern,
                                             replacement = color("\\1"))

    line_nums <- seq_along(lines)[idx]

    tibble::tibble(line = line_nums, emoji = emoji, text = marked_lines[idx])
}

