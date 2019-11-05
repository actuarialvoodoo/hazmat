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
    tibble::tibble(line = line_nums,
                   text = marked_lines[idx],
                   orig_text = lines[idx],
                   emoji = emoji)
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

#' Screen File For Hazardous R Code
#'
#' `screen_file` applies a set of defined predefined searches (regexps) to all
#' of the R code in an R or Rmd file.
#'
#' @param path a string, the path to the file to be screened.
#' @param quiet a boolean, if TRUE then console output is suppressed. Defaults
#' FALSE.
#'
#' @return `screen_file` is typically called for it's side effects of printing
#' information about hazardous material to the console. A tibble of the data
#' used to create this message is returned invisibly to enable piping.
#'
#' @export
#'
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
    if (!quiet && nrow(hazards) > 0) {
        usethis::ui_line(glue::glue("== File: {path} =="))
        output <- glue::glue_data(hazards, "{emoji} {line}: {text}")
        purrr::walk(output, usethis::ui_line)
    }

    invisible(hazards)
}

#' Screen All R Files in Folder for Hazardous Code
#'
#' `screen_folder` applies a set of defined predefined searches (regexps) to all
#' of the R code in all of the R and Rmd files contained in a folder.
#'
#' @param path a string, the path to the file to be screened.
#' @param quiet a boolean, if TRUE then console output is suppressed. Defaults
#' FALSE.
#' @param recurse a boolean, if TRUE then sub-directories of `path` are also
#' checked for R and Rmd files. Defaults to FALSE.
#'
#' @return `screen_folder` is typically called for it's side effects of printing
#' information about hazardous material to the console. A tibble of the data
#' used to create this message is returned invisibly to enable piping.
#'
#' @export
#'
screen_folder <- function(path = ".", quiet = FALSE, recurse = FALSE) {
    r_files <- fs::dir_ls(path = path,
                          recurse = recurse,
                          regexp = "(?i)\\.R(md)?$")

    result <- purrr::map_df(r_files,
                            .f = ~ screen_file(.x, quiet = quiet),
                            .id = "file_name")
    invisible(result)
}
