DATA hosp;   /* start of a DATA step */ 
INPUT h $ d s c; /* identifies the names of the variables that are 
assigned the values read from the observations */ 
   DATALINES; 
 A  1  1 18 
 A  1  0 2 
 A  2  1 32 
 A  2  0 48 
 B  1  1 64 
 B  1  0 16 
 B  2  1 4 
 B  2  0 16 
; 
RUN; 

