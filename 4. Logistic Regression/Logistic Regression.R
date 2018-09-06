
# Logistic distribution

?plogis
plogis(0)
exp(0) / (exp(0) + 1)  # computing logistic by hand

# By default, the two parameters defining the Logistic distribution (CDF) are set as follows
# the location parameter= 0
# the scale parameter= 1

# qlogis(p) is the same as the logit function, logit(p) = log(p/(1-p)), and 
# plogis(x) is called the inverse logit
plogis(-Inf)           # infinite dispreference = likelihood 0
plogis(2)              # moderate preference = 88% chance (e.g., of purchase)
plogis(-0.2)           # weak dispreference
log(0.5 / (1-0.5))     # indifference = 50% likelihood = 0 utility
log(0.88 / (1-0.88))   # moderate high likelihood
qlogis(0.88)           # equivalent to hand computation

# season pass data
pass.df <- read.csv("rintro-chapter9.csv")
summary(pass.df)
str(pass.df)

# Logistic regression with glm()
# GLM: Generalized Linear Model

# initial logistic regression model
# Model 1: Is Promotion related to Pass purchase? (Warning: naive model!)
with(pass.df, table(Promo,Pass))
with(pass.df, prop.table(table(Promo,Pass), margin=1))
library(lattice)
histogram(~Pass | Promo, data=pass.df)

pass.m0 <- glm(Pass ~ Promo, data=pass.df, family=binomial)
summary(pass.m0)

# By default, the levels (e.g., Bundle, NoBundle) in a categorical variable (e.g., Promo) are sorted alphabetically. That's why
# the level "Bundle" (with the initial "B") has been taken as the baseline (i.e., assign the value 0 to it) while 
# the level "NoBundle" (with the initial "N") has been submitted to the model as a dummy variable (i.e., assign the value 1 to it).
# For sure, we are interested in the regression coefficient for "Bundle" instead of "NoBundle"

Promo_Bundle<- ifelse(pass.df$Promo=="Bundle", 1, 0)

pass.m1 <- glm(Pass ~ Promo_Bundle, data=pass.df, family=binomial)
summary(pass.m1)

# how the coef translates to an odds ratio
plogis(0.3888)                          # outcome %
plogis(0.3888) / (1-plogis(0.3888))    # ratio of outcome % to alternative %
exp(0.3888)                             # identical

# regression coefficients
coef(pass.m1)
# odds ratio for sales
exp(coef(pass.m1))
# confidence intervals
exp(confint(pass.m1))

# at first it looks like the promotion is working
# but is this really the right model? check Channel

table(pass.df$Pass, pass.df$Channel)
histogram(~Pass | Channel, data=pass.df)

# Model 2: add the effect of channel

pass.m2 <- glm(Pass ~ Promo_Bundle + Channel, data=pass.df, family=binomial)
summary(pass.m2)

# updated coefs and odds ratios
exp(coef(pass.m2))
exp(confint(pass.m2))

# Reconsider Model 2
# visualization

library(vcd)    # install if needed
doubledecker(table(pass.df))

# Model 3: add the interaction of promotion and channel

pass.m3 <- glm(Pass ~ Promo_Bundle + Channel + Promo_Bundle:Channel, 
               data=pass.df, family=binomial)
summary(pass.m3)

# updated coefs and odds ratios
exp(confint(pass.m3))

# Use continuous predictors
# Example: Michelin and Zagat guides to New York City restaurants

MichelinNY <- read.csv("MichelinNY.csv", header=TRUE)
str(MichelinNY)

# We consider the 164 French restaurants included in the Zagat Survey 2006: New York City Restaurants. 
# We classify each restaurant according to whether they were included in the Michelin Guide New York City. 
# As such we define the following binary response variable:
# InMichelin = 1 if the restuarant is included in the Michelin guide
# InMichelin = 0 if the restuarant is NOT included in the Michelin guide

# We shall consider the following potential predictor variables:
# Food = customer rating of the food (out of 30)
# D??cor = customer rating of the decor (out of 30)
# Service = customer rating of the service (out of 30)
# Price = the price (in $US) of dinner (including one drink and a tip)

# Model 1: the main effect of food
MichelinNY.m1 <- glm(InMichelin~Food,family=binomial,data=MichelinNY)
summary(MichelinNY.m1)

libray("visreg")
par(mfrow=c(1,2))
visreg(MichelinNY.m1, "Food", xlab="customer rating of the food", 
       ylab="Log odds (included in the Michelin guide)")
visreg(MichelinNY.m1, "Food", scale="response", rug=2, xlab="customer rating of the food",
       ylab="P(included in the Michelin guide)")
par(mfrow=c(1,1))

# Model 2: all main effects plus the interaction effect of service and decor
MichelinNY.m2 <- glm(InMichelin~Food+Decor+Service+Price+log(Price)+Service:Decor,
                     family=binomial,data=MichelinNY)
summary(MichelinNY.m2)

library(gpairs)
gpairs(MichelinNY[,3:6])

visreg(MichelinNY.m2, "Decor", by="Service", overlay=TRUE, partial=FALSE,
       xlab="customer rating of the decor", 
       ylab="Log odds (included in the Michelin guide)")
visreg(MichelinNY.m2, "Decor", by="Service", scale="response", overlay=TRUE, partial=FALSE,
       xlab="customer rating of the decor", 
       ylab="P(included in the Michelin guide)")
