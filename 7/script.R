#!/bin/env Rscript

# Set the seed for the RNG
set.seed(1310)

# Generate all the numbers
n <- 18
nums_len <- 3000
nums <- sapply(1:nums_len, function(idx) {
    sum(rnorm(18, mean = 0, sd = 1)^2)
})
found_q <- quantile(nums, probs = 0.45, type = 2, names = FALSE)
expected_q <- 16.610782192541615317452678264022358815695613493397815519636198613

print(round(abs(found_q - expected_q), 4))
