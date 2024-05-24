#include <Rcpp.h>
#include <tuple>

using namespace Rcpp;

//' stern_brocot
//'
//' Approximates a floating-point number to arbitrary precision.
//'
//' @param x Number to convert to rational fraction
//' @param precision Binary search stops once the desired precision is reached
//'
//' @return A ratio of num / den
//'
//' @export
// [[Rcpp::export]]
NumericVector stern_brocot(const double x, const double precision) {
  double approximation;

  const double valid_min = x - precision;
  const double valid_max = x + precision;

  int left_num    = floor(x);
  int left_den    = 1;
  int mediant_num = round(x);
  int mediant_den = 1;
  int right_num   = floor(x)+1;
  int right_den   = 1;

  approximation  = std::round(mediant_num / mediant_den);

  int sanity = 0;
  const int insane = 1000;
  while (((approximation < valid_min) || (valid_max < approximation)) &&
         sanity < insane) {
    double x0  = 2*x - approximation;
    if (approximation < valid_min) {
      left_num  = mediant_num;
      left_den  = mediant_den;
      int k     = floor((right_num-x0*right_den)/(x0*left_den-left_num));
      right_num = right_num + k*left_num;
      right_den = right_den + k*left_den;
    } else if (valid_max < approximation) {
      right_num = mediant_num;
      right_den = mediant_den;
      int k     = floor((x0*left_den-left_num)/(right_num-x0*right_den));
      left_num  = left_num + k*right_num;
      left_den  = left_den + k*right_den;
    }
    mediant_num   = left_num + right_num;
    mediant_den   = left_den + right_den;
    approximation = (double) mediant_num / (double) mediant_den;
    sanity++;
  }

  return NumericVector::create(mediant_num, mediant_den);
}

//' rational_fractions
//'
//' Approximates floating-point numbers to arbitrary precision.
//'
//' @param x Vector of floating point numbers to approximate
//' @param precision Precision for approximations
//'
//' @return A data frame of rational numbers and metadata
//'
//' @export
// [[Rcpp::export]]
DataFrame rational_fractions(NumericVector x,
                             const double precision,
                             const double pseudo_octave) {

  const int     n = x.size();
  NumericVector nums(n);
  NumericVector dens(n);
  NumericVector pseudo_x(n);
  NumericVector approximations(n);

  for (int i = 0; i < n; ++i) {
    pseudo_x[i]                  = pow(2.0, log(x[i]) / log(pseudo_octave));
    const NumericVector fraction = stern_brocot(pseudo_x[i], precision);
    nums[i]                      = fraction[0];
    dens[i]                      = fraction[1];
    approximations[i]            = nums[i] / dens[i];
  }

  return DataFrame::create(
    _("rational_number")        = x,
    _("pseudo_rational_number") = pseudo_x,
    _("num")                    = nums,
    _("den")                    = dens,
    _("approximation")          = approximations,
    _("precision")              = precision
  );
}
//' pseudo_octave
//'
//' Determine pseudo octave of all frequencies relative to lowest frequency
//'
//' @param x Chord frequencies
//'
//' @return A data frame of frequencies and pseudo_octaves
//'
//' @export
// [[Rcpp::export]]
DataFrame pseudo_octaves(const NumericVector x) {

  const double f0 = min(x);
  const int num_harmonics = ceil(pow(2,log(max(x)/f0)/log(2))) + 1;

  NumericVector harmonics(num_harmonics);
  NumericVector harmonics_min(num_harmonics);
  NumericVector harmonics_max(num_harmonics);
  for (int i=0; i<num_harmonics;i++) {
    harmonics[i] = (i+1) * f0;
    harmonics_min[i] = harmonics[i] * 0.8408964;
    harmonics_max[i] = harmonics[i] * 1.189207;
  }

  NumericVector freq(num_harmonics*num_harmonics);
  NumericVector pseudo_octave(num_harmonics*num_harmonics);
  int num_matches=0;
  for (int i=0; i<num_harmonics; i++) {
    for (int j=0; j<x.size(); j++){
      if ((harmonics_min[i] < x[j]) && (x[j] < harmonics_max[i])) {
        freq[num_matches] = x[j];
        pseudo_octave[num_matches] = std::round(1000000 * pow(x[j]/f0,1/(log(i+1)/log(2)))) / 1000000;
        num_matches++;
      }
    }
  }

  return DataFrame::create(
    _("freq") = freq[Rcpp::Range(0, num_matches-1)],
    _("pseudo_octave") = pseudo_octave[Rcpp::Range(0, num_matches-1)]
  );
}
