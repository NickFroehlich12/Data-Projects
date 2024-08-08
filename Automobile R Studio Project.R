getwd()
setwd("/Users/nickf/OneDrive/R Studio Projects")
getwd()

Auto <- read.csv("/Users/nickf/OneDrive/R Studio Projects/Auto-1.csv", stringsAsFactors = TRUE)
View(Auto)

library(psych)
library(corrplot)
library(ggplot2)
library(readr)
Auto <- read_csv("/Users/nickf/OneDrive/R Studio Projects/Auto-1.csv")

Auto$`Weight (lbs)`<- as.numeric(as.character(Auto$`Weight (lbs)`))

colnames(Auto)
colnames(Auto) <- c('Name', 'Drive', 'MPG', 'Fuel', 'FuelCap', 'LengthInches', 'WheelBaseInches',
                    'WidthInches', 'TurningRadiusFeet', 'WeightLBS', 'DoorTopInches', 'LuggageCuFt',
                    'FrontShoulderInches', 'FrontLegRoomInches', 'FrontHeadRoomInches',
                    'RearShoulderInches', 'RearLegRoomInches', 'RearHeadRoomInches') 

str(Auto)
Auto$Name <- as.character(Auto$Name)
Auto$Drive <- as.factor(Auto$Drive)
Auto$Fuel <- as.factor(Auto$Fuel)


levels(Auto$Fuel)
Auto$Fuel <- as.character(Auto$Fuel)
Auto$Fuel <- trimws(Auto$Fuel)
Auto$Fuel <- as.factor(Auto$Fuel)
levels(Auto$Fuel)

is.na(Auto)
any(is.na(Auto))
colSums(is.na(Auto))

originalAuto <- Auto
Auto$LuggageCuFt[is.na(Auto$LuggageCuFt)] <- mean(Auto$LuggageCuFt,na.rm = TRUE)
any(is.na(Auto))
Auto <- originalAuto
dim(Auto)

Auto <- na.omit(Auto)
dim(Auto)
Auto <- originalAuto

any(duplicated(Auto))

#Create a subset data frame

AutoS <- subset(Auto, Auto$WeightLBS >= 4000 & Auto$MPG >= 20)
str(Auto)

AutoMileagePerFuel <- aggregate(Auto$MPG ~ Auto$Fuel, FUN= 'mean')

numerics <- data.frame(Auto$MPG, Auto$FuelCap, Auto$LengthInches, Auto$WheelBaseInches,
                       Auto$WidthInches, Auto$TurningRadiusFeet, Auto$WeightLBS, 
                       Auto$DoorTopInches, Auto$LuggageCuFt, Auto$FrontShoulderInches,
                       Auto$FrontLegRoomInches, Auto$FrontHeadRoomInches, Auto$RearHeadRoomInches,
                       Auto$RearLegRoomInches, Auto$RearShoulderInches)
cor(numerics)

plot(Auto$MPG, Auto$WeightLBS, main = 'MPG by Weight', xlab = 'MPG', ylab = 'WeightLBS')

ggplot(Auto, aes(x = MPG, y = LuggageCuFt)) + geom_point()
ggplot(Auto, aes(x = MPG, y = LuggageCuFt)) + geom_point(aes(color = Fuel))
savedplot <- ggplot(Auto, aes(x = MPG, y = LuggageCuFt))
savedplot
savedplot + geom_point(aes(color = Fuel)) + facet_wrap(~Fuel) + geom_smooth(method = 'lm')
