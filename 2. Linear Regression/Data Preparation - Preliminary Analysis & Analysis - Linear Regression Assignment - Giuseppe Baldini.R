
# New York City condo evaluations for fiscal year 2011???2012, obtained through NYC Open Data
housing <- read.table("housing.csv", sep = ",", header = TRUE, stringsAsFactors = FALSE)

# Looking at the data, we see that we have a lot of columns and some bad names
# so we should rename those
names(housing) <- c("Neighborhood", "Class", "Units", "YearBuilt",
                    "SqFt", "Income", "IncomePerSqFt", "Expense",
                    "ExpensePerSqFt", "NetIncome", "Value",
                    "ValuePerSqFt", "Boro")
head(housing)
summary(housing)

# Visualize the data by starting with the histgram of "ValuePerSqFt"
library(ggplot2)
ggplot(housing, aes(x=ValuePerSqFt)) + geom_histogram(binwidth=10) + labs(x="Value per Square Foot")

# The bimodal nature of the histgram means there is something left to be explored
# Mapping color to "Boro" and faceting on "Boro" reveal that Brooklyn and Queens
# make up on Mode and Manhattan makes up the other, while there is not much data
# on the Bronx and Staten Island
ggplot(housing, aes(x=ValuePerSqFt, fill=Boro)) +geom_histogram(binwidth=10) + labs(x="Value per Square Foot")
ggplot(housing, aes(x=ValuePerSqFt, fill=Boro)) + geom_histogram(binwidth=10) + 
      labs(x="Value per Square Foot") + facet_wrap(~Boro)

# Next, we should look at histgram for square footage and the number of units
ggplot(housing, aes(x=SqFt)) + geom_histogram()
ggplot(housing, aes(x=Units)) + geom_histogram()

# The distributions are highly right skewed. There are quite a few buildings with
# incredible number of units. So these distributions are repeated after removing 
# buildings with more than 1,000 units
ggplot(housing[housing$Units < 1000, ], aes(x=SqFt)) + geom_histogram()
ggplot(housing[housing$Units < 1000, ], aes(x=Units)) + geom_histogram()

# Scatterplots of value versus square footage and value versus number of units,
# both with and without the buildings that have over 1,000 units
ggplot(housing, aes(x = SqFt, y = ValuePerSqFt)) + geom_point()
ggplot(housing, aes(x = Units, y = ValuePerSqFt)) + geom_point()
ggplot(housing[housing$Units < 1000, ], aes(x = SqFt, y = ValuePerSqFt)) + geom_point()
ggplot(housing[housing$Units < 1000, ], aes(x = Units, y = ValuePerSqFt)) + geom_point()

# These plots give us an idea whether we can remove these buildings from the analysis
# how many need to be removed?
sum(housing$Units >= 1000)
# remove them
housing <- housing[housing$Units < 1000, ]

# Data is ready for you to run linear regression models

# Explore correlation

library(corrplot)
corrplot.mixed(cor(housing[ , c(3,5,12)]), upper="ellipse")

# Multiple regression with 3 predictors

m1 <- lm(ValuePerSqFt ~ Units + SqFt + Boro, data=housing)
summary(m1)

# Diagnostic plots for Model 1

par(mfrow=c(2,2))
plot(m1)

# Standardizing variables

housing.std <- scale(housing[3:12])

# Checking summary statistics of standardized dataset
summary(housing.std)

# Checking interaction effects of Boro

m2 <- lm(ValuePerSqFt ~ Units + SqFt + Boro + Units:Boro, data=housing)
summary(m2)

m3 <- lm(ValuePerSqFt ~ Units + SqFt + Boro + SqFt:Boro, data=housing)
summary(m3)

# Diagnostic plots for Model 2 & 3

par(mfrow=c(2,2))
plot(m2)

par(mfrow=c(2,2))
plot(m3)

# Adding quadratic terms

m4 <- lm(ValuePerSqFt ~ I(Units^2) + Units + SqFt + Boro , data=housing)
summary(m4)

m5 <- lm(ValuePerSqFt ~ I(SqFt^2) + Units + SqFt + Boro , data=housing)
summary(m5)

# Diagnostic plots for Model 4 & 5

par(mfrow=c(2,2))
plot(m4)

par(mfrow=c(2,2))
plot(m5)

# Adding interaction term for Units and SqFt

m6 <- lm(ValuePerSqFt ~ Units + SqFt + Boro + Units:SqFt, data=housing)
summary(m6)

# Diagnostic plots for Model 6

par(mfrow=c(2,2))
plot(m6)

# Comparing models using ANOVA

anova (m1,m2,m3,m4,m5,m6)

# Visualizing regression coefficient plot

library(coefplot)
coefplot(m1, intercept=FALSE, outerCI=1.96, lwdOuter=1.5,
         ylab="Factors", 
         xlab="Association with Value per SqFt")

coefplot(m2, intercept=FALSE, outerCI=1.96, lwdOuter=1.5,
         ylab="Factors", 
         xlab="Association with Value per SqFt")

coefplot(m3, intercept=FALSE, outerCI=1.96, lwdOuter=1.5,
         ylab="Factors", 
         xlab="Association with Value per SqFt")

coefplot(m4, intercept=FALSE, outerCI=1.96, lwdOuter=1.5,
         ylab="Factors", 
         xlab="Association with Value per SqFt")

coefplot(m5, intercept=FALSE, outerCI=1.96, lwdOuter=1.5,
         ylab="Factors", 
         xlab="Association with Value per SqFt")

coefplot(m6, intercept=FALSE, outerCI=1.96, lwdOuter=1.5,
         ylab="Factors", 
         xlab="Association with Value per SqFt")
