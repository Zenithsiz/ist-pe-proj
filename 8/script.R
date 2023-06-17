#!/bin/env Rscript

# Libraries
library("pracma")
library("ggplot2")

# Set the seed for the RNG
set.seed(2009)

cauchy_location <- 1
cauchy_scale <- 1.8
cauchy_gen <- rcauchy(n = 107, location = cauchy_location, scale = cauchy_scale)
cauchy_gen <- sort(cauchy_gen)

quantile_idxs <- 1:107 / (107 + 1)

cauchy_quantiles <- sapply(quantile_idxs, function(p) {
    qcauchy(p, location = cauchy_location, scale = cauchy_scale)
})

norm_mean <- -2.8
norm_var <- 1.4
norm_quantiles <- sapply(quantile_idxs, function(p) {
    qnorm(p, mean = norm_mean, sd = sqrt(norm_var))
})

df <- data.frame(
    quantile_idxs = quantile_idxs,
    cauchy_gen = cauchy_gen,
    cauchy_quantiles = cauchy_quantiles,
    norm_quantiles = norm_quantiles
)

#  Then plot them and save the output
plot <- ggplot(df, aes(x = quantile_idxs)) +
    geom_line(aes(y = cauchy_gen, color = "Generated")) +
    geom_line(aes(y = cauchy_quantiles, color = "Cauchy Quantiles")) +
    geom_line(aes(y = norm_quantiles, color = "Normal Quantiles")) +
    geom_line(aes(y = quantile_idxs, color = "Line bisector of odd quadrants")) +
    xlab("Quantiles") +
    ylab("") +
    scale_color_manual(values = c("red", "blue", "black", "green")) +
    theme(legend.title = element_blank())

ggsave(plot = plot, "output.png")
