* This program import data from a .txt file and 
  calculate the value of each stock. And compute
  the mean Price and Share
  Author: Yang Liu
  Date:   8/24/15;

data Portfolio;
	infile '/folders/myfolders/SAS_by_Examples/stocks.txt';
	input Stock_Symbol $ Price Share;
	Value = Price * Share;
run;

proc means data=Portfolio;
	var Price Share;
run;