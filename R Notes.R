# R Notes

df <- read.csv("")

# Exploration
head(df)
str(df)
summary(df)

aggregate(y1 ~ y2, data=df, mean)
by(df$y1, df$y2, mean)

names(df) <- c("c1", "c2", "c3")

# Visualize the data

# Histogram
library(ggplot2)
ggplot(housing, aes(x=ValuePerSqFt)) + geom_histogram(binwidth=10) + labs(x="Value per Square Foot")

# Histogram of subset of the data
library(lattice)
histogram(~subscribe | Segment, data=seg.df)
histogram(~subscribe | Segment, data=seg.df,
          type="count", layout=c(4,1), col=c("burlywood",
                                             "darkolivegreen"))

# Scatterplot
library(lattice)
bwplot(y1 ~ y2, data=df)

library(car)
scatterplotMatrix(formula = ~ SqFt + Units + ValuePerSqFt, data=housing, diagonal="histogram")

# Correlation
gpairs(sat.df)

library("corrplot")

# Table
table(seg.df$subscribe, seg.df$ownHome)
with(seg.df, table(subscribe, ownHome))
with(seg.df, prop.table(table(subscribe, ownHome)))
with(seg.df, prop.table(table(subscribe, ownHome),
                          margin=1))

# Chi-square test

chisq.test(table(seg.df$subscribe, seg.df$ownHome))

# t-test
t.test(y1 ~ y2, data=df)

# Linear Regression Model
df.m1<- lm(y~ SqFt+ Units+ Boro, data=housing)
summary(df.m1)
coef(df.m1)

# Visualization of Linear Regression Model
library(visreg)
library(ggplot2)
visreg(condo.m4, "Units", type="conditional", gg=TRUE)

# Diagnostic plots
par(mfrow=c(2,2))
plot(m1)

# ANOVA
seg.aov.own <- aov(income ~ ownHome, data=seg.df)
anova(seg.aov.own)

# Visualize ANOVA

install.packages("multcomp")
glht()

# Conjoint Analysis
library(conjoint)

# Orthogonal Main Effects Plans
sport.car.design.orthogonal<-caFactorialDesign(data=sport.car.experiment,type="orthogonal")
str(sport.car.design.orthogonal)
print(sport.car.design.orthogonal)
print(cor(caEncodedDesign(sport.car.design.orthogonal)))

# Export Orthogonal Main Effects Plans
write.csv(sport.car.design.orthogonal, file = "sport.car.design.orthogonal.csv", 
          row.names = FALSE)