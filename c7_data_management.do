*********Chapter 6 
global isspsport  "H:\thesis_analysis\data\secondary_data\issp\sport_leisure"

global isspgender "H:\thesis_analysis\data\secondary_data\issp\gender_inequality"

global isspwork  "H:\thesis_analysis\data\secondary_data\issp\work"

global output "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational"


******DV prep 

***family and gender

use $isspgender\ZA3880_v1-1-0.dta, clear
numlabel _all, add
tab COUNTRY
recode COUNTRY 3=2

tab1 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v18 v19 v20 v21 v24 v22 v23 v25 v26 v28 v27   

capture drop _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11 _v12 _v13 _v18 _v19 _v20 _v21 _v24 _v22 _v23 _v25 _v26 _v28 _v27 

gen _v4 = v4
gen _v5 = v5
gen _v6 = v6
gen _v7 = v7
gen _v8 = v8
gen _v9 = v9
gen _v10 = v10
gen _v11 = v11
gen _v12 = v12
gen _v13 = v13
gen _v18 = v18
gen _v19 = v19
gen _v20 = v20
gen _v21 = v21
gen _v24 = v24
gen _v22 = v22
gen _v23 = v23
gen _v25 = v25
gen _v26 = v26
gen _v28 = v28
gen _v27 = v27


recode _v4 1/2=1 3=. 4/5=0
recode _v5 1/2=1 3=. 4/5=0
recode _v6 1/2=1 3=. 4/5=0
recode _v7 1/2=1 3=. 4/5=0
recode _v8 1/2=1 3=. 4/5=0
recode _v9 1/2=1 3=. 4/5=0
recode _v10 1/2=1 3=. 4/5=0
recode _v11 1/2=1 3=. 4/5=0
recode _v12 1/2=1 3=. 4/5=0
recode _v13 1/2=1 3=. 4/5=0
recode _v18 1/2=1 3=. 4/5=0
recode _v19 1/2=1 3=. 4/5=0
recode _v20 1/2=1 3=. 4/5=0
recode _v21 1/2=1 3=. 4/5=0
recode _v24 1/2=1 3=. 4/5=0
recode _v22 1/2=1 3=. 4/5=0
recode _v23 1/2=1 3=. 4/5=0
recode _v25 1/2=1 3=. 4/5=0
recode _v26 1/2=1 3=. 4/5=0
recode _v28 1/2=1 3=. 4/5=0
recode _v27 1/2=1 3=. 4/5=0



* Factor Analysis

polychoric v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v18 v19 v20 v21 v24 v22 v23  v25 v26 v28 v27 
display r(sum_w)
global N = r(sum_w)
matrix r = r(R)
factormat r, n($N) mineigen(1)
rotate, horst blanks(.4)

polychoric v4 v5 v6 v7 v11 
display r(sum_w)
global N = r(sum_w)
matrix r = r(R)
factormat r, n($N) mineigen(1)
rotate, horst blanks(.4)
capture drop factor1 
predict factor1 
rename factor1 f1

polychoric v9 v10 v12 v13 v25 v28 v27 
display r(sum_w)
global N = r(sum_w)
matrix r = r(R)
factormat r, n($N) mineigen(1)
rotate, horst blanks(.4)
capture drop factor1 
predict factor1 
rename factor1 factor2

polychoric v18 v20 v22 v23 
display r(sum_w)
global N = r(sum_w)
matrix r = r(R)
factormat r, n($N) mineigen(1)
rotate, horst blanks(.4)
capture drop factor1 
predict factor1 
rename factor1 factor3

rename f1 factor1

sav $isspgender\g1.dta, replace


 
***sport and leisure 

use $isspsport\ZA4850_v2-0-0.dta, clear
numlabel _all, add
tab V5
gen COUNTRY = V5 
recode COUNTRY ///
32	=	50 ///
40	=	7 ///
36	=	1 ///
56	=	34 ///
100	=	17 ///
756	=	33 ///
152	=	31 ///
196	=	29 ///
203	=	14 ///
276	=	2 ///
208	=	32 ///
214	=	43 ///
246	=	37 ///
250	=	28 ///
826	=	4 ///
348	=	8 ///
840	=	6 ///
191	=	51 ///
372	=	10 ///
376	=	22 ///
392	=	24 ///
410	=	41 ///
428	=	26 ///
484	=	38 ///
578	=	12 ///
554	=	19 ///
608	=	21 ///
616	=	16 ///
643	=	18 ///
752	=	13 ///
705	=	15 ///
703	=	27 ///
858	=	52 ///
710	=	40 ///
158 =	39





tab1 V6 V7 V8 V9 V10 V13 V14 V15 V16 V17 V18 V21 V23 V24  V52 V53 V54 V55 V56

foreach var in V21 V22 V23 V24 {
gen `var'_ = `var'
recode `var'_ 6=1 1=2 2=3 3=4 4=5 5=6
}

foreach var in  V21 V22 V23 V24 {
gen _`var' = `var'
recode _`var' 1/3=0 4/5=1 6=0
}




polychoric V6 V7 V8 V9 V10 V11 V12 V13 V14  V17 V18 V24_  V22_ V21_  V52 V53 V55 V54 V56 
display r(sum_w)
global N = r(sum_w)
matrix r = r(R)
factormat r, n($N) mineigen(1)
rotate, horst blanks(.4)


polychoric V16 V15 V52 V23_
display r(sum_w)
global N = r(sum_w)
matrix r = r(R)
factormat r, n($N) mineigen(1)
rotate, horst blanks(.4)


polychoric V16 V15 V52 V23_
display r(sum_w)
global N = r(sum_w)
matrix r = r(R)
factormat r, n($N) mineigen(1)
rotate, horst blanks(.4)


foreach var in  V21 V22 V23 V24 {
gen _`var' = `var'
recode _`var' 1/3=0 4/5=1 6=0
}


sav $isspsport\s1.dta, replace

***work oriantations 
use $isspwork\ZA4350_v2-0-0.dta, clear
numlabel _all, add
tab COUNTRY
recode COUNTRY 3=2
tab1  V10  V29 V30 V31 V32 V33 V34  V38 V39 V41 V42 V43 V45 V51 V60 V62

gen _v10 = V10
gen _v29 = V29
gen _v30 = V30
gen _v31 = V31
gen _v32 = V32
gen _v33 = V33
gen _v34 = V34
gen _v38 = V38
gen _v39 = V39
gen _v41 = V41
gen _v42 = V42
gen _v43 = V43
gen _v45 = V45
gen _v51 = V51
gen _v59 = V59
gen _v60 = V60
gen _v62 = V62


recode _v10 1/2=1 3=. 4/5=0
recode _v29 1/2=1 3=. 4/5=0
recode _v30 1/2=1 3=. 4/5=0
recode _v31 1/2=1 3=. 4/5=0
recode _v32 1/2=1 3=. 4/5=0
recode _v33 1/2=1 3=. 4/5=0
recode _v34 1/2=1 3=. 4/5=0
recode _v38 1/2=1 3=. 4/5=0
recode _v39 1/2=1 3=. 4/5=0
recode _v41 1=0 2/3=1
recode _v42 1/2=1 3=0
recode _v43 1/2=1 3/4=0
recode _v45 1/2=1 3=. 4/5=0
recode _v51 1/3=1 4=. 5/7=0
recode _v59 1/2=1 3=. 4/5=0
recode _v60 1/2=1 3=. 4/5=0
recode _v62 1/2=1 3=. 4/5=0


polychoric V10  V29 V30 V31 V32 V33 V34  V38 V39 V41 V42 V43 V45 V51 V60 V62 
display r(sum_w)
global N = r(sum_w)
matrix r = r(R)
factormat r, n($N) mineigen(1)
rotate, horst blanks(.4)

polychoric V29 V30 V31 V32 V33 V51
display r(sum_w)
global N = r(sum_w)
matrix r = r(R)
factormat r, n($N) mineigen(1)
rotate, horst blanks(.4)
capture drop factor1  
predict factor1
rename factor1 f1

 
polychoric V33  V41 V42 V43
display r(sum_w)
global N = r(sum_w)
matrix r = r(R)
factormat r, n($N) mineigen(1)
rotate, horst blanks(.4)
capture drop factor1  
predict factor1 

rename factor1 factor2 
rename f1 factor1
sav $isspwork\w1.dta, replace





/*stage one country level analysis with World Bank data – 
 how differences between countries influence -  gender roles, work, leisure*/
 
*Creating aggragate and adding world bank data 

*gender 
use $isspgender\g1.dta, clear 
keep COUNTRY _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11  _v28 _v27 factor*
collapse (mean) _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11 _v28 _v27 factor*, by (COUNTRY) 
sav $isspgender\g2.dta, replace

use $isspgender\g1.dta, clear 
tab v200
drop if v200==2
tab v200
keep COUNTRY _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11  _v28 _v27 factor*
collapse (mean) _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11 _v28 _v27 factor*, by (COUNTRY)
sav $isspgender\g2m.dta, replace

use $isspgender\g1.dta, clear  
tab v200
drop if v200==1
tab v200
keep COUNTRY _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11  _v28 _v27 factor*
collapse (mean) _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11 _v28 _v27 factor*, by (COUNTRY)
sav $isspgender\g2f.dta, replace

import excel using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\worldbank_indicators.xlsx", firstrow clear 
sort COUNTRY
sav "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta" , replace 

use $isspgender\g2.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace 
drop if _merge ==2
drop _merge 
sav $isspgender\g3.dta, replace

use $isspgender\g2m.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspgender\g3m.dta, replace

use $isspgender\g2f.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspgender\g3f.dta, replace

***only those with degree 
use $isspgender\g1.dta, clear 
tab	v205
keep if v205==5
keep COUNTRY _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11  _v28 _v27 factor*
collapse (mean) _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11 _v28 _v27 factor*, by (COUNTRY) 
sav $isspgender\g2d.dta, replace

use $isspgender\g1.dta, clear 
tab v200
drop if v200==2
tab	v205
keep if v205==5
keep COUNTRY _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11  _v28 _v27 factor*
collapse (mean) _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11 _v28 _v27 factor*, by (COUNTRY)
sav $isspgender\g2md.dta, replace

use $isspgender\g1.dta, clear  
tab v200
drop if v200==1
tab v200
tab	v205
keep if v205==5
keep COUNTRY _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11  _v28 _v27 factor*
collapse (mean) _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11 _v28 _v27 factor*, by (COUNTRY)
sav $isspgender\g2fd.dta, replace

import excel using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\worldbank_indicators.xlsx", firstrow clear 
sort COUNTRY
sav "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta" , replace 

use $isspgender\g2d.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace 
drop if _merge ==2
drop _merge 
sav $isspgender\g3d.dta, replace

use $isspgender\g2md.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspgender\g3md.dta, replace

use $isspgender\g2fd.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspgender\g3fd.dta, replace

***only those with out degree 
use $isspgender\g1.dta, clear 
tab	v205
keep if v205 <5
keep COUNTRY _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11  _v28 _v27 factor*
collapse (mean) _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11 _v28 _v27 factor*, by (COUNTRY) 
sav $isspgender\g2nd.dta, replace

use $isspgender\g1.dta, clear 
tab v200
drop if v200==2
tab v200
tab	v205
keep if v205<5
keep COUNTRY _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11  _v28 _v27 factor*
collapse (mean) _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11 _v28 _v27 factor*, by (COUNTRY)
sav $isspgender\g2mnd.dta, replace

use $isspgender\g1.dta, clear  
tab v200
drop if v200==1
tab v200
tab	v205
keep if v205<5
keep COUNTRY _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11  _v28 _v27 factor*
collapse (mean) _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11 _v28 _v27 factor*, by (COUNTRY)
sav $isspgender\g2fnd.dta, replace

import excel using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\worldbank_indicators.xlsx", firstrow clear 
sort COUNTRY
sav "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta" , replace 

use $isspgender\g2nd.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace 
drop if _merge ==2
drop _merge 
sav $isspgender\g3nd.dta, replace

use $isspgender\g2mnd.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspgender\g3mnd.dta, replace

use $isspgender\g2fnd.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspgender\g3fnd.dta, replace

****only those under 35 

use $isspgender\g1.dta, clear
tab	v201
keep if v201<=35 
keep COUNTRY _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11  _v28 _v27 factor*
collapse (mean) _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11 _v28 _v27 factor* , by (COUNTRY) 
sav $isspgender\g2a1.dta, replace

use $isspgender\g1.dta, clear 
tab v200
drop if v200==2
tab v200
tab	v201
keep if v201<=35 
keep COUNTRY _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11  _v28 _v27 factor*
collapse (mean) _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11 _v28 _v27 factor*, by (COUNTRY)
sav $isspgender\g2ma1.dta, replace

use $isspgender\g1.dta, clear  
tab v200
drop if v200==1
tab v200
tab	v201
keep if v201<=35 
keep COUNTRY _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11  _v28 _v27 factor*
collapse (mean) _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11 _v28 _v27 factor*, by (COUNTRY)
sav $isspgender\g2fa1.dta, replace

import excel using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\worldbank_indicators.xlsx", firstrow clear 
sort COUNTRY
sav "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta" , replace 

use $isspgender\g2a1.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace 
drop if _merge ==2
drop _merge 
sav $isspgender\g3a1.dta, replace

use $isspgender\g2ma1.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspgender\g3ma1.dta, replace

use $isspgender\g2fa1.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspgender\g3fa1.dta, replace

****only those 35 to 55 

use $isspgender\g1.dta, clear 
tab	v201
keep if v201>=36
drop if v201 <=56
keep COUNTRY _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11  _v28 _v27 factor*
collapse (mean) _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11 _v28 _v27 factor*, by (COUNTRY) 
sav $isspgender\g2a2.dta, replace

use $isspgender\g1.dta, clear 
tab v200
drop if v200==2
tab v200
tab	v201
keep if v201>=36
drop if v201 <=56
keep COUNTRY _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11  _v28 _v27 factor*
collapse (mean) _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11 _v28 _v27 factor* , by (COUNTRY)
sav $isspgender\g2ma2.dta, replace

use $isspgender\g1.dta, clear  
tab v200
drop if v200==1
tab v200
tab	v201
keep if v201>=36
drop if v201 <=56
keep COUNTRY _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11  _v28 _v27 factor*
collapse (mean) _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11 _v28 _v27 factor* , by (COUNTRY)
sav $isspgender\g2fa2.dta, replace

import excel using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\worldbank_indicators.xlsx", firstrow clear 
sort COUNTRY
sav "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta" , replace 

use $isspgender\g2a2.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace 
drop if _merge ==2
drop _merge 
sav $isspgender\g3a2.dta, replace

use $isspgender\g2ma2.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspgender\g3ma2.dta, replace

use $isspgender\g2fa2.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspgender\g3fa2.dta, replace


*****only those 55+ 

use $isspgender\g1.dta, clear 
tab	v201
keep if v201>=56
keep COUNTRY _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11  _v28 _v27 factor*
collapse (mean) _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11 _v28 _v27 factor*, by (COUNTRY) 
sav $isspgender\g2a3.dta, replace

use $isspgender\g1.dta, clear 
tab v200
drop if v200==2
tab v200
tab	v201
keep if v201>=56
keep COUNTRY _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11  _v28 _v27 factor*
collapse (mean) _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11 _v28 _v27 factor*, by (COUNTRY)
sav $isspgender\g2ma3.dta, replace

use $isspgender\g1.dta, clear  
tab v200
drop if v200==1
tab v200
tab	v201
keep if v201>=56
keep COUNTRY _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11  _v28 _v27 factor*
collapse (mean) _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11 _v28 _v27 factor*, by (COUNTRY)
sav $isspgender\g2fa3.dta, replace

import excel using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\worldbank_indicators.xlsx", firstrow clear 
sort COUNTRY
sav "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta" , replace 

use $isspgender\g2a3.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace 
drop if _merge ==2
drop _merge 
sav $isspgender\g3a3.dta, replace

use $isspgender\g2ma3.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspgender\g3ma3.dta, replace

use $isspgender\g2fa3.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspgender\g3fa3.dta, replace




*work 
use $isspwork\w1.dta, clear 
keep COUNTRY  _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 factor*
collapse (mean) _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 factor* , by (COUNTRY) 
sav $isspwork\w2.dta, replace

use $isspwork\w1.dta, clear 
drop if SEX==2
keep COUNTRY  _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 factor*
collapse (mean) _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 factor*, by (COUNTRY) 
sav $isspwork\w2m.dta, replace

use $isspwork\w1.dta, clear 
drop if SEX==1
keep COUNTRY  _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 factor*
collapse (mean) _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 factor* , by (COUNTRY) 
sav $isspwork\w2f.dta, replace

import excel using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\worldbank_indicators.xlsx", firstrow clear 
sort COUNTRY
sav "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta" , replace 

use $isspwork\w2.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace 
drop if _merge ==2
drop _merge 
sav $isspwork\w3.dta, replace

use $isspwork\w2m.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspwork\w3m.dta, replace

use $isspwork\w2f.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspwork\w3f.dta, replace

*degree 
use $isspwork\w1.dta, clear 
tab DEGREE
keep if DEGREE ==5 
keep COUNTRY  _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 factor*
collapse (mean) _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 factor*, by (COUNTRY) 
sav $isspwork\w2d.dta, replace

use $isspwork\w1.dta, clear 
drop if SEX==2
tab DEGREE
keep if DEGREE ==5 
keep COUNTRY  _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 factor*
collapse (mean) _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 factor* , by (COUNTRY) 
sav $isspwork\w2md.dta, replace

use $isspwork\w1.dta, clear 
drop if SEX==1
tab DEGREE
keep if DEGREE ==5 
keep COUNTRY  _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 factor*
collapse (mean) _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 factor* , by (COUNTRY) 
sav $isspwork\w2fd.dta, replace

import excel using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\worldbank_indicators.xlsx", firstrow clear 
sort COUNTRY
sav "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta" , replace 

use $isspwork\w2d.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace 
drop if _merge ==2
drop _merge 
sav $isspwork\w3d.dta, replace

use $isspwork\w2md.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspwork\w3md.dta, replace

use $isspwork\w2fd.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspwork\w3fd.dta, replace
 
 *no degree 
 use $isspwork\w1.dta, clear 
tab DEGREE
keep if DEGREE ~=5 
keep COUNTRY  _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 factor*
collapse (mean) _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 factor* , by (COUNTRY) 
sav $isspwork\w2nd.dta, replace

use $isspwork\w1.dta, clear 
drop if SEX==2
tab DEGREE
keep if DEGREE ~=5 
keep COUNTRY  _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 factor*
collapse (mean) _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62  factor*, by (COUNTRY) 
sav $isspwork\w2mnd.dta, replace

use $isspwork\w1.dta, clear 
drop if SEX==1
tab DEGREE
keep if DEGREE ~=5 
keep COUNTRY  _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 factor*
collapse (mean) _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 factor* , by (COUNTRY) 
sav $isspwork\w2fnd.dta, replace

import excel using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\worldbank_indicators.xlsx", firstrow clear 
sort COUNTRY
sav "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta" , replace 

use $isspwork\w2nd.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace 
drop if _merge ==2
drop _merge 
sav $isspwork\w3nd.dta, replace

use $isspwork\w2mnd.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspwork\w3mnd.dta, replace

use $isspwork\w2fnd.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspwork\w3fnd.dta, replace
 
*age 35 or lower 

use $isspwork\w1.dta, clear 
tab AGE
keep if AGE <=35
keep COUNTRY  _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 factor*
collapse (mean) _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 factor*, by (COUNTRY) 
sav $isspwork\w2a1.dta, replace

use $isspwork\w1.dta, clear 
drop if SEX==2
tab AGE
keep if AGE <=35
keep COUNTRY  _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 factor*
collapse (mean) _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 factor* , by (COUNTRY) 
sav $isspwork\w2ma1.dta, replace

use $isspwork\w1.dta, clear 
drop if SEX==1
tab AGE
keep if AGE <=35
keep COUNTRY  _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 factor*
collapse (mean) _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 factor* , by (COUNTRY) 
sav $isspwork\w2fa1.dta, replace

import excel using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\worldbank_indicators.xlsx", firstrow clear 
sort COUNTRY
sav "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta" , replace 

use $isspwork\w2a1.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace 
drop if _merge ==2
drop _merge 
sav $isspwork\w3a1.dta, replace

use $isspwork\w2ma1.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspwork\w3ma1.dta, replace

use $isspwork\w2fa1.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspwork\w3fa1.dta, replace
 
 *age 36 - 55
 
 use $isspwork\w1.dta, clear 
tab AGE
keep if AGE >=36
drop if AGE >=56
keep COUNTRY  _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 factor*
collapse (mean) _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62  factor*, by (COUNTRY) 
sav $isspwork\w2a2.dta, replace

use $isspwork\w1.dta, clear 
drop if SEX==2
tab AGE
keep if AGE >=36
drop if AGE >=56
keep COUNTRY  _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 factor*
collapse (mean) _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 factor*, by (COUNTRY) 
sav $isspwork\w2ma2.dta, replace

use $isspwork\w1.dta, clear 
drop if SEX==1
tab AGE
keep if AGE >=36
drop if AGE >=56
keep COUNTRY  _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 factor*
collapse (mean) _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 factor* , by (COUNTRY) 
sav $isspwork\w2fa2.dta, replace

import excel using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\worldbank_indicators.xlsx", firstrow clear 
sort COUNTRY
sav "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta" , replace 

use $isspwork\w2a2.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace 
drop if _merge ==2
drop _merge 
sav $isspwork\w3a2.dta, replace

use $isspwork\w2ma2.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspwork\w3ma2.dta, replace

use $isspwork\w2fa2.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspwork\w3fa2.dta, replace
 
 * age 56 plus 
use $isspwork\w1.dta, clear 
tab AGE
keep if AGE >=56
keep COUNTRY  _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 factor*
collapse (mean) _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 factor* , by (COUNTRY) 
sav $isspwork\w2a3.dta, replace

use $isspwork\w1.dta, clear 
drop if SEX==2
tab AGE
keep if AGE >=56
keep COUNTRY  _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 factor*
collapse (mean) _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 factor* , by (COUNTRY) 
sav $isspwork\w2ma3.dta, replace

use $isspwork\w1.dta, clear 
drop if SEX==1
tab AGE
keep if AGE >=56
keep COUNTRY  _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 factor*
collapse (mean) _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62  factor*, by (COUNTRY) 
sav $isspwork\w2fa3.dta, replace

import excel using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\worldbank_indicators.xlsx", firstrow clear 
sort COUNTRY
sav "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta" , replace 

use $isspwork\w2a3.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace 
drop if _merge ==2
drop _merge 
sav $isspwork\w3a3.dta, replace

use $isspwork\w2ma2.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspwork\w3ma3.dta, replace

use $isspwork\w2fa3.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspwork\w3fa3.dta, replace
 

 */
 
  *sport 
use $isspsport\s1.dta, clear 
keep COUNTRY   _V21 _V22 _V23 _V24
collapse (mean) _V21 _V22 _V23 _V24 , by (COUNTRY) 
sav $isspsport\s2.dta, replace

use $isspsport\s1.dta, clear 
drop if sex==2
keep COUNTRY _V21 _V22 _V23 _V24
collapse (mean)_V21 _V22 _V23 _V24 , by (COUNTRY) 
sav $isspsport\s2m.dta, replace

use $isspsport\s1.dta, clear 
drop if sex==1
keep COUNTRY  _V21 _V22 _V23 _V24
collapse (mean)_V21 _V22 _V23 _V24 , by (COUNTRY) 
sav $isspsport\s2f.dta, replace

import excel using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\worldbank_indicators.xlsx", firstrow clear 
sort COUNTRY
sav "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta" , replace 

use $isspsport\s2.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace 
drop if _merge ==2
drop _merge 
sav $isspsport\s3.dta, replace

use $isspsport\s2m.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspsport\s3m.dta, replace

use $isspsport\s2f.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspsport\s3f.dta, replace



 *degree
 use $isspsport\s1.dta, clear 
tab degree
keep if degree ==5 
keep COUNTRY   _V21 _V22 _V23 _V24
collapse (mean) _V21 _V22 _V23 _V24 , by (COUNTRY) 
sav $isspsport\s2d.dta, replace

use $isspsport\s1.dta, clear 
drop if sex==2
keep if degree ==5 
keep COUNTRY _V21 _V22 _V23 _V24
collapse (mean)_V21 _V22 _V23 _V24 , by (COUNTRY) 
sav $isspsport\s2md.dta, replace

use $isspsport\s1.dta, clear 
drop if sex==1
keep if degree ==5 
keep COUNTRY  _V21 _V22 _V23 _V24
collapse (mean)_V21 _V22 _V23 _V24 , by (COUNTRY) 
sav $isspsport\s2fd.dta, replace

import excel using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\worldbank_indicators.xlsx", firstrow clear 
sort COUNTRY
sav "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta" , replace 

use $isspsport\s2d.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace 
drop if _merge ==2
drop _merge 
sav $isspsport\s3d.dta, replace

use $isspsport\s2md.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspsport\s3md.dta, replace

use $isspsport\s2fd.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspsport\s3fd.dta, replace

 * no degree 
use $isspsport\s1.dta, clear 
tab degree
drop if degree ==5 
keep COUNTRY   _V21 _V22 _V23 _V24
collapse (mean) _V21 _V22 _V23 _V24 , by (COUNTRY) 
sav $isspsport\s2nd.dta, replace

use $isspsport\s1.dta, clear 
drop if sex==2
drop  if degree ==5 
keep COUNTRY _V21 _V22 _V23 _V24
collapse (mean)_V21 _V22 _V23 _V24 , by (COUNTRY) 
sav $isspsport\s2mnd.dta, replace

use $isspsport\s1.dta, clear 
drop if sex==1
drop if degree ==5 
keep COUNTRY  _V21 _V22 _V23 _V24
collapse (mean)_V21 _V22 _V23 _V24 , by (COUNTRY) 
sav $isspsport\s2fnd.dta, replace

import excel using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\worldbank_indicators.xlsx", firstrow clear 
sort COUNTRY
sav "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta" , replace 

use $isspsport\s2nd.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace 
drop if _merge ==2
drop _merge 
sav $isspsport\s3nd.dta, replace

use $isspsport\s2mnd.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspsport\s3mnd.dta, replace

use $isspsport\s2fnd.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspsport\s3fnd.dta, replace


 * age 35 or less 
use $isspsport\s1.dta, clear 
tab age
drop if age >=36 
keep COUNTRY   _V21 _V22 _V23 _V24
collapse (mean) _V21 _V22 _V23 _V24 , by (COUNTRY) 
sav $isspsport\s2a1.dta, replace

use $isspsport\s1.dta, clear 
drop if sex==2
tab age
drop if age >=36 
keep COUNTRY _V21 _V22 _V23 _V24
collapse (mean)_V21 _V22 _V23 _V24 , by (COUNTRY) 
sav $isspsport\s2ma1.dta, replace

use $isspsport\s1.dta, clear 
drop if sex==1
tab age
drop if age >=36 
keep COUNTRY  _V21 _V22 _V23 _V24
collapse (mean)_V21 _V22 _V23 _V24 , by (COUNTRY) 
sav $isspsport\s2fa1.dta, replace

import excel using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\worldbank_indicators.xlsx", firstrow clear 
sort COUNTRY
sav "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta" , replace 

use $isspsport\s2a1.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace 
drop if _merge ==2
drop _merge 
sav $isspsport\s3a1.dta, replace

use $isspsport\s2ma1.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspsport\s3ma1.dta, replace

use $isspsport\s2fa1.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspsport\s3fa1.dta, replace
 
 
*age 36 to 55 
use $isspsport\s1.dta, clear 
tab age
keep if age >=36
drop if age >=56
keep COUNTRY   _V21 _V22 _V23 _V24
collapse (mean) _V21 _V22 _V23 _V24 , by (COUNTRY) 
sav $isspsport\s2a2.dta, replace

use $isspsport\s1.dta, clear 
drop if sex==2
tab age
keep if age >=36
drop if age >=56
keep COUNTRY _V21 _V22 _V23 _V24
collapse (mean)_V21 _V22 _V23 _V24 , by (COUNTRY) 
sav $isspsport\s2ma2.dta, replace

use $isspsport\s1.dta, clear 
drop if sex==1
tab age
keep if age >=36
drop if age >=56
keep COUNTRY  _V21 _V22 _V23 _V24
collapse (mean)_V21 _V22 _V23 _V24 , by (COUNTRY) 
sav $isspsport\s2fa2.dta, replace

import excel using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\worldbank_indicators.xlsx", firstrow clear 
sort COUNTRY
sav "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta" , replace 

use $isspsport\s2a2.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace 
drop if _merge ==2
drop _merge 
sav $isspsport\s3a2.dta, replace

use $isspsport\s2ma2.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspsport\s3ma2.dta, replace

use $isspsport\s2fa2.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspsport\s3fa2.dta, replace


*age 56 plus  
use $isspsport\s1.dta, clear 
tab age
drop if age <=55
keep COUNTRY   _V21 _V22 _V23 _V24
collapse (mean) _V21 _V22 _V23 _V24 , by (COUNTRY) 
sav $isspsport\s2a3.dta, replace

use $isspsport\s1.dta, clear 
drop if sex==2
tab age
drop if age <=55
keep COUNTRY _V21 _V22 _V23 _V24
collapse (mean)_V21 _V22 _V23 _V24 , by (COUNTRY) 
sav $isspsport\s2ma3.dta, replace

use $isspsport\s1.dta, clear 
drop if sex==1
tab age
drop if age <=55
keep COUNTRY  _V21 _V22 _V23 _V24
collapse (mean)_V21 _V22 _V23 _V24 , by (COUNTRY) 
sav $isspsport\s2fa3.dta, replace

import excel using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\worldbank_indicators.xlsx", firstrow clear 
sort COUNTRY
sav "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta" , replace 

use $isspsport\s2a3.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace 
drop if _merge ==2
drop _merge 
sav $isspsport\s3a3.dta, replace

use $isspsport\s2ma3.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspsport\s3ma3.dta, replace

use $isspsport\s2fa3.dta, clear 
sort COUNTRY
merge COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace
drop if _merge ==2
drop _merge  
sav $isspsport\s3fa3.dta, replace
