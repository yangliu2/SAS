data school;
	input Age Quiz : $1. Midterm Final;

	if Age=12 then
		Grade=6;

	if Age=13 then
		Grade=8;

	Select (Quiz);
		when ('A') Course=0.2 * 95 + 0.3 * Midterm + 0.5 * Final;
		when ('B') Course=0.2 * 85 + 0.3 * Midterm + 0.5 * Final;
		when ('C') Course=0.2 * 75 + 0.3 * Midterm + 0.5 * Final;
		when ('D') Course=0.2 * 70 + 0.3 * Midterm + 0.5 * Final;
		when ('F') Course=0.2 * 65 + 0.3 * Midterm + 0.5 * Final;
		otherwise ;
	end;
	datalines;
12 A 92 95
12 B 88 88
13 C 78 75
13 A 92 93
12 F 55 62
13 B 88 82
;