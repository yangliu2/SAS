data Stocks;
	infile '/folders/myfolders/SAS_by_Examples/stockprices.txt';
	input @1  Stock		$4.
		  @5  PurDate	mmddyy10.
		  @15 PurPrice	dollar6.
		  @21 Number	4.
		  @25 SellDate	mmddyy10.
		  @35 SellPrice	dollar6.;
		  TotalPur = Number * PurPrice;
		  TotalSell = Number * SellPrice;
		  Profit = TotalSell - TotalPur;
	format PurDate SellDate mmddyy10. PurPrice SellPrice Profit dollar6.2;
		  
run;

proc print data=Stocks;
run;
