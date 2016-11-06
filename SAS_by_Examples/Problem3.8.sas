data Cache;
	infile '/folders/myfolders/SAS_by_Examples/geocaching.txt';
	input @1 Name $20.
		  @21 LongDeg 2.
		  @23 LongMin 6.
		  @29 LatDeg 2.
		  @31 LatMin 6.;
run;

proc print data=Cache;
run;
