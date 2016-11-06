* make the data with one non-unique number;
data nonunique;
	input Number;
datalines;
1
2
3
4
5
6
7
8
9
10
1
;

* use frequency function to get the the output;
proc freq data=nonunique;
	tables Number / out=keylist;
run;

* search for the count that's greater than or equal to 2;
proc print data=keylist;
	where count ge 2;
run;

proc surveyselect data=nonunique groups=2 out=RandomGroups;
run;

proc freq data=RandomGroups;
	tables GroupID;
run;

proc print data=RandomGroups;
run;