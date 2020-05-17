## see https://github.com/hypertidy/decido/issues/17


#' Polygon area
#'
#' Calculate polygon area from a matrix of a closed polygon. Closed means
#' that the first coordinate is the same as the last.
#'
#' Currently inputs are not checked whether they are closed polygons or not.
#'
#' If `signed = FALSE` the absolute value of area is returned, otherwise the
#' sign reflects path orientation. Positive means counter-clockwise orientation.
#' @param x coordinates x,y in triplets matrix where nrow(x) = ntriangles*3
#' @param signed  defaults to `FALSE` and absolute value of area is returned
#' @export
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
