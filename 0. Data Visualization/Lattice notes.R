# Notes for "Getting Started with Lattice Graphics" by Deepayan Sarkar

library(lattice)

# Examples use the Chem97 dataset from the mlmRev package
# Data represents information on 1997 A-Level Chem examination
install.packages("mlmRev")

data(Chem97, package = "mlmRev")
head(Chem97)

# Histogram
histogram(~ gcsescore, data = Chem97)

# It would be interesting to compare gcsescore across subgroups
histogram(~ gcsescore | factor(score), data = Chem97)

# Superposition using kernel density estimates and additional subdivision by gender
densityplot(~ gcsescore | factor(score), Chem97, groups = gender,
       plot.points = FALSE, auto.key = TRUE)

# Trellis displays are defined by TYPE of graphic (histogram, densityplot etc.) 
# and role of variables (primary, conditioning, grouping)

# Main customizable elements in lattice:
# - the primary (panel) display
# - axis annotation
# - strip annotation (describing the conditioning process)
# - legends (typically describing the grouping process)

# Normal Q-Q Plot allow comparison between one sample and a theoretical distribution

qqmath(~ gcsescore | factor(score), Chem97, groups = gender,
       f.value = ppoints(100), auto.key = TRUE,
       type = c("p", "g"), aspect = "xy")

# Two-sample Q-Q plots allow comparison between two samples
# Therefore the function qq() requires two variables

qq(gender ~ gcsescore | factor(score), Chem97,
   f.value = ppoints(100), type = c("p", "g"), aspect = 1)

# For an arbitrary number of samples, use comparative box-and-whisker plot
bwplot(factor(score) ~ gcsescore | gender, Chem97)

# The same plot can be displayed vertically
bwplot(gcsescore ~ gender | factor(score), Chem97, layout = c(6, 1))

#

