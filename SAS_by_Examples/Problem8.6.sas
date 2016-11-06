data log;
	do N=5 to 100 by 5;
		LogN = LOG(N);
		output;
	end;
	format LogN 4.3;
run;