library(Rcpp)
# Make sure your working directory is where the .cpp file is located
sourceCpp(file.choose())

random_values <- generateRandomNumbers(1000)

library(microbenchmark)

# Comparison of sampling methods
microbenchmark(
  sample_integers = sample(1:100, 1000, replace = TRUE),
  runif_floats = runif(1000, min = 0, max = 1),
  rnorm_normal = rnorm(1000),
  sample_replace = sample(1:1000, 1000, replace = TRUE),
  random_values = generateRandomNumbers(1000),
  times = 1000
)