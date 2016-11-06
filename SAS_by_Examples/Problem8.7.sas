data log;
	do x=0 to 10 by .10;
		y = 3 * x**2- 5 *x + 10;
		output;
	end;
run;

proc plot data=log;
plot y * x;
run;