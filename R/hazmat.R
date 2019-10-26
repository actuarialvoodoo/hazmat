#' Identify Hazard in Lines of Text
#'
#' @param lines a character vector of to check for hazards
#' @param pattern a regexp to identify the hazard
#' @param color a function to highlight the hazard within a line of text
#'
#' @return a tibble with lines of text which match the hazard along with the
#' corresponding line numbers
identify_hazard <- function(lines, pattern, color = function(x) x){
    if (!is.function(color)) {
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

    tibble::tibble(line = line_nums, text = marked_lines[idx])
}

