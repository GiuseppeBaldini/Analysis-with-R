# ggplot2 notes

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

# Example: Lines
df1 <- data.frame(a = c(2,4,6), b = c(12,24,42))
df1
ggplot(df1) +  geom_line(aes(x=a , y=b ))

df2 <- data.frame(c = c(6,7,8), d = c(22,33,44))
df2
ggplot(df1) +  geom_line(aes(x=a , y=b )) + geom_line(data=df2 , aes (x=c, y=d ))

# Histogram
df <- data.frame(data)
obj <- ggplot(df)
obj + geom_histogram(eas(HiDeg))

# Scatterplot (e.g. height and weight)
obj + geom_point(aes(x = Height, y = Weight))

# To differentiate according to a third variable (e.g. age)
obj + geom_point(aes(x = Height, y = Weight, color = Age))

# NOTE: to set color to all the points, we can do it outside aes()
obj + geom_point(aes(x = Height, y = Weight), color)

# Similarly with shapes
obj + geom_point(aes(x = Height, y = Weight, shape = Age))

# Subsets (e.g. age)
# The new operator %+% is mapped to "+.ggplot"()
obj %+% subset(df, Age > 18) + geom_point(aes(x = Height, y = Weight, color = Age))

# Introduction to ggplot2 by Babraham Bioinformatics

# Overview of common geometric objects

geom_bar()
geom_point()    
geom_line() 
geom_smooth() 
geom_histogram() 
geom_boxplot() 
geom_text() 
geom_errorbar() 
geom_hline() 
geom_vline() 

# Examples using msleep (built-in) dataset

# ggplot2 deals with data frames
msleep.df <- data.frame(msleep)

# Plotting relationship between hours slept/day and weight (ggplot object > print object)
scatterplot<-ggplot(msleep.df, aes(x=bodywt, y=sleep_total)) + geom_point()
print(scatterplot)

# Alternatively in one line
ggplot(msleep.df) + geom_point(aes(x=bodywt, y=sleep_total))

# Assign the ggplot object to a variable for future use
msleep.gg <- ggplot(msleep.df)

# Different colors according to nutrition
msleep.gg + geom_point(aes(x=bodywt, y=sleep_total, col=vore))

# Transform the variables directly in the ggplot call
msleep.gg + geom_point(aes(x=log(bodywt), y=sleep_total, col=vore))

scatterplot<-ggplot(msleep.df, aes(x=log(bodywt), y=sleep_total, col=vore)) + geom_point()
print(scatterplot)
                      
# Cosmetic changes: points size, axes names and graph title
scatterplot <- scatterplot + geom_point(size = 3)+ xlab("Log Body Weight") + 
  ylab("Total Hours Sleep")+ggtitle("Animal Sleep Data")

print(scatterplot)

# To adjust the tick marks on the x-axis
scatterplot + scale_x_continuous(breaks=-5:10)

# Changing the overall theme (e.g. white)
scatterplot + theme_set(theme_bw(base_size=18))
                                 