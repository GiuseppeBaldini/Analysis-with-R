# Notes for "Getting Started with Lattice Graphics" by Deepayan Sarkar, author of "Lattice: Multivariate Data Visualization with R"

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

# Using the quakes dataset
# Using stripplot (one-dimensional scatterplot)
# Axes renamed for clarity + Added title 

stripplot(depth ~ factor(mag), data = quakes,
          jitter.data = TRUE, alpha = 0.6,
          main = "Depth of earthquake epicenters by magnitude",
          xlab = "Magnitude (Richter)",
          ylab = "Depth (km)")

# Tabular data
# Using the VADeaths dataset (death rates in Virginia in 1941 among different population subgroups)
# To use lattice, we need to convert to data frame

VADeathsDF <- as.data.frame.table(VADeaths, responseName = "Rate")

# Using barchart
barchart(Var1 ~ Rate | Var2, VADeathsDF, layout = c(4, 1))

# To make it meaningful, we make the areas proportional to the values they represent
barchart(Var1 ~ Rate | Var2, VADeathsDF, layout = c(4, 1), origin = 0)

# Alternatively we can use a dot plot
dotplot(Var1 ~ Rate | Var2, VADeathsDF, layout = c(4, 1))

# Finally, we overlap them in a single graph to highlight differences
dotplot(Var1 ~ Rate, data = VADeathsDF, groups = Var2, type = "o",
        auto.key = list(space = "right", points = TRUE, lines = TRUE))

# Generic functions and methods
# All examples before use the "formula" method (first argument is a formula)
# An alternative for the last example would be:

dotplot(VADeaths, type = "o",
        auto.key = list(points = TRUE, lines = TRUE, space = "right"))

# We can see methods available for a specific generic X using
methods(generic.function = "X")

# Scatterplots 
# Using the Earthquake dataset (measurements recorded at various locations for 23 large
# earthquakes in western North America between 1940 and 1980)

data(Earthquake, package = "nlme")
xyplot(accel ~ distance, data = Earthquake)

# We can make it clearer plotting on logarithmic scale and adding a grid & a smooth 
xyplot(accel ~ distance, data = Earthquake, scales = list(log = TRUE),
       type = c("p", "g", "smooth"), xlab = "Distance From Epicenter (km)",
       ylab = "Maximum Horizontal Acceleration (g)")

# Shingles
# Using the quakes dataset
Depth <- equal.count(quakes$depth, number=8, overlap=.1)
summary(Depth)

# Trivariate displays
# NO interactive manipulation but viewing direction can be changes from "screen" arg
cloud(depth ~ lat * long, data = quakes,
      zlim = rev(range(quakes$depth)),
      screen = list(z = 105, x = -70), panel.aspect = 0.75,
      xlab = "Longitude", ylab = "Latitude", zlab = "Depth")

# Alternatives are wireframe() and levelplot()
?wireframe
?levelplot

# The "trellis" object
# High-level functions do not plot anything. Instead, they return an object of class "trellis"
# that needs to be print()ed or plot()ted

# Not plotting 
dp.uspe <- dotplot(t(USPersonalExpenditure), groups = FALSE, layout = c(1, 5),
          xlab = "Expenditure (billion dollars)")

dp.uspe.log <- dotplot(t(USPersonalExpenditure), groups = FALSE, layout = c(1, 5),
          scales = list(x = list(log = 2)),
          xlab = "Expenditure (billion dollars)")

# Plotting
plot(dp.uspe, split = c(1, 1, 2, 1))
plot(dp.uspe.log, split = c(2, 1, 2, 1), newpage = FALSE)

# Further resources

# Online documentation
help(lattice) 

# PDF documentation
https://cran.r-project.org/web/packages/lattice/lattice.pdf 

# Lattice: Multivariate Data Visualization with R by Deepayan Sarkar
http://lmdvr.r-forge.r-project.org