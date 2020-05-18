#ifndef AREA_AREA0_H
#define AREA_AREA0_H

#include <Rcpp.h>

namespace area0 {

using namespace Rcpp;
 void donothing(double a) {

 }


NumericVector area_x_y(NumericVector x, NumericVector y) {

  int len = (int)x.length();
  double left = 0;
  double right = 0;

  for(int i = 0; i < len; i++){
    left += x[i] * y[i+1];
    right += x[i+1] * y[i];
  }
   NumericVector out = NumericVector(1);
   out[0] = 0.5 * (left - right);
   return out;
 }

} // namespace area0


#endif // AREA_AREA0_H
