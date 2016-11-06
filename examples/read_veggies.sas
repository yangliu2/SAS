* read veggies.txt

options nocenter nonumber;

data veg;
	/* select the location of the file */
	infile "/folders/myfolders/examples/veggies.txt";

	/* take data, Name and Code is string, others are number */
	input Name $ Code $ Days Number Price;

	/* last variable is calculated from the other data */
	CostPerSeed=Price / Number;
run;

title="List of the raw veggies";

/* print a table, from the data (veg) defined earlier */
proc print data=veg;
run;

title="frequency distribution of veggie names";

/* show the frequency table of veg data:  frequency, percent, cum freq, cum percent*/
proc freq data=veg;
	tables Name;
run;

title="average cost of seeds";
/* give a brief stat description of the variables Price and Days */
proc means data=veg;
	var Price Days;
run;

