#!/bin/env Rscript

# Set the seed for the RNG
# set.seed(1966)


p <- 0.4
mass_fn <- function(x) {
    if (x >= 0) {
        (1 - p)^floor(x) * p
    } else {
        0
    }
}

dist_fn <- function(x) {
    # Equal to `sum(sapply(0:x, mass_fn))`
    if (x >= 0) {
        p * (1 - p)^floor(x) - (1 - p)^floor(x) + 1
    } else {
        0
    }
}

# TODO: This doesn't seem right...
values_length <- 1090
values <- vector()
while (length(values) < values_length) {
    u <- runif(1, min = 0, max = 1)

    x <- 0
    while (TRUE) {
        min <- dist_fn(x - 1)
        max <- dist_fn(x)

        if (u > min && u <= max) {
            values <- append(values, x)
            break
        }

        x <<- x + 1
    }
}

true_mean <- (1 - p) / p
values_mean <- mean(values)
values_sd <- sd(values)


values_count <- sum(sapply(values, function(value) {
    value >= true_mean + values_sd && value >= values_mean
}))
print(values_count)
print(values_count / values_length)
