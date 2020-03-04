libname clasdat "C:\SAS\epi5143 classdata";
run;
libname ex "C:\SAS\epi5143 classdata\data";
run;

data ex.diagquiz2;
set clasdat.NhrDiagnosis;
run;

proc contents data=ex.diagquiz2 position;
run;
 *the 5 most common diagnostic codes (hgdCd) rolled up to the first 3 characters/numbers;
proc freq data=ex.diagquiz2 order=freq;
tables hdgCd/missing;
run; *Z370, V30, Z38, I100, V27.0;

	*diag variable with only the first 3 letter/numbers ;
data ex.diagquiz2;
set ex.diagquiz2;
diag = substr (hdgCd,1,3);
run;

*we can do with trim statement;

proc freq data=ex.diagquiz2 order=freq;
tables diag/missing;
run; *V30, Z38, Z37, I25, I10;

 *a new diagnosis dataset called top_five that only includes records with any of these five diagnoses;
data ex.top_five;
set ex.diagquiz2;
 if diag = 'V30' or diag = 'Z38' or diag = 'Z37' or diag = 'I25' or diag = 'I10';
run;

 *another way to do it;
data ex.top_five2;
set ex.diagquiz2;
if diag in ('V30','Z38','Z37','I25','I10') then output;
run;
 *anoter way to do it;
data pract;
set ex.diagquiz2;
where diag in ('V30','Z38','Z37','I25','I10');
run;

proc freq data=ex.top_five2;
tables diag;
run;

proc freq data = ex.top_five;
table hdgHraEncWID;
run;


 *determine how many unique encounters are represented in the dataset ; 
proc sort data = ex.top_five out=ex.uniqencsort nodupkey;
by hdgHraEncWID;
run; 

 *checking the duplicates ;
data dup;
set ex.top_five;
by hdgHraEncWID;
if first.hdgHraEncWID=1 and last.hdgHraEncWID=1 then delete;
run;

proc print data=dup;
id hdgHraEncWID;
run;
