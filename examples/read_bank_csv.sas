* read in data using list input;
data list_example;
	infile '/folders/myfolders/examples/list.csv' dsd;
	input Subj : $3.
		  Name : $20.
		  DOB  : mmddyy10.
		  Salaray : dollar8.;
	format DOB date9. Salary dollar8.;
run;

* or specifically using the informat statement;
data list_example;
	informat Subj $3.
			Name $20.
			DOB mmddyy10.
			Salary dollar8.;
	infile '/folders/myfolders/examples/list.csv' dsd;
	input Subj
			Name
			DOB
			Salary;
	format DOB date9. Salary dollar8.;
run;