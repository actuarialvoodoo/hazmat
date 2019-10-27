#' Identify Hazard in Lines of Text
#'
#' @param lines a character vector of to check for hazards
#' @param pattern a regexp to identify the hazard
#' @param color a function to highlight the hazard within a line of text
#' @param emoji an emoji to include in the the output
#'
#' @return a tibble with lines of text which match the hazard along with the
#' corresponding line numbers
identify_hazard <- function(lines, pattern, color = function(x) x, emoji = ""){
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
    if (length(line_nums) == 0L) {
        emoji <- character(0)
    }
    tibble::tibble(line = line_nums, text = marked_lines[idx], emoji = emoji)
}

identify_rm <- function(lines) {
    pattern <- "rm\\(ls = ls\\(\\)\\)"
    emoji <- intToUtf8(0x1f525) #  Fire Emoji
    identify_hazard(lines, pattern, color = crayon::red, emoji = emoji)
}

identify_setwd <- function(lines) {
    pattern <- "setwd\\([^\\)]+\\)"
    emoji <- intToUtf8(0x1f525) #  Fire Emoji
    identify_hazard(lines, pattern, color = crayon::red, emoji = emoji)
}

identify_system <- function(lines) {
    pattern <- "system(2)?\\('[^\\')]+'\\)"
    emoji <- intToUtf8(0x1f514) #  Bell Emoji
    identify_hazard(lines, pattern, color = crayon::yellow, emoji = emoji)
}

screen_file <- function(path = NULL, quiet = FALSE){
    if (is.null(path)) {
        stop("`path` should be a valid file path.", call. = FALSE)
    }

    if (!fs::file_access(path, mode = "read")) {
        stop("Cannot read `path`. ",
             "You may not have read access or the file may not exist.",
             call. = FALSE)
    }
    file_lines <- readLines(path)

    hazards <- dplyr::bind_rows(
        identify_rm(file_lines),
        identify_setwd(file_lines),
        identify_system(file_lines)
    )

    hazards <- dplyr::arrange_at(hazards, .vars = "line")
    if (!quiet) {

        output <- glue::glue_data(hazards, "{emoji} {line}: {text}")
        purrr::walk(output, usethis::ui_line)
    }

    invisible(hazards)
}

format_hazards <- function(hazards) {
    glue::glue_data(hazards, "{emoji} {line}: {text}")
}
