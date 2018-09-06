set.seed(690784)

# Step 1 - Dummy Variable Coding

hbat.dummy <- read.csv("HBAT_CONJOINT_Long.csv")

premixed <- ifelse(hbat.dummy$Product_Form=="Premixed", 1, 0)
concentrate <- ifelse(hbat.dummy$Product_Form=="Concentrate", 1, 0)
powder <- ifelse(hbat.dummy$Product_Form=="Powder", 1, 0)

applic_50 <- ifelse(hbat.dummy$Number_of_Applications=="50", 1, 0)
applic_100 <- ifelse(hbat.dummy$Number_of_Applications=="100", 1, 0)
applic_200 <- ifelse(hbat.dummy$Number_of_Applications=="200", 1, 0)

disinf_yes <- ifelse(hbat.dummy$Disinfectant_Quality=="Yes", 1, 0)
disinf_no <- ifelse(hbat.dummy$Disinfectant_Quality=="No", 1, 0)

biodeg_yes <- ifelse(hbat.dummy$Biodegradable_Form=="Yes", 1, 0)
biodeg_no <- ifelse(hbat.dummy$Biodegradable_Form=="No", 1, 0)

price_35 <- ifelse(hbat.dummy$Price_per_Application=="35 cents", 1, 0)
price_49 <- ifelse(hbat.dummy$Price_per_Application=="49 cents", 1, 0)
price_79 <- ifelse(hbat.dummy$Price_per_Application=="79 cents", 1, 0)

hbat.dummy$premixed <- premixed
hbat.dummy$concentrate <- concentrate
hbat.dummy$powder <- powder

hbat.dummy$applic_50 <- applic_50
hbat.dummy$applic_100 <- applic_100
hbat.dummy$applic_200 <- applic_200

hbat.dummy$disinf_yes <- disinf_yes
hbat.dummy$disinf_no <- disinf_no

hbat.dummy$biodeg_yes <- biodeg_yes
hbat.dummy$biodeg_no <- biodeg_no

hbat.dummy$price_35 <- price_35
hbat.dummy$price_49 <- price_49
hbat.dummy$price_79 <- price_79

head(hbat.dummy)

# Step 2 - Multiple linear regression with dummy variables

hbat.dummy.lm <- lm(Preference ~ concentrate + powder + applic_100 + applic_200 +
                    disinf_yes + biodeg_yes + price_35 + price_49,
                    data = hbat.dummy)
summary(hbat.dummy.lm)
