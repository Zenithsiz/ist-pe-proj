#!/bin/env Rscript

# Set the seed for the RNG
set.seed(4728)

# Generate all the numbers
nums_len <- 1550
nums <- rexp(nums_len, rate = 21)

# Then generate the cumulative sum of them
# TODO: Is `max_time` even required?
nums_cumsum <- cumsum(nums)
max_time <- ceiling(nums_cumsum[nums_len])

# Calculate a list of steps to discriminate
# around unitary steps
next_step <- 1
steps <- sapply(nums_cumsum, function(x) {
    if (x < next_step) {
        FALSE
    } else {
        next_step <<- next_step + 1
        TRUE
    }
})

# Then count the occurrences within each unitary step
cur_occurrences <- 0
occurrences <- mapply(function(x, is_step) {
    if (is_step) {
        occurrences <- cur_occurrences
        cur_occurrences <<- 1
        occurrences
    } else {
        cur_occurrences <<- cur_occurrences + 1
        NA
    }
}, nums_cumsum, steps)
occurrences <- occurrences[!is.na(occurrences)]


# TODO: Calculate expected value (theoretical) and
#       compare it to the experimental value discovered here
