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
DataFrame ratios(NumericVector x, const double pseudo_octave, const double tolerance, const double factor);
RcppExport SEXP _mami_codi_R_ratios(SEXP xSEXP, SEXP pseudo_octaveSEXP, SEXP toleranceSEXP, SEXP factorSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericVector >::type x(xSEXP);
    Rcpp::traits::input_parameter< const double >::type pseudo_octave(pseudo_octaveSEXP);
    Rcpp::traits::input_parameter< const double >::type tolerance(toleranceSEXP);
    Rcpp::traits::input_parameter< const double >::type factor(factorSEXP);
    rcpp_result_gen = Rcpp::wrap(ratios(x, pseudo_octave, tolerance, factor));
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
// listen_for_highest_fundamental
DataFrame listen_for_highest_fundamental(const NumericVector x);
RcppExport SEXP _mami_codi_R_listen_for_highest_fundamental(SEXP xSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const NumericVector >::type x(xSEXP);
    rcpp_result_gen = Rcpp::wrap(listen_for_highest_fundamental(x));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_mami_codi_R_rational_fraction", (DL_FUNC) &_mami_codi_R_rational_fraction, 2},
    {"_mami_codi_R_ratios", (DL_FUNC) &_mami_codi_R_ratios, 4},
    {"_mami_codi_R_compute_pseudo_octave", (DL_FUNC) &_mami_codi_R_compute_pseudo_octave, 3},
    {"_mami_codi_R_listen_for_highest_fundamental", (DL_FUNC) &_mami_codi_R_listen_for_highest_fundamental, 1},
    {NULL, NULL, 0}
};

RcppExport void R_init_mami_codi_R(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
