*Program name: demog.sas stored in the
	/folders/myfolders/examples/ folder.
	Purpose: The program reads in data on height and weight
	(in inches and pounds, respectively) and computes a body
	mass index (BMI) for each subject.
	Programmer: Ron Cody
	Date Written: May 2006;

data demographic;
	infile "/folders/myfolders/examples/mydata.txt";
	input Gender $ Age Height Weight;
	*Compute a body mass index (BMI);
	BMI = (Weight / 2.2) / (Height*.0254)**2;
run;

title "list of data set demographics";
proc print data=demographic;
run;

title "gender frequencies";
proc freq data=demographic;
	tables Gender;
run;

title "summary stats";
proc means data=demographic;
	var Age Height Weight;
run;