data scores;
	infile '/folders/myfolders/SAS_by_Examples/score.txt';
	input Gender $1. Score1 Score2 Score3 Score4;
		Average = (Score1+Score2+Score3+Score4)/4;
run;

proc print data=scores;
run;

proc contents data=scores;
run;