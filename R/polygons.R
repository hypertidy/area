## lead shift by 1
.lead <- function(x) x[2:(length(x) + 1)]

#' Polygon area
#'
#' Calculate polygon area from a matrix of a closed polygon. Closed means
#' that the first coordinate is the same as the last.
#'
#' Currently inputs are not checked whether they are closed polygons or not.
#'
#' If `signed = FALSE` the absolute value of area is returned, otherwise the
#' sign reflects path orientation. Positive means clockwise orientation.
#' @param x polygon in xy matrix
#' @param signed  defaults to `FALSE` and absolute value of area is returned
#' @examples
#' x <- c(2, 10, 8, 11, 7, 2)
#' y <- c(7, 1,  6, 7, 10, 7)
#' poly_area(cbind(x, y), signed = TRUE)
#' xy <-
#'  cbind(x = c(2.3, 1.5, 2.4, 4.5, 4.6, 5.4, 7.6, 8.6, 7.4, 5.1, 2.3),
#'        y = c(-1.4, 7.3, 22.2, 22.5, 14.4, 11.8, 16.4, 5, 0.8, -1.6, -1.4))
#' poly_area(xy)
#' ## xy is clockwise so area is negative
#' poly_area(xy, signed = TRUE)
#' poly_area(xy[nrow(xy):1, ], signed = TRUE)
#' @export
poly_area <- function(x, signed = FALSE) {
  xx <- x[,1L, drop = TRUE]
  yy <- x[,2L, drop = TRUE]
  #area <- sum(.lead(xx) * yy - xx * .lead(yy), na.rm = TRUE)/2
  area <- sum(xx * .lead(yy) -
              .lead(xx) * yy, na.rm = TRUE)/2
  if (!signed) {
    area <- abs(area)
  }
  area
}

## see application https://github.com/mdsumner/gibble/issues/1

