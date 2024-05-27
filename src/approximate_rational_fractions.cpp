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
     const int r = 1000000;
     return std::round(r * pow(2, log(fn / f0) / log(n))) / r;
   }
 }

//' approximate_harmonics
//'
//' Determine pseudo octave of all frequencies relative to lowest frequency
//'
//' @param x Chord frequencies
//' @param deviation Deviation for estimating least common multiples
//'
//' @return A double of the best guess of the pseudo octave
//'
//' @export
// [[Rcpp::export]]
DataFrame approximate_harmonics(const NumericVector x,
                         const double deviation) {
  const int x_size   = x.size();
  const double f_max = max(x);
  NumericVector harmonic_number(x_size * x_size * x_size);
  NumericVector evaluation_freq(x_size * x_size * x_size);
  NumericVector reference_freq(x_size * x_size * x_size);
  NumericVector reference_amp(x_size * x_size * x_size);
  NumericVector pseudo_octave(x_size * x_size * x_size);
  NumericVector highest_freq(x_size * x_size * x_size);


  const DataFrame default_pseudo_octave = DataFrame::create(
    _("harmonic_number") = 1,
    _("evaluation_freq") = f_max,
    _("reference_freq")  = f_max,
    _("pseudo_octave")   = 2.0,
    _("highest_freq")    = f_max
  );

  if (x_size <= 2) {
    return default_pseudo_octave;
  }

  int num_matches=0;

  for (int eval_freq_index = 0; eval_freq_index < x_size; ++eval_freq_index) {
    for (int ref_freq_index = 0; ref_freq_index < x_size; ++ref_freq_index) {
      for (int harmonic_num = 2; harmonic_num <= x_size; ++harmonic_num) {
        const double p_octave = compute_pseudo_octave(x[eval_freq_index], x[ref_freq_index], harmonic_num);
        if (2.0 - deviation < p_octave && p_octave < 2.0 + deviation) {
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
    return default_pseudo_octave;
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

//' pseudo_octave
//'
//' Finds the pseudo octave from approximate harmonics.
//'
//' @param approximate_harmonics List of candidate pseudo octaves
//'
//' @return A data frame of rational numbers and metadata
//'
//' @export
// [[Rcpp::export]]
const double pseudo_octave(NumericVector approximate_harmonics) {
   const IntegerVector counts = table(approximate_harmonics);
    IntegerVector idx = seq_along(counts) - 1;
    std::sort(idx.begin(), idx.end(), [&](int i, int j){return counts[i] > counts[j];});
    CharacterVector names_of_count = counts.names();
    names_of_count = names_of_count[idx];
    return std::stod(std::string(names_of_count[0]));
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
                                         const double precision,
                                         const double deviation) {

  const int     n = x.size();
  NumericVector nums(n);
  NumericVector dens(n);
  NumericVector pseudo_x(n);
  NumericVector approximations(n);

  const DataFrame approximate_harmonics_df = approximate_harmonics(x, deviation);
  const double pseudo_octave_double = pseudo_octave(approximate_harmonics_df["pseudo_octave"]);

  for (int i = 0; i < n; ++i) {
    pseudo_x[i]                  = pow(2.0, log(x[i]) / log(pseudo_octave_double));
    const NumericVector fraction = stern_brocot(pseudo_x[i], precision);
    nums[i]                      = fraction[0];
    dens[i]                      = fraction[1];
    approximations[i]            = nums[i] / dens[i];
  }

  return DataFrame::create(
    _("rational_number")        = x,
    _("pseudo_rational_number") = pseudo_x,
    _("pseudo_octave")          = pseudo_octave_double,
    _("num")                    = nums,
    _("den")                    = dens,
    _("approximation")          = approximations,
    _("precision")              = precision
  );
}
