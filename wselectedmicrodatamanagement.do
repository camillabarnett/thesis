*work
 use $isspwork\w1.dta, clear 
 
 *demographics 
tab SEX
capture drop fem
gen fem =SEX
recode fem 1=0 2=1

tab AGE
capture drop age 
gen age = AGE


tab MARITAL 
capture drop married 
gen married =MARITAL
recode married 1=1 else=0

tab EDUCYRS
capture drop ted
gen ted =EDUCYRS
recode ted 93/97=.

*interactions 
gen fem_ted = fem*ted
gen fem_mar = fem*married
gen fem_age = fem*age


*social strat 
gen sex = SEX
gen wrktyp =  WRKTYPE
gen wrksup = WRKSUP
gen spwrktyp = SPWRKTYP
gen wrkst =  WRKST
gen spwrkst = SPWRKST
do $output\adding_strat_to_issp.do








*interactions 


sav $isspwork\w4.dta, replace
