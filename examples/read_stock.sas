* this program read stock prices
	Author: Yang Liu
	Date: October 31, 2016;
	
data Portfolio;
	infile "/folders/myfolders/examples/stocks.txt";
	input Symbol $ Price Shares;
run;

proc print data=Portfolio;
run;

proc means data=portfolio;
run;