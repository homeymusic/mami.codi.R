// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

#ifdef RCPP_USE_GLOBAL_ROSTREAM
Rcpp::Rostream<true>&  Rcpp::Rcout = Rcpp::Rcpp_cout_get();
Rcpp::Rostream<false>& Rcpp::Rcerr = Rcpp::Rcpp_cerr_get();
#endif

// stern_brocot
NumericVector stern_brocot(const double lower_bound, const double x, const double upper_bound);
RcppExport SEXP _mami_codi_R_stern_brocot(SEXP lower_boundSEXP, SEXP xSEXP, SEXP upper_boundSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const double >::type lower_bound(lower_boundSEXP);
    Rcpp::traits::input_parameter< const double >::type x(xSEXP);
    Rcpp::traits::input_parameter< const double >::type upper_bound(upper_boundSEXP);
    rcpp_result_gen = Rcpp::wrap(stern_brocot(lower_bound, x, upper_bound));
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
// approximate_harmonics
DataFrame approximate_harmonics(const NumericVector x, const double approximate_lcm_sd);
RcppExport SEXP _mami_codi_R_approximate_harmonics(SEXP xSEXP, SEXP approximate_lcm_sdSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const NumericVector >::type x(xSEXP);
    Rcpp::traits::input_parameter< const double >::type approximate_lcm_sd(approximate_lcm_sdSEXP);
    rcpp_result_gen = Rcpp::wrap(approximate_harmonics(x, approximate_lcm_sd));
    return rcpp_result_gen;
END_RCPP
}
// approximate_pseudo_octave
const double approximate_pseudo_octave(NumericVector approximate_harmonics);
RcppExport SEXP _mami_codi_R_approximate_pseudo_octave(SEXP approximate_harmonicsSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericVector >::type approximate_harmonics(approximate_harmonicsSEXP);
    rcpp_result_gen = Rcpp::wrap(approximate_pseudo_octave(approximate_harmonics));
    return rcpp_result_gen;
END_RCPP
}
// approximate_rational_fractions
DataFrame approximate_rational_fractions(NumericVector x, const double reference, const double sd, const double approximate_lcm_sd);
RcppExport SEXP _mami_codi_R_approximate_rational_fractions(SEXP xSEXP, SEXP referenceSEXP, SEXP sdSEXP, SEXP approximate_lcm_sdSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericVector >::type x(xSEXP);
    Rcpp::traits::input_parameter< const double >::type reference(referenceSEXP);
    Rcpp::traits::input_parameter< const double >::type sd(sdSEXP);
    Rcpp::traits::input_parameter< const double >::type approximate_lcm_sd(approximate_lcm_sdSEXP);
    rcpp_result_gen = Rcpp::wrap(approximate_rational_fractions(x, reference, sd, approximate_lcm_sd));
    return rcpp_result_gen;
END_RCPP
}
// frequency_uncertainty
const double frequency_uncertainty(const double frequency);
RcppExport SEXP _mami_codi_R_frequency_uncertainty(SEXP frequencySEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const double >::type frequency(frequencySEXP);
    rcpp_result_gen = Rcpp::wrap(frequency_uncertainty(frequency));
    return rcpp_result_gen;
END_RCPP
}
// wavelength_uncertainty
const double wavelength_uncertainty(const double wavelength, const double speed_of_sound);
RcppExport SEXP _mami_codi_R_wavelength_uncertainty(SEXP wavelengthSEXP, SEXP speed_of_soundSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const double >::type wavelength(wavelengthSEXP);
    Rcpp::traits::input_parameter< const double >::type speed_of_sound(speed_of_soundSEXP);
    rcpp_result_gen = Rcpp::wrap(wavelength_uncertainty(wavelength, speed_of_sound));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_mami_codi_R_stern_brocot", (DL_FUNC) &_mami_codi_R_stern_brocot, 3},
    {"_mami_codi_R_compute_pseudo_octave", (DL_FUNC) &_mami_codi_R_compute_pseudo_octave, 3},
    {"_mami_codi_R_approximate_harmonics", (DL_FUNC) &_mami_codi_R_approximate_harmonics, 2},
    {"_mami_codi_R_approximate_pseudo_octave", (DL_FUNC) &_mami_codi_R_approximate_pseudo_octave, 1},
    {"_mami_codi_R_approximate_rational_fractions", (DL_FUNC) &_mami_codi_R_approximate_rational_fractions, 4},
    {"_mami_codi_R_frequency_uncertainty", (DL_FUNC) &_mami_codi_R_frequency_uncertainty, 1},
    {"_mami_codi_R_wavelength_uncertainty", (DL_FUNC) &_mami_codi_R_wavelength_uncertainty, 2},
    {NULL, NULL, 0}
};

RcppExport void R_init_mami_codi_R(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
