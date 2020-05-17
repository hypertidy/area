## see https://github.com/hypertidy/decido/issues/17


#' Area of triangles
#'
#' Calculate triangle area from a matrix of coordinates. Triangles are composed
#' of three coordinates, so the matrix should have this as triplets of rows
#' one after the other.
#'
#' If `signed = FALSE` the absolute value of area is returned, otherwise the
#' sign reflects path orientation. Positive means counter-clockwise orientation.
#'
#' @param x coordinates x,y in triplets matrix where 'nrow(x) = ntriangles*3'
#' @param signed  defaults to `FALSE` and absolute value of area is returned,
#' if `TRUE` negative means clockwise 'p->q->r' turns right and positve means
#' counter-clockwise 'p->q->r' turns left
#' @export
#' @references see http://www.cs.tufts.edu/comp/163/OrientationTests.pdf
#' @examples
#' tri_area(mm_tri$P[t(mm_tri$T), ])
tri_area <- function(x, signed = FALSE) {
  ## offset index for shoelace formula
  reps <- rep(seq(0L, nrow(x) - 1L, by = 3L), each = 3L)
  ix <- c(2L, 3L, 1L) + reps
  jx <- c(1L, 2L, 3L) + reps
  area <- colSums(matrix(
    (x[ix, 1L, drop = TRUE] + x[jx, 1, drop = TRUE]) *
      (x[ix, 2, drop = TRUE] - x[jx, 2, drop = TRUE]),
    nrow = 3L))/2
  if (!signed) {
    area <- abs(area)
  }
  area
}
