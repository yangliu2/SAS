libname learn '/folders/myfolders/examples';
libname myfmts '/folders/myfolders/examples';

data learn.test_scores;
	input ID $ Score1-Score3;
	label ID = 'Student ID'
			Score1 = 'Math Score'
			Score2 = 'Science Score'
			Score3 = 'English Score';
datalines;
1 90 95 98
2 78 77 75
3 88 91 92
;

proc means data=learn.test_scores;
run;

data learn.survey;
	infile '/folders/myfolders/examples/survey.txt';
	input ID Gender$ Age Salary Ques1-Ques5;
run;

proc format library=myfmts;
	value $gender 'M' = 'Male'
					'F' = 'Female'
					' ' = 'Not entered'
					other = 'Miscoded';
	value age low-<29 = 'Less than 30'
				30-<50 = '30 to 50'
				51-high = '51+';
	value likert 1 = 'Strongly disagree'
					2 = 'Disagree'
					3 = 'No opinion'
					4 = 'Agree'
					5 = 'Strongly agree';
run;

title "Data Set SURVEY with Formatted Values";
proc print data=learn.survey;
	id ID;
	var Gender Age Salary Ques1-Ques5;
	format Gender $gender.
			Age age.
			Ques1-Ques5 likert.
			Salary dollar11.2;
run;

proc print data=learn.survey;
run;

proc format;
	value three 1,2 = 'Disagreement'
					3 = 'No Opinion'
					4, 5 = 'Agreement';
run;

proc freq data=learn.survey;
	title 'question frequencies using the $three format';
	tables Ques1-Ques5;
	format Ques1-Ques5 three.;
run;


options fmtsearch=(myfmts);
data learn.survey;
	infile '/folders/myfolders/examples/survey.txt' pad;
	input ID : $3.
			Gender : $1.
			Age
			Salary
			(Ques1-Ques5)(: $1.);
	format Gender $gender.
			Age age.
			Ques1-Ques5 likert.
			Salary dollar10.0;
	label ID = 'Subject ID'
			Gender = 'Gender'
			Age = 'Age as of 1/1/2006'
			Salary = 'Yearly Salary'
			Ques1 = 'The governor is doing a good job?'
			Ques2 = 'The property tax should be lowered'
			Ques3 = 'Guns should be banned'
			Ques4 = 'Expand the Green Acre program'
			Ques5 = 'The school needs to be expanded';
run;

title "Data set SURVEY";
proc contents data=learn.survey varnum;
run;

title 'format diefinitions in the myfmts library';
proc format library=myfmts fmtlib;
run;

proc format library=myfmts;
	select age $likert;
run;