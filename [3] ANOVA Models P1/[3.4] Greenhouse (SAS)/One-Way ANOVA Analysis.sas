data greenhouse;
input fert $ Height;
datalines;
Control      21
Control      19.5
Control      22.5
Control      21.5
Control      20.5
Control      21
F1      32
F1      30.5
F1      25
F1      27.5
F1      28
F1      28.6
F2      22.5
F2      26
F2      28
F2      27
F2      26.5
F2      25.2
F3      28
F3      27.5
F3      31
F3      29.5
F3      30
F3      29.2
;

proc mixed data=greenhouse method=type3 plots=all; 
class fert;
model height=fert;
store myresults; /*myresults is an user defined object that stores results*/
title 'ANOVA of Greenhouse Data';
run;

/*To conduct the pairwise comparisons using Tukey adjustment*/ 
/*lsmeans statement below outputs the estimates means, 
performs the Tukey paired  comparisons, plots the data. */
/*Use proc plm procedure for post estimation analysis*/
proc plm restore=myresults; 
lsmeans fert / adjust=tukey plot=meanplot cl lines; 
run;

/* Testing for contrasts of interest with Bonferroni adjustment*/
proc plm restore=myresults; 
lsmeans fert / adjust=tukey plot=meanplot cl lines; 
estimate 'Compare control + F3  with F1 and F2 ' fert 1 -1  -1 1, 
		 'Compare control + F2 with F1' fert 1 -2 1 0/ adjust=bon;
run;