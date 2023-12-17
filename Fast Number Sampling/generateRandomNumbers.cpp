#include <Rcpp.h>
#include <vector>
#include <random>

using namespace Rcpp;

// [[Rcpp::export]]
std::vector<double> generateRandomNumbers(int size,
                                          Nullable<NumericVector> weights = R_NilValue,
                                          double minVal = 0, double maxVal = 1) {
  
  std::vector<double> result(size);
  
  if (!weights.isNull() && Rf_length(weights) > 0) {
    // If weights are provided and they are not null then:
    
    NumericVector w(weights);
    std::vector<double> weightsVec(w.begin(), w.end());
    
    std::random_device rd;
    std::mt19937 gen(rd()); // Mersenne Twister pseudo-random number generator
    std::uniform_real_distribution<> distribution(minVal, maxVal);
    
    for (int i = 0; i < size; ++i) {
      
      int randomIndex = static_cast<int>(gen() % weightsVec.size());
      result[i] = minVal + (maxVal - minVal) * weightsVec[randomIndex];
      
    }
    
  } else {
    // If no weights are provided or the weights are null then:
    
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_real_distribution<> distribution(minVal, maxVal);
    
    for (int i = 0; i < size; ++i) {
      
      result[i] = distribution(gen);
      
    }
    
  }
  
  return result;
  
}
