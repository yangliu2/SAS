data Vote;
	infile '/folders/myfolders/SAS_by_Examples/political.csv' dsd;
	input State $ Party $ Age;
run;

proc print data=Vote;
run;

proc freq data=Vote;
	tables Party;
run;