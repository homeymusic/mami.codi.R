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
DataFrame rational_fractions(NumericVector x, const double precision) {

  const int    m = x.size();

  NumericVector nums(m);
  NumericVector dens(m);
  NumericVector approximations(m);

  for (int i = 0; i < m; ++i) {
    const NumericVector fraction = stern_brocot(x[i], precision);
    nums[i]           = fraction[0];
    dens[i]           = fraction[1];
    approximations[i] = nums[i] / dens[i];
  }

  return DataFrame::create(
    _("rational_number") = x,
    _("num")             = nums,
    _("den")             = dens,
    _("approximation")   = approximations,
    _("precision")       = precision
  );
}
