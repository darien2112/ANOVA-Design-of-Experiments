aov3

# Calculate within group variance
within.var = aov3$`Sum Sq`[3]/aov3$Df[3]
within.var

# Calculate between-group variance
lsmeans # equivalent to print(lsmeans)
groupmeans = summary(lsmeans)$emmean
between.var = var(groupmeans)
between.var

# Conduct a Power Analysis 
power.anova.test(groups=4,n=6,between.var=between.var,within.var=within.var)

# Plot (with different sample) (What-If case)
n = seq(2,8,by=1)
p = power.anova.test(groups=4,n=n,between.var=between.var,within.var=within.var)
p1 = power.anova.test(groups=4,n=n,between.var=between.var,within.var=4)
p2 = power.anova.test(groups=4,n=n,between.var=between.var,within.var=6.25)
p3 = power.anova.test(groups=4,n=n,between.var=between.var,within.var=9)
p4 = power.anova.test(groups=4,n=n,between.var=between.var,within.var=16)
p5 = power.anova.test(groups=4,n=n,between.var=between.var,within.var=25)
par(mfcol=c(1,1),mar=c(4.5,4.5,2,0))
plot(n,p$power,ylab="Power",xlab="Sample size per Group",main="Overall F test for One-Way ANOVA", ylim=c(0,1))
lines(n,p$power, col = "blue")
text(2.5,p$power[1]+0.05,"var=3.05",col="blue")
points(n,p1$power)
lines(n,p1$power, col = "red")
text(2.5,p1$power[1]+0.05,"var=4",col="red")
points(n,p2$power)
lines(n,p2$power, col = "green")
text(2.5,p2$power[1]+0.05,"var=6.25",col="green")
points(n,p3$power)
lines(n,p3$power, col = "brown")
text(2.5,p3$power[1]+0.05,"var=9",col="brown")
points(n,p4$power)
lines(n,p4$power, col = "purple")
text(2.5,p4$power[1]+0.05,"var=16",col="purple")
points(n,p5$power)
lines(n,p5$power, col = "gray")
text(2.5,p5$power[1]+0.05,"var=25",col="gray")
abline(h=0.80,lty=2,col="dark gray")