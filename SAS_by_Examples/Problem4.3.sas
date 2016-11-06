libname learn '/folders/myfolders/SAS_by_Examples';
data learn.Survey2007 ;
input Age Gender $ (Ques1-Ques5)($1.);
/* See Chapter 21, Section 14 for a discussion
of variable lists and format lists used above */
datalines;
23 M 15243
30 F 11123
42 M 23555
48 F 55541
55 F 42232
62 F 33333
68 M 44122
;

libname learn '/folders/myfolders/SAS_by_Examples';
proc means data= learn.Survey2007;
	var Age;
run;

proc contents data=learn.survey2007 varnum;
run;
