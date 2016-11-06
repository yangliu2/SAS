* reading using the column input;
data financial;
	infile '/folders/myfolders/examples/bank.txt';
	input Subj $ 1-3
		DOB $ 4-13
		Gender $ 14
		Balance 15-21;
run;

proc print data=financial;
run;

* reading using the format input;
data financial;
	infile '/folders/myfolders/examples/bank.txt';
	input @1 Subj $3.
		  @4 DOB mmddyy10.
		  @14 Gender $1.
		  @15 Balance 7.;
		  
title "Listing of FINANCIAL";
proc print data=financial;
	format DOB mmddyy10.
			Balance dollar11.2;
run;

title "Listing of FINANCIAL";
proc print data=financial;
	format DOB date9.
		Balance dollar11.2;
run;