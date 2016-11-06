libname learn '/folders/myfolders/SAS_by_Examples';

data learn.perm;
	input ID : $3. Gender : $1. DOB : mmddyy10.
		Height Weight;
	label DOB='Date of Birth'
		Height='Height in inches'
		Weight='Weight in pounds';
	format DOB date9.;
datalines;
001 M 10/21/1946 68 150
002 F 5/26/1950 63 122
003 M 5/11/1981 72 175
004 M 7/4/1983 70 128
005 F 12/25/2005 30 40
;

proc print data=learn.perm;
run;

proc contents data=learn.perm;
run;