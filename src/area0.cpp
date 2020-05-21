#include <Rcpp.h>
using namespace Rcpp;


#include "area/area.h"

#include "area0.h"


// [[Rcpp::export]]
Rcpp::NumericVector area_cpp(NumericVector x, NumericVector y) {
  return area::area_x_y(x, y);

}

// [[Rcpp::export]]
Rcpp::NumericVector area_triangle_cpp(NumericVector x, NumericVector y) {
  return area::area_triangle(x, y);

}


