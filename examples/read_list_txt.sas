* & will read first name and last name, if last name is 
	followed by two spaces;
data list_example;
	infile '/folders/myfolders/examples/list.txt';
	input Subj : $3.
			Name & $20.
			DOB : mmddyy10.
			Salary : dollar8.;
	format DOB date9. Salary dollar8.;
run;

