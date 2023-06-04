#!/bin/env Rscript

# Libraries
library("ggplot2")


# Read the data
df <- read.csv("TIME_USE_24092022.csv")

# Remove south africa records
df <- df[df$País != "África do Sul", ]

# Filter out male records
df <- df[df$Sexo == "Homens", ]

# Then filter our the occupations
df <- df[df$Ocupação %in% c("Cuidados pessoais", "Trabalho remunerado ou estudo"), ]

#  Then plot them and save the output
plot <- ggplot(df, aes(x = Ocupação, y = Tempo)) +
    geom_boxplot()

ggsave(plot = plot, "output.png")
