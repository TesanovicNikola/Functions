# Fast number sampling

These functions were developed to determine if there is a noteworthy performance improvement by utilizing C++ compiled code compared to the pre-existing R functions.<br>

The benchmarks can be found within the file titled **Benchmarking_function_speed.R**.

## generateRandomNumbers
The generateRandomNumbers() function generates random double variables within a specified interval, offering the option to incorporate probabilities and define the range accordingly.

The benchmark results show that the generateRandomNumbers() function is approximately ~5% quicker than the tested pre-existing R functions.

## rcpp_sample
The rcpp_sample() function provides an alternative to the base sample() function while maintaining identical functionality.<br>

The benchmark results show that when the 'replace' parameter is set to TRUE, the rcpp_sample() function performs approximately ~5% faster than the sample() function. However, its performance is notably quicker ~250% when 'replace' is set to FALSE.