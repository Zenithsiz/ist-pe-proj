#!/bin/env Rscript

# Set the seed for the RNG
set.seed(4728)

# Generate all the numbers
nums_len <- 1550
expected_mean <- 1.0 / 21.0
nums <- rexp(nums_len, rate = expected_mean)

# Then generate the cumulative sum of them
# TODO: Is `max_time` even required?
nums_cumsum <- cumsum(nums)
max_time <- ceiling(nums_cumsum[nums_len])

print(abs(nums_len / max_time - 1 / 21))
