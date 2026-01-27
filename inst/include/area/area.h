#ifndef AREA_AREA0_H
#define AREA_AREA0_H

#include <cpp11.hpp>
#include <cmath>
using namespace cpp11;

namespace area {

// polygon area, x,y coords assumed first == last
// -------------------------------------------------
// http://www.cs.tufts.edu/comp/163/OrientationTests.pdf
// https://en.wikipedia.org/wiki/Shoelace_formula
// https://rosettacode.org/wiki/Shoelace_formula_for_polygonal_area
doubles area_x_y(doubles x, doubles y) {

  int len = (int)x.size();

  writable::doubles lefts(len-1);
  writable::doubles rights(len-1);

  double csum = 0.0;
  for(int i = 0; i < (len-1); i++){
    lefts[i] =  x[i] * y[i+1];
    rights[i] = x[i+1] * y[i];
    csum += 0.5 * (lefts[i] - rights[i]);
  }
  writable::doubles out(1);
  out[0] = csum;
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

// 3D triangle surface area, x, y, z coords assumed triplets
// Uses cross product: Area = 0.5 * ||(v1 - v0) x (v2 - v0)||
doubles area_triangle_surface(doubles x, doubles y, doubles z) {
  int len = (int)x.size();
  int len3 = len / 3;

  writable::doubles out(len3);

  int i0 = 0;
  int i1 = 1;
  int i2 = 2;

  for (int j = 0; j < len3; j++) {
    // Edge vectors from vertex 0
    double ux = x[i1] - x[i0], uy = y[i1] - y[i0], uz = z[i1] - z[i0];
    double vx = x[i2] - x[i0], vy = y[i2] - y[i0], vz = z[i2] - z[i0];

    // Cross product components
    double cx = uy * vz - uz * vy;
    double cy = uz * vx - ux * vz;
    double cz = ux * vy - uy * vx;

    // Half the magnitude
    out[j] = 0.5 * std::sqrt(cx * cx + cy * cy + cz * cz);

    i0 += 3;
    i1 += 3;
    i2 += 3;
  }
  return out;
}

} // namespace area0

#endif // AREA_AREA0_H
