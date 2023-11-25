#include <Rcpp.h>
#include <random>

// [[Rcpp::plugins(cpp11)]]

// Function to generate random numbers using Mersenne Twister
// [[Rcpp::export]]
Rcpp::NumericVector generateRandomNumbers(int n) {
    // Initialize Mersenne Twister engine
    std::mt19937 mt(std::random_device{}());
    
    // Generate random numbers
    Rcpp::NumericVector randomNumbers(n);
    for (int i = 0; i < n; ++i) {
        randomNumbers[i] = std::generate_canonical<double, 32>(mt);
    }
    
    return randomNumbers;
}