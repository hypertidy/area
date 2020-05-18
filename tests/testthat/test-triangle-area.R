#dput(round(triangle_area(mm_tri$P[t(mm_tri$T), ]), digits = 3))
tt <- mm_tri$P[t(mm_tri$T), ]
areas <- c(0.03, 0.069, 0.03, 0.02, 0.05, 0.1, 0.055, 0.03, 0.03, 0.03,
           0.03, 0.1455, 0.05145, 0.045, 0.1125, 0.0625, 0.068)

tri <- cbind(c(0, 1, 1, 1, 0, 0),
             c(0, 0, 1, 1, 1, 0))
test_that("triangle works", {
  expect_equivalent(triangle_area(tt), areas)

  expect_equivalent(triangle_area(tri), c(0.5, 0.5))
  expect_equivalent(triangle_area(tri, signed = FALSE), c(0.5, 0.5))
  expect_equivalent(triangle_area(tri[nrow(tri):1, ], signed = FALSE), c(0.5, 0.5))
  expect_equivalent(triangle_area(tri, signed = TRUE), c(0.5, 0.5))
})
