data demographics;
	* dsd = deliminter sensitive data;
	infile "/folders/myfolders/examples/mydata.csv" dsd;
	input Gender $ Age Height Weight;
run;

