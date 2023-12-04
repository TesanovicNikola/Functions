#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
IntegerVector rcpp_sample(IntegerVector x, int size, NumericVector prob = NumericVector()) {
  int n = x.size();
  IntegerVector out(size);
  
  if (prob.size() == 0) {
    // Sample without probabilities
    for (int i = 0; i < size; ++i) {
      out[i] = x[rand() % n];
    }
  } else {
    // Sample with probabilities
    for (int i = 0; i < size; ++i) {
      double rand_val = (double)rand() / RAND_MAX;
      double cumulative_prob = 0.0;
      int j = 0;
      while (j < n && rand_val > cumulative_prob + prob[j]) {
        cumulative_prob += prob[j];
        ++j;
      }
      out[i] = x[j];
    }
  }
  
  return out;
}