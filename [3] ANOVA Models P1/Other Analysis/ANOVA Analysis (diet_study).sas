data diet_study;
input diet $ wt_gain;
datalines;
diet1 12
diet1 10
diet1 13
diet1 11
diet1 12
diet1 09
diet2 18
diet2 19
diet2 18
diet2 18
diet2 19
diet2 19
diet3 10
diet3 12
diet3 13
diet3 16
diet3 14
diet3 13
diet4 19
diet4 20
diet4 18
diet4 19
diet4 18
diet4 19
;
ods graphics on;
proc mixed data= Lesson3_ex1 plots=all; class diet;
model wt_gain = diet;
contrast 'Compare diet1 with diets 2,3,4 combined ' diet 3 -1  -1 -1; 
store result1; 
title 'ANOVA of Weight Gain Data';
run;
ods html style=statistical sge=on;
proc plm restore=result1; 
lsmeans diet/ adjust=tukey plot=meanplot cl lines; 
run; 
