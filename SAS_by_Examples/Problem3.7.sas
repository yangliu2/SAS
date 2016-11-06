data Cache;
	infile '/folders/myfolders/SAS_by_Examples/geocaching.txt';
	input Name $	1-20
		  LongDeg 21-22
		  LongMin 23-28
		  LatDeg 29-30
		  LatMin 31-36;
run;

proc print data=Cache;
run;
