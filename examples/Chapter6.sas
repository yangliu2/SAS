libname readit '/folders/myfolders/examples/wages.xls';

title 'stats from sales spreadsheet';
proc means data=import mean;
	var Wage Hours_Worked;
run;

* create a csv file using the survey data;

libname learn '/folders/myfolders/examples';

ods csv file='/folders/myfolders/odsexample.csv';

proc print data=learn.survey noobs;
run;

ods csv close;