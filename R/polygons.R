
#' Area of polygon
#'
#' Calculate polygon area from a matrix of a closed polygon. Closed means
#' that the first coordinate is the same as the last.
#'
#' Only one polygon can be input. We are using the normal definition of
#' polygon which is a plane figure described by straight line segments.
#'
#' Currently inputs are not checked but are assumed to have the last coordinate
#' as a copy of the first aka 'closed'.
#'
#' If `signed = FALSE` the absolute value of area is returned, otherwise the
#' sign reflects path orientation. Positive means counter-clockwise orientation.
#' @param x polygon in xy matrix
#' @param signed  defaults to `FALSE` and absolute value of area is returned
#' @examples
#' x <- c(2, 10, 8, 11, 7, 2)
#' y <- c(7, 1,  6, 7, 10, 7)
#' polygon_area(cbind(x, y), signed = TRUE)
#' xy <-
#'  cbind(x = c(2.3, 1.5, 2.4, 4.5, 4.6, 5.4, 7.6, 8.6, 7.4, 5.1, 2.3),
#'        y = c(-1.4, 7.3, 22.2, 22.5, 14.4, 11.8, 16.4, 5, 0.8, -1.6, -1.4))
#' polygon_area(xy)
#' ## xy is clockwise so area is negative
#' polygon_area(xy, signed = TRUE)
#' polygon_area(xy[nrow(xy):1, ], signed = TRUE)
#'
#' ## Rosetta code example
#' ## https://rosettacode.org/wiki/Shoelace_formula_for_polygonal_area
#'
#' m <- rbind(c(3,4), c(5,11), c(12,8), c(9,5), c(5,6))
#' p <- m[c(1:nrow(m), 1), ]  ## close it
#' polygon_area(p)
#' @export
#' @return numeric vector of area
polygon_area <- function(x, signed = FALSE) {
  area <- area_cpp(x[,1L, drop = TRUE],
           x[,2L, drop = TRUE])
  if (!signed) {
    area <- abs(area)
  }
  area
}

## lead shift by 1
.lead <- function(x) x[2:(length(x) + 1)]
polygon_area_r <- function(x, signed = FALSE) {
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
