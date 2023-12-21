test_that("proper sums work, agree with _r and geos", {
  xx <- as.numeric(c(x_benchmark$row, x_benchmark$row[1]))
  yy <- as.numeric(c(x_benchmark$col, x_benchmark$col[1]))

  expect_equal(polygon_area(cbind(xx, yy)),  170900015202589, tolerance = 1e-14)
})
