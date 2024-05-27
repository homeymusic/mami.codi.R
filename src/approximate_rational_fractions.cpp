#include "RcppArray.h"
#include <iostream>
#include <numeric>
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

//' approximate_rational_fractions
//'
//' Approximates floating-point numbers to arbitrary precision.
//'
//' @param x Vector of floating point numbers to approximate
//' @param precision Precision for finding rational fractions
//' @param deviation Deviation for estimating least common multiples
//'
//' @return A data frame of rational numbers and metadata
//'
//' @export
// [[Rcpp::export]]
DataFrame approximate_rational_fractions(NumericVector x,
                                         const double precision) {

  const int     n = x.size();
  NumericVector nums(n);
  NumericVector dens(n);
  NumericVector approximations(n);

  for (int i = 0; i < n; ++i) {
    const NumericVector fraction = stern_brocot(x[i], precision);
    nums[i]                      = fraction[0];
    dens[i]                      = fraction[1];
    approximations[i]            = nums[i] / dens[i];
  }

  return DataFrame::create(
    _("rational_number")        = x,
    _("num")                    = nums,
    _("den")                    = dens,
    _("approximation")          = approximations,
    _("precision")              = precision
  );
}

int gcd(int a, int b)
{
  for (;;)
  {
    if (a == 0) return b;
    b %= a;
    if (b == 0) return a;
    a %= b;
  }
}

int lcm(int a, int b)
{
  int temp = gcd(a, b);

  return temp ? (a / temp * b) : 0;
}

//' alcm
//'
//' Approximate least common multiple
//'
//' @param x Vector of integers to approximate
//' @param deviation Deviation for estimating least common multiples
//'
//' @return Approximate least common multiple
//'
//' @export
// [[Rcpp::export]]
const int alcm(const IntegerVector x,
               const double deviation) {

  const std::vector<int> x_vec = as<std::vector<int> >(x);

  return std::accumulate(x_vec.begin(), x_vec.end(), 1, lcm);

}

