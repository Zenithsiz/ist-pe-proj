#!/bin/env Rscript

# Libraries
library("readxl")
library("ggplot2")


# Read the data
df <- read_xlsx("econ.xlsx")


# Filter for years >= 1971
df <- df[df$tempo >= "1971/01/01", ]


# Create a new data frame with adjusted `ddesemp` and `tpp` columns
ddesemp_mean <- mean(df$ddesemp)
ddesemp_sd <- sd(df$ddesemp)

tpp_mean <- mean(df$tpp)
tpp_sd <- sd(df$tpp)

df_adjusted <- data.frame(
    tempo = df[, c("tempo")],
    ddesemp = lapply(df[, c("ddesemp")], function(ddesemp) {
        (ddesemp - ddesemp_mean) / ddesemp_sd
    }),
    tpp = lapply(df[, c("tpp")], function(tpp) {
        (tpp - tpp_mean) / tpp_sd
    })
)

#  Then plot them and save the output
plot <- ggplot(df_adjusted, aes(x = tempo)) +
    geom_line(aes(y = ddesemp, color = "ddesemp")) +
    geom_line(aes(y = tpp, color = "tpp")) +
    xlab("Tempo") +
    ylab("") +
    scale_color_manual(values = c("red", "blue")) +
    theme(legend.title = element_blank())

ggsave(plot = plot, "output.png")
