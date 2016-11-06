data vitals;
	input ID : $3. Age Pulse SBP DBP;
	label SBP="Systolic Blood Pressure" DBP="Diastolic Blood Pressure";
	datalines;
001 23 68 120 80
002 55 72 188 96
003 78 82 200 100
004 18 58 110 70
005 43 52 120 82
006 37 74 150 98
007 . 82 140 100
;

data NewVitals;
	set vitals;
	if Age lt 50 and not missing(Age) then do;
		if Pulse lt 70 then PulseGroup = 'Low '; 
		else PulseGroup = 'High';
		if SBP lt 130 then SBPGroup = 'Low '; 
		else SBPGroup = 'High';
	end;
	else do;
		if Pulse lt 74 then PulseGroup = 'Low '; 
		else PulseGroup = 'High';
		if SBP lt 140 then SBPGroup = 'Low '; 
		else SBPGroup = 'High';
	end;
run;
		
proc print data=newvitals;
run;