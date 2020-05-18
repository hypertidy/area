// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// area_cpp
Rcpp::NumericVector area_cpp(NumericVector x, NumericVector y);
RcppExport SEXP _area_area_cpp(SEXP xSEXP, SEXP ySEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericVector >::type x(xSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type y(ySEXP);
    rcpp_result_gen = Rcpp::wrap(area_cpp(x, y));
    return rcpp_result_gen;
END_RCPP
}
// area_dummy
Rcpp::NumericVector area_dummy(double x1i, double x2i);
RcppExport SEXP _area_area_dummy(SEXP x1iSEXP, SEXP x2iSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< double >::type x1i(x1iSEXP);
    Rcpp::traits::input_parameter< double >::type x2i(x2iSEXP);
    rcpp_result_gen = Rcpp::wrap(area_dummy(x1i, x2i));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_area_area_cpp", (DL_FUNC) &_area_area_cpp, 2},
    {"_area_area_dummy", (DL_FUNC) &_area_area_dummy, 2},
    {NULL, NULL, 0}
};

RcppExport void R_init_area(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
