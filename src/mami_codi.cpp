#include <Rcpp.h>
#include <tuple>

using namespace Rcpp;

//' rational_fraction
 //'
 //' Stern-Brocot: find the highest fundamental freq
 //'
 //' @param r Number to convert to fraction
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
 //' @param reference Reference value
 //' @param tolerance A vector with two values for the upper and lower tolerance.
 //' @param pseudo_octave Factor for calculating stretched and compressed ratios.
 //'
 //' @return A data frame of numerators and denominators
 //'
 //' @export
 // [[Rcpp::export]]
 DataFrame ratios(NumericVector x,
                  const double reference_tone,
                  const double pseudo_octave,
                  const double tolerance) {

   int m = x.size();
   NumericVector fraction(2);

   NumericVector nums(m);
   NumericVector dens(m);
   NumericVector ratios(m);
   NumericVector pseudo_ratios(m);
   NumericVector reference_tones(m);

   for (int i = 0; i < m; ++i) {
     ratios[i]          = x[i] / reference_tone;
     pseudo_ratios[i]   = pow(2.0, log(ratios[i]) / log(pseudo_octave));
     fraction           = rational_fraction(pseudo_ratios[i],tolerance);
     nums[i]            = fraction[0];
     dens[i]            = fraction[1];
     reference_tones[i] = reference_tone;
   }

   return DataFrame::create(
     _("num")                 = nums,
     _("den")                 = dens,
     _("ratio")               = ratios,
     _("pseudo_ratio")        = pseudo_ratios,
     _("tone")                = x,
     _("reference_tone")      = reference_tone
   );
 }

 //' compute_pseudo_octave
 //'
 //' Find the highest fundamental freq
 //'
 //' @param fn freq to eval
 //' @param f0 fundamental freq
 //' @param n  harmonic number
 //'
 //' @return Calculated pseudo octave
 //'
 //' @export
 // [[Rcpp::export]]
 const double compute_pseudo_octave(const double fn, const double f0, const int n) {
   if (n==1) {
     return 1.0;
   } else {
     return std::round(1000000 * pow(2, log(fn / f0) / log(n))) / 1000000;
   }
 }

 //' listen_for_highest_fundamental
 //'
 //' Find the highest fundamental freq
 //'
 //' @param x Chord frequencies or wavelengths
 //'
 //' @return A data frame of frequencies, harmonics and pseudo_octaves
 //'
 //' @export
 // [[Rcpp::export]]
 DataFrame listen_for_highest_fundamental(const NumericVector x) {

   const int x_size   = x.size();
   const double f_max = max(x);
   NumericVector harmonic_number(x_size * x_size * x_size);
   NumericVector evaluation_freq(x_size * x_size * x_size);
   NumericVector reference_freq(x_size * x_size * x_size);
   NumericVector reference_amp(x_size * x_size * x_size);
   NumericVector pseudo_octave(x_size * x_size * x_size);
   NumericVector highest_freq(x_size * x_size * x_size);

   if (x_size <= 2) {
     throw std::range_error("find_highest_fundamental requires more than 2 frequencies");
     return R_NilValue;
   }

   int num_matches=0;

   for (int eval_freq_index = 0; eval_freq_index < x_size; ++eval_freq_index) {
     for (int ref_freq_index = 0; ref_freq_index < x_size; ++ref_freq_index) {
       for (int harmonic_num = 2; harmonic_num <= x_size; ++harmonic_num) {
         const double p_octave = compute_pseudo_octave(x[eval_freq_index], x[ref_freq_index], harmonic_num);
         if (1.89 < p_octave && p_octave < 2.11) { // TODO: check with Sethares on limits of stretching and compressing
           harmonic_number[num_matches] = harmonic_num;
           evaluation_freq[num_matches] = x[eval_freq_index];
           reference_freq[num_matches]  = x[ref_freq_index];
           highest_freq[num_matches]    = f_max;
           pseudo_octave[num_matches]   = p_octave;
           num_matches++;
         }
       }
     }
   }

   if (num_matches == 0) {
     return DataFrame::create(
       _("harmonic_number") = 1,
       _("evaluation_freq") = f_max,
       _("reference_freq")  = f_max,
       _("pseudo_octave")   = 2.0,
       _("highest_freq")    = f_max
     );
   } else {
     return DataFrame::create(
       _("harmonic_number") = harmonic_number[Rcpp::Range(0, num_matches-1)],
       _("evaluation_freq") = evaluation_freq[Rcpp::Range(0, num_matches-1)],
       _("reference_freq")  = reference_freq[Rcpp::Range(0, num_matches-1)],
       _("pseudo_octave")   = pseudo_octave[Rcpp::Range(0, num_matches-1)],
       _("highest_freq")    = highest_freq[Rcpp::Range(0, num_matches-1)]
     );
   }

 }
