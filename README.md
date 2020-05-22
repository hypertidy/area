
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

Very much work in progress.

Please, do not use this for your land surveying contract.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("hypertidy/area")
```

## Straightforward tools

The area package is written to allow easy to use calculations for
developing packages. It’s similar to the
[traipse](https://CRAN.r-project.org/) package which was created to
leverage the grouping mechanisms of the tidyverse for common tracking
data calculations.

``` r
library(area)
polygon_area(cbind(c(0, 1, 1, 0, 0), 
                c(0, 0, 1, 1, 0)))
#> [1] 1

triangle_area(cbind(c(0, 1, 1, 1, 0, 0), 
               c(0, 0, 1, 1, 1, 0)))
#> [1] 0.5 0.5
```

There’s an inbuilt data set with a path of Tasmania’s outline.

``` r
index <- 4423 ## explain later
idx <- c(tas$S[1], tas$S[1:index,2], 1)
plot(tas$P[idx, ], type = "l", asp = 1)
```

<img src="man/figures/README-tas-1.png" width="100%" />

``` r
polygon_area(tas$P[idx, ])/1e6
#> [1] 61672.74

sf::st_area(sf::st_polygon(list(tas$P[idx, ])))/1e6
#> [1] 61672.74
```

``` r
library(dplyr)
library(area)

calc_area <- function(df) {
 area <- df %>% mutate(row = row_number()) %>% 
  group_by(multipolygon_id, polygon_id, linestring_id) %>% 
   arrange(row) %>% 
  summarize(area = polygon_area(cbind(x, y))) %>% 
  ungroup() #%>% 
  area %>%  mutate(area = area, 
                   hole = c(-1, 1)[(pmax(c(1, diff(multipolygon_id)), c(1, diff(polygon_id))) == 1) + 1])
}
xsf <- silicate::inlandwaters
df <- sfheaders::sf_to_df(xsf)
(mmarea <- calc_area(df))
#> # A tibble: 189 x 5
#>    multipolygon_id polygon_id linestring_id          area  hole
#>              <dbl>      <dbl>         <dbl>         <dbl> <dbl>
#>  1               1          1             1   2203380098.     1
#>  2               2          1             1    103039733.     1
#>  3               3          1             1 750145539388.     1
#>  4               3          1             2    100909770.    -1
#>  5               3          1             3   2203380098.    -1
#>  6               3          1             4     45585186.    -1
#>  7               3          1             5     89780792.    -1
#>  8               3          1             6    110755146.    -1
#>  9               3          1             7     59287239.    -1
#> 10               3          1             8     66189369.    -1
#> # … with 179 more rows
sum(mmarea$area * mmarea$hole)
#> [1] 1.923706e+12
sum(sf::st_area(xsf))
#> 1.923706e+12 [m^2]
```

## Straightforward?

Well - ha ha - we will need some ease of use here, and some speed ups -
but we aren’t restricted to one in-memory format, we have the area of
every component part to use as we wish (the grouping tells us about
holes and multipolygons), we can tell the orientation of the polygon or
triangle and get its area, and when we have the right tools we’ll only
be using R and C++. Oh and we can calculate with triangles stored
compactly.

``` r
(a <- triangle_area(mm_tri$P[t(mm_tri$T), ]))
#>  [1] 0.03000 0.06900 0.03000 0.02000 0.05000 0.10000 0.05500 0.03000 0.03000
#> [10] 0.03000 0.03000 0.14550 0.05145 0.04500 0.11250 0.06250 0.06800
sum(a)
#> [1] 0.95895

## so we don't double count the hole
print(sum(mmarea$area[mmarea$hole > 0]))
#> [1] 1.952986e+12
```

The key motivation here is *flexibility* and working with triangles.

Performance is compelling, compare silicate::tri\_area() to this C++
version

``` r
library(silicate)
#> 
#> Attaching package: 'silicate'
#> The following objects are masked _by_ '.GlobalEnv':
#> 
#>     inlandwaters, minimal_mesh
#> The following object is masked from 'package:stats':
#> 
#>     filter
tas_tri <- RTriangle::triangulate(tas)
trxy <- tas_tri$P[t(tas_tri$T), ]
dim(trxy)
#> [1] 18291     2
rbenchmark::benchmark(R = {a <- tri_area(trxy)}, cpp = {b <- triangle_area(trxy)})
#>   test replications elapsed relative user.self sys.self user.child sys.child
#> 2  cpp          100   0.064    1.000     0.036    0.028          0         0
#> 1    R          100   0.292    4.562     0.259    0.032          0         0
sum(abs(a - b))
#> [1] 0.0004653583
mean(c(sum(a), sum(b)))
#> [1] 61672735794
```

-----

## Code of Conduct

Please note that the area project is released with a [Contributor Code
of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
