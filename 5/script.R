#!/bin/env Rscript

# Set the seed for the RNG
set.seed(1051)


p <- 0.15
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
values <- vector()
cur_idx <- 0
while (length(values) < 1056) {
    u <- runif(1, min = 0, max = 1)

    min <- dist_fn(cur_idx - 1)
    max <- dist_fn(cur_idx)

    message("Trying ", u, " (", min, "..", max, ")")
    if (u > min && u <= max) {
        message("Successful ", u)
        values <- append(values, TRUE)
    } else {
        values <- append(values, FALSE)
    }
    cur_idx <- cur_idx + 1
}
print(cur_idx)
print(values)
