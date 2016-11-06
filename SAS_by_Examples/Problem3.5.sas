data equation;
	input x y;
	z = 100 + 50 * x + 2 * x **2 - 25 * y + y**2;
datalines;
1 2
3 6
5 9
9 11
;