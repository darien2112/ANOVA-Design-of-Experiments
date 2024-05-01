proc power;
onewayanova alpha=.05 test=overall
groupmeans=(21 28.6 25.87 29.2)
npergroup=6 stddev=1.747
power=.;
run;