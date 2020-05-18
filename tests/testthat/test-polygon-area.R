context("polygon")

m <- rbind(c(3,4), c(5,11), c(12,8), c(9,5), c(5,6))
p <- m[c(1:nrow(m), 1), ]  ## close it

# print(polygon_area(p))
# print(polygon_area(p, signed = TRUE))

test_that("polygon works", {
  expect_equivalent(polygon_area(p), 30)
  expect_equivalent(polygon_area(p, signed = TRUE), -30)
})
