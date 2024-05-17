// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

#ifdef RCPP_USE_GLOBAL_ROSTREAM
Rcpp::Rostream<true>&  Rcpp::Rcout = Rcpp::Rcpp_cout_get();
Rcpp::Rostream<false>& Rcpp::Rcerr = Rcpp::Rcpp_cerr_get();
#endif

// rational_fraction
NumericVector rational_fraction(const double x, const double tolerance);
RcppExport SEXP _mami_codi_R_rational_fraction(SEXP xSEXP, SEXP toleranceSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const double >::type x(xSEXP);
    Rcpp::traits::input_parameter< const double >::type tolerance(toleranceSEXP);
    rcpp_result_gen = Rcpp::wrap(rational_fraction(x, tolerance));
    return rcpp_result_gen;
END_RCPP
}
// ratios
DataFrame ratios(NumericVector x, const double tolerance);
RcppExport SEXP _mami_codi_R_ratios(SEXP xSEXP, SEXP toleranceSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericVector >::type x(xSEXP);
    Rcpp::traits::input_parameter< const double >::type tolerance(toleranceSEXP);
    rcpp_result_gen = Rcpp::wrap(ratios(x, tolerance));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_mami_codi_R_rational_fraction", (DL_FUNC) &_mami_codi_R_rational_fraction, 2},
    {"_mami_codi_R_ratios", (DL_FUNC) &_mami_codi_R_ratios, 2},
    {NULL, NULL, 0}
};

RcppExport void R_init_mami_codi_R(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
