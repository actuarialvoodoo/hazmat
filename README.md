
<!-- README.md is generated from README.Rmd. Please edit that file -->

# hazmat

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/hazmat)](https://CRAN.R-project.org/package=hazmat)
<!-- badges: end -->

The goal of hazmat is to provide a simple way for educators, and other
folks that need to run a lot of other people’s code, to have some
confidence that there aren’t any unexpected *scary* R snippets.

This package was motivated by this exchange on twitter.

<https://twitter.com/ryebreadnyc/status/1186665880098430977>

<blockquote class="twitter-tweet">

<p lang="en" dir="ltr">

what's the best way to scrub any “rm(list =ls())” from a bunch of .rmd
files in
<a href="https://twitter.com/hashtag/rstats?src=hash&amp;ref_src=twsrc%5Etfw">\#rstats</a>
? there might be only 1 but i'd like to just get rid of any an all

</p>

— Nathan Brouwer (@lobrowR)
<a href="https://twitter.com/lobrowR/status/1186661775502008320?ref_src=twsrc%5Etfw">October
22,
2019</a>

</blockquote>

<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet">

<p lang="en" dir="ltr">

Not to make you lose any sleep, but do you ever worry about students
adding something like system(‘rm -fr ~’) to their code.<br><br>Also,
seems like a useful utility to have: search all R/Rmd files for rm(ls =
ls()) and notify user of location

</p>

— Ryan Thomas (@ryebreadnyc)
<a href="https://twitter.com/ryebreadnyc/status/1186665880098430977?ref_src=twsrc%5Etfw">October
22,
2019</a>

</blockquote>

<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet">

<p lang="en" dir="ltr">

I'd never thought about running student code on my computer. I need to
put student code in a sand box otherwise bad stuff could happen - some
of them have a CS background and could really mess with me\!

</p>

— Nathan Brouwer (@lobrowR)
<a href="https://twitter.com/lobrowR/status/1186666905395838976?ref_src=twsrc%5Etfw">October
22,
2019</a>

</blockquote>

<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Installation

You can install the released version of hazmat from
[CRAN](https://CRAN.R-project.org) with:

``` r
# install.packages("devtools")
devtools::install_github("actuarialvoodoo/hazmat")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(hazmat)
## basic example code

quarantine(fs::path("path", "to", "project"))
```
