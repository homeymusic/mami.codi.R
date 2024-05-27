// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

#ifdef RCPP_USE_GLOBAL_ROSTREAM
Rcpp::Rostream<true>&  Rcpp::Rcout = Rcpp::Rcpp_cout_get();
Rcpp::Rostream<false>& Rcpp::Rcerr = Rcpp::Rcpp_cerr_get();
#endif

// stern_brocot
NumericVector stern_brocot(const double x, const double precision);
RcppExport SEXP _mami_codi_R_stern_brocot(SEXP xSEXP, SEXP precisionSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const double >::type x(xSEXP);
    Rcpp::traits::input_parameter< const double >::type precision(precisionSEXP);
    rcpp_result_gen = Rcpp::wrap(stern_brocot(x, precision));
    return rcpp_result_gen;
END_RCPP
}
// compute_pseudo_octave
const double compute_pseudo_octave(const double fn, const double f0, const int n);
RcppExport SEXP _mami_codi_R_compute_pseudo_octave(SEXP fnSEXP, SEXP f0SEXP, SEXP nSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const double >::type fn(fnSEXP);
    Rcpp::traits::input_parameter< const double >::type f0(f0SEXP);
    Rcpp::traits::input_parameter< const int >::type n(nSEXP);
    rcpp_result_gen = Rcpp::wrap(compute_pseudo_octave(fn, f0, n));
    return rcpp_result_gen;
END_RCPP
}
// pseudo_octaves
DataFrame pseudo_octaves(const NumericVector x, const double deviation);
RcppExport SEXP _mami_codi_R_pseudo_octaves(SEXP xSEXP, SEXP deviationSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const NumericVector >::type x(xSEXP);
    Rcpp::traits::input_parameter< const double >::type deviation(deviationSEXP);
    rcpp_result_gen = Rcpp::wrap(pseudo_octaves(x, deviation));
    return rcpp_result_gen;
END_RCPP
}
// most_common_pseudo_octave
const double most_common_pseudo_octave(NumericVector pseudo_octaves);
RcppExport SEXP _mami_codi_R_most_common_pseudo_octave(SEXP pseudo_octavesSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericVector >::type pseudo_octaves(pseudo_octavesSEXP);
    rcpp_result_gen = Rcpp::wrap(most_common_pseudo_octave(pseudo_octaves));
    return rcpp_result_gen;
END_RCPP
}
// approximate_rational_fractions
DataFrame approximate_rational_fractions(NumericVector x, const double precision, const double deviation);
RcppExport SEXP _mami_codi_R_approximate_rational_fractions(SEXP xSEXP, SEXP precisionSEXP, SEXP deviationSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericVector >::type x(xSEXP);
    Rcpp::traits::input_parameter< const double >::type precision(precisionSEXP);
    Rcpp::traits::input_parameter< const double >::type deviation(deviationSEXP);
    rcpp_result_gen = Rcpp::wrap(approximate_rational_fractions(x, precision, deviation));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_mami_codi_R_stern_brocot", (DL_FUNC) &_mami_codi_R_stern_brocot, 2},
    {"_mami_codi_R_compute_pseudo_octave", (DL_FUNC) &_mami_codi_R_compute_pseudo_octave, 3},
    {"_mami_codi_R_pseudo_octaves", (DL_FUNC) &_mami_codi_R_pseudo_octaves, 2},
    {"_mami_codi_R_most_common_pseudo_octave", (DL_FUNC) &_mami_codi_R_most_common_pseudo_octave, 1},
    {"_mami_codi_R_approximate_rational_fractions", (DL_FUNC) &_mami_codi_R_approximate_rational_fractions, 3},
    {NULL, NULL, 0}
};

RcppExport void R_init_mami_codi_R(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
