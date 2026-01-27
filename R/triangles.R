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
#' The algorithm was once documented at 'w w w cs.tufts.edu/comp/163/OrientationTests.pdf'
#' @param x coordinates x,y triplets matrix where 'nrow(x) = ntriangles*3'
#' @param signed  defaults to `FALSE` and absolute value of area is returned,
#' if `TRUE` negative means clockwise 'p->q->r' turns right and positive means
#' counter-clockwise 'p->q->r' turns left
#' @export
#' @returns numeric vector of area
#' @examples
#' sum(triangle_area(mm_tri$P[t(mm_tri$T), ]))
#'
triangle_area <- function(x, signed = FALSE) {
  area <- area_triangle_cpp(x[,1L, drop = TRUE],
                    x[,2L, drop = TRUE])
  if (!signed) {
    area <- abs(area)
  }
  area
}



triangle_area_r <- function(x, signed = FALSE) {
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


#' Calculate surface area of triangles in 2D or 3D
#'
#' Compute the unsigned surface area of triangles defined by vertex coordinates.
#' Works with both 2D (xy) and 3D (xyz) input. For 2D input, z coordinates are
#' assumed to be zero.
#'
#' @param x A matrix with 2 or 3 columns (x, y) or (x, y, z). Each set of 3
#'   consecutive rows defines one triangle.
#'
#' @return A numeric vector of surface areas, one per triangle.
#'
#' @details
#' The area is calculated using the cross product method:
#' `Area = 0.5 * ||(v1 - v0) x (v2 - v0)||`
#'
#' For 2D input, this reduces to the absolute value of the shoelace formula.
#'
#' @examples
#' # 2D triangle (unit right triangle)
#' tri_2d <- matrix(c(0, 0,
#'                    1, 0,
#'                    0, 1), ncol = 2, byrow = TRUE)
#' triangle_surface_area(tri_2d)  # 0.5
#'
#' # 3D triangle
#' tri_3d <- matrix(c(0, 0, 0,
#'                    1, 0, 0,
#'                    0, 1, 1), ncol = 3, byrow = TRUE)
#' triangle_surface_area(tri_3d)
#'
#' @export
triangle_surface_area <- function(x) {
  if (!is.matrix(x)) {
    x <- as.matrix(x)
  }

  nc <- ncol(x)
  if (nc == 2) {
    # Add z = 0 for 2D input
    x <- cbind(x, 0)
  } else if (nc != 3) {
    stop("'x' must have 2 or 3 columns")
  }

  if (nrow(x) %% 3 != 0) {
    stop("Number of rows must be a multiple of 3 (triplets of vertices)")
  }

  area_triangle_surface_cpp(x[, 1], x[, 2], x[, 3])
}

