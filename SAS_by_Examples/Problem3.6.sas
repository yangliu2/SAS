data Bank;
	infile '/folders/myfolders/SAS_by_Examples/bankdata.txt';
	input @1 Name 		$15.
		  @16 Acct 		$5.
		  @21 Balance 	6.
		  @27 Rate		4.;
	Interest = Balance * Rate; 
run;

proc print data=Bank;
run;
