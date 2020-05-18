
<!-- README.md is generated from README.Rmd. Please edit that file -->

# area

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![R build
status](https://github.com/hypertidy/area/workflows/R-CMD-check/badge.svg)](https://github.com/hypertidy/area/actions)
<!-- badges: end -->

The goal of area is to calculate areas, allow control over how that
happens, and illustrate how it works.

Very much work in progress. VERY BUGGY RIGHT NOW

Please, do not use this for your land surveying contract.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("hypertidy/area")
```

## Motivation

The key motivation here is *flexibility*.

Performance is compelling, compare `silicate::tri_area()` to this C++ version

```
 dim(trxy)
[1] 99615     2
rbenchmark::benchmark(tri_area(trxy), triangle_area(trxy))
                 test replications elapsed relative user.self sys.self user.child
1      tri_area(trxy)          100   1.452    5.902     1.420    0.032          0
2 triangle_area(trxy)          100   0.246    1.000     0.223    0.024          0
```
-----

## Code of Conduct

Please note that the area project is released with a [Contributor Code
of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
