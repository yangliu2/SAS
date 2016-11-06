data Cache;
	infile '/folders/myfolders/SAS_by_Examples/geocaching.txt';
	input @1  Name $17.
		  @19 Location $16.;
run;

proc print data=Cache;
run;
