#include <Rcpp.h>
#include <tuple>

using namespace Rcpp;

NumericVector rational_fraction(const double x, const NumericVector tolerance) {
  double approximation;

  const double valid_min = x * tolerance[0];
  const double valid_max = x * tolerance[1];

  int left_num    = floor(x);
  int left_den    = 1;
  int mediant_num = round(x);
  int mediant_den = 1;
  int right_num   = floor(x)+1;
  int right_den   = 1;

  approximation  = mediant_num / mediant_den;

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
//' @param ref_harmonic_number The harmonic number of the reference
//'
//' @return A data frame of numerators and denominators
//'
//' @export
// [[Rcpp::export]]
DataFrame ratios(NumericVector x,
                 const double reference,
                 const NumericVector tolerance,
                 const double pseudo_octave,
                 const double ref_harmonic_number) {

  x = unique(x);

  int m = x.size();
  NumericVector nums(m);
  NumericVector dens(m);
  NumericVector pitch(m);
  NumericVector ratios(m);
  NumericVector pseudo_ratios(m);
  NumericVector fraction(2);

  for (int i = 0; i < m; ++i) {
    double ratio = x[i] / reference;
    if (ratio != 1) {
      ratio = ratio / (ref_harmonic_number + 1);
    }
    const double pseudo_ratio = pow(2.0, log(ratio) / log(pseudo_octave));
    fraction = rational_fraction(pseudo_ratio,tolerance);
    nums[i]          = fraction[0];
    dens[i]          = fraction[1];
    ratios[i]        = ratio;
    pseudo_ratios[i] = pseudo_ratio;
    pitch[i]         = x[i];
  }

  return DataFrame::create(
    _("num")          = nums,
    _("den")          = dens,
    _("ratio")        = ratios,
    _("pseudo_ratio") = pseudo_ratios,
    _("pitch")        = pitch,
    _("reference")    = reference
  );
}

//' analyze_harmonics
 //'
 //' Determine pseudo octave of all frequencies relative to lowest frequency
 //'
 //' @param x Chord frequencies
 //' @param amp Chord frequencies
 //'
 //'
 //' @return A data frame of frequencies and pseudo_octaves
 //'
 //' @export
 // [[Rcpp::export]]
 DataFrame analyze_harmonics(const NumericVector x,
                             const NumericVector y) {
   const int x_size = x.size();

   const double f0 = min(x);
   const int num_harmonics = ceil(pow(2,log(max(x)/f0)/log(2))) + 1;

   NumericVector freq(x_size*num_harmonics*num_harmonics);
   NumericVector amp(x_size*num_harmonics*num_harmonics);
   NumericVector harmonic_number(x_size*num_harmonics*num_harmonics);
   NumericVector ref_freq(x_size*num_harmonics*num_harmonics);
   NumericVector pseudo_octave(x_size*num_harmonics*num_harmonics);

   int num_matches=0;

   for (int k = 0; k < x_size; ++k) {
     double ref = x[k];

     NumericVector harmonics(num_harmonics);
     NumericVector harmonics_min(num_harmonics);
     NumericVector harmonics_max(num_harmonics);

     for (int i=0; i<num_harmonics-k;i++) {
       harmonics[i] = (i+1) * ref;
       harmonics_min[i] = harmonics[i] * 0.8408964;
       harmonics_max[i] = harmonics[i] * 1.189207;
     }

     for (int i=0; i<num_harmonics-k; i++) {
       for (int j=k; j<x_size; j++){
         if ((harmonics_min[i] < x[j]) && (x[j] < harmonics_max[i])) {
           harmonic_number[num_matches] = i;
           ref_freq[num_matches] = ref;
           freq[num_matches] = x[j];
           amp[num_matches] = y[j];
           pseudo_octave[num_matches] = std::round(1000000 * pow(x[j]/ref,1/(log(i+1)/log(2)))) / 1000000;
           num_matches++;
         }
       }
     }
   }

   return DataFrame::create(
     _("freq")            = freq[Rcpp::Range(0, num_matches-1)],
     _("amp")             = amp[Rcpp::Range(0, num_matches-1)],
     _("harmonic_number") = harmonic_number[Rcpp::Range(0, num_matches-1)],
     _("ref_freq")        = ref_freq[Rcpp::Range(0, num_matches-1)],
     _("pseudo_octave")   = pseudo_octave[Rcpp::Range(0, num_matches-1)]
   );

 }

//' find_highest_fundamental
 //'
 //' Determine pseudo octave of all frequencies relative to lowest frequency
 //'
 //' @param x Chord frequencies
 //'
 //' @return A data frame of frequencies and pseudo_octaves
 //'
 //' @export
 // [[Rcpp::export]]
 DataFrame find_highest_fundamental(const NumericVector x) {

   const double f_max = max(x);
   const int x_size   = x.size();

   NumericVector harmonic_number(x_size * x_size);
   NumericVector reference_freq(x_size * x_size);
   NumericVector pseudo_octave(x_size * x_size);
   NumericVector highest_freq(x_size * x_size);

   int num_matches=0;

   //  2D loop
   //  for fixed highest freq
   //  loop through every possible harmonic number from 1 to i_max
   //  loop through every frequency other than highest freq
   //  look for the ones that five pseudo octave ~= 2.0

   for (int freq_index = 0; freq_index < x_size; ++freq_index) {
     for (int harmonic_num = 0; harmonic_num < x_size; ++harmonic_num) {
       harmonic_number[num_matches] = harmonic_num;
       reference_freq[num_matches]  = x[freq_index];
       highest_freq[num_matches]    = f_max;
       pseudo_octave[num_matches]   = std::round(1000000 * pow(f_max/reference_freq[num_matches],1/(log(harmonic_num+1)/log(2)))) / 1000000;;
       num_matches++;
     }
   }

   return DataFrame::create(
     _("harmonic_number") = harmonic_number[Rcpp::Range(0, num_matches-1)],
     _("reference_freq")  = reference_freq[Rcpp::Range(0, num_matches-1)],
     _("pseudo_octave")   = pseudo_octave[Rcpp::Range(0, num_matches-1)],
     _("highest_freq")    = highest_freq[Rcpp::Range(0, num_matches-1)]
   );
 }
