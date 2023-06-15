#!/bin/env Rscript

# Libraries
library("readxl")
library("ggplot2")


# Read the data
df <- read_xlsx("econ.xlsx")


# Filter for years >= 1976
df <- df[df$tempo >= "1976/01/01", ]


# Create a new data frame with adjusted `ddesemp` and `pop` columns
ddesemp_mean <- mean(df$ddesemp)
ddesemp_sd <- sd(df$ddesemp)

pop_mean <- mean(df$pop)
pop_sd <- sd(df$pop)

df_adjusted <- data.frame(
    tempo = df[, c("tempo")],
    ddesemp = lapply(df[, c("ddesemp")], function(ddesemp) (ddesemp - ddesemp_mean) / ddesemp_sd),
    pop = lapply(df[, c("pop")], function(pop) (pop - pop_mean) / pop_sd)
)

#  Then plot them and save the output
plot <- ggplot(df_adjusted, aes(x = tempo)) +
    geom_line(aes(y = ddesemp, color = "ddesemp")) +
    geom_line(aes(y = pop, color = "pop")) +
    xlab("Tempo") +
    ylab("") +
    scale_color_manual(values = c("red", "blue")) +
    theme(legend.title = element_blank())

ggsave(plot = plot, "output.png")
