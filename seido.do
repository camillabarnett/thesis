****Chapter 5 
global bhps "H:\thesis_analysis\data\secondary_data\bhps\"
global data "H:\thesis_analysis\data\my_data\measures_3\sei\"


*merging waves of bhps 
 
foreach wav in k l m n o p q r  { 
  use pid `wav'fimnl `wav'basrate `wav'basrest `wav'sex `wav'jbsoc00 `wav'qfedhi `wav'age `wav'casmin `wav'doby `wav'paygu `wav'paygl `wav'jbhrs `wav'jssize `wav'payuw `wav'jbsemp `wav'jbmngr `wav'jbsize `wav'jsboss  `wav'jbttwt `wav'paygl `wav'paygw `wav'paynl `wav'paynw `wav'payu `wav'payuw `wav'payug `wav'paytyp `wav'ovtpay `wav'jbisco `wav'jbcssm `wav'jbcssf `wav'jbhgs `wav'jbsec `wav'jbseg `wav'jbgold `wav'pytc  `wav'jbsemp `wav'jbmngr `wav'jbsect `wav'jbsize `wav'jbhrs `wav'jbot `wav'jbotpd `wav'jbhrlk `wav'jbpl ///
       using "H:\thesis_analysis\data\secondary_data\bhps\\`wav'indresp.dta", clear
  renpfix `wav'
  capture rename id pid  
  sav $data\new_`wav'.dta, replace 
  }
 
use $data\new_k.dta, clear 
gen year = 2001
sav $data\new_k.dta, replace
use $data\new_l.dta
gen year = 2002
sav $data\new_l.dta, replace
use $data\new_m.dta
gen year = 2003
sav $data\new_m.dta, replace
use $data\new_n.dta
gen year = 2004
sav $data\new_n.dta, replace
use $data\new_o.dta
gen year = 2005
sav $data\new_o.dta, replace
use $data\new_p.dta
gen year = 2006
sav $data\new_p.dta, replace
use $data\new_q.dta
gen year = 2007
sav $data\new_q.dta, replace
use $data\new_r.dta
gen year = 2008
sav $data\new_r.dta, replace


use $data\new_k.dta , clear 
append using  $data\new_l.dta
append using  $data\new_m.dta
append using  $data\new_n.dta
append using  $data\new_o.dta
append using  $data\new_p.dta
append using  $data\new_q.dta
append using  $data\new_r.dta

*removing duplicates
sort pid jbsoc00
quietly by pid jbsoc00:  gen dup = cond(_N==1,0,_n)
drop if dup>1

*checking income 
sum paygu /*usual monthly pay - created in bhps */
drop if paygu <=0

tab  jbhrs /*hours worked per week*/
drop if jbhrs <=0

*gen yearly income 
gen yearpay = paygu*12

*total median income 
sum yearpay  if jbhrs >= 35, detail 

*removing missing 
tab qfedhi/* highest educational qualification*/
drop if qfedhi== -9 /*removing those that are missing */
drop if qfedhi== -7 /*removing those that are proxy */
tab jbcssf /*camsis*/
tab jbcssm /*camsis*/
drop if jbcssf ==-8 /* removing those missing camsis */
drop if jbcssf ==-9 /* removing those missing camsis */
drop if jbcssm ==-8 /* removing those missing camsis */
drop if jbcssm ==-9 /* removing those missing camsis */



save $data\bhpsforsei, replace 
********************************************************

use $data\bhpsforsei, clear
numlabel _all, add


*********** data management ******
*****************************************
use $data\bhpsforsei, clear 

**** ocupations 


*removing soc 2000 codes  that are not 4 digit or dont exist 
tab jbsoc00
drop if jbsoc00 < 1000
drop if jbsoc00 ==  1391
drop if jbsoc00 ==  1421
drop if jbsoc00 ==	1726
drop if jbsoc00 ==	1751
drop if jbsoc00 ==	1791
drop if jbsoc00 ==	2142
drop if jbsoc00 ==	2202
drop if jbsoc00 ==	2332
drop if jbsoc00 ==	2342
drop if jbsoc00 ==	2393
drop if jbsoc00 ==	2532
drop if jbsoc00 ==	2922
drop if jbsoc00 ==	2933
drop if jbsoc00 ==	3003
drop if jbsoc00 ==	3203
drop if jbsoc00 ==	3463
drop if jbsoc00 ==	3611
drop if jbsoc00 ==	3823
drop if jbsoc00 ==	3913
drop if jbsoc00 ==	4004
drop if jbsoc00 ==	4014
drop if jbsoc00 ==	4104
drop if jbsoc00 ==	4204
drop if jbsoc00 ==	4309
drop if jbsoc00 ==	4414
drop if jbsoc00 ==	4504
drop if jbsoc00 ==	4634
drop if jbsoc00 ==	5045
drop if jbsoc00 ==	5222
drop if jbsoc00 ==	5265
drop if jbsoc00 ==	5325
drop if jbsoc00 ==	5405
drop if jbsoc00 ==	6416
drop if jbsoc00 ==	6446
drop if jbsoc00 ==	6526
drop if jbsoc00 ==	6726
drop if jbsoc00 ==	7207
drop if jbsoc00 ==	7209
drop if jbsoc00 ==	7217
drop if jbsoc00 ==	7317
drop if jbsoc00 ==	8629
drop if jbsoc00 ==	8728
drop if jbsoc00 ==	8738
drop if jbsoc00 ==	8748
drop if jbsoc00 ==	8868
drop if jbsoc00 ==	8928
drop if jbsoc00 ==	9319
drop if jbsoc00 ==	9589
drop if jbsoc00 ==	9998
drop if jbsoc00 ==	9999

gen fsoc = jbsoc00 if sex==2
gen msoc = jbsoc00 if sex==1

gen cfreq =1

sort fsoc
capture drop n_occ1
egen n_occ1=sum(cfreq), by(fsoc)
sort msoc
capture drop n_occ2
egen n_occ2=sum(cfreq), by(msoc)

capture drop occ1
capture drop occ2
gen occ1=fsoc
gen occ2=msoc



** merging occs so each has 10+
tab fsoc if n_occ1 <10
do "H:\thesis_analysis\do_files\my_dofiles\ch4_measures\sei\seimergef.do" 

tab msoc if n_occ2 <10

do "H:\thesis_analysis\do_files\my_dofiles\ch4_measures\sei\seimergem.do" 

sort occ1
capture drop n_occ1s
egen n_occ1s=sum(cfreq), by(occ1)
sort occ2
capture drop n_occ2s
egen n_occ2s=sum(cfreq), by(occ2)

tab occ1 if n_occ1s <10
tab occ2 if n_occ2s <10





*******
save $data\bhpsforsei1, replace 

use $data\bhpsforsei1, clear 
*********************************************
**********************prestige***************

*camsis 
tab jbcssf
tab jbcssm


*********************************************
********************** education ************

*education 
tab qfedhi/* highest educational qualification*/
drop if qfedhi== -9 /*removing those that are missing */
drop if qfedhi== -7 /*removing those that are proxy */

capture drop university
gen university =0
replace university =1 if qfedhi <=3
tab university qfedhi




*********************************************
***********************income ************

sum paygu
sum yearpay 


*cut off at median annual (18,000).
capture drop yearmedian
gen yearmedian =0
replace yearmedian=1 if  yearpay>=18000
tab yearmedian


*cut off at median hourly (18,000 devided by 52 devided by 35 = 9.90).
tab jbhrs
gen jbhrs4 = jbhrs*4 
gen hourpay = paygu/jbhrs4
capture drop hourmedian
gen hourmedian =0
replace hourmedian=1 if  hourpay>=9.90

tab hourmedian 

save $data\bhpsforsei2, replace 



 
******************************************************************************

***************avrageing income and education by occupation ******************************************


***********************************************************************************************************


*women
use $data\bhpsforsei2, clear
tab sex 
drop if sex==1
collapse (mean) jbcssf university yearmedian hourmedian, by(occ1) 
rename _all  femalemean=
sav  "$data\bhpsforsei_agrfem", replace

*men
use $data\bhpsforsei2, clear
tab sex 
drop if sex==2
collapse (mean) jbcssm university  yearmedian hourmedian, by(occ2) 
rename _all  malemean=
sav  "$data\bhpsforsei_agrmale", replace


use $data\bhpsforsei2, clear
keep msoc occ2 cfreq 
rename cfreq cfreqm 
collapse (sum) cfreqm, by(msoc occ2)
summarize
sav $data\bhpsforsei2m, replace 

use $data\bhpsforsei2, clear
keep fsoc occ1 cfreq 
rename cfreq cfreqf 
collapse (sum) cfreqf, by(fsoc occ1)
summarize
sav $data\bhpsforsei2f, replace 


use $data\bhpsforsei2, clear
keep jbsoc00 jbcssf jbcssm
rename jbsoc00 soc
collapse (mean) jbcssf jbcssm, by(soc)
summarize
sav $data\bhpsforsei2c, replace 


*****************************regressons to perdic scores ***********************

********************************************************************************
*regressed camsis scores on average education and income (male) 



use $data\bhpsforsei_agrmale, clear 
rename malemeanocc2 occ2
drop if occ2 ==. 

reg malemeanjbcssm malemeanuniversity malemeanyearmedian
est store mseiyear
predict mseiyear

reg malemeanjbcssm malemeanuniversity malemeanhourmedian
est store mseihour
predict mseihour

esttab mseiyear mseihour, b  stats(N r2 rmse)
esttab mseiyear mseihour, beta  stats(N r2 rmse)


keep occ2  mseiyear  mseihour

sort occ2  

sav $data\bhpsforsei_male, replace


******************************************************************************
*regressed camsis scores on average education and income (female) 

use $data\bhpsforsei_agrfem
rename femalemeanocc1 occ1
drop if occ1 == . 
reg femalemeanjbcssf femalemeanuniversity femalemeanyearmedian
est store fseiyear
predict fseiyear

reg femalemeanjbcssf femalemeanuniversity femalemeanhourmedian
est store fseihour
predict fseihour

esttab fseiyear fseihour, b  stats(N r2 rmse)
esttab fseiyear fseihour, beta  stats(N r2 rmse)

keep occ1  fseiyear  fseihour

sort occ1  

sav $data\bhpsforsei_fem, replace

********************************************************************************************

use $data\bhpsforsei2f, clear 
sort occ1 
merge occ1 using $data\bhpsforsei_fem
drop _merge
rename fsoc soc
sort soc 
sav $data\bhpsforsei3f, replace 

use $data\bhpsforsei2m, clear 
sort occ2
merge occ2 using $data\bhpsforsei_male
drop _merge
rename msoc soc
sort soc 
merge soc using $data\bhpsforsei3f,
drop _merge
sort soc 
merge soc using $data\bhpsforsei2c,
drop _merge 
sort soc 
order soc cfreqm occ2 cfreqf occ1 mseiyear mseihour jbcssm fseiyear fseihour  jbcssf
sav $data\bhpsforsei4, replace 


********************************************************************************************
********************************************************************************************
use $data\bhpsforsei4, clear 

* compairing values of predicted sei with camsis. 

scatter mseihour jbcssm , ytitle("Male SEI score" "based on hourly pay") xtitle("Male CAMSIS")mlabel(soc) mlabsize(tiny) msize(tiny) mlabpos(2) 
graph save graphmh, replace 

scatter mseiyear jbcssm , ytitle("Male SEI score" "based on yearly pay") xtitle("Male CAMSIS")mlabel(soc) mlabsize(tiny) msize(tiny) mlabpos(2) 
graph save graphmy, replace

scatter fseihour jbcssf  , ytitle("Female SEI score" "based on hourly pay") xtitle("Female CAMSIS")mlabel(soc) mlabsize(tiny) msize(tiny) mlabpos(2) 
graph save graphfh, replace

scatter fseiyear jbcssf , ytitle("Female SEI score" "based on yearly pay") xtitle("Female CAMSIS")mlabel(soc) mlabsize(tiny) msize(tiny) mlabpos(2) 
graph save graphfy, replace

graph combine graphmh.gph graphmy.gph graphfh.gph graphfy.gph

* compairing values of predicted sei with camsis - labeling outliers. 
do "H:\thesis_analysis\do_files\my_dofiles\other\labelsoc00"
label values  soc soc001

capture drop outliermh 
gen outliermh =0 
replace outliermh = 1 if mseihour-jbcssm <= -15
replace outliermh = 1 if mseihour-jbcssm >= 15

capture drop outliermy 
gen outliermy =0 
replace outliermy = 1 if mseiyear-jbcssm <= -15
replace outliermy = 1 if mseiyear-jbcssm >= 15

capture drop outlierfh 
gen outlierfh =0 
replace outlierfh = 1 if fseihour-jbcssf <= -15
replace outlierfh = 1 if fseihour-jbcssf >= 15

capture drop outlierfy 
gen outlierfy =0 
replace outlierfy = 1 if fseiyear-jbcssf <= -15
replace outlierfy = 1 if fseiyear-jbcssf >= 15


scatter mseihour jbcssm if outliermh == 1 , ytitle("Male SEI score" "based on hourly pay") xtitle("Male CAMSIS")mlabel(soc) mlabsize(tiny) msize(tiny) mlabpos(2) 
graph save graphmh2, replace 

scatter mseiyear jbcssm if outliermy == 1, ytitle("Male SEI score" "based on yearly pay") xtitle("Male CAMSIS")mlabel(soc) mlabsize(tiny) msize(tiny) mlabpos(2) 
graph save graphmy2, replace

scatter fseihour jbcssf if outlierfh == 1, ytitle("Female SEI score" "based on hourly pay") xtitle("Female CAMSIS")mlabel(soc) mlabsize(tiny) msize(tiny) mlabpos(2) 
graph save graphfh2, replace

scatter fseiyear jbcssf if outlierfy == 1, ytitle("Female SEI score" "based on yearly pay") xtitle("Female CAMSIS")mlabel(soc) mlabsize(tiny) msize(tiny) mlabpos(2) 
graph save graphfy2, replace


* seprate male and female scales  color coded by soc major 

 

twoway (scatter  mseihour jbcssm  if socmajor ==1, ytitle("Male SEI score" "based on hourly pay") xtitle("Male CAMSIS") mcolor(black) msymbol(circle_hollow) )  ///
       (scatter  mseihour jbcssm  if socmajor ==2, mcolor(blue) msymbol(circle_hollow) )  ///
       (scatter  mseihour jbcssm  if socmajor ==3, mcolor(cranberry) msymbol(circle_hollow) )  ///
       (scatter  mseihour jbcssm  if socmajor ==4, mcolor(midgreen) msymbol(circle_hollow) ) ///
	   (scatter  mseihour jbcssm  if socmajor ==5, mcolor(dkorange) msymbol(circle_hollow) ) ///
       (scatter  mseihour jbcssm  if socmajor ==6, mcolor(brown) msymbol(circle_hollow) )  ///
       (scatter  mseihour jbcssm  if socmajor ==7, mcolor(pink) msymbol(circle_hollow) )  ///
       (scatter  mseihour jbcssm  if socmajor ==8, mcolor(lavender) msymbol(circle_hollow) ) ///
	   (scatter  mseihour jbcssm  if socmajor ==9, mcolor(ltblue) msymbol(circle_hollow) ) 
graph save graphmh3, replace
    

twoway (scatter  mseihour jbcssm  if socmajor ==1, ytitle("Male SEI score" "based on yearly pay") xtitle("Male CAMSIS") mcolor(black) msymbol(circle_hollow) )  ///
       (scatter  mseihour jbcssm  if socmajor ==2, mcolor(blue) msymbol(circle_hollow) )  ///
       (scatter  mseihour jbcssm  if socmajor ==3, mcolor(cranberry) msymbol(circle_hollow) )  ///
       (scatter  mseihour jbcssm  if socmajor ==4, mcolor(midgreen) msymbol(circle_hollow) ) ///
	   (scatter  mseihour jbcssm  if socmajor ==5, mcolor(dkorange) msymbol(circle_hollow) ) ///
       (scatter  mseihour jbcssm  if socmajor ==6, mcolor(brown) msymbol(circle_hollow) )  ///
       (scatter  mseihour jbcssm  if socmajor ==7, mcolor(pink) msymbol(circle_hollow) )  ///
       (scatter  mseihour jbcssm  if socmajor ==8, mcolor(lavender) msymbol(circle_hollow) ) ///
	   (scatter  mseihour jbcssm  if socmajor ==9, mcolor(ltblue) msymbol(circle_hollow) ) 	 
graph save graphmy3, replace
	   

twoway (scatter  fseihour jbcssf  if socmajor ==1, ytitle("Female SEI score" "based on hourly pay") xtitle("Female CAMSIS") mcolor(black) msymbol(circle_hollow) )  ///
       (scatter  fseihour jbcssf   if socmajor ==2, mcolor(blue) msymbol(circle_hollow) )  ///
       (scatter  fseihour jbcssf   if socmajor ==3, mcolor(cranberry) msymbol(circle_hollow) )  ///
       (scatter  fseihour jbcssf   if socmajor ==4, mcolor(midgreen) msymbol(circle_hollow) ) ///
	   (scatter  fseihour jbcssf   if socmajor ==5, mcolor(dkorange) msymbol(circle_hollow) ) ///
       (scatter  fseihour jbcssf   if socmajor ==6, mcolor(brown) msymbol(circle_hollow) )  ///
       (scatter  fseihour jbcssf   if socmajor ==7, mcolor(pink) msymbol(circle_hollow) )  ///
       (scatter  fseihour jbcssf   if socmajor ==8, mcolor(lavender) msymbol(circle_hollow) ) ///
	   (scatter  fseihour jbcssf  if socmajor ==9, mcolor(ltblue) msymbol(circle_hollow) ) 	   
graph save graphfh3, replace
	   

twoway (scatter  fseiyear jbcssf   if socmajor ==1, ytitle("Female SEI score" "based on yearly pay") xtitle("Female CAMSIS") mcolor(black) msymbol(circle_hollow) )  ///
       (scatter  fseiyear jbcssf   if socmajor ==2, mcolor(blue) msymbol(circle_hollow) )  ///
       (scatter  fseiyear jbcssf   if socmajor ==3, mcolor(cranberry) msymbol(circle_hollow) )  ///
       (scatter  fseiyear jbcssf   if socmajor ==4, mcolor(midgreen) msymbol(circle_hollow) ) ///
	   (scatter  fseiyear jbcssf   if socmajor ==5, mcolor(dkorange) msymbol(circle_hollow) ) ///
       (scatter  fseiyear jbcssf   if socmajor ==6, mcolor(brown) msymbol(circle_hollow) )  ///
       (scatter  fseiyear jbcssf   if socmajor ==7, mcolor(pink) msymbol(circle_hollow) )  ///
       (scatter  fseiyear jbcssf   if socmajor ==8, mcolor(lavender) msymbol(circle_hollow) ) ///
	   (scatter  fseiyear jbcssf   if socmajor ==9, mcolor(ltblue) msymbol(circle_hollow) ) 
graph save graphfy3, replace	   

grc1leg2 graphmh3.gph graphmy3.gph graphfh3.gph graphfy3.gph


*comapairing male and female sei 

corr jbcssm jbcssf

corr mseihour  fseihour

corr mseiyear  fseiyear 

sum mseihour
sum mseiyear 
sum fseihour
sum fseiyear 

scatter mseihour  fseihour, ytitle("Male SEI score" "based on hourly pay") xtitle(" Female SEI score" "based on hourly pay")mlabel(soc) mlabsize(tiny) msize(tiny) mlabpos(2) 
graph save graph_seimfoutliers2, replace 


capture drop outlierfm
gen outlierfm =0 
replace outlierfm = 1 if fseihour-mseihour <= -10
replace outlierfm = 1 if fseihour-mseihour >= 10

scatter mseihour  fseihour  if outlierfm == 1  , ytitle("Male SEI score" "based on hourly pay") xtitle(" Female SEI score" "based on hourly pay")mlabel(soc) mlabsize(tiny) msize(tiny) mlabpos(2) 
graph save graph_seimfoutliers2, replace 

gen socmajor =0
replace socmajor =1 if soc >=1000 & soc <=1999
replace socmajor =2 if soc >=2000 & soc <=2999
replace socmajor =3 if soc >=3000 & soc <=3999
replace socmajor =4 if soc >=4000 & soc <=4999
replace socmajor =5 if soc >=5000 & soc <=5999
replace socmajor =6 if soc >=6000 & soc <=6999
replace socmajor =7 if soc >=7000 & soc <=7999
replace socmajor =8 if soc >=8000 & soc <=8999
replace socmajor =9 if soc >=9000 & soc <=9999


*
	   
scatter fseihour jbcssf  [w=cfreqf] , ytitle("Female SEI score" "based on hourly pay") xtitle("Female CAMSIS")
graph save graphfh, replace

scatter  mseihour mseihour  [w=cfreqm ], msymbol(circle_hollow) 

scatter  fseihour fseihour  [w=cfreqf], msymbol(circle_hollow) msize(medium)


* seprate male and female scales weighted by number in occ color coded by soc major - p97 in lambert and griffiths 
twoway lfit  soc90 cb_camsis_m  , mlabel(soc90_)mlabsize(tiny) msize (tiny) mlabpos(2) 
scatter  cb_camsis_m cb_camsis_f  [w=used_m], msymbol(circle_hollow)

*sales 

***********************************************************************************************

* creating scalee for use with isco 88 

use $data\bhpsforsei4, clear 
keep soc mseihour fseihour
rename soc soc00



save $data\cbsei, replace

use  $data\cbsei, clear 
do soc00toisco88


bysort isco88:egen mseiisco=mean (mseihour)
bysort isco88:egen fseiisco=mean (fseihour)
sort isco88

sort isco88 mseiisco fseiisco
quietly by isco88 mseiisco fseiisco:  gen dup = cond(_N==1,0,_n)
drop if dup>1
drop dup

sav $data\cbseiisco88, replace 
use $data\cbseiisco88, clear 
