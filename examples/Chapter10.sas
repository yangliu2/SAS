libname learn '/folders/myfolders/examples/';

data females;
	set learn.survey(drop=Salary);
	where gender = 'F';
run;

data males females;
	set learn.survey;
	if gender = 'F' then output females;
	else if gender = 'M' then output males;
run;

data one;
	input ID Name$ Weight;
datalines;
7 Adams 210
1 Smith 190
2 Schneider 110
4 Gregory 90
;

data two;
	input ID Name$ Weight;
datalines;
9 Shea 120
3 O'Brien 180
5 Bessler 207
;

data one_two;
	set one two;
run;

proc print data=one_two;
run;

data three;
	input ID Gender$ Name$;
datalines;
10 M Horvath
15 F Stevens
20 M Brown
;

data one_three;
	set one three;
run;


proc print data=one_three;
run;

proc sort data=one;
	by ID;
run;

proc sort data=two;
	by ID;
run;

data interleave;
	set one two;
	by ID;
run;

proc print data=interleave noobs;
run;

data learn.blood;
	infile '/folders/myfolders/examples/blood.txt';
	input Subject Gender$ Type$ Age$ Number Point Chol;
run;

proc means data=learn.blood noprint;
	var Chol;
	output out = means(keep=AveChol)
			mean = AveChol;
run;

data percent;
	set learn.blood(keep=Subject Chol);
	if _n_ = 1 then set means;
	PerChol = Chol / AveChol;
	format PerChol percent8.;
run;

proc print data=percent;
run;

proc print data=means;
run;

data employee;
	input ID Name$;
datalines;
1 Smith
2 Schneider
4 Gregory
5 Washington
7 Adams
;

data hours;
	input ID Class$ Hours;
datalines;
1 A 39
4 B 44
5 A 35
9 B 57
;

proc sort data=employee;
	by ID;
run;

proc sort data=hours;
	by ID;
run;

data combine;
	merge employee hours;
	by ID;
run;

proc print data=combine;
run;

options mergenoby = error;

data new;
	merge employee(in=InEmploy)
			hours (in=InHours);
	by ID;
	file print;
	put ID= InEmploy= InHours= Name= JobClass= Hours=;
run;

data combine;
	merge employee(in=InEmploy)
			hours(in=InHours);
	by ID;
	if InEmploy and InHours;
run;

proc print data=combine;
run;

data in_both
	missing_name(drop =Name);
	merge employee(in=InEmploy)
			hours(in=InHours);
	by ID;
	if InEmploy and InHours then output in_both;
	else if InHours and not InEmploy then
		output missing_name;
run;

proc print data=missing_name;
run;

data division1;
	input SS DOB$ Gender$;
datalines;
111223333 11/14/1956 M
123456789 05/17/1946 F
987654321 04/01/1977 F
;

data division2;
	length SS$ 11;
	input SS$ JobCode$ Salary;
datalines;
111-22-3333 A10 45123
123-45-6789 B5 35400
987-65-4321 A20 87900
;

data division1c;
	set division1(rename=(SS=NumSS));
	SS = put(NumSS, ssn11.);
	drop NumSS;
run;

data both_divisions;
	merge division1c division2;
	by SS;
run;

proc print data=both_divisions;
run;

data division2n;
	set division2(rename=(SS=CharSS));
	SS = input(compress(CharSS,'-'),9.);
	drop CharSS;
run;

proc print data=division2n;
run;