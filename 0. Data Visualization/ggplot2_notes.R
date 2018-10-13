# ggplot2 notes
# Introduction to ggplot2 by N. Matloff

# R implementation of "The Grammar of Graphics" by Leland Wilkison
library(ggplot2)

# Call ggplot to data frame
p <- ggplot(df)

# + adds new layers to the graph
+.ggplot(df2)

# Map data variables to graph attributes
# Can be done for the entire graph or for a specific action 
aes()

# Objects that can be used as second operand for "+" operator
# - geoms: Geometric objects 
# - position adjustments
# - facets: Specifications to draw graphs together
# - themes

# Example 1: Lines
df1 <- data.frame(a = c(2,4,6), b = c(12,24,42))
df1
ggplot(df1) +  geom_line(aes(x=a , y=b ))

df2 <- data.frame(c = c(6,7,8), d = c(22,33,44))
df2
ggplot(df1) +  geom_line(aes(x=a , y=b )) + geom_line(data=df2 , aes (x=c, y=d ))
