setwd("~/path-to-folder/")
greenhouse_data<-read.table("feritilizer_treatment.txt",header=T)

greenhouse_data <- feritilizer_treatment
head(greenhouse_data, 5)

# Put original data in a stacked format
my_data <- stack(greenhouse_data)
my_data

# Change column names
colnames(my_data) <- c("height", "fert")
my_data
attach(my_data)

# Calculate overall mean, std, standard error
overall_mean <- mean(height)
overall_mean 

overall_sd <- sd(height)
overall_sd

overall_standard_error <- overall_sd/sqrt(length(height))
overall_standard_error

# Calculate mean, std, standdard error for each group
aggregate(height~fert, FUN=mean)
aggregate(height~fert, FUN=sd)

std_error_fn = function(x){ sd(x)/sqrt(length(x)) }
aggregate(height~fert, FUN=std_error_fn)

# Box-plot
boxplot(height ~ fert, xlab = "Fertilizer", ylab = "Plan Height",
        main = "Distribution of Plant Heights by Fertilizer")

# ANOVA Table (Type III)
options(contrasts =  c("contr.sum", "contr.poly"))

library(car)
lm1 = lm(height ~ fert, data = my_data)
aov3 = Anova(lm1, type = 3)
aov3

aov1 = aov(lm1)
library(emmeans)
lsmeans = emmeans(aov1, ~fert)
plot(lsmeans, xlab = "height LS-Means with 95% CIs")

# Tukey pairwise comparisons of means
tpairs = TukeyHSD(aov1)
tpairs
plot(tpairs)

# Another way
lsmeans = emmeans(aov1, ~fert)
tpairs2 = pairs(lsmeans, adjust = "Tukey")
tpairs2
plot(tpairs2)

# Residual Analysis
par(mfcol = c(2,2), mar = c(4.5,4.5,2,0))
plot(aov1, 1)
plot(aov1, 2)
hist(aov1$residuals, main = "Residual Histogram", xlab = "residuals")
