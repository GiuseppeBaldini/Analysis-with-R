# A (very) short introduction of R by Paul Torfs & Claudia Brauer

# Set working directory

setwd("C:/Users/Giuseppe/Documents/GitHub/Analysis with R")

# Check the libraries or packages already installed - Opens list in a new tab

library() 

# Install a new package and load it

install.packages("package_name")
library("package_name")

# You can assign values to variables in R

original_name = 42
original_name / 2

# To remove one and all variables names from memory respectively

rm(variable_name) 
rm(list=ls())

# Data types: Scalar (0-dim), Vector (or Array, 1-dim) and Matrix (2-dim)
# To define a vector we use "c", short for "concatenate"

fib_array = c(0,1,1,2,3,5)

# Introducing fuctions (example with built-in function "mean")

mean(x=fib_array)
mean(fib_array)

# Trivial graphs

x = rnorm(100)
plot(x)

# Help and documentation

help(function_name)
example(function_name)
help.start()

help(sqrt)

# Scripts
# Run the whole script using "source" or CTRL + SHIFT + S

source("foo.R")

# Data Structures in R

# More about Vectors - Creating a Vector

vec1 = c(1,2,4,8,16)
vec2 = seq(from=0, to = 16, by=4)
vec3 = seq(0,100,10)

# Replacing a value - NOTE: array indexes start at 1

vec1[1] = 2
vec1

# Matrices 

P = seq(31,60)
Q = matrix(data=P,6,5)
Q
Q[1,4]
Q[1,3] + Q[4,2]

# Data Frames: Like a matrix, but with names

t = data.frame(x = c(11,12,14), y = c(19,20,21), z = c(10,9,7))
mean(t$z)
mean(t[["z"]])

# ToDo - Data Frames

x1 = rnorm(100)
x2 = rnorm(100)
x3 = rnorm(100)

t = data.frame(a = x1, b = x1+x2, c= x1+x2+x3)

plot(t)
sd(t)

# Lists: collections of vectors

L = list(one = 1, two = c(1,2), five = seq(0,1,length(5)))
L$one
L[1]

# Graphics

plot(rnorm(100), type = "l", col="gold")
plot(rnorm(50), type = "b", col="red")

hist(rnorm(100))

t = data.frame(x = c(11,12,14), y = c(19,20,21), z = c(10,9,7))

plot(t$a, type = "l", ylim=range(t), lwd=3, col=rgb(1,0,0,0,0.3))
lines(t$b, type="s", lwd=2, col=rgb(0.3,0.4,0.3,0.9))
points(t$c, pch=20, cex=4, col=rgb(0,0,1,0.3))

# Reading and writing data files

setwd("C:/Users/Giuseppe/Documents/GitHub/Analysis with R")

d = data.frame(a = c(3,4,5), b = c(12,43,54))
write.table(d, file='test0.txt', row.names=FALSE)
d2 = read.table(file='test0.txt', header=TRUE)

d3 = data.frame(a = c(1, 2^(1:5)), g= 2^(1:6), x=3*(2^(0:5)))
write.table(d3, file='test1.txt', row.names = F)
d4 = read.table(file='test1.txt', header=T)
d5 = data.frame(a = d4$a, g = (d4$g*5), x = d4$x)
write.table(d5, file = 'test2.txt', row.names = F)

# Dealing with missing values / NAs

j = c(1,12,42,NA)
max(j)
max(j, na.rm = T)

# Classes

#Date and Time

date1=strptime( c("20180303084332", "20180303091244"), format='%Y%m%d%H%M%S')
date1

dates=strptime( c('20180303', '20141206', '20181228'), format='%Y%m%d')
n_gifts = c(0,0,2)

plot(dates, n_gifts)

# If-statement

w = 3
if(w < 5)
{
d=2
}else{
d=10
}
d

# Subsets

a = c(1,2,3,4)
b = c(5,6,7,8)
f = a[b==5 | b==8]
# f is made of elements of a for which b==5 or b==8

# For-loop

h = seq(1,8)
s = c()
for(i in 2:10)
{
  s[i] = h[i]*10
}
s

# ToDo - For-loop

s = c()
for (i in seq(1,100))
{
  if (i < 5 | i > 90)
  {
    s[i] = i * 10
  }else{
    s[i] = i * 0.1
  }
}
s

