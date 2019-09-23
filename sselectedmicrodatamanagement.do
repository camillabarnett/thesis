
 use $isspsport\s1.dta, clear 
 
 *demographics 
tab sex
capture drop fem
gen fem =sex
recode fem 1=0 2=1

tab age

tab marital
capture drop married 
gen married =marital
recode married 1=1 6=1 else=0

tab  educyrs
capture drop ted
gen ted = educyrs
recode ted 93/97=.

*interactions 
gen fem_ted = fem*ted
gen fem_mar = fem*married
gen fem_age = fem*age


*social strat 
gen wrktyp = wrktype
do $output\adding_strat_to_issp.do




*interactions 

sav $isspsport\s4.dta, replace
