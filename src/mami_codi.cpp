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
                             const NumericVector amp) {

   const double f0   = min(x);
   const double amp0 = max(amp);
   const int num_harmonics = ceil(pow(2,log(max(x)/f0)/log(2)));

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
   double amp_ceiling = amp0;
   for (int i=1; i<=num_harmonics; i++) {
     for (int j=1; j<x.size(); j++){
       if (amp[j] < amp_ceiling && (harmonics_min[i] < x[j]) && (x[j] < harmonics_max[i])) {
         freq[num_matches] = x[j];
         pseudo_octave[num_matches] = std::round(1000000 * pow(x[j]/f0,1/(log(i+1)/log(2)))) / 1000000;
         num_matches++;
       }
       amp_ceiling = amp[j];
     }
   }

   return DataFrame::create(
     _("freq") = freq[Rcpp::Range(0, num_matches-1)],
                     _("pseudo_octave") = pseudo_octave[Rcpp::Range(0, num_matches-1)]
   );
 }
