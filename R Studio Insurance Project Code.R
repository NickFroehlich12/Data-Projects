#Insurance Dataset

#About this Dataset

#This dataset gives us a great look at the way demographic factors and health factors effect insurance claims
#This information includes data about the age, gender, BMI, bloodpressure, diabetic, children, smoker, region, and claim amounts
#This data can be used across companies to help make informed decisions about possible clients

#Insert Data and remove unneccessary columns
read.csv("C:/Users/nickf/OneDrive/BIA 6201/insurance_data.csv")
Dataset <- read.csv("C:/Users/nickf/OneDrive/BIA 6201/insurance_data.csv")
Dataset = subset(Dataset, select = -c(index, X, X.1, X.2) )

#Cleaning the Data
Dataset$age <- as.numeric(Dataset$age)
Dataset$bloodpressure <- as.numeric(Dataset$bloodpressure)
Dataset$children <- as.numeric(Dataset$children)
Dataset$gender <- as.factor(Dataset$gender)
Dataset$diabetic <- as.factor(Dataset$diabetic)
Dataset$region <- as.factor(Dataset$region)
Dataset$smoker <- as.factor(Dataset$smoker)

is.na(Dataset)
any(is.na(Dataset))
colSums(is.na(Dataset))
Dataset <- na.omit(Dataset)

levels(Dataset$region)
Dataset[Dataset == ""] <- NA
InsuranceData <- na.omit(Dataset)
rm(Dataset)

install.packages("rmarkdown")
install.packages("markdown")
install.packages("randomForest")
install.packages("dplyr")
install.packages("devtools")
install.packages("caTools")
library(caTools)
library(randomForest)

#Running t-test

t.test(claim~gender, InsuranceData)
ggplot(InsuranceData, aes(gender, claim)) + 
  geom_boxplot(aes(fill = gender)) +
  labs(x="Gender", y="Claim") +
  theme_bw() 

#There is a signifcant difference between the genders but it is not a giant difference

t.test(claim~diabetic, InsuranceData)
ggplot(InsuranceData, aes(diabetic, claim)) + 
  geom_boxplot(aes(fill = diabetic)) +
  labs(x="Diabetic", y="Claim") +
  theme_bw() 

#There is not a Significant Difference weather a person is diabetic or not

t.test(claim~smoker, InsuranceData)
ggplot(InsuranceData, aes(smoker, claim)) + 
  geom_boxplot(aes(fill = smoker)) +
  labs(x="Smoker", y="Claim") +
  theme_bw() 

#There is definately a significant difference between smokers and non smokers as the p value is very low

# Running Anova Test
AnovaRegion <- aov(claim ~ region, data = InsuranceData)
summary(AnovaRegion)
TukeyHSD(AnovaRegion)
ggplot(InsuranceData, aes(region, claim)) + 
  geom_boxplot(aes(fill = region)) +
  labs(x="Region", y="Claim") +
  theme_bw() 
var.test(claim~region, InsuranceData, region %in% c("northeast", "northwest"))
var.test(claim~region, InsuranceData, region %in% c("northeast", "southwest"))
var.test(claim~region, InsuranceData, region %in% c("northeast", "southeast"))


# The difference between the northwest and northeast, northeast and southeast, southwest and northeast are significantly different
# Claims in the northeast seem to have the highest claim amounts

#Linear regression models with plots

AgeRegression <- lm(formula = claim ~ age, data = InsuranceData)
summary(AgeRegression)
Ageplot <- plot(claim~age, InsuranceData)
abline(coef(AgeRegression))



# Age is not significant and our R squared amount is very small which means there is a lot of outside variance 

BMIRegression = lm(formula = claim ~ bmi, data = InsuranceData)
summary(BMIRegression)
BMIplot <- plot(claim~bmi, InsuranceData)
abline(coef(BMIRegression))

# BMI is significant and does have a linear regression although there is still quite a bit of outside variance

BloodpressureRegression = lm(formula = claim ~ bloodpressure, data = InsuranceData)
summary(BloodpressureRegression)
Bloodpressureplot <- plot(claim~bloodpressure, InsuranceData)
abline(coef(BloodpressureRegression))
                                                  
# Bloodpressure is significant and has a linear regression with a bit of outside variance

ChildrenRegression = lm(formula = claim ~ children, data = InsuranceData)
summary(ChildrenRegression)
Childrenplot <- plot(claim~children, InsuranceData)
abline(coef(ChildrenRegression))

# Number of children is significant but does not have a huge difference and has outside variance

ggplot(InsuranceData,aes(y=claim,x=bmi,color=gender))+geom_point()+stat_smooth(method="lm",se=FALSE)
ggplot(InsuranceData,aes(y=claim,x=bloodpressure,color=gender))+geom_point()+stat_smooth(method="lm",se=FALSE)

ggplot(InsuranceData,aes(y=claim,x=bmi,color=region))+geom_point()+stat_smooth(method="lm",se=FALSE)
ggplot(InsuranceData,aes(y=claim,x=bloodpressure,color=region))+geom_point()+stat_smooth(method="lm",se=FALSE)

ggplot(InsuranceData,aes(y=claim,x=bmi,color=diabetic))+geom_point()+stat_smooth(method="lm",se=FALSE)
ggplot(InsuranceData,aes(y=claim,x=bloodpressure,color=diabetic))+geom_point()+stat_smooth(method="lm",se=FALSE)

ggplot(InsuranceData,aes(y=claim,x=bmi,color=smoker))+geom_point()+stat_smooth(method="lm",se=FALSE)
ggplot(InsuranceData,aes(y=claim,x=bloodpressure,color=smoker))+geom_point()+stat_smooth(method="lm",se=FALSE)


