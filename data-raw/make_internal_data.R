## code to prepare `make_internal_data` dataset goes here

FIRE_EMOJI <- intToUtf8(0x1f525)
BELL_EMOJI <- intToUtf8(0x1f514)

hazard_material <- tibble::tribble(
    ~pattern,                           ~color,         ~emoji,
    "rm\\(ls = ls\\(\\)\\)",            crayon::red,    FIRE_EMOJI,
    "setwd\\([^\\)]+\\)",               crayon::red,    FIRE_EMOJI,
    "system(2)?\\('[^\\')]+'\\)",       crayon::yellow, BELL_EMOJI,
    "install.packages\\('[^\\')]+'\\)", crayon::yellow, BELL_EMOJI
)

usethis::use_data(FIRE_EMOJI, BELL_EMOJI, hazard_material,
                  internal = TRUE,
                  overwrite = TRUE )
