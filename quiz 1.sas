

data cars;
set sashelp.cars;
run;

proc contents data=cars varnum;
run;

proc freq data = cars;
tables type;
run; 

data SUV1;
set cars;
if type ne "SUV" then DELETE;
run;
/*making new dataset SUVS from cars - that has only SUV */
data SUVS;
	set cars;
	where type = "SUV";    
run;
/*checking the dataset and variable*/
proc print data = SUVS;
run;
proc freq data = SUVS;
table type;
run;
/*b. Create a new variable in the CARS dataset called disp_per_cylinder that 
is calculated as the engine size (engineSize) divided by the number of cylinders
(Cylinders).  */

data CARS;
set CARS;
disp_per_cylinder = engineSize/Cylinders;
run;

/*checking the dataset and variable*/
proc print data = cars;
run;

proc univariate data = cars;
var disp_per_cylinder;
run;
/*2c*/
data cars;
set cars;
profit = MSRP-Invoice;
format profit DOLLAR7.0;
run; 

/*checking the dataset and variable*/
proc print data = cars;
run;

/*2d*/
data cars;
set cars;
if find(model,'4dr')>0 then four_door = 1;
	else four_door = 0;
run;

/*checking the dataset and variable*/
proc print data = cars;
run;
proc freq data = cars;
table four_door;
run;

data cars;
set cars; 
if mean(MPG_highway, MPG_city)<20 then gas_guzzler = 1;
if mean(MPG_highway, MPG_city)>=20 then gas_guzzler = 0;
run; 

/*checking the variable*/
proc freq data = cars;
table gas_guzzler1;
run;

