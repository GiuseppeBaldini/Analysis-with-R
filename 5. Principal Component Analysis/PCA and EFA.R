
# Dimensional Consumer Data: Brand Ratings
# load the data
brand.ratings <- read.csv("rintro-chapter8.csv")

# check it out
head(brand.ratings)
summary(brand.ratings)
str(brand.ratings)

# pairwise correlation
library(corrplot)
corrplot(cor(brand.ratings[, 1:8]), order="hclust")

# aggregate personality attributes by brand
brand.mean <- aggregate(. ~ brand, data=brand.ratings, mean)
brand.mean

rownames(brand.mean) <- brand.mean[, 1] # use brand for the row names
brand.mean <- brand.mean[, -1]          # remove brand name column
brand.mean

# basic visualization of the raw data
# heatmap of attribute by brand
library(gplots)
library(RColorBrewer)
heatmap.2(as.matrix(brand.mean), 
          col=brewer.pal(9, "GnBu"), trace="none", key=FALSE, dend="none",
          main="\n\n\n\n\nBrand attributes")

###########################
#  PCA for brand ratings  #
###########################

install.packages("psych")
library(psych)

# Decide how many components to extract
fa.parallel(brand.ratings[, 1:8], fa="pc", n.iter=100, sim=FALSE,
            show.legend=TRUE, main="Scree plot with parallel analysis")
# Note: fa="pc", show the eigen values for principal components (pc)
# Note: For continuous data, the default is to resample as well as to generate random normal data. 
# If sim=FALSE, then just show the resampled results. These two results are very similar.

brand.prl<- fa.parallel(brand.ratings[, 1:8], fa="pc", n.iter=100, sim=FALSE,
            show.legend=TRUE, main="Scree plot with parallel analysis")
str(brand.prl)
brand.prl$pc.values
# Note: The eigen values of a principal components of the real data.

brand.prl$pc.simr
# Note: The eigen values of a principal components of the resmpled data.

# Extracting principal components: No rotation
brand.pca.1 <- principal(brand.ratings[, 1:8], nfactors=3, rotate="none")
brand.pca.1

# Extracting principal components: Varimax rotation
brand.pca.2 <- principal(brand.ratings[, 1:8], nfactors=3, rotate="varimax")
brand.pca.2
# Component 2: Competence
# Component 1: Value for money
# Component 3: Fashion

# Obtain component scores
brand.pca.2.sc <- principal(brand.ratings[, 1:8], nfactors=3, rotate="varimax", score=TRUE)
str(brand.pca.2.sc)
head(brand.pca.2.sc$scores)
cor(brand.pca.2.sc$scores[ ,1], brand.pca.2.sc$scores[ ,2])
cor(brand.pca.2.sc$scores[ ,1], brand.pca.2.sc$scores[ ,3])
cor(brand.pca.2.sc$scores[ ,2], brand.pca.2.sc$scores[ ,3])
# the three components are orthogonal, indeed 

cor(brand.pca.2.sc$scores[ ,1], brand.ratings[, 9])
# Note: correlation between component 2 (Compentence) and rebuy

cor(brand.pca.2.sc$scores[ ,2], brand.ratings[, 9])
# Note: correlation between component 1 (Value for money) and rebuy

cor(brand.pca.2.sc$scores[ ,3], brand.ratings[, 9])
# Note: correlation between component 3 (Fashion) and rebuy

brand.ratings.pc<- brand.ratings
brand.ratings.pc$Competence<- brand.pca.2.sc$scores[ ,1]
brand.ratings.pc$Value_for_Money<- brand.pca.2.sc$scores[ ,2]
brand.ratings.pc$Fashion<- brand.pca.2.sc$scores[ ,3]

summary(brand.ratings.pc)
corrplot(cor(brand.ratings.pc[, -10]))

brand.model.1 <- lm(rebuy ~ perform + leader + latest + fun + serious +
                    bargain + value + trendy, data=brand.ratings.pc)
summary(brand.model.1)

brand.model.2 <- lm(rebuy ~ Competence+ Value_for_Money+ Fashion, data=brand.ratings.pc)
summary(brand.model.2)
# Note: PCA provides a way to extract orthogonal components that are guaranteed to be 
# free of collinearity (i.e., the predictors in the regression model are highly correlated).
# Colleearity: refer to Chapter 9.1 (p. 226-31) in "R for Marketing Research and Analytics"

# Obtain principal component scoring coefficients
brand.pca.2.sc$weights

# package "FactorMineR"
library(FactoMineR)
brand.pca.3 <- PCA(brand.ratings, ncp= 3, quanti.sup = 9, quali.sup = 10)
summary(brand.pca.3)
# Note: unrotated solution 

# By default, the PCA function gives two graphs, one for the variables and 
# one for the individuals
plot(brand.pca.3, choix = "var", axes = c(1, 2), lim.cos2.var = 0)
plot(brand.pca.3, choix = "var", axes = c(2, 3), lim.cos2.var = 0)
plot(brand.pca.3, choix = "var", axes = c(1, 3), lim.cos2.var = 0)

plot(brand.pca.3, choix = "ind", axes = c(1, 2))
plot(brand.pca.3, choix = "ind", axes = c(1, 2), invisible ="ind")
plot(brand.pca.3, choix = "ind", axes = c(1, 3), invisible ="ind")
plot(brand.pca.3, choix = "ind", axes = c(2, 3), invisible ="ind")


#  EFA for brand ratings  

# To decide on the number of factors to extract
install.packages("nFactors")
library(nFactors)

# The nScree function returns an analysis of the number of components/factors to 
# retain in an exploratory principal component or factor analysis.
nScree(brand.ratings[, 1:8])
?nScree
# Components$noc	
# Number of components/factors to retain according to optimal coordinates oc
# Components$naf	
# Number of components/factors to retain according to the acceleration factor af
# Components$npar.analysis	
# Number of components/factors to retain according to parallel analysis
# Components$nkaiser	
# Number of components/factors to retain according to the Kaiser rule

eigen(cor(brand.ratings[, 1:8]))

factanal(brand.ratings[, 1:8], rotation= "varimax", factors=3)
brand.fa.vm<- factanal(brand.ratings[, 1:8], factors=3)
# Default: varimax rotation
brand.fa.vm

# More ratation options
install.packages("GPArotation")
library(GPArotation)

brand.fa.ob <- factanal(brand.ratings[, 1:8], factors=3, rotation="oblimin")
brand.fa.ob 

install.packages(c("gplots","RColorBrewer"))
library(gplots)
library(RColorBrewer)
heatmap.2(brand.fa.ob$loadings, 
          col=brewer.pal(9, "Greens"), trace="none", key=FALSE, dend="none",
          Colv=FALSE, cexCol = 1.2,
          main="\n\n\n\n\nFactor loadings for brand adjectives")

# visualize the item-factor relationships with a heatmap of $loadings
heatmap.2(brand.fa.ob.r$loadings, 
          col=brewer.pal(9, "Greens"), trace="none", key=FALSE, dend="none",
          Colv=FALSE, cexCol = 1.2,
          main="\n\n\n\n\nFactor loadings for brand adjectives: Ratings")

# plot the structure
install.packages("semPlot")
library(semPlot)
semPaths(brand.fa.ob, what="est", residuals=FALSE,
         cut=0.3, posCol=c("white", "darkgreen"), negCol=c("white", "red"),
         edge.label.cex=0.75, nCharNodes=7)

# use regression scores
brand.fa.ob.sc <- factanal(brand.ratings[, 1:8], factors=3, rotation="oblimin", 
                        scores="Bartlett")
?factanal
# scores: Type of scores to produce, if any. The default is none, "regression" gives Thompson's scores, 
#         "Bartlett" given Bartlett's weighted least-squares scores.  

brand.scores <- data.frame(brand.fa.ob.sc$scores)
brand.scores$brand <- brand.ratings$brand
head(brand.scores)

brand.fa.mean <- aggregate(. ~ brand, data=brand.scores, mean)
rownames(brand.fa.mean) <- brand.fa.mean[, 1]
brand.fa.mean <- brand.fa.mean[, -1]
names(brand.fa.mean) <- c("Leader", "Value", "Latest")
brand.fa.mean

heatmap.2(as.matrix(brand.fa.mean), 
          col=brewer.pal(9, "GnBu"), trace="none", key=FALSE, dend="none",
          cexCol=1.2, main="\n\n\n\n\n\nMean factor score by brand")

# EFA with the package "psych"
library(psych)
fa.parallel(brand.ratings[,1:8], fa="both", n.iter=100, sim=FALSE,
            main="Scree plots with parallel analysis")
# Notice you???ve requested that the function display results for both a principal-components 
# and common-factor approach, so that you can compare them (fa = "both")

fa.parallel(brand.ratings[,1:8], fa="fa", n.iter=100,sim=FALSE,
            main="Scree plots with parallel analysis")

fa.brand.1<- fa(brand.ratings[,1:8], nfactors=3, rotate="none", fm="ml")
fa.brand.1
# fm: specifies the methods of extracting common factors (minres by default).
# They include maximum likelihood (ml), iterated principal axis (pa), 
# weighted least square (wls), generalized weighted least squares (gls), 
# and minimum residual (minres). Statisticians tend to prefer the maximum likelihood 
# approach because of its well-defined statistical model. Sometimes, this approach 
# fails to converge, in which case the iterated principal axis option often works well.

fa.brand.2<- fa(brand.ratings[,1:8], nfactors=3, rotate="varimax", fm="ml")
fa.brand.2
# rotate: indicates the rotation to be applied (oblimin by default).

fa.brand.3<- fa(brand.ratings[,1:8], nfactors=3, rotate="promax", fm="ml")
fa.brand.3

fa.brand.4<- fa(brand.ratings[,1:8], nfactors=3, fm="ml")
fa.brand.4
# using an oblique rotation

# plot factor solution
factor.plot(fa.brand.3, labels=rownames(fa.brand.3$loadings))
factor.plot(fa.brand.3, labels=rownames(fa.brand.3$loadings), choose=c(1,2), ylim=c(-0.3, 1))
factor.plot(fa.brand.3, labels=rownames(fa.brand.3$loadings), choose=c(2,3), xlim=c(-0.25,1), ylim=c(-0.2, 1.1))
factor.plot(fa.brand.3, labels=rownames(fa.brand.3$loadings), choose=c(1,3), xlim=c(-0.4,1), ylim=c(-0.2, 1.1))

fa.diagram(fa.brand.3, simple=FALSE, digits=2)
#simple: Only the biggest loading per item is shown

# factor scores
fa.brand.3$weights
