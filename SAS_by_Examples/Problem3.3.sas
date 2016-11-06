data Company;
	infile '/folders/myfolders/SAS_by_Examples/company.txt' delimiter="$" dsd;
	input LastName$ EmpNo$ Salary;
run;

proc print data=Company;
run;
