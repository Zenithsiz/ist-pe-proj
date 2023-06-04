#!/bin/env Rscript

# Libraries
library("ggplot2")


# Read the data
df <- read.csv("GENDER_EMP_190320231152556091.txt", sep = "\t")

# Filter out EMP 1 data
df <- df[df$IND == "EMP1", ]

# Filter out year
df <- df[df$Time == 2018, ]

# Filter out country
df <- df[df$Country == "United States", ]

# Filter out total ages
df <- df[df$AGE != "TOTAL", ]
df <- df[df$AGE != "1564", ]

# Rename age groups
df$AGE[df$AGE == "1524"] <- "15-24"
df$AGE[df$AGE == "2554"] <- "25-54"
df$AGE[df$AGE == "5564"] <- "55-64"

#  Then plot them and save the output
plot <- ggplot(df, aes(x = AGE, y = Value)) +
    geom_col()

ggsave(plot = plot, "output.png")
