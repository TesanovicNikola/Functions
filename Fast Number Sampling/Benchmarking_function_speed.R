#Benchmarking the functions to the native R functions

library(Rcpp)
library(microbenchmark)

#Finds the path of the config file to connect to everything
wd.cur <- tryCatch(expr = dirname(rstudioapi::getSourceEditorContext()$path),
                   error=function(e){
                     return(getwd())
                   }
)

generateRandomNumbers <- paste0(wd.cur,"/generateRandomNumbers.cpp")
cpp_sample <- paste0(wd.cur,"/Cppsample.cpp")

#Sourcing the Cpp function
sourceCpp(generateRandomNumbers)
sourceCpp(cpp_sample)


#First, benchmarking the generateRandomNumbers function vs native R functions:
#Generating the weights:
weight_numbers <- runif(10000, min = 0, max = 1)


generateRandomNumbers_benchmark <- 
  microbenchmark(
  sample_replace_true = sample(1:10000, 10000, replace = TRUE),
  sample_replace_false = sample(1:10000, 10000, replace = FALSE, prob = weight_numbers),
  runif_floats = runif(10000, min = 0, max = 1),
  rnorm_normal = rnorm(10000),
  generateRandomNumbers_with_weights = generateRandomNumbers(size = 10000, weights = weight_numbers),
  generateRandomNumbers_no_weights = generateRandomNumbers(size = 10000,),
  times = 1000)

print(generateRandomNumbers_benchmark)



#Second, benchmarking the rcpp_sample function vs native R sample functions:
#Generating variables and the weights:
x <- 1:10000
probs <- runif(10000)  # Random probabilities for each element
size <- 10000


# Benchmark the sample function in R
rcpp_sample_benchmark <- 
  microbenchmark(
  sample_replace_true = sample(x, size, replace = TRUE, prob = probs),
  sample_replace_false = sample(x, size, replace = FALSE, prob = probs),
  rcpp_sample_with_weights = rcpp_sample(x, size = size, prob = probs),
  rcpp_sample_no_weights = rcpp_sample(x, size = size, prob = probs),
  times = 1000)


print(rcpp_sample_benchmark)
