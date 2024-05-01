proc transreg data=boxcoxSimData;
model boxcox(ResponseVariable)=class(Treatment);
run; 