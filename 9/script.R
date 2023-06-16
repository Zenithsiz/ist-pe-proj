#!/bin/env Rscript

# Libraries
library("pracma")
library("ggplot2")

# Set the seed for the RNG
set.seed(1549)

# All the `n`s we'll be iterating over
all_n <- list(30, 50, 100, 200, 300, 500, 1000)
all_n <- sapply(all_n, function(n) n)
print(all_n)

# Calculate the samples
p <- 0.8
samples_len <- 2000
samples <- lapply(all_n, function(n) {
    lapply(1:samples_len, function(sample_idx) {
        rbinom(n, size = 1, prob = p)
    })
})

# Calculate the interval lengths for each method
confidence <- 0.98
z <- qnorm((1.0 + confidence) / 2.0)
method1_length <- function(mean, n) {
    a <- z^2 / n
    b <- a * (a + 4 * mean - 4 * mean^2)

    p_min <- (2 * mean + a - sqrt(b)) / (2 * (a + 1))
    p_max <- (2 * mean + a + sqrt(b)) / (2 * (a + 1))

    p_max - p_min
}

method2_length <- function(mean, n) {
    a <- z^2 * (mean * (1 - mean)) / n

    p_min <- -sqrt(a) + mean
    p_max <- sqrt(a) + mean

    p_max - p_min
}

lengths1 <- mapply(function(samples_n, n) {
    mean(sapply(samples_n, function(sample) {
        method1_length(mean(sample), n)
    }))
}, samples, all_n)
print(lengths1)

lengths2 <- mapply(function(samples_n, n) {
    mean(sapply(samples_n, function(sample) {
        method2_length(mean(sample), n)
    }))
}, samples, all_n)
print(lengths2)


# Finally plot and save it
df <- data.frame(
    all_n = all_n,
    lengths1 = lengths1,
    lengths2 = lengths2
)

plot <- ggplot(df, aes(x = all_n)) +
    geom_line(aes(y = lengths1, color = "Method 1")) +
    geom_line(aes(y = lengths2, color = "Method 2")) +
    xlab("N") +
    ylab("") +
    scale_color_manual(values = c("red", "blue")) +
    theme(legend.title = element_blank())

ggsave(plot = plot, "output.png")
