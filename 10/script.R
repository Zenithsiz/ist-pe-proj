#!/bin/env Rscript

# Set the seed for the RNG
set.seed(1803)

expected_mean <- 48
significance <- 0.09

# Generate all samples
true_mean <- 49.2
true_var <- 4
n <- 22
m <- 100
all_samples <- lapply(1:m, function(idx) {
    rnorm(n = n, mean = true_mean, sd = sqrt(true_var))
})

# Then get their t value
samples_t <- sapply(all_samples, function(samples) {
    (mean(samples) - expected_mean) / sqrt(true_var / n)
})

# And check if they're accepted
samples_accept <- sapply(samples_t, function(t) {
    a <- significance / 2
    t > qnorm(a) && t < qnorm(1 - a)
})

# Finally average the number of accepts
accept <- mean(samples_accept)
message("Accept: ", accept)
