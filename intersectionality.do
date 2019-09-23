
global bhpsdata "H:\thesis_analysis\data\secondary_data\bhps"
global pathdata "H:\thesis_analysis\data\my_data\c5"

*******************************
*****merging for race varible 
use pid mracel using $bhpsdata\mindresp.dta, clear
sort pid
sav $pathdata\m_mracel.dta, replace 

use pid nracel using $bhpsdata\nindresp.dta, clear
sort pid
sav $pathdata\m_nracel.dta, replace  

use pid oracel using $bhpsdata\oindresp.dta, clear
sort pid
sav $pathdata\m_oracel.dta, replace  

use pid pracel using $bhpsdata\pindresp.dta, clear
sort pid
sav $pathdata\m_pracel.dta, replace  

use pid qracel using $bhpsdata\qindresp.dta, clear
sort pid
sav $pathdata\m_qracel.dta, replace  

use $bhpsdata\rindresp.dta, clear
sort pid
merge 1:1 pid using $pathdata\m_mracel.dta
tab rracel
drop if  _merge == 2
replace rracel = mracel if _merge ==3
tab rracel
drop _merge

sort pid
merge 1:1 pid using $pathdata\m_nracel.dta
drop if  _merge == 2
tab rracel
drop _merge



sort pid
merge 1:1 pid using $pathdata\m_oracel.dta
drop if  _merge == 2
drop _merge

sort pid
merge 1:1 pid using $pathdata\m_pracel.dta
drop if  _merge == 2
drop _merge

sort pid
merge 1:1 pid using $pathdata\m_qracel.dta
drop if  _merge == 2
drop _merge

sav $pathdata\rindrespl_race.dta, replace  

*******************************
*using wave r BHPS - race added from previous waves 
*****************************************
use $pathdata\rindrespl_race.dta, clear 

numlabel _all, add

tab1  nracel oracel pracel qracel
recode nracel -8=. -9=. -7=.
recode oracel -8=. -9=. -7=.
recode pracel -8=. -9=. -7=.
recode qracel -8=. -9=. -7=.
tab1  nracel oracel pracel qracel

replace rracel = nracel if !missing(nracel) 
replace rracel = oracel if !missing(oracel) 
replace rracel = pracel if !missing(pracel) 
replace rracel = qracel if !missing(qracel) 

tab rracel

sav $pathdata\rindrespl_race.dta, replace 

************************************************ 
*using wave r BHPS - race added from previous waves 

************************************************ 
*creating dummy varibles
************************************************ 

use $pathdata\rindrespl_race.dta, clear 
renpfix r
numlabel _all, add

*age - working age only 18-65
tab age
drop if age <16
drop if age> 65

*hours worked 
tab jbhrs/*number of hours normally worked per week*/
drop if jbhrs <5
tab jbhrs/*number of hours normally worked per week*/

*income 
sum paygu
replace paygu =. if paygu <0
sum paygu

*dropping the top and bottom 1%
summarize paygu
gen pay =paygu
centile(pay), centile(1, 99)
drop if ( pay < r(c_1) | pay > r(c_2) )
summarize pay 

*creating log pay perweek
capture drop lnic
gen lnic = log(pay)
hist lnic

*********************************************************

*sex
tab sex
recode sex -7 =.
capture drop fem 
gen fem =sex
recode fem 1=0 2=1
tab fem sex

*ethnicity
tab racel
recode racel -1=. -2=. -7=. -8=. -9=.
tab racel 

capture drop minority
gen minority =racel
recode minority 1=0 2=0 3=0 4=0 5=0 else=1
tab racel minority  

/*jobs statisfaction 
*jssat1 jbsat2 jbsat4 jssat5 jbsat6 jbsat7
tab1 jbsat 
recode jbsat -8=. -7=. -2=. -1=.
sort sex
by sex: egen jbsatmean=mean(jbsat)
tab sex jbsatmean*/


*housework
tab howlng
recode howlng -7=. -1=.
sort sex
by sex: egen groupmean=mean(howlng)
tab sex groupmean



*married civil partner or living as couple
tab mastat
capture drop married 
gen married =0 
replace married =1 if mastat==1 |mastat==2 |mastat==7

tab married mastat

*has children 

tab  nchild
capture drop child 
gen child =0 
replace child =1 if nchild>=1
tab child nchild



*education 
tab qfedhi
recode qfedhi -7=. -9=. 13=.
tab qfedhi
capture drop degree
gen degree=0
replace degree=1 if qfedhi==1 | qfedhi==2 | qfedhi==3

tab degree qfedhi



*age 
tab age 
capture drop age4
gen age4 = .
replace age4 =1 if age >= 16
replace age4 =2 if age >= 34
replace age4 =3 if age >= 45

tab age4

*hours worked per week 
tab jbhrs
capture drop fulltime 
gen fulltime=1 if  jbhrs>=35
replace fulltime=0 if jbhrs<=34 & jbhrs>=1
tab fulltime
sav $pathdata\rindrespl_race1.dta, replace 
************************************************ 
**wave r BHPS - race added from previous waves with dummy varible created creating dummy varibles =rindrespl_race1.dta

************************************************ 
****************social strat********************** 

use $pathdata\rindrespl_race1.dta, clear
sav $pathdata\rindrespl_race2.dta, replace 
*****************icam 
use $pathdata\rindrespl_race2.dta, clear
tab jbiscon
replace jbiscon=. if jbiscon ==-9
capture drop icam
gen icam =  jbiscon
do "H:\data\icam.do"
summarize icam 

sav $pathdata\rindrespl_race3.dta, replace 

************camsis 
use $pathdata\rindrespl_race3.dta, clear
summarize jbcssm jbcssf 
recode jbcssf -1=. -2=. -3=. -7=. -8=.
recode jbcssm -1=. -2=. -3=. -7=. -8=.
summarize jbcssm jbcssf 

sav $pathdata\rindrespl_race4.dta, replace

***************RGSC 
use $pathdata\rindrespl_race4.dta, clear
tab jbrgsc
recode jbrgsc -9=. -8=.
sav $pathdata\rindrespl_race5.dta, replace 


**************female freind camsis
use $pathdata\rindrespl_race5.dta, clear
sort jbsoc
sav $pathdata\rindrespl_race5.dta, replace 

use H:\thesis_analysis\data\my_data\camsis_creation\temp\cb_camsis__all.dta, clear 
rename soc90 jbsoc
sort jbsoc cb_camsis_f
merge 1:m jbsoc using $pathdata\rindrespl_race5.dta
drop if _merge ==1
drop _merge

sav $pathdata\rindrespl_race6.dta, replace



***************fem sei 

use $pathdata\rindrespl_race6.dta, clear
sort jbsoc
sav $pathdata\rindrespl_race6.dta, replace 

use "H:\thesis_analysis\data\my_data\measures_3\sei\bhpsforsei4", clear 
rename soc jbsoc00
keep jbsoc00 fseihour
sort jbsoc00 fseihour
merge 1:m jbsoc00 using $pathdata\rindrespl_race6.dta
drop if _merge ==1
drop _merge


sav $pathdata\rindrespl_race7.dta, replace

***********isei
use $pathdata\rindrespl_race7.dta, clear

global hendrickx_files "H:\thesis_analysis\do_files\hendrickx"
capture program drop iskoisei
do "$hendrickx_files\Hendrick6.do" /* defines the isei prog  */

iskoisei isei , isko(jbiscon)

sav $pathdata\rindrespl_race8.dta, replace

********************
*standardizing scales 
use $pathdata\rindrespl_race8.dta, clear
egen z2icam = std(icam)
egen z2jbcssm = std(jbcssm)
egen z2jbcssf = std(jbcssf)
egen z2cb_camsis_f = std(cb_camsis_f)
egen z2isei = std(isei)
egen z2fseihour = std(fseihour)
sav $pathdata\rindrespl_race9.dta, replace


*****************************************************************************
*****************************analaysis***************************************
*****************************************************************************


use $pathdata\rindrespl_race9.dta, replace
capture drop touse
gen touse = !missing(z2icam, jbrgsc,cb_camsis_f, jbcssm, jbcssf,  ///
						jbhrs ,age ,degree, fem, minority)

*regression main effects - cumulative disadvantage 
reg lnic jbhrs age degree fem minority  i.jbrgsc if touse ==1
est store a1jbrgsc
reg lnic  jbhrs age degree fem minority  z2icam if touse ==1
est store a1z2icam
reg lnic  jbhrs age degree fem minority  z2jbcssm if touse ==1
est store a1z2jbcssm
reg lnic  jbhrs age degree fem minority  z2jbcssf if touse ==1
est store a1z2jbcssf
reg lnic  jbhrs age degree fem minority  z2cb_camsis_f if touse ==1
est store a1z2cb_camsis_f



esttab a1jbrgsc a1z2icam  a1z2jbcssm a1z2jbcssf a1z2cb_camsis_f , r2 bic ///
                                 cells(b(star fmt(%9.2f))) label       ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles ///
								title (Appendix A)
                               


*interaction 1
gen z2femicam =fem*z2icam 
gen z2femisei =fem*z2isei, 

reg lnic jbhrs age degree fem minority  i.jbrgsc##fem if touse ==1
est store b1jbrgsc

bysort jbrgsc: table minority  degree fem

reg lnic  jbhrs age degree fem minority  z2icam z2femicam if touse ==1
est store b1z2icam




esttab b1jbrgsc b1z2icam , r2 bic ///
                                 cells(b(star fmt(%9.2f))) label       ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles ///
								title (Appendix b)
                               

*interactions gender
gen femdegree =fem*degree
gen femage =fem*age
gen femhours = fem*jbhrs 
gen femmin =fem*minority


reg lnic jbhrs age degree fem minority  i.jbrgsc##fem femdegree femage femhours femmin if touse ==1
est store c1jbrgsc
reg lnic  jbhrs age degree fem minority  z2icam z2femicam femdegree femage femhours femmin if touse ==1
est store c1z2icam




esttab c1jbrgsc c1z2icam   , r2 bic ///
                                 cells(b(star fmt(%9.2f))) label       ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles ///
								title (Appendix c)							   
							   
*interactions strat
gen z2icammin=z2icam*minority
gen z2icamdegree=z2icam*degree
gen z2icamage = z2icam*age 
gen z2icamhours = z2icam*jbhrs




reg lnic jbhrs age degree fem minority  i.jbrgsc##fem i.jbrgsc##minority i.jbrgsc##degree jbrgsc#c.age  jbrgsc#c.jbhrs  if touse ==1
est store d1jbrgsc
reg lnic  jbhrs age degree fem minority  z2icam z2femicam z2icamdegree z2icamage z2icamhours z2icammin if touse ==1
est store d1z2icam




esttab d1jbrgsc d1z2icam , r2 bic ///
                                 cells(b(star fmt(%9.2f))) label       ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles ///
								title (Appendix d)
                               								
								

                               																
								
								
								
								
*catigorical aproach

gen mindegree =minority*degree
gen minage =minority*age
gen minhours = minority*jbhrs 

gen degreeage= degree*age 
gen degreehours = degree*jbhrs 

gen agehours =age*jbhrs


reg lnic jbhrs age degree fem minority  i.jbrgsc##fem i.jbrgsc##minority i.jbrgsc##degree jbrgsc#c.age  jbrgsc#c.jbhrs femdegree femage femhours femmin  mindegree minage minhours degreeage degreehours agehours if touse ==1
est store e1jbrgsc
reg lnic  jbhrs age degree fem minority  z2icam z2femicam z2icamdegree z2icamage z2icamhours z2icammin femdegree femage femhours femmin mindegree minage minhours degreeage degreehours agehours if touse ==1
est store e1z2icam




esttab e1jbrgsc e1z2icam , r2 bic ///
                                 cells(b(star fmt(%9.2f))) label       ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles ///
								title (Appendix e)
                               								
								

								
								
								
******************************************************							
***table 1 

esttab a1jbrgsc b1jbrgsc c1jbrgsc d1jbrgsc e1jbrgsc , r2 bic ///
                                 cells(b(star fmt(%9.2f))) label       ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles ///
								title ( table 1 RGSC )							
								
						
						
	
esttab a1z2icam b1z2icam c1z2icam d1z2icam e1z2icam , r2 bic ///
                                 cells(b(star fmt(%9.2f))) label       ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles ///
								title ( table 1 international camsis )								
								
								
******************************************************		
					

*gender spesific mesures 
capture drop minjbcssm 
capture drop agejbcssm 
capture drop degreejbcssm 
capture drop hoursjbcssm 

gen minjbcssm =minority*z2jbcssm
gen agejbcssm =age*z2jbcssm
gen degreejbcssm =degree*z2jbcssm 
gen hoursjbcssm =jbhrs*z2jbcssm 

capture drop minjbcssf
capture drop agejbcssf 
capture drop degreejbcssf 
capture drop hoursjbcssf 

gen minjbcssf =minority*z2jbcssf
gen agejbcssf =age*z2jbcssf
gen degreejbcssf =degree*z2jbcssf 
gen hoursjbcssf =jbhrs*z2jbcssf

capture drop minjbcssc 
capture drop agejbcssc 
capture drop degreejbcssc 
capture drop hoursjbcssc 

gen minjbcssc =minority*z2cb_camsis_f
gen agejbcssc =age*z2cb_camsis_f
gen degreejbcssc =degree*z2cb_camsis_f 
gen hoursjbcssc =jbhrs*z2cb_camsis_f 



*********************for women comparison 
*ICAM
reg lnic  jbhrs age degree minority z2icam  if sex==2 &  touse ==1
est store a2z2icam
reg lnic jbhrs age degree minority z2icam minjbcssm agejbcssm degreejbcssm hoursjbcssm  if sex==2 & touse ==1
est store b2z2icam

*Male camsis 
reg lnic  jbhrs age degree minority z2jbcssm  if sex==2 &  touse ==1
est store a2z2jbcssm
reg lnic jbhrs age degree minority z2jbcssm minjbcssm agejbcssm degreejbcssm hoursjbcssm  if sex==2 & touse ==1
est store b2z2jbcssm

			

*Female camsis 
reg lnic  jbhrs age degree minority z2jbcssf  if sex==2 & touse ==1
est store a2z2jbcssf
reg lnic jbhrs age degree minority z2jbcssf minjbcssf agejbcssf degreejbcssf hoursjbcssf  if sex==2 & touse ==1
est store b2z2jbcssf


*Female Friends camsis  

reg lnic  jbhrs age degree minority z2cb_camsis_f   if sex==2  & touse ==1
est store a2z2jbcssc
reg lnic jbhrs age degree minority z2cb_camsis_f  minjbcssc agejbcssc degreejbcssc hoursjbcssc  if sex==2  & touse ==1
est store b2z2jbcssc

esttab a2z2icam b2z2icam a2z2jbcssm b2z2jbcssm a2z2jbcssf b2z2jbcssf a2z2jbcssc b2z2jbcssc, r2 bic ///
                                cells(b(star fmt(%9.2f))) label       ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles ///
								title (gender spesific female freind )
								
sav $pathdata\rindrespl_race10.dta, replace

***************************multi level

use $pathdata\rindrespl_race10.dta, clear

*********************************

mixed  lnic i.jbrgsc jbhrs fem minority degree age   if touse ==1 
est store nulla

mixed  lnic i.jbrgsc jbhrs fem minority degree age i.jbrgsc##fem femdegree femage femhours femmin   if touse ==1 
est store nullb


mixed  lnic  if touse ==1  ||jbrgsc:, 
est store nulld
estat icc


mixed  lnic jbhrs fem minority degree age   if touse ==1 ||jbrgsc:, 
est store maina
estat icc

mixed  lnic jbhrs fem minority degree age femdegree femage femhours femmin  if touse ==1 ||jbrgsc:, 
est store inta 
estat icc


mixed  lnic jbhrs fem minority degree age   if touse ==1 ||jbrgsc:fem, 
est store slopesa 
estat icc

mixed  lnic jbhrs fem minority degree age femdegree femage femhours femmin  if touse ==1 ||jbrgsc:fem, 
est store slopesa1 
estat icc


mixed  lnic jbhrs fem minority degree age   if touse ==1 ||jbrgsc:fem degree , 
est store slopesa2
estat icc

mixed  lnic jbhrs fem minority degree age femdegree femage femhours femmin  if touse ==1 ||jbrgsc:fem degree , 
est store slopesa3
estat icc


lrtest nulld maina /*i -  ii*/ 
lrtest maina inta /*ii -  iii*/ 
lrtest maina slopesa /*ii -  iv*/ 
lrtest inta slopesa1/*iii -  v*/ 
lrtest slopesa  slopesa2/*iv -  v*/
lrtest slopesa1 slopesa3 /*v -  vii*/

 



esttab  nulld maina inta slopesa slopesa1 slopesa2 slopesa3, bic ///
                                cells(b(star fmt(%9.2f))) label       ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles 
								


							
**************************

mixed  lnic  if touse ==1  ||jbsoc:, 
est store _nulld
estat icc


mixed  lnic jbhrs fem minority degree age   if touse ==1 ||jbsoc:, 
est store _maina
estat icc

mixed  lnic jbhrs fem minority degree age femdegree femage femhours femmin  if touse ==1 ||jbsoc:, 
est store _inta 
estat icc


mixed  lnic jbhrs fem minority degree age   if touse ==1 ||jbsoc:fem, 
est store _slopesa 
estat icc

mixed  lnic jbhrs fem minority degree age femdegree femage femhours femmin  if touse ==1 ||jbsoc:fem, 
est store _slopesa1 
estat icc


mixed  lnic jbhrs fem minority degree age   if touse ==1 ||jbsoc:fem degree, 
est store _slopesa2
estat icc

mixed  lnic jbhrs fem minority degree age femdegree femage femhours femmin  if touse ==1 ||jbsoc:fem degree , 
est store _slopesa3
estat icc

esttab  _nulld _maina _inta _slopesa _slopesa1 _slopesa2 _slopesa3, bic ///
                                cells(b(star fmt(%9.2f))) label       ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles 
								
								
lrtest _nulld _maina /*i -  ii*/ 
lrtest _maina _inta /*ii -  iii*/ 
lrtest _maina _slopesa /*ii -  iv*/ 
lrtest _inta _slopesa1/*iii -  v*/ 
lrtest _slopesa  _slopesa2/*iv -  v*/
lrtest _slopesa1 _slopesa3 /*v -  vii*/
								
***************************************


**************evans (2018)

use $pathdata\rindrespl_race10.dta, clear
tab1 jbrgsc fem degree minority degree age4 
recode jbrgsc 7=.
capture drop intid
egen intid = group(jbrgsc fem minority degree age4) 
codebook jbrgsc fem degree fulltime age4 intid , compact 
tab intid 


gen cfreq =1
collapse (sum) cfreq, by(intid )
summarize
sort cfreq
capture drop intid1 
gen intid1 = 0
replace intid1 =1 if cfreq <10
replace intid1 =2 if cfreq >=10 & cfreq <=20
replace intid1 =3 if cfreq >20

tab intid1 





**************


* Category random effects

*null
mixed  lnic  if touse ==1  ||intid:,
est store null
estat icc

*main 
mixed  lnic  i.jbrgsc fem minority degree i.age4   if touse ==1||intid:, 
est store main 
estat icc

*interactaions 
mixed lnic  age degree fem minority  i.jbrgsc##fem i.jbrgsc##minority i.jbrgsc##degree jbrgsc#c.age  femdegree femage  femmin  mindegree minage  degreeage  if touse ==1||intid:, 
est store inter
estat icc



est tab null main  

**************************************

mixed  lnic  i.jbrgsc fem minority degree i.age4   if touse ==1||intid:, 
est store main 
capture drop onerec
egen onerec=tag(intid) /* just an indicator of one record per strata */
* First, the 'empirical bayes' residuals (with 'shrinkage') 
capture drop ebi_p 
predict ebi_p, reffects  /* new variable with higher level residual values */
graph twoway (scatter ebi_p intid if onerec==1, ///
       msymbol(circle) msize(vlarge) mcolor(purple) ) /* residuals by numeric value of strata*/
capture drop intid_rank
egen intid_rank=group(ebi_p)
graph twoway (scatter ebi_p intid_rank if onerec==1, ///
       msymbol(circle) msize(vlarge) mcolor(green) ) /* residuals in rank order */




* We ofen present these as 'caterpillar plos' because standard errors for the residuals make sense (e.g. some 
*   residuals might be based on relatively few cases)

capture drop intid_ses
predict intid_ses, reses /* this gives the standard errors for the random effects */
capture drop upper
gen upper = ebi_p + 1.96*intid_ses //manually making 
capture drop lower
gen lower = ebi_p - 1.96*intid_ses
graph twoway (scatter ebi_p  intid_rank if onerec==1, ///
       msymbol(circle) msize(medium) mcolor(green) )  ///
     (rspike upper lower intid_rank if onerec==1, lcolor(gs10) lwidth(thin)) ///
    , scheme(s1mono) yline(0, lcolor(purple) lwidth(medium)) subtitle(" 'Caterpillar plot' for stata residuals " )

	

sort intid
list intid jbrgsc fem minority degree age4 if onerec==1

list intid jbrgsc fem minority degree age4 if upper < 0 & onerec==1
list intid jbrgsc fem minority degree age4 if lower > 0 & onerec==1
sort intid_rank
list intid_rank intid if onerec==1
rename intid_rank rank1


***********************************************************************************

mixed lnic  age degree fem minority  i.jbrgsc##fem i.jbrgsc##minority i.jbrgsc##degree jbrgsc#c.age  femdegree femage  femmin  mindegree minage  degreeage  if touse ==1||intid:, 
est store inter

* First, the 'empirical bayes' residuals (with 'shrinkage') 
capture drop ebi_p 
predict ebi_p, reffects  /* new variable with higher level residual values */
graph twoway (scatter ebi_p intid if onerec==1, ///
       msymbol(circle) msize(vlarge) mcolor(purple) ) /* residuals by numeric value of strata*/
capture drop intid_rank
egen intid_rank=group(ebi_p)
graph twoway (scatter ebi_p intid_rank if onerec==1, ///
       msymbol(circle) msize(vlarge) mcolor(green) ) /* residuals in rank order */




* We ofen present these as 'caterpillar plos' because standard errors for the residuals make sense (e.g. some 
*   residuals might be based on relatively few cases)

capture drop intid_ses
predict intid_ses, reses /* this gives the standard errors for the random effects */
capture drop upper
gen upper = ebi_p + 1.96*intid_ses //manually making 
capture drop lower
gen lower = ebi_p - 1.96*intid_ses
graph twoway (scatter ebi_p  intid_rank if onerec==1, ///
       msymbol(circle) msize(medium) mcolor(green) )  ///
     (rspike upper lower intid_rank if onerec==1, lcolor(gs10) lwidth(thin)) ///
    , scheme(s1mono) yline(0, lcolor(purple) lwidth(medium)) subtitle(" 'Caterpillar plot' for stata residuals " )

	
list intid jbrgsc fem minority degree age4 if upper < 0 & onerec==1
list intid jbrgsc fem minority degree age4 if lower > 0 & onerec==1
list rank1 intid_rank intid if onerec==1
