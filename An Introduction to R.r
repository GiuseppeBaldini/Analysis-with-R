# An Introduction to R by W. N. Venables, D. M. Smith (S Language) and the R Core Team

# Notes of the official documentation to the R programming language

# Chapter 1: Introduction and preliminaries

# Getting help 
help(solve)
?solve
example(topic)

# Access commands from an external file
source("commands.R")

# Divert output to a certain file
sink("file_name.lis")
sink() #to stop

# Objects
# Check objects
objects()
ls()

# Chapter 2: Simple manipulations; numbers and vectors

# Vectors
<-        assingment operator
=         mostly equivalent
assign()  verbose equivalent 

x <- c(2018, 3.4, 36)
assign("x", c(2018, 3.4, 36))

# Vector arithmetic

Basic operators: + - * / ^
Additional operators: log exp sin cos tan sqrt
Range operators: max min range length(x) 

# Sorting
sort() increasing order
order() or sort.list() more flexible

# Generating regular sequences

seq(n:m)    from n to m (inclusive)
seq(n,m)    from n to m (inclusive)
from =      starting
to =        ending
by =        step size
length =    sequence lenghth 

# Logical vectors

TRUE, FALSE can be abbreviated T,F

temp <- 12 > 4     TRUE
temp <- x > 4     

Logical operators  ( < <= > >= == != )

# Character vectors

"example of a character vector"
Escape sequences use C-style, e.g.  \n, newline, \t, tab and \b, backspace

paste() #to concatenate and convert to characters
tags <- paste(c("X","Y","Z"), 1:5, sep='a') #separe arguments with 'a'

# Index vectors 
# Logical vectors

y <- x[!is.na(x)] #creates object with non-missing values of x

# Vector of positive integer quantities

y <- x[5] # 5th element of x
y <- x[1:10] # first 10 elements of x

# Vector of positive integer quantities

y <- x[-(1:5)] # to specify values to exclude

# Vector of character strings
# To assign numeric indexes to character values

fruit <- c(5, 10, 1, 20)
names(fruit) <- c("orange", "banana", "apple", "peach")
lunch <- fruit[c("apple","orange")]

# Chapter 3: Objects, their modes and attributes

# Intrinsic = Mode & Length
Modes: numeric complex logical character raw

mode(obj)
length(obj)
properties(obj)

# Attributes
attributes(obj) #for a list of non-intrinsic attributes

# Class of an object - OOP in R
unclass() #removes temporarily the effects of class with

# Chapter 4: Ordered and unordered factors

Factor = vector object used to specify a discrete classification 
(grouping) of the components of other vectors of the same length

# Example

state <- c("tas", "sa", "qld", "nsw", "nsw", "nt", "wa", "wa",
           "qld", "vic", "nsw", "vic", "qld", "qld", "sa", "tas",
           "sa", "nt", "wa", "vic", "qld", "nsw", "nsw", "wa",
           "sa", "act", "nsw", "vic", "vic", "act")

statef <- factor(state)
levels(statef) #returns the discrete classes (groups) of statef

# We can use factors to apply operations by category
# Example: mean income per state

tapply(incomes, state, mean) 
# works also if arg is not a factor since arguments are coerced to factors

# Chapter 5: Arrays and matrices

# Generate arrays specifying values and dimensions
x <- array(1:20, dim=c(4,5))

# Negative indices are NOT allowed
# NA and zero values are allowed

# The array() function
Z <- array(data_vector, dim_vector)

# Example
Z <- array(h, dim=c(3,4,2))

# If h = 24 is the same as Z <- h ; dim(Z) <- c(3,4,2)
# Else, it will recycle from the beginning of h

# Matrixes
T()     returns the matrix transpose
nrow()  returns the number of rows
ncol()  returns the number of columns

# Matrix multiplication
A * B   if A and B are square matr of same size
A %*% B is the matrix of element by element products

# Chapter 6: Lists and data frames
Object consisting of  an ordered collection of components
Not necessarily of the same mode/type
Components are always numbered

Lst <- list(name="Fred", wife="Mary", no.children=3,
            child.ages=c(4,7,9))

Lst[[1]]       # returns value of Lst at index 1
length(Lst)    # returns number of high level components
Lst$wife       # returns value associated with 'wife'

# Data Frames
data.frame()   # creates a data frame
as.data.frame()# coerces a suitable list in a data frame

# attach() and detach()
attach() allows to use variables from the data frame 
         without referencing the df
detach() reverts the above to default

# Example
df_example <- data.frame(job=carpenter, income=decent)
attach(df_example) 
job, income    #can be used directly instead of 
               # df_example$job & df_example$income

# Chapter 7: Reading data from files

read.table() # has simple but specific requirements

1. Columns should be labeled on first line
2. Rows should be labeled on first column (can be omitted)

# R has built-in datasets (Cool!) that can be used to practice
data()

# Datasets can also be loaded from other packages
data(package="rpart")
data(Puromycin, package = "datasets")