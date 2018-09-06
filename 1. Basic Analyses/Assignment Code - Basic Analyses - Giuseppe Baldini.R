# Set Working Directory
setwd("Users/Giuseppe/Google Drive/Uni/GMiM/Fudan University/Term 2/Marketing Analytics/Assignments/Individual/2")
seg.df <- read.csv("Data_Magazine.csv")

# Preliminary data exploration
summary(seg.df)

# Import Lattice package for visualization
library(lattice)
bwplot(Satisfy ~ Copies, data=seg.df)
# Run independent t-test on "Copies"
t.test(Satisfy ~ Copies, data=seg.df)

# Import Lattice package for visualization
library(lattice)
bwplot(Satisfy ~ Gender, data=seg.df)
# Run independent t-test on "Gender"
t.test(Satisfy ~ Gender, data=seg.df)

# ANOVA for the two variables
anova(aov(Satisfy ~ Gender + Copies, data=seg.df))
# ANOVA for the two variables + interaction
anova(aov(Satisfy ~ Gender + Copies + Gender:Copies, data=seg.df))

# Import data set
swi.df <- read.csv("Data_Switching.csv")
# Table of proportions
with(swi.df, prop.table(table(Switch_From,Switch_To), margin=1))
