#include <Rcpp.h>
using namespace Rcpp;


#include "area/area0.h"

// [[Rcpp::export]]
Rcpp::NumericVector area_cpp(NumericVector x, NumericVector y) {
  return area0::area_x_y(x, y);

}

// just a hull so I can test randomly
// [[Rcpp::export]]
Rcpp::NumericVector area_dummy(double x1i, double x2i) {
  area0::donothing(x1i);
 // area0::do1(Rcpp::wrap(x1i));
  bool x1NA = NumericVector::is_na(x1i);
  bool x2NA = NumericVector::is_na(x2i);
  NumericVector out = NumericVector(1);
  if (x1NA || x2NA) {
    out[0] = NA_REAL;
    return out;
  } else {
    return Rcpp::wrap(std::min(x1i, x2i));
  }
}
