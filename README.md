
<!-- README.md is generated from README.Rmd. Please edit that file -->

# HashSeq

<!-- badges: start -->

<!-- badges: end -->

The goal of HashSeq is to infer true biological 16S rRNA sequences from
the background noise.

## Installation

You can install the released version of HashSeq from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("HashSeq")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("FarnazFouladi/HashSeq")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(HashSeq)
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
#summary(cars)
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this. You could also
use GitHub Actions to re-render `README.Rmd` every time you push. An
example workflow can be found here:
<https://github.com/r-lib/actions/tree/master/examples>.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.
