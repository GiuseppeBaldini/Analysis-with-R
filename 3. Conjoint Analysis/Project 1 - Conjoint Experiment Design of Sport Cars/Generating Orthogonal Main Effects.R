set.seed(690784)

# Generating orthogonal main effects

# Step 1 - Stimulus set construction

library(conjoint)
sport.cars.ca = expand.grid(
  price = c("23,000", "25,000", "27,000", "29,000"),
  brand = c("Toyota", "Volkswagen", "Saturn", "Kia"),
  horsepower = c("220HP", "250HP", "280HP"),
  upholstery = c("Cloth", "Leather"),
  sunroof = c("Yes", "No"))

# Step 2 - Orthogonal Main Effects

sport.cars.orthogonal<-caFactorialDesign(data=sport.cars.ca,type="orthogonal")

# Step 3 - Check product profiles, encoded design and correlation

str(sport.cars.orthogonal)
print(sport.cars.orthogonal)
print(caEncodedDesign(sport.cars.orthogonal))
print(cor(caEncodedDesign(sport.cars.orthogonal)))

# Step 4 - Export the designs in .csv format

write.csv2(sport.cars.orthogonal, file = "Orthogonal Main Effects Plans.csv", row.names = TRUE)
