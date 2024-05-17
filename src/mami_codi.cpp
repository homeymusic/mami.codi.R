#include <Rcpp.h>
#include <tuple>

using namespace Rcpp;

//' rational_fraction
 //'
 //' Stern-Brocot: find the highest fundamental freq
 //'
 //' @param x Number to convert to fraction
 //' @param tolerance Tolerance for converting
 //'
 //' @return A ratio of num / den
 //'
 //' @export
 // [[Rcpp::export]]
 NumericVector rational_fraction(const double x, const double tolerance) {
   double approximation;

   const double valid_min = x - tolerance;
   const double valid_max = x + tolerance;

   int left_num    = floor(x);
   int left_den    = 1;
   int mediant_num = round(x);
   int mediant_den = 1;
   int right_num   = floor(x)+1;
   int right_den   = 1;

   approximation  = std::round(mediant_num / mediant_den);

   int sanity = 0;
   while (((approximation < valid_min) || (valid_max < approximation)) && sanity < 1000) {
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

 //' ratios
 //'
 //' Creates a list of ratios as rational fractions
 //'
 //' @param x Chord values
 //' @param pseudo_octave Factor for calculating stretched and compressed ratios.
 //' @param tolerance A vector with two values for the upper and lower tolerance.
 //'
 //' @return A data frame of numerators and denominators
 //'
 //' @export
 // [[Rcpp::export]]
 DataFrame ratios(NumericVector x,
                  const double tolerance) {

   const int    m = x.size();
   const double reference_tone = min(x);

   NumericVector fraction(2);

   NumericVector index(m);
   NumericVector nums(m);
   NumericVector dens(m);
   NumericVector ratios(m);
   NumericVector reference_tones(m);

   for (int i = 0; i < m; ++i) {
     index[i]           = i+1;
     ratios[i]          = x[i] / reference_tone;
     fraction           = rational_fraction(ratios[i], tolerance);
     nums[i]            = fraction[0];
     dens[i]            = fraction[1];
     reference_tones[i] = reference_tone;
   }

   return DataFrame::create(
     _("index")               = index,
     _("num")                 = nums,
     _("den")                 = dens,
     _("ratio")               = ratios,
     _("tone")                = x,
     _("reference_tone")      = reference_tone
   );
 }
