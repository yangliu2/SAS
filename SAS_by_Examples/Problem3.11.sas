data Employ;
	infile '/folders/myfolders/SAS_by_Examples/employee.csv' dsd;
	input ID 		: $3.
		  Name 		: $20.
		  Depart 	: $8.
		  DateHire 	: mmddyy10.
		  Salary 	& dollar8. 
		  ;
	format DateHire mmddyy10. Salary dollar8.;
		  
run;

proc print data=Employ noobs;
run;
