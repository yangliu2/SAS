libname myfmts '/folders/myfolders/SAS_by_Examples/formats';

proc format library=myfmts fmtlib;
	value YESNO 1 = 'Yes'
				2 = 'No';
	value $YESNO 'Y' = 'Yes'
				 'N' = 'No';
	value $Gender 'M' = 'Male'
				  'F' = 'Female';
	value age20yr low-20 = 1
				  21-40 = 2
				  41-60 = 3
				  61-80 = 4
				  81-high = 5;
run;
