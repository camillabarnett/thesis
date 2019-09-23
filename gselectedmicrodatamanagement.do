* gender 
 use $isspgender\g1.dta, clear 
 
 *demographics 
tab v200
capture drop fem
gen fem =v200
recode fem 1=0 2=1

tab v201
capture drop age 
gen age = v201


tab v202 
capture drop married 
gen married =v202
recode married 1=1 else=0

tab v204
capture drop ted
gen ted =v204
recode ted 93/97=.

*interactions 
gen fem_ted = fem*ted
gen fem_mar = fem*married
gen fem_age = fem*age




*social strat 
gen ISCO88 = v241
gen SPISCO88 = v247
gen sex = v200
gen wrktyp =  v242
gen wrksup = v244
gen spwrktyp = v248
gen wrkst =  v239
gen spwrkst = v246
do $output\adding_strat_to_issp.do






sav $isspgender\g4.dta, replace
