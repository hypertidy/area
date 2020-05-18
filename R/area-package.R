#' @keywords internal
"_PACKAGE"

# The following block is used by usethis to automatically manage
# roxygen namespace tags. Modify with care!
## usethis namespace: start
#' @useDynLib area, .registration = TRUE
#' @importFrom Rcpp sourceCpp
## usethis namespace: end
NULL

#' Planar straight line graphs and triangulations
#'
#' A minimal mesh with one hole `mm` and a map of Tasmania with multiple
#' holes in planar straight line graph format from the RTriangle package.
#'
#' `mm_tri` is a triangulated form of `mm` in RTriangle `triangulation` format.
#' The `H`OLE property is not yet set WIP.
#' @docType data
#' @aliases tas mm_tri
#' @examples
#' # library(RTriangle)
#' # plot(mm)
#' # plot(tas, pch = ".")
#' # plot(triangulate(mm, a = .002, D = TRUE), pch = ".")
"mm"
