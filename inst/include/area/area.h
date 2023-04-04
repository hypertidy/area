#ifndef AREA_AREA0_H
#define AREA_AREA0_H

#include <cpp11.hpp>
using namespace cpp11;

namespace area {



 // polygon area, x,y coords assumed first == last
 // -------------------------------------------------
 // http://www.cs.tufts.edu/comp/163/OrientationTests.pdf
 // https://en.wikipedia.org/wiki/Shoelace_formula
 // https://rosettacode.org/wiki/Shoelace_formula_for_polygonal_area
 doubles area_x_y(doubles x, doubles y) {

  int len = (int)x.size();
  double left = 0;
  double right = 0;

 for(int i = 0; i < (len-1); i++){
  left  += x[i] * y[i+1];
    right += x[i+1] * y[i];
  }
  writable::doubles out(1);
  out[0] = 0.5 * (left - right);
  return out;
}

// triangle area, x, y coords assumed triplets
doubles area_triangle(doubles x, doubles y) {
  int len = (int)x.size();
  int len3 = len/3;

  writable::doubles out(len3);

   //ix = 2, 3, 1
   //jx = 1, 2, 3
   int i1 = 0;
   int i2 = 1;
   int i3 = 2;

  for (int j = 0; j < len3; j++) {
        out[j] = (
        (x[i2] + x[i1]) *
        (y[i2] - y[i1]) +
        (x[i3] + x[i2]) *
        (y[i3] - y[i2]) +
        (x[i1] + x[i3]) *
        (y[i1] - y[i3]))/2;
     i1 = i1 + 3;
     i2 = i2 + 3;
     i3 = i3 + 3;

    }
 return out;
}
} // namespace area0

#endif // AREA_AREA0_H
