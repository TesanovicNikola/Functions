#include <Rcpp.h>
#include <random>

using namespace Rcpp;

// [[Rcpp::export]]
IntegerVector rcpp_sample(IntegerVector x, int size, NumericVector prob = NumericVector()) {
  int n = x.size();
  IntegerVector out(size);
  
  if (n == 0) {
    stop("Input vector 'x' should not be empty.");
  }
  
  if (size < 0) {
    stop("Invalid sample size. It should be a non-negative value.");
  }
  
  if (prob.size() != 0 && prob.size() != n) {
    stop("Length of 'prob' vector should match the length of 'x' or be empty.");
  }
  
  std::random_device rd;
  std::mt19937 gen(rd());
  
  try {
    if (prob.size() == 0) {
      std::uniform_int_distribution<> dis(0, n - 1);
      for (int i = 0; i < size; ++i) {
        out[i] = x.at(dis(gen)); // Using .at() to access elements with bounds checking
      }
    } else {
      std::discrete_distribution<> dis(prob.begin(), prob.end());
      for (int i = 0; i < size; ++i) {
        int j = dis(gen);
        out[i] = x.at(j % n); // Using modulo to wrap around indices for sampling with replacement
      }
    }
  } catch (const std::out_of_range& e) {
    stop("Out of range error occurred during sampling.");
  }
  
  return out;
}