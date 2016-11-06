data soccer;
	input Team : $20. Wins Losses;
	datalines;
Readington 20 3
Raritan 10 10
Branchburg 3 18
Somerville 5 18
;
	options nodate nonumber;
	title;
	ods listing close;
	ods csv file='/folders/myfolders/SAS_by_Examples/soccer.csv';

proc print data=soccer noobs;
run;

ods csv close;
ods listing;

proc print data=mydata.soccer;
run;