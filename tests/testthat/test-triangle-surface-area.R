test_that("triangle_surface_area works for 2D input", {
  # Unit right triangle: vertices (0,0), (1,0), (0,1)
  tri <- matrix(c(0, 0,
                  1, 0,
                  0, 1), ncol = 2, byrow = TRUE)
  expect_equal(triangle_surface_area(tri), 0.5)
})

test_that("triangle_surface_area works for 3D input in xy plane", {
  # Same triangle but with z = 0 explicitly

tri <- matrix(c(0, 0, 0,
                  1, 0, 0,
                  0, 1, 0), ncol = 3, byrow = TRUE)
  expect_equal(triangle_surface_area(tri), 0.5)
})

test_that("triangle_surface_area works for 3D triangle not in xy plane
", {
  # Triangle with vertices at (0,0,0), (1,0,0), (0,0,1)
  # This is a right triangle in the xz plane with legs of length 1
  tri <- matrix(c(0, 0, 0,
                  1, 0, 0,
                  0, 0, 1), ncol = 3, byrow = TRUE)
  expect_equal(triangle_surface_area(tri), 0.5)
})

test_that("triangle_surface_area handles multiple triangles", {
  # Two unit right triangles
  tris <- matrix(c(0, 0, 0,
                   1, 0, 0,
                   0, 1, 0,
                   0, 0, 0,
                   2, 0, 0,
                   0, 2, 0), ncol = 3, byrow = TRUE)
  result <- triangle_surface_area(tris)
  expect_length(result, 2)
  expect_equal(result[1], 0.5)
  expect_equal(result[2], 2.0)  
# legs of 2, area = 0.5 * 2 * 2 = 2
})

test_that("triangle_surface_area gives same result as abs(triangle_area) for 2D", {
  # Test that 2D results match the absolute value of signed area
  tri <- matrix(c(0, 0,
                  1, 0,
                  0, 1), ncol = 2, byrow = TRUE)
  expect_equal(triangle_surface_area(tri), abs(triangle_area(tri, signed = TRUE)))
})

test_that("triangle_surface_area validates input", {
  # Wrong number of columns
  expect_error(triangle_surface_area(matrix(1:4, ncol = 4)),
               "must have 2 or 3 columns")
  
  # Wrong number of rows
  expect_error(triangle_surface_area(matrix(1:8, ncol = 2)),
               "multiple of 3")
})
