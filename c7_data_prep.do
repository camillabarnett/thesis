*********Chapter 6 
global isspsport  "H:\thesis_analysis\data\secondary_data\issp\sport_leisure"

global isspgender "H:\thesis_analysis\data\secondary_data\issp\gender_inequality"

global isspwork  "H:\thesis_analysis\data\secondary_data\issp\work"

global output "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational"



***************************************************************************************************
***family and gender
***************************************************************************************************
use $isspgender\ZA3880_v1-1-0.dta, clear
numlabel _all, add

*****************
***dummy varaibles 
*******************
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




sav $isspgender\g1.dta, replace

******************************
***********aggragate file 
******************************
use $isspgender\g1.dta, clear 
keep COUNTRY _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11  _v28 _v27 
collapse (mean) _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11 _v28 _v27 , by (COUNTRY) 
sav $isspgender\g2.dta, replace

use $isspgender\g1.dta, clear 
tab v200
drop if v200==2
tab v200
keep COUNTRY _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11  _v28 _v27 
collapse (mean) _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11 _v28 _v27 , by (COUNTRY)
sav $isspgender\g2m.dta, replace

use $isspgender\g1.dta, clear  
tab v200
drop if v200==1
tab v200
keep COUNTRY _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11  _v28 _v27 
collapse (mean) _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11 _v28 _v27 , by (COUNTRY)
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

****************************
***creating multi level file 
****************************
do H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\gselectedmicrodatamanagement.do
use $isspgender\g4.dta, clear
sort COUNTRY
drop _merge
merge m:1 COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
drop _merge
destring, replace 

sav $isspgender\g5.dta, replace






*************************************************************************************************** 
***sport and leisure 
***************************************************************************************************
use $isspsport\ZA4850_v2-0-0.dta, clear
numlabel _all, add
*****************
***dummy varaibles 
*******************

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
710	=	4





tab1 V6 V7 V8 V9 V10 V11 V12 V13 V14 V15 V16 V17 V18 V19 V20 V21 V22 V23 V24  V38 V39  V52 V53 V54 V55 V56

foreach var in  V21 V22 V23 V24 {
gen _`var' = `var'
recode _`var' 1/3=0 4/5=1 6=0
}


sav $isspsport\s1.dta, replace


******************************
***********aggragate file 
******************************
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


****************************
***creating multi level file 
****************************
do H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\sselectedmicrodatamanagement.do
use $isspsport\s4.dta, clear
sort COUNTRY
merge m:1 COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
drop _merge
destring, replace 

sav $isspsport\s5.dta, replace






***************************************************************************************************
***work oriantations 
***************************************************************************************************
use $isspwork\ZA4350_v2-0-0.dta, clear
numlabel _all, add


*****************
***dummy varaibles 
*******************
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





sav $isspwork\w1.dta, replace

******************************
***********aggragate file 
******************************
  
use $isspwork\w1.dta, clear 
keep COUNTRY  _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62
collapse (mean) _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 , by (COUNTRY) 
sav $isspwork\w2.dta, replace

use $isspwork\w1.dta, clear 
drop if SEX==2
keep COUNTRY  _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62
collapse (mean) _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 , by (COUNTRY) 
sav $isspwork\w2m.dta, replace

use $isspwork\w1.dta, clear 
drop if SEX==1
keep COUNTRY  _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62
collapse (mean) _v10  _v29 _v30 _v31 _v32 _v33 _v34  _v38 _v39 _v41 _v42 _v43 _v45 _v51 _v60 _v62 , by (COUNTRY) 
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

****************************
***creating multi level file 
****************************
do H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wselectedmicrodatamanagement.do
use $isspwork\w4.dta, clear
sort COUNTRY
merge m:1 COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
drop _merge
destring, replace 

sav $isspwork\w5.dta, replace
/

*/*checking signficance 
reg _v4 wb_lab2 
reg _v4 wb_seats
reg _v4 wb_manage
reg _v4 wb_proftech
reg _v4 wb_matpay
reg _v4 wb_pteach
reg _v4 wb_steach
reg _v4 wb_edwork

*graphing best fit solid if significant 
twoway lfit _v4 wb_lab2, lpattern(solid)  ///
|| lfit _v4 wb_seats, lpattern(shortdash) ///
|| lfit _v4 wb_manage, lpattern(shortdash) /// 
|| lfit _v4 wb_proftech, lpattern(shortdash) ///
|| lfit _v4 wb_matpay, lpattern(shortdash) ///
|| lfit _v4 wb_pteach, lpattern(shortdash) ///
|| lfit _v4 wb_steach, lpattern(shortdash)  ///
|| lfit _v4 wb_edwork, lpattern(shortdash) ///
 title("A working mother can establish" "just as warm and secure a relationship" "with her children as a mother" "who does not work", size(vsmall)) legend( off ) 
graph save _v4

*checking signficance 
reg _v5 wb_lab2 
reg _v5 wb_seats
reg _v5 wb_manage
reg _v5 wb_proftech
reg _v5 wb_matpay
reg _v5 wb_pteach
reg _v5 wb_steach
reg _v5 wb_edwork

*graphing best fit solid if significant 
twoway lfit _v5 wb_lab2, lpattern(solid)  ///
|| lfit _v5 wb_seats, lpattern(solid) ///
|| lfit _v5 wb_manage, lpattern(solid) /// 
|| lfit _v5 wb_proftech, lpattern(shortdash) ///
|| lfit _v5 wb_matpay, lpattern(solid) ///
|| lfit _v5 wb_pteach, lpattern(solid) ///
|| lfit _v5 wb_steach, lpattern(solid)  ///
|| lfit _v5 wb_edwork, lpattern(shortdash) ///
title("A pre-school child is likely to suffer" "if his or her mother works", size(vsmall)) legend( off ) 
graph save _v5

*checking signficance 
reg _v6 wb_lab2 
reg _v6 wb_seats
reg _v6 wb_manage
reg _v6 wb_proftech
reg _v6 wb_matpay
reg _v6 wb_pteach
reg _v6 wb_steach
reg _v6 wb_edwork

*graphing best fit solid if significant 
twoway lfit _v6 wb_lab2, lpattern(solid)  ///
|| lfit _v6 wb_seats, lpattern(solid) ///
|| lfit _v6 wb_manage, lpattern(shortdash) /// 
|| lfit _v6 wb_proftech, lpattern(shortdash) ///
|| lfit _v6 wb_matpay, lpattern(shortdash) ///
|| lfit _v6 wb_pteach, lpattern(shortdash) ///
|| lfit _v6 wb_steach, lpattern(shortdash)  ///
|| lfit _v6 wb_edwork, lpattern(shortdash) ///
title("All in all family life suffers when" "the woman has a full-time job", size(vsmall)) legend( off ) 
 
graph save _v6
 
*checking signficance 
reg _v7 wb_lab2 
reg _v7 wb_seats
reg _v7 wb_manage
reg _v7 wb_proftech
reg _v7 wb_matpay
reg _v7 wb_pteach
reg _v7 wb_steach
reg _v7 wb_edwork

*graphing best fit solid if significant 
twoway lfit _v7 wb_lab2, lpattern(solid)  ///
|| lfit _v7 wb_seats, lpattern(solid) ///
|| lfit _v7 wb_manage, lpattern(shortdash) /// 
|| lfit _v7 wb_proftech, lpattern(solid) ///
|| lfit _v7 wb_matpay, lpattern(shortdash) ///
|| lfit _v7 wb_pteach, lpattern(shortdash) ///
|| lfit _v7 wb_steach, lpattern(solid)  ///
|| lfit _v7 wb_edwork, lpattern(shortdash) ///
title("A job is all right but what most women" "really want is a home and children", size(vsmall)) legend( off ) 
graph save _v7 
 
**checking signficance 
reg _v8 wb_lab2 
reg _v8 wb_seats
reg _v8 wb_manage
reg _v8 wb_proftech
reg _v8 wb_matpay
reg _v8 wb_pteach
reg _v8 wb_steach
reg _v8 wb_edwork

*graphing best fit solid if significant 
twoway lfit _v8 wb_lab2, lpattern(shortdash)  ///
|| lfit _v8 wb_seats, lpattern(solid) ///
|| lfit _v8 wb_manage, lpattern(shortdash) /// 
|| lfit _v8 wb_proftech, lpattern(shortdash) ///
|| lfit _v8 wb_matpay, lpattern(shortdash) ///
|| lfit _v8 wb_pteach, lpattern(shortdash) ///
|| lfit _v8 wb_steach, lpattern(shortdash)  ///
|| lfit _v8 wb_edwork, lpattern(shortdash) ///
title("Being a housewife is just as" "fulfilling as working for pay", size(vsmall)) legend( off ) 
graph save _v8 
 
 *checking signficance 
reg _v9 wb_lab2 
reg _v9 wb_seats
reg _v9 wb_manage
reg _v9 wb_proftech
reg _v9 wb_matpay
reg _v9 wb_pteach
reg _v9 wb_steach
reg _v9 wb_edwork

*graphing best fit solid if significant 
twoway lfit _v9 wb_lab2, lpattern(shortdash)  ///
|| lfit _v9 wb_seats, lpattern(shortdash) ///
|| lfit _v9 wb_manage, lpattern(shortdash) /// 
|| lfit _v9 wb_proftech, lpattern(shortdash) ///
|| lfit _v9 wb_matpay, lpattern(shortdash) ///
|| lfit _v9 wb_pteach, lpattern(shortdash) ///
|| lfit _v9 wb_steach, lpattern(shortdash)  ///
|| lfit _v9 wb_edwork, lpattern(shortdash) ///
title("Having a job is the best way for a" "woman to be an independent person" , size(vsmall)) legend( off ) 
graph save _v9 
 
*checking signficance 
reg _v10 wb_lab2 
reg _v10 wb_seats
reg _v10 wb_manage
reg _v10 wb_proftech
reg _v10 wb_matpay
reg _v10 wb_pteach
reg _v10 wb_steach
reg _v10 wb_edwork

*graphing best fit solid if significant 
twoway lfit _v10 wb_lab2, lpattern(shortdash)  ///
|| lfit _v10 wb_seats, lpattern(shortdash) ///
|| lfit _v10 wb_manage, lpattern(shortdash) /// 
|| lfit _v10 wb_proftech, lpattern(shortdash) ///
|| lfit _v10 wb_matpay, lpattern(shortdash) ///
|| lfit _v10 wb_pteach, lpattern(shortdash) ///
|| lfit _v10 wb_steach, lpattern(solid)  ///
|| lfit _v10 wb_edwork, lpattern(shortdash) ///
title("Both the man and woman should" "contribute to the household income", size(vsmall)) legend( off )

graph save _v10

*checking signficance 
reg _v11 wb_lab2 
reg _v11 wb_seats
reg _v11 wb_manage
reg _v11 wb_proftech
reg _v11 wb_matpay
reg _v11 wb_pteach
reg _v11 wb_steach
reg _v11 wb_edwork

*graphing best fit solid if significant 
twoway lfit _v11 wb_lab2, lpattern(soild)  ///
|| lfit _v11 wb_seats, lpattern(soild) ///
|| lfit _v11 wb_manage, lpattern(soild) /// 
|| lfit _v11 wb_proftech, lpattern(soild) ///
|| lfit _v11 wb_matpay, lpattern(shortdash) ///
|| lfit _v11 wb_pteach, lpattern(soild) ///
|| lfit _v11 wb_steach, lpattern(solid)  ///
|| lfit _v11 wb_edwork, lpattern(shortdash) ///
title("A man's job is to earn money;" "a woman's job is to look after" "the home and family", size(vsmall)) legend( off ) 
graph save _v11
 
 *checking signficance 
reg _v27 wb_lab2 
reg _v27 wb_seats
reg _v27 wb_manage
reg _v27 wb_proftech
reg _v27 wb_matpay
reg _v27 wb_pteach
reg _v27 wb_steach
reg _v27 wb_edwork

*graphing best fit solid if significant 
twoway lfit _v27 wb_lab2, lpattern(shortdash)  ///
|| lfit _v27 wb_seats, lpattern(shortdash) ///
|| lfit _v27 wb_manage, lpattern(shortdash) /// 
|| lfit _v27 wb_proftech, lpattern(shortdash) ///
|| lfit _v27 wb_matpay, lpattern(shortdash) ///
|| lfit _v27 wb_pteach, lpattern(shortdash) ///
|| lfit _v27 wb_steach, lpattern(soild)  ///
|| lfit _v27 wb_edwork, lpattern(shortdash) ///
title("Working women should receive paid" "maternity leave when they have a baby", size(vsmall)) legend( off ) 

graph save _v27
 
 *checking signficance 
reg _v28 wb_lab2 
reg _v28 wb_seats
reg _v28 wb_manage
reg _v28 wb_proftech
reg _v28 wb_matpay
reg _v28 wb_pteach
reg _v28 wb_steach
reg _v28 wb_edwork

*graphing best fit solid if significant 
twoway lfit _v28 wb_lab2, lpattern(soild)  ///
|| lfit _v28 wb_seats, lpattern(soild) ///
|| lfit _v28 wb_manage, lpattern(shortdash) /// 
|| lfit _v28 wb_proftech, lpattern(shortdash) ///
|| lfit _v28 wb_matpay, lpattern(shortdash) ///
|| lfit _v28 wb_pteach, lpattern(shortdash) ///
|| lfit _v28 wb_steach, lpattern(soild)  ///
|| lfit _v28 wb_edwork, lpattern(shortdash) ///
title("Families should receive financial benefits" "for child care when both parents work", size(vsmall)) legend( off ) 


graph save _v28
      
	  
*******combining grpahs 
*findit grc1leg2

graph drop _all


graph use _v4.gph, name(_v4)
graph use _v5.gph, name(_v5)
graph use _v6.gph, name(_v6)
graph use _v7.gph, name(_v7)
graph use _v8.gph, name(_v8)
graph use _v9.gph, name(_v9)
graph use _v10.gph, name(_v10)
graph use _v11.gph, name(_v11)
graph use _v27.gph, name(_v27)
graph use _v28.gph, name(_v28)

grc1leg2 v4 v5 v6 v7 v8 v9 v10 v11 v27 v28, ycommon xcommon  legendfrom(v9) cols (3) 
	  
graph combine _v4 _v5 _v6 _v7 _v8 _v9 _v10 _v11 _v27 _v28, ycommon xcommon
	  
	  
 
*selection for inclusion in main text 
graph combine  _v5 _v6 _v7    , ycommon xcommon  \


*work 


 *checking signficance 
reg _v10 wb_lab2 
reg _v10 wb_seats 
reg _v10 wb_manage 
reg _v10 wb_proftech 
reg _v10 wb_matpay 
reg _v10 wb_pteach 
reg _v10 wb_steach 
reg _v10 wb_edwork 

*graphing best fit solid if significant 
twoway lfit _v10 wb_lab2,  lpattern(shortdash)  ///
|| lfit _v10 wb_seats, lpattern(shortdash) ///
|| lfit _v10 wb_manage, lpattern(shortdash) /// 
|| lfit _v10 wb_proftech,  ///
|| lfit _v10 wb_matpay, lpattern(shortdash) ///
|| lfit _v10 wb_pteach, lpattern(shortdash) ///
|| lfit _v10 wb_steach, lpattern(shortdash)  ///
|| lfit _v10 wb_edwork, lpattern(shortdash) ///
 title("Enjoy a paid job even if" "I did not need money", size(vsmall)) legend( off ) 
graph save _wv10

 
 *checking signficance 
reg _v29 wb_lab2 
reg _v29 wb_seats 
reg _v29 wb_manage 
reg _v29 wb_proftech 
reg _v29 wb_matpay 
reg _v29 wb_pteach 
reg _v29 wb_steach 
reg _v29 wb_edwork 

*graphing best fit solid if significant 
twoway lfit _v29 wb_lab2,  lpattern(shortdash)  ///
|| lfit _v29  wb_seats, lpattern(shortdash) ///
|| lfit _v29  wb_manage, lpattern(shortdash) /// 
|| lfit _v29  wb_proftech, lpattern(shortdash)  ///
|| lfit _v29  wb_matpay, lpattern(shortdash) ///
|| lfit _v29  wb_pteach, lpattern(shortdash) ///
|| lfit _v29  wb_steach, lpattern(shortdash)  ///
|| lfit _v29  wb_edwork, lpattern(shortdash) ///
 title("My job is secure", size(vsmall)) legend( off ) 
graph save _wv29
 
*checking signficance 
reg _v30 wb_lab2 
reg _v30 wb_seats 
reg _v30 wb_manage 
reg _v30 wb_proftech 
reg _v30 wb_matpay 
reg _v30 wb_pteach 
reg _v30 wb_steach 
reg _v30 wb_edwork 

*graphing best fit solid if significant 
twoway lfit _v30 wb_lab2,  lpattern(shortdash)  ///
|| lfit _v30  wb_seats, lpattern(shortdash) ///
|| lfit _v30  wb_manage, lpattern(shortdash) /// 
|| lfit _v30  wb_proftech, lpattern(shortdash)  ///
|| lfit _v30  wb_matpay, lpattern(shortdash) ///
|| lfit _v30  wb_pteach, lpattern(shortdash) ///
|| lfit _v30  wb_steach, lpattern(shortdash)  ///
|| lfit _v30  wb_edwork, lpattern(shortdash) ///
 title("My income is high", size(vsmall)) legend( off ) 
graph save _wv30
 
*checking signficance 
reg _v31 wb_lab2 
reg _v31 wb_seats 
reg _v31 wb_manage 
reg _v31 wb_proftech 
reg _v31 wb_matpay 
reg _v31 wb_pteach 
reg _v31 wb_steach 
reg _v31 wb_edwork 

*graphing best fit solid if significant 
twoway lfit _v31 wb_lab2,  lpattern(shortdash)  ///
|| lfit _v31  wb_seats, lpattern(shortdash) ///
|| lfit _v31  wb_manage, lpattern(shortdash) /// 
|| lfit _v31  wb_proftech, lpattern(shortdash)  ///
|| lfit _v31  wb_matpay, lpattern(shortdash) ///
|| lfit _v31  wb_pteach, lpattern(shortdash) ///
|| lfit _v31  wb_steach, lpattern(shortdash)  ///
|| lfit _v31  wb_edwork, lpattern(shortdash) ///
 title("My opportunities for" "advancement are high", size(vsmall)) legend( off ) 
graph save _wv31 
 
 *checking signficance 
reg _v32 wb_lab2 
reg _v32 wb_seats 
reg _v32 wb_manage 
reg _v32 wb_proftech 
reg _v32 wb_matpay 
reg _v32 wb_pteach 
reg _v32 wb_steach 
reg _v32 wb_edwork 

*graphing best fit solid if significant 
twoway lfit _v32 wb_lab2,  ///
|| lfit _v32  wb_seats, ///
|| lfit _v32  wb_manage, lpattern(shortdash) /// 
|| lfit _v32  wb_proftech, lpattern(shortdash)  ///
|| lfit _v32  wb_matpay, lpattern(shortdash) ///
|| lfit _v32  wb_pteach, lpattern(shortdash) ///
|| lfit _v32  wb_steach, lpattern(shortdash)  ///
|| lfit _v32  wb_edwork, lpattern(shortdash) ///
 title("My job is interesting", size(vsmall)) legend( off ) 
graph save _wv32 
 
 *checking signficance 
reg _v33 wb_lab2 
reg _v33 wb_seats 
reg _v33 wb_manage 
reg _v33 wb_proftech 
reg _v33 wb_matpay 
reg _v33 wb_pteach 
reg _v33 wb_steach 
reg _v33 wb_edwork 

*graphing best fit solid if significant 
twoway lfit _v33 wb_lab2,  ///
|| lfit _v33  wb_seats,  ///
|| lfit _v33  wb_manage, lpattern(shortdash) /// 
|| lfit _v33  wb_proftech, lpattern(shortdash)  ///
|| lfit _v33  wb_matpay, lpattern(shortdash) ///
|| lfit _v33  wb_pteach, lpattern(shortdash) ///
|| lfit _v33  wb_steach, lpattern(shortdash)  ///
|| lfit _v33  wb_edwork, lpattern(shortdash) ///
 title("I can work independently", size(vsmall)) legend( off ) 
graph save _wv33  

*checking signficance 
reg _v34 wb_lab2 
reg _v34 wb_seats 
reg _v34 wb_manage 
reg _v34 wb_proftech 
reg _v34 wb_matpay 
reg _v34 wb_pteach 
reg _v34 wb_steach 
reg _v34 wb_edwork 

*graphing best fit solid if significant 
twoway lfit _v34 wb_lab2,  ///
|| lfit _v34  wb_seats, lpattern(shortdash)  ///
|| lfit _v34  wb_manage,  /// 
|| lfit _v34  wb_proftech, lpattern(shortdash)  ///
|| lfit _v34  wb_matpay, lpattern(shortdash) ///
|| lfit _v34  wb_pteach, lpattern(shortdash) ///
|| lfit _v34  wb_steach, lpattern(shortdash)  ///
|| lfit _v34  wb_edwork, lpattern(shortdash) ///
 title("In my job I can help" "other people", size(vsmall)) legend( off ) 
graph save _wv34  

*checking signficance 
reg _v60 wb_lab2 
reg _v60 wb_seats 
reg _v60 wb_manage 
reg _v60 wb_proftech 
reg _v60 wb_matpay 
reg _v60 wb_pteach 
reg _v60 wb_steach 
reg _v60 wb_edwork 

*graphing best fit solid if significant 
twoway lfit _v60 wb_lab2,  ///
|| lfit _v60  wb_seats, lpattern(shortdash)  ///
|| lfit _v60  wb_manage, lpattern(shortdash) /// 
|| lfit _v60  wb_proftech, lpattern(shortdash)  ///
|| lfit _v60  wb_matpay, lpattern(shortdash) ///
|| lfit _v60  wb_pteach, lpattern(shortdash) ///
|| lfit _v60  wb_steach, lpattern(shortdash)  ///
|| lfit _v60  wb_edwork, lpattern(shortdash) ///
 title("In order to avoid unemployment" "I would be willing to accept a" "position with lower pay", size(vsmall)) legend( off ) 
graph save _wv60 
 
*checking signficance 
reg _v62 wb_lab2 
reg _v62 wb_seats 
reg _v62 wb_manage 
reg _v62 wb_proftech 
reg _v62 wb_matpay 
reg _v62 wb_pteach 
reg _v62 wb_steach 
reg _v62 wb_edwork 

*graphing best fit solid if significant 
twoway lfit _v62 wb_lab2,  ///
|| lfit _v62  wb_seats,  ///
|| lfit _v62  wb_manage, lpattern(shortdash) /// 
|| lfit _v62  wb_proftech, lpattern(shortdash)  ///
|| lfit _v62  wb_matpay, lpattern(shortdash) ///
|| lfit _v62  wb_pteach, lpattern(shortdash) ///
|| lfit _v62  wb_steach, lpattern(shortdash)  ///
|| lfit _v62  wb_edwork, lpattern(shortdash) ///
 title("In order to avoid unemployment" "I would be willing to travel" "longer to get to work", size(vsmall)) legend( off ) 
graph save _wv62 

*checking signficance 
reg _v38 wb_lab2 
reg _v38 wb_seats 
reg _v38 wb_manage 
reg _v38 wb_proftech 
reg _v38 wb_matpay 
reg _v38 wb_pteach 
reg _v38 wb_steach 
reg _v38 wb_edwork 

*graphing best fit solid if significant 
twoway lfit _v38 wb_lab2, lpattern(shortdash) ///
|| lfit _v38  wb_seats, lpattern(shortdash)  ///
|| lfit _v38  wb_manage, lpattern(shortdash) /// 
|| lfit _v38  wb_proftech, lpattern(shortdash)   ///
|| lfit _v38  wb_matpay, lpattern(shortdash) ///
|| lfit _v38  wb_pteach, lpattern(shortdash) ///
|| lfit _v38  wb_steach, lpattern(shortdash)  ///
|| lfit _v38  wb_edwork, lpattern(shortdash) ///
 title("I have to do hard physical work", size(vsmall)) legend( off ) 
graph save _wv38 

*checking signficance 
reg _v39 wb_lab2 
reg _v39 wb_seats 
reg _v39 wb_manage 
reg _v39 wb_proftech 
reg _v39 wb_matpay 
reg _v39 wb_pteach 
reg _v39 wb_steach 
reg _v39 wb_edwork 

*graphing best fit solid if significant 
twoway lfit _v39 wb_lab2, ///
|| lfit _v39  wb_seats, lpattern(shortdash)  ///
|| lfit _v39  wb_manage, lpattern(shortdash) /// 
|| lfit _v39  wb_proftech, lpattern(shortdash)  ///
|| lfit _v39  wb_matpay, lpattern(shortdash) ///
|| lfit _v39  wb_pteach, lpattern(shortdash) ///
|| lfit _v39  wb_steach, lpattern(shortdash)  ///
|| lfit _v39  wb_edwork, lpattern(shortdash) ///
 title("I find my work stressful", size(vsmall)) legend( off ) 
graph save _wv39 

*checking signficance 
reg _v45 wb_lab2 
est s
reg _v45 wb_seats 
reg _v45 wb_manage 
reg _v45 wb_proftech 
reg _v45 wb_matpay 
reg _v45 wb_pteach 
reg _v45 wb_steach 
reg _v45 wb_edwork 

*graphing best fit solid if significant 
twoway lfit _v45 wb_lab2,lpattern(shortdash)  ///
|| lfit _v45  wb_seats, lpattern(shortdash)  ///
|| lfit _v45  wb_manage, lpattern(shortdash) /// 
|| lfit _v45  wb_proftech, lpattern(shortdash)  ///
|| lfit _v45  wb_matpay, lpattern(shortdash) ///
|| lfit _v45  wb_pteach, lpattern(shortdash) ///
|| lfit _v45  wb_steach, lpattern(shortdash)  ///
|| lfit _v45  wb_edwork, lpattern(shortdash) ///
 title("My Family life interferes with job", size(vsmall)) legend( off ) 
graph save _wv45 

*checking signficance 
reg _v41 wb_lab2 
reg _v41 wb_seats 
reg _v41 wb_manage 
reg _v41 wb_proftech 
reg _v41 wb_matpay 
reg _v41 wb_pteach 
reg _v41 wb_steach 
reg _v41 wb_edwork 

*graphing best fit solid if significant 
twoway lfit _v41 wb_lab2,  lpattern(shortdash) ///
|| lfit _v41  wb_seats,   ///
|| lfit _v41  wb_manage, lpattern(shortdash) /// 
|| lfit _v41  wb_proftech,  ///
|| lfit _v41  wb_matpay, lpattern(shortdash) ///
|| lfit _v41  wb_pteach, ///
|| lfit _v41  wb_steach,  ///
|| lfit _v41  wb_edwork, lpattern(shortdash) ///
 title("I have some control over the" "time I start and finish work", size(vsmall)) legend( off ) 
graph save _wv41

*checking signficance 
reg _v42 wb_lab2 
reg _v42 wb_seats 
reg _v42 wb_manage 
reg _v42 wb_proftech 
reg _v42 wb_matpay 
reg _v42 wb_pteach 
reg _v42 wb_steach 
reg _v42 wb_edwork 

*graphing best fit solid if significant 
twoway lfit _v42 wb_lab2,  lpattern(shortdash) ///
|| lfit _v42  wb_seats, lpattern(shortdash)  ///
|| lfit _v42  wb_manage, lpattern(shortdash) /// 
|| lfit _v42  wb_proftech,  ///
|| lfit _v42  wb_matpay, lpattern(shortdash) ///
|| lfit _v42  wb_pteach, lpattern(shortdash) ///
|| lfit _v42  wb_steach, lpattern(shortdash)  ///
|| lfit _v42  wb_edwork, lpattern(shortdash) ///
 title("I have some control over how " "my daily work is organized", size(vsmall)) legend( off ) 
graph save _wv42

*checking signficance 
reg _v43 wb_lab2 
reg _v43 wb_seats 
reg _v43 wb_manage 
reg _v43 wb_proftech 
reg _v43 wb_matpay 
reg _v43 wb_pteach 
reg _v43 wb_steach 
reg _v43 wb_edwork 

*graphing best fit solid if significant 
twoway lfit _v43 wb_lab2,  ///
|| lfit _v43 wb_seats, lpattern(shortdash)  ///
|| lfit _v43  wb_manage, lpattern(shortdash) /// 
|| lfit _v43  wb_proftech, lpattern(shortdash) ///
|| lfit _v43  wb_matpay, lpattern(shortdash) ///
|| lfit _v43  wb_pteach, lpattern(shortdash) ///
|| lfit _v43  wb_steach,  ///
|| lfit _v43  wb_edwork, lpattern(shortdash) ///
 title("It is not difficult to take time" "off during working hrs", size(vsmall)) legend( off ) 
graph save _wv43


*checking signficance 
reg _v51 wb_lab2 
reg _v51 wb_seats 
reg _v51 wb_manage 
reg _v51 wb_proftech 
reg _v51 wb_matpay 
reg _v51 wb_pteach 
reg _v51 wb_steach 
reg _v51 wb_edwork 

*graphing best fit solid if significant 
twoway lfit _v51 wb_lab2, lpattern(shortdash)  ///
|| lfit _v51 wb_seats, lpattern(shortdash)  ///
|| lfit _v51  wb_manage, lpattern(shortdash) /// 
|| lfit _v51  wb_proftech, lpattern(shortdash) ///
|| lfit _v51  wb_matpay, lpattern(shortdash) ///
|| lfit _v51  wb_pteach, lpattern(shortdash) ///
|| lfit _v51  wb_steach, lpattern(shortdash)  ///
|| lfit _v51  wb_edwork, lpattern(shortdash)  ///
 title("I am satisfied in my job", size(vsmall)) legend( off ) 
graph save _wv51

*******combining graphs 
*findit grc1leg2

graph drop _all

graph use _wv10.gph, name(_wv10)
graph use _wv29.gph, name(_wv29)
graph use _wv30.gph, name(_wv30)
graph use _wv31.gph, name(_wv31)
graph use _wv32.gph, name(_wv32)
graph use _wv33.gph, name(_wv33)
graph use _wv34.gph, name(_wv34)
graph use _wv60.gph, name(_wv60)
graph use _wv62.gph, name(_wv62)
graph use _wv38.gph, name(_wv38)
graph use _wv39.gph, name(_wv39)
graph use _wv45.gph, name(_wv45)
graph use _wv41.gph, name(_wv41)
graph use _wv42.gph, name(_wv42)
graph use _wv43.gph, name(_wv43)
graph use _wv51.gph, name(_wv51)
  
graph combine _wv10 _wv29 _wv30 _wv31 _wv32 _wv33 _wv34 _wv60 _wv62 _wv38 _wv39 _wv45 _wv41 _wv42 _wv43 _wv51 , ycommon xcommon col(5)
*/
 
 
 



 
 