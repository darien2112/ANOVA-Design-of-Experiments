# Input response variable and design matrix 
y = matrix(c(2,1,3,4,6,5), ncol=1)
x = matrix(c(1,1,1,1,1,1), ncol=1)

# Calculate regression coefficients
beta = solve(t(x)%*%x)%*%(t(x)%*%y)

# Calculate entries of ANOVA Table
n = nrow(y)
p = ncol(x)
J = matrix(1,n,n)
ss_tot = (t(y)%*%y) - (1/n)*(t(y)%*%J)%*%y 
ss_trt = t(beta)%*%(t(x)%*%y) - (1/n)*(t(y)%*%J)%*%y 
ss_error = ss_tot - ss_trt 
total_df = n-1 
trt_df = p-1 
error_df = n-p 
MS_trt = ss_trt/(p-1)
MS_error = ss_error / error_df 
Fstat = MS_trt/MS_error

# Build and print the ANOVA Table
ANOVA <- data.frame(
  c ("","Treatment","Error", "Total"),
  c("DF", trt_df,error_df,total_df),
  c("SS", ss_trt, ss_error, ss_tot),
  c("MS", MS_trt, MS_error, ""),
  c("F",Fstat,"",""),
  stringsAsFactors = FALSE)
names(ANOVA) <- c(" ", "  ", " ","","")
print(ANOVA)

# Intermediate matrix computations
xprimex = t(x)%*%x 
xprimex
xprimey = t(x)%*%y 
xprimey
xprimexinv = solve(t(x)%*%x) 
xprimexinv
check = xprimexinv*xprimex 
check
SumY2 = t(beta)%*%(t(x)%*%y) 
SumY2
CF = (1/n)*(t(y)%*%J)%*%y 
CF

## Another way to run the model using built-in functions
#options(contrasts=c("contr.sum","contr.poly"))
#lm1 = lm(y~1)
#beta = lm1$coefficients
#beta

# Obtain ANOVA Table
library(car)
aov3 = Anova(lm1,type = 3) 
aov3

# ANOVA Type 1 Table
aov1 = aov(lm1)
summary(aov1)