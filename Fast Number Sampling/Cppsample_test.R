# Load the Rcpp package
library(Rcpp)
library(microbenchmark)

#Finds the path of the config file to connect to everything
wd.cur <- tryCatch(expr = dirname(rstudioapi::getSourceEditorContext()$path),
                   error=function(e){
                     return(getwd())
                   }
)


function_file <- paste0(wd.cur,"/Cppsample.cpp")
# Source the C++ code
sourceCpp(function_file)

set.seed(42)
x <- 1:10
probs <- c(0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1)  # Equal probabilities for each element

# Sample without probabilities
sample_no_probs <- rcpp_sample(x, size = 1)
print(sample_no_probs)

# Sample with probabilities
sample_with_probs <- rcpp_sample(x, size = 5, prob = probs)
print(sample_with_probs)



set.seed(42)
x <- 1:1000
probs <- runif(1000)  # Random probabilities for each element
size <- 500

# Benchmark the rcpp_sample function
benchmark_rcpp <- microbenchmark(
  rcpp_sample(x, size = size, prob = probs),
  times = 100
)

# Benchmark the sample function in R
benchmark_r_sample <- microbenchmark(
  original = sample(x, size, replace = TRUE, prob = probs),
  new = rcpp_sample(x, size = size, prob = probs),
  times = 100
)

# Print the results
print(benchmark_rcpp)
print(benchmark_r_sample)
