filename vote '/folders/myfolders/SAS_by_Examples/political.csv';

data Vote;
	infile vote dsd;
	input State $ Party $ Age;
run;

proc print data=Vote;
run;

proc freq data=Vote;
	tables Party;
run;