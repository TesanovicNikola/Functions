library(Rcpp)
library(microbenchmark)

#Finds the path of the config file to connect to everything
wd.cur <- tryCatch(expr = dirname(rstudioapi::getSourceEditorContext()$path),
                   error=function(e){
                     return(getwd())
                   }
)

function_file <- paste0(wd.cur,"/fast_random_numbers.cpp")

#Sourcing the Cpp function
sourceCpp(function_file)

#weights
weight_numbers <- runif(100000, min = 0, max = 1)

#Function usage
random_values_weights <- generateRandomNumbers(size = 100000, minVal = 0, 
                                               maxVal = 1, weights = weight_numbers)

random_values_no_weights <- generateRandomNumbers(size = 100000,  minVal = 0, maxVal = 1)



#Comparing different sampling functions for speed
microbenchmark(
  sample_integers = sample(1:10000, 100000, replace = TRUE),
  runif_floats = runif(100000, min = 0, max = 1),
  rnorm_normal = rnorm(100000),
  sample_replace = sample(1:100000, 100000, replace = TRUE),
  random_values_weights <- generateRandomNumbers(size = 100000, weights = weight_numbers),
  random_values_no_weights <- generateRandomNumbers(size = 100000,),
  times = 1000
)

