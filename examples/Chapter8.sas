data grades;
	length Gender $ 1
			Quiz $ 2
			AgeGrp $ 13;
	infile '/folders/myfolders/examples/grades.txt' missover;
	input Age Gender Midterm Quiz FinalExam;
	if missing(Age) then delete;
	if Age le 39 then Agegrp = 'Younger group';
	if Age le 39 then Grade = .4*Midterm + .6*FinalExam;
	if Age gt 39 then Agegrp = 'Older group';
	if Age gt 39 then Grade = (Midterm + FinalExam)/2;
run;

proc print data=grades;
run;

data grades;
	length Gender $ 1
			Quiz $ 2
			AgeGrp $ 13;
	infile '/folders/myfolders/examples/grades.txt' missover;
	input Age Gender Midterm Quiz FinalExam;
	if missing(Age) then delete;
	if Age le 39 then do;
		Agegrp = 'Younger group';
		Grade = .4*Midterm + .6*FinalExam;
	end;
	else if Age gt 39 then do;
		Agegrp = 'Older group';
		Grade = (Midterm + FinalExam)/2;
	end;
run;

title "Listing of GRADES";
proc print data=grades noobs;
run;

data revenue;
	input Day : $3.
			Revenue : dollar6.;
	Total = Total + Revenue; /* Note: this does not work */
	format Revenue Total dollar8.;
datalines;
Mon $1,000
Tue $1,500
Wed .
Thu $2,000
Fri $3,000
;

*sum function 'total + revenue';
data revenue;
	input Day : $3.
		Revenue : dollar6.;
		Total + Revenue;
	format Revenue Total dollar8.;
datalines;
Mon $1,000
Tue $1,500
Wed .
Thu $2,000
Fri $3,000
;

*counter function;
data test;
	input x;
	if missing(x) then MissCounter + 1;
datalines;
2
.
7
.
;

data compound;
	Interest = .0375;
	Total = 100;
	do Year = 1 to 3;
		Total + Interest*Total;
		output;
	end;
	format Total dollar10.2;
run;