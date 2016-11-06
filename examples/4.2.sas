libname Mozart '/folders/myfolders/examples';

data Mozart.test_scores;
	input ID $ Score1-Score3;
datalines;
1 90 95 98
2 78 77 75
3 88 91 92
;

proc print data=Mozart.test_scores;
run;

proc contents data=Mozart.test_scores varnum;
run;

proc contents data=Mozart._all_ nods;
run;

data new;
	set Mozart.test_scores;
	AveScore = mean(of score1-score3);
run;

proc print data=new;
run;

* set up the output file name;
file '/folders/myfolders/example/output.txt';



data _null_;
	set Mozart.test_scores;
	
	file print; * output window;
	if score1 ge 95 or score2 ge 95 or score3 ge 95 then
		put ID= Score1= score2= score3=;
run;

