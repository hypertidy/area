# area 0.3.0

* New `triangle_surface_area()` function for calculating triangle areas in 2D or
  3D. Accepts a matrix with 2 or 3 columns; for 2D input, z coordinates default
  to zero. This provides a general interface for triangle area calculations
  without the signed area semantics of `triangle_area()`.

# area 0.2.0

*  Improved C++ sum method to match benchmarks (from 2023 advent of code Day 18, 
 see https://github.com/hypertidy/area/issues/4). Thanks to Tan Ho, Jonathan Carroll, and Rich FitzJohn. 
 
# area 0.1.0

* Now use cpp11. 

* Added C++ versions of triangle and polygon area. 

* Begin conversion to C++ headers capability. 

# area 0.0.1

* First working version using R code only. 
