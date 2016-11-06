data conditional;
	length Gender $1
			Quiz $2;
	input Age Gender Midterm Quiz FinalExam;
	if Age lt 20 and not missing(age) then AgeGroup = 1;
	else if Age ge 20 and Age lt 40 then AgeGroup = 2;
	else if Age ge 40 and Age lt 60 then AgeGroup = 3;
	else if Age ge 60 then AgeGroup = 4;
datalines;
21 M 80 B- 82
. F 90 A 93
35 M 87 B+ 85
48 F . . 76
59 F 95 A+ 97
15 M 88 . 93
67 F 97 A 91
. M 62 F 67
35 F 77 C- 77
49 M 59 C 81
;

title 'listing of conditional';
proc print data=conditional noobs;
run;

data females;
length Gender $ 1
Quiz $ 2;
input Age Gender Midterm Quiz FinalExam;
if Gender eq 'F';
datalines;
21 M 80 B- 82
. F 90 A 93
35 M 87 B+ 85
48 F . . 76
59 F 95 A+ 97
15 M 88 . 93
67 F 97 A 91
. M 62 F 67
35 F 77 C- 77
49 M 59 C 81
;
title "Listing of FEMALES";
proc print data=Females noobs;
run;

data conditional;
	length Gender $ 1
			Quiz $ 2;
	input Age Gender Midterm Quiz FinalExam;
	select;
		when (missing(Age)) AgeGroup = .;
		when (Age lt 20) AgeGroup = 1;
		when (Age lt 40) AgeGroup = 2;
		when (Age lt 60) AgeGroup = 3;
		when (Age ge 60) Agegroup = 4;
	otherwise;
end;