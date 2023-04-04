#include <cpp11.hpp>
using namespace cpp11;



#include "area/area.h"

#include "area0.h"


[[cpp11::register]]
doubles area_cpp(doubles x, doubles y) {
  return area::area_x_y(x, y);

}

[[cpp11::register]]
doubles area_triangle_cpp(doubles x, doubles y) {
  return area::area_triangle(x, y);

}


