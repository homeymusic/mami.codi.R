#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericVector smooth_2d_gaussian(
    const NumericVector data_x,
    const NumericVector data_y,
    const NumericVector data_val,
    const NumericVector probe_x,
    const NumericVector probe_y,
    const double sigma_x,
    const double sigma_y
) {
  const int data_N = data_x.size();
  const int probe_N = probe_x.size();
  NumericVector probe_val = NumericVector(probe_N);

  for (int i = 0; i < probe_N; i ++) {
    double weighted_sum = 0.0;
    double sum_of_weights = 0.0;
    for (int j = 0; j < data_N; j ++) {
      const double x_dist = (data_x[j] - probe_x[i]) / sigma_x;
      const double y_dist = (data_y[j] - probe_y[i]) / sigma_y;
      const double dist = sqrt(x_dist * x_dist + y_dist * y_dist);
      const double weight = R::dnorm(dist, 0.0, 1.0, false);
      weighted_sum += weight * data_val[j];
      sum_of_weights += weight;
    }
    probe_val[i] = weighted_sum / sum_of_weights;
  }

  return probe_val;
}
