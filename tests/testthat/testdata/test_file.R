# This is a test R file
f1 <- function(x) {
    x <- 2*x
    rm(ls = ls())
}

f2 <- function(y) {
    system('pwd')
}
