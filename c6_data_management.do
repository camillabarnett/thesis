*********Chapter 7 

global issp "H:\thesis_analysis\data\secondary_data\issp\"

global output "H:\thesis_analysis\do_files\my_dofiles\ch7_overtime"

global c7data "H:\thesis_analysis\data\my_data\c7\"



***********************************************************************************
*****************************1980's***************************************************
***********************************************************************************


**********************uk********************
*BSA 1985 

use H:\thesis_analysis\data\secondary_data\bsa\bsa85, clear
numlabel _all, add

gen year= 1985

*self-rate strat 
tab srsoccl
capture drop ss
gen ss = srsoccl 
recode ss 5=1 4=2 3=3 2=4 1=5 else =./* creating varible as in issp */
tab ss

*political 
tab partyid1
capture drop lr
gen lr = partyid1
recode lr 2=1 1 =0 else =.
tab lr

*demographics  
tab rsex
capture drop fem
gen fem =rsex
recode fem 1=0 2=1
tab fem 

tab rage
capture drop age 
gen age =rage 
recode rage 99=.


tab marstat
capture drop married 
gen married =marstat
recode married 1=1  2=1 9=. else=0
tab married 

tab edqual15
capture drop degree
gen degree =edqual15
recode degree 15=1



*adding social stafcation via soc90 and isco88 

*respondent
capture drop soc90
capture drop isco88

tab1 rocccode 
gen oug88 =  rocccode
do H:\thesis_analysis\do_files\my_dofiles\other\oug88tosoc90.do

gen SOC90= soc90
capture drop emstat
capture drop soe
capture drop sic80c

gen emstat = rempstat
recode emstat 0=. 1=4 2=4 3=5 9=1 8=3 5=2 6=2 7=2 4=9 11=9
gen soe= rempwork
recode soe -1=9 0=1 1=1 2=1 3=2 4=2 5=3 8=9 9=9
gen sic80c = rindclas
recode sic80c 50=1 -9=9 else=2

do H:\thesis_analysis\do_files\my_dofiles\other\soc90toisco88.do

gen ISCO88 = isco88


*spouse
capture drop soc90
capture drop isco88
capture drop oug88
tab1  socccode 
gen oug88 =  socccode
do H:\thesis_analysis\do_files\my_dofiles\other\oug88tosoc90.do

gen SSOC90= soc90
capture drop emstat
capture drop soe
capture drop sic80c

gen emstat = sempstat
recode emstat 0=9 1=4 2=4 3=5 9=1 8=3 5=2 6=2 7=2 4=9 10=1 11=9
gen soe= sempwork
recode soe -1=9 0=1 1=1 2=1 3=2 4=2 5=3 8=9 9=9
gen sic80c = sindclas
recode sic80c 50=1 999=9 -9=9 else=2

do H:\thesis_analysis\do_files\my_dofiles\other\soc90toisco88.do

gen SPISCO88 = isco88
drop isco88

*adding social strat 
tab1 remploye semploye rsuper ssuper spartful ejbhrcat sjbhrca
gen sex = rsex

gen self_emp =  remploye
recode self_emp 0=. 1=0 2=1 
gen s_self_emp = semploye
recode s_self_emp 0=. 1=0 2=1 8=. 9=. 

gen superv = rsuper
recode superv -1=. 0=0 1/8000=1 9998=. 9999=.
gen s_superv = ssuper
recode s_superv -1=. 0=0 1/8000=1 9998=. 9999=.

capture drop fulltime
gen fulltime=0
replace fulltime = 1 if ejbhrcat == 4 
replace fulltime = 1 if sjbhrcat == 4 
gen s_fulltime = spartful
recode s_fulltime 0=.  1=1 2=0

replace ISCO88 =. if ISCO88<=0
replace SPISCO88 =. if SPISCO88<=0

do $output\adding_strat_to_issp.do

sav $c7data\uk1985.dta, replace



**********************usa********************
use H:\thesis_analysis\data\secondary_data\issp\gender_inequality\FG1988.dta, clear 

numlabel _all, add

tab  v3
keep if v3==4

capture drop year 
gen year = 1988

*self-rate strat 
tab v93
gen ss =v93

*political 
 tab v84
gen lr = v84
recode lr 1=1 2=1 3=1 4=. 5=0 6=0 7=0 95=.



*demographics  
tab v65
capture drop fem
gen fem =v65
recode fem 1=0 2=1

tab v66
capture drop age 
gen age =v66 
recode age 99=.

tab v67
capture drop married 
gen married =v67
recode married 1=1  else=0

tab v70
capture drop degree
gen degree = 0
replace degree =1 if v70 ==5
replace degree =1 if v70 ==6

*creating isco88  

*turning  usa soc70 into isco88 
tab v73
capture drop ussoc70
gen ussoc70 = v73
capture drop isco88 
do H:\thesis_analysis\do_files\my_dofiles\other\ussoc70toisco88.do

gen ISCO88 = isco88 
drop isco88
tab v99
capture drop ussoc70
gen ussoc70 = v99
capture drop isco88 
do H:\thesis_analysis\do_files\my_dofiles\other\ussoc70toisco88.do

gen SPISCO88 = isco88 
drop isco88
** adding strat 

gen sex = v65

tab v77
gen self_emp=  v77
recode self_emp 1=1 3=0
tab v98
gen s_self_emp =  v98
recode s_self_emp 1=1 3=0

tab v78
gen superv = v78
recode superv 1=1 0=2
gen s_superv=0

tab v71
gen fulltime =   v71
recode fulltime 1=1 2=0 3=0 4=5 5=0 6=7 7=0 8=0 9=0 10=0
tab v97
gen s_fulltime =  v97
recode s_fulltime 1=1 2=0 3=0 4=5 5=0 6=7 7=0 8=0 9=0 10=0

replace ISCO88 =. if ISCO88<=0
replace SPISCO88 =. if SPISCO88<=0

do $output\adding_strat_to_issp.do

sav $c7data\us1988.dta, replace





***********************************************************************************
*****************************1990's***************************************************
***********************************************************************************

****************
*uk
****************

*bsa 1996
use H:\thesis_analysis\data\secondary_data\bsa\bsa96, clear

numlabel _all, add

gen year= 1996

*self rated social class
tab srsoccl
gen ss = srsoccl
recode ss 5=1 4=2 2=4 1=5  8=. 9=. /* creating varible as in issp */

*political 
tab partyid1
gen lr = partyid1
recode lr 2=1 1=0 else =.


tab rsex
capture drop fem
gen fem =rsex
recode fem 1=0 2=1

tab rage
capture drop age
gen age = rage
recode age 98/99 =.

tab married
recode married 1=1  9=. else=0

tab edqual15
capture drop degree
gen degree =edqual15
recode degree  -1=. 15=1 99=.


***creating isco88

capture drop soc90
capture drop isco88
capture drop emstat
capture drop soe
capture drop sic80c

gen soc90= rsoc
gen emstat = rempstat
recode emstat -1=. 1=4 2=4 3=5 9=1 8=3 5=2 6=2 7=2 4=9 11=9
gen soe= rempwork
recode soe 0=1 1=1 2=1 3=2 4=2 5=3 8=9 9=9
gen sic80c = rsic92
recode sic80c 45=1 -3/-2=9 else=2
do H:\thesis_analysis\do_files\my_dofiles\other\soc90toisco88.do
gen ISCO88 = isco88

capture drop soc90
capture drop isco88
capture drop emstat
capture drop soe
capture drop sic80c


gen soc90= ssoc
gen emstat = sempstat
recode emstat -1=. -2=. 1=4 2=4 3=5 9=1 8=3 5=2 6=2 7=2 4=9 11=9
gen soe= sempwork
recode soe 0=1 1=1 2=1 3=2 4=2 5=3 8=9 9=9
gen sic80c = ssic92
recode sic80c 45=1 -3/-2=9 else=2
do H:\thesis_analysis\do_files\my_dofiles\other\soc90toisco88.do
gen SPISCO88 = isco88

capture drop soc90
capture drop isco88
capture drop emstat
capture drop soe
capture drop sic80c

*social strat 
tab1 remploye semploye rsuper ssuper spartful
gen sex = rsex
gen self_emp=  remploye
recode self_emp  1=0 2=1 8=.
gen s_self_emp = semploye
recode s_self_emp 1=0 2=1 8=. 9=.

gen superv = rsuper 
recode superv  0=0 1/8000=1 9998=. 9999=.
gen s_superv = ssuper
recode s_superv 0=0 1/8000=1 9998=. 9999=. -2=. -1=. 

gen fulltime =  rpartful
recode fulltime 1=1 2=0 8=. 9=.
  
gen s_fulltime = spartful
recode s_fulltime 1=1 2=0 8=. 9=.

replace ISCO88 =. if ISCO88<=0
replace SPISCO88 =. if SPISCO88<=0
do $output\adding_strat_to_issp.do


sav $c7data\uk1996.dta, replace

*
*********************************************
*USA 
*********************************************

use H:\thesis_analysis\data\secondary_data\issp\gender_inequality\ZA2620.dta, clear
numlabel _all, add
tab v3
keep if v3 == 6

capture drop year
gen year= 1994


*self-rate strat 
tab v221
gen ss =v221

*political 
tab v245
gen lr =  v245
recode lr 1=1 2=1 3=1 4=. 5=0 6=0 7=0




*demographics 
tab v200
capture drop fem
gen fem =v200
recode fem 1=0 2=1

tab v201
capture drop age 
gen age =v201

tab v202
capture drop married 
gen married =v202
recode married 1=1 else=0

tab v205
capture drop degree
gen degree =0
replace degree =1 if v205==6
replace degree =1 if v205==7

*social strat 
gen isco68 = v208
do H:\thesis_analysis\do_files\my_dofiles\other\isco68to88.do
rename isco88 ISCO88
capture drop isco88
capture drop isco68

gen isco68 = v210
do H:\thesis_analysis\do_files\my_dofiles\other\isco68to88.do
rename isco88 SPISCO88
capture drop isco88
capture drop isco68

gen sex = v200
tab v213
gen self_emp =   v213
recode self_emp 1=1 2=0
gen s_self_emp=0

tab v216
gen superv = v216
recode superv 1=1 2=0
gen s_superv=0

tab v206
gen fulltime =0
replace fulltime =1 if v206 ==1

tab v207
gen s_fulltime =0
replace s_fulltime =1 if v207 ==1

replace ISCO88 =. if ISCO88<=0
replace SPISCO88 =. if SPISCO88<=0

do $output\adding_strat_to_issp.do

sav $c7data\us1994.dta, replace





***********************************************************************************
*****************************2000's***************************************************
***********************************************************************************

use $issp\work\w1.dta , clear 
*numlabel _all, add
tab COUNTRY
keep if COUNTRY == 6 | COUNTRY == 4 
capture drop year 
gen year= 2005


*ss
tab  TOPBOT if COUNTRY ==4
tab  TOPBOT if COUNTRY ==6
gen ss= TOPBOT


*politics 
tab1 GB_PRTY US_PRTY
 
capture drop lr
gen lr= .

replace lr= 1 if GB_PRTY  == 2 
replace lr= 0 if GB_PRTY  == 1 


replace lr= 1 if US_PRTY  == 1
replace lr= 1 if US_PRTY  == 2
replace lr= 1 if US_PRTY  == 3

replace lr= 0 if US_PRTY  == 5 
replace lr= 0 if US_PRTY  == 6
replace lr= 0 if US_PRTY  == 7

tab lr GB_PRTY
tab lr US_PRTY
 
*demographic
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

tab DEGREE
capture drop degree
gen degree = 0
replace degree =1 if DEGREE ==5


*social strat 

tab1 ISCO88 SPISCO88

 tab1 WRKTYPE SPWRKTYP WRKSUP  WRKST  SPWRKST

 gen sex=SEX
 
gen self_emp = 0
replace self_emp =1 if WRKTYPE  ==4
 
gen s_self_emp = 0
replace s_self_emp =1 if SPWRKTYP  ==4

gen superv =0
replace superv =1 if WRKSUP   ==1
gen s_superv=0

gen fulltime =0
replace fulltime =1 if WRKST  ==1

gen s_fulltime =0
replace s_fulltime =1 if SPWRKST  ==1

replace ISCO88 =. if ISCO88==.n
replace ISCO88 =. if ISCO88==.a
replace SPISCO88 =. if SPISCO88==.n
replace SPISCO88 =. if SPISCO88==.a


do $output\adding_strat_to_issp.do

sav $c7data\ukus2005.dta, replace



***********************************************************************************
*****************************2010's***************************************************
***********************************************************************************

*self-rate strat 2016 issp 
use H:\thesis_analysis\data\secondary_data\issp\political\p2016, clear
numlabel _all, add
tab country
keep if country == 826 | country == 840

capture drop year 
gen year= 2016

*self rate social class
tab TOPBOT if country ==840
tab TOPBOT if country ==826
gen ss= TOPBOT
recode ss 98=. 99=.

tab SEX
capture drop fem
gen fem =SEX
recode fem 1=0 2=1 9=.

tab AGE
capture drop age 
gen age = AGE
recode age 999=.

tab MARITAL
capture drop married 
gen married =MARITAL
recode married 1=1 2=1 7/9=. else=0

tab DEGREE
capture drop degree
gen degree =0
replace degree =1 if DEGREE==5 
replace degree =1 if DEGREE==6



*social strat 
capture drop isco08
gen isco08 = ISCO08
do H:\thesis_analysis\do_files\my_dofiles\other\isco08toisco88
gen ISCO88=isco88
capture drop isco08
capture drop isco88

gen isco08= SPISCO08
do H:\thesis_analysis\do_files\my_dofiles\other\isco08toisco88
gen SPISCO88=isco88
capture drop isco08
capture drop isco88


gen sex = SEX

tab  EMPREL
gen self_emp = EMPREL
recode self_emp 0=. 1=0 2=1 3=1 9=.
tab SPEMPREL
gen s_self_emp = SPEMPREL
recode s_self_emp 0=. 1=0 2=1 5=1 9=.

tab WRKSUP
gen superv = WRKSUP
recode superv 0=. 1=1 2=0 8=. 9=.

tab SPWRKSUP
gen s_superv =SPWRKSUP
recode s_superv 0=. 1=1 2=0 8=. 9=.
 
gen fulltime=0
replace fulltime =1 if WRKHRS >=35 & WRKHRS <97
replace fulltime =. if WRKHRS >=97

gen s_fulltime=0
replace s_fulltime =1 if SPWRKHRS >=35 & SPWRKHRS <97
replace s_fulltime =. if SPWRKHRS >=97

replace ISCO88 =. if ISCO88<=0
replace SPISCO88 =. if SPISCO88<=0

do $output\adding_strat_to_issp.do

sav  $c7data\ukus2016.dta, replace

*******

use $issp\gender_inequality\FG2012.dta, clear
numlabel _all, add
tab V3
keep if V3 == 840 | V3 == 82601

capture drop year 
gen year= 2012


*political 
tab GB_PRTY
tab US_PRTY

gen lr =.
replace lr =1 if GB_PRTY ==2
replace lr =0 if GB_PRTY ==1

replace lr =1 if US_PRTY ==2
replace lr =0 if US_PRTY ==6


tab SEX
capture drop fem
gen fem =SEX
recode fem 1=0 2=1 9=.

tab AGE
capture drop age 
gen age = AGE
recode age 999=.

tab MARITAL
capture drop married 
gen married =MARITAL
recode married 1=1 2=1 7/9=. else=0

tab DEGREE
capture drop degree
gen degree = 0
replace degree = 1 if DEGREE==5
replace degree = 1 if DEGREE==6



*social strat 
*gen ISCO88 = ISCO88
*gen SPISCO88 = SPISCO88
gen sex = SEX

tab  EMPREL
gen self_emp = EMPREL
recode self_emp 0=. 1=0 2=1 3=1 9=.
tab SPEMPREL
gen s_self_emp = SPEMPREL
recode s_self_emp 0=. 1=0 2=1 5=1 9=.

tab WRKSUP 
gen superv = WRKSUP
recode superv 0=. 1=1 2=0 8=. 9=.

gen s_superv =0

 
gen fulltime=0
replace fulltime =1 if WRKHRS >=35 & WRKHRS <97
replace fulltime =. if WRKHRS >=97

gen s_fulltime=0
replace s_fulltime =1 if SPWRKHRS >=35 & SPWRKHRS <97
replace s_fulltime =. if SPWRKHRS >=97


replace ISCO88 =. if ISCO88<=0
replace SPISCO88 =. if SPISCO88<=0

do $output\adding_strat_to_issp.do

sav  $c7data\ukus2012.dta, replace



*********************************************************************************
**creating merged files for anaylsis 

*merging uk files 
use H:\thesis_analysis\data\my_data\c7\uk1985.dta, clear 

keep  spdom ISCO88 SPISCO88 year ss lr fem age married degree sex trei isei  icam  ///
s_trei s_isei s_icam  tradicam  tradisei tradtrei ///
domicam  domisei domtrei highicam highisei hightrei  ///
meanicam  meanisei meantrei addicam addisei addtrei ///
z2icam  z2isei z2trei z2tradicam  z2tradisei z2tradtrei ///
ffcamsis msei fsei z2ffcamsis z2msei z2fsei ///
z2domicam z2domisei z2domtrei ///
z2highicam  z2highisei z2hightrei ///
z2meanicam  z2meanisei z2meantrei ///
z2addicam  z2addisei z2addtrei ///
fem_z2icam fem_z2isei fem_z2trei ///
fem_z2tradicam   fem_z2tradisei fem_z2tradtrei ///
fem_z2domicam   fem_z2domisei fem_z2domtrei ///
fem_z2highicam   fem_z2highisei fem_z2hightrei ///
fem_z2meanicam  fem_z2meanisei fem_z2meantrei ///
fem_z2addicam   fem_z2addisei fem_z2addtrei 

sav $c7data\ukmerge1.dta, replace



use H:\thesis_analysis\data\my_data\c7\uk1996.dta

keep  spdom ISCO88 SPISCO88 year ss lr fem age married degree sex trei isei  icam  ///
s_trei s_isei s_icam  tradicam  tradisei tradtrei ///
domicam  domisei domtrei highicam highisei hightrei  ///
meanicam  meanisei meantrei addicam addisei addtrei ///
z2icam  z2isei z2trei z2tradicam  z2tradisei z2tradtrei ///
ffcamsis msei fsei z2ffcamsis z2msei z2fsei ///
z2domicam z2domisei z2domtrei ///
z2highicam  z2highisei z2hightrei ///
z2meanicam  z2meanisei z2meantrei ///
z2addicam  z2addisei z2addtrei ///
fem_z2icam fem_z2isei fem_z2trei ///
fem_z2tradicam   fem_z2tradisei fem_z2tradtrei ///
fem_z2domicam   fem_z2domisei fem_z2domtrei ///
fem_z2highicam   fem_z2highisei fem_z2hightrei ///
fem_z2meanicam  fem_z2meanisei fem_z2meantrei ///
fem_z2addicam   fem_z2addisei fem_z2addtrei 

sav $c7data\ukmerge2.dta, replace

use H:\thesis_analysis\data\my_data\c7\ukus2005.dta
tab COUNTRY
keep if COUNTRY ==4
keep  spdom ISCO88 SPISCO88 year  lr fem age married degree sex trei isei  icam  ///
s_trei s_isei s_icam  tradicam  tradisei tradtrei ///
domicam  domisei domtrei highicam highisei hightrei  ///
meanicam  meanisei meantrei addicam addisei addtrei ///
z2icam  z2isei z2trei z2tradicam  z2tradisei z2tradtrei ///
ffcamsis msei fsei z2ffcamsis z2msei z2fsei ///
z2domicam z2domisei z2domtrei ///
z2highicam  z2highisei z2hightrei ///
z2meanicam  z2meanisei z2meantrei ///
z2addicam  z2addisei z2addtrei ///
fem_z2icam fem_z2isei fem_z2trei ///
fem_z2tradicam   fem_z2tradisei fem_z2tradtrei ///
fem_z2domicam   fem_z2domisei fem_z2domtrei ///
fem_z2highicam   fem_z2highisei fem_z2hightrei ///
fem_z2meanicam  fem_z2meanisei fem_z2meantrei ///
fem_z2addicam   fem_z2addisei fem_z2addtrei 

sav $c7data\ukmerge3.dta, replace

use H:\thesis_analysis\data\my_data\c7\ukus2012.dta
tab V3
keep if V3 == 82601
keep year  spdom ISCO88 SPISCO88 lr  fem age married degree sex trei isei  icam  ///
s_trei s_isei s_icam  tradicam  tradisei tradtrei ///
domicam  domisei domtrei highicam highisei hightrei  ///
meanicam  meanisei meantrei addicam addisei addtrei ///
z2icam  z2isei z2trei z2tradicam  z2tradisei z2tradtrei ///
ffcamsis msei fsei z2ffcamsis z2msei z2fsei ///
z2domicam z2domisei z2domtrei ///
z2highicam  z2highisei z2hightrei ///
z2meanicam  z2meanisei z2meantrei ///
z2addicam  z2addisei z2addtrei ///
fem_z2icam fem_z2isei fem_z2trei ///
fem_z2tradicam   fem_z2tradisei fem_z2tradtrei ///
fem_z2domicam   fem_z2domisei fem_z2domtrei ///
fem_z2highicam   fem_z2highisei fem_z2hightrei ///
fem_z2meanicam  fem_z2meanisei fem_z2meantrei ///
fem_z2addicam   fem_z2addisei fem_z2addtrei 
sav $c7data\ukmerge4.dta, replace

use H:\thesis_analysis\data\my_data\c7\ukus2016.dta
tab country
keep if country == 826
keep  spdom ISCO88 SPISCO88 year ss  fem age married degree sex trei isei  icam  ///
s_trei s_isei s_icam  tradicam  tradisei tradtrei ///
domicam  domisei domtrei highicam highisei hightrei  ///
meanicam  meanisei meantrei addicam addisei addtrei ///
z2icam  z2isei z2trei z2tradicam  z2tradisei z2tradtrei ///
ffcamsis msei fsei z2ffcamsis z2msei z2fsei ///
z2domicam z2domisei z2domtrei ///
z2highicam  z2highisei z2hightrei ///
z2meanicam  z2meanisei z2meantrei ///
z2addicam  z2addisei z2addtrei ///
fem_z2icam fem_z2isei fem_z2trei ///
fem_z2tradicam   fem_z2tradisei fem_z2tradtrei ///
fem_z2domicam   fem_z2domisei fem_z2domtrei ///
fem_z2highicam   fem_z2highisei fem_z2hightrei ///
fem_z2meanicam  fem_z2meanisei fem_z2meantrei ///
fem_z2addicam   fem_z2addisei fem_z2addtrei 
sav $c7data\ukmerge5.dta, replace

use $c7data\ukmerge1.dta, clear 
append using  $c7data\ukmerge2.dta
append using  $c7data\ukmerge3.dta
append using  $c7data\ukmerge4.dta
append using  $c7data\ukmerge5.dta
tab year
gen year2 = year
recode year2 1985= 1980 1988=1980 1994=1990 1996=1990 2005=2000 2012=2010 2016=2010
tab year2
save  $c7data\ukmerge.dta, replace

**usa


use $c7data\us1988.dta, clear 

keep  spdom ISCO88 SPISCO88 year ss lr fem age married degree sex trei isei  icam  ///
s_trei s_isei s_icam  tradicam  tradisei tradtrei ///
domicam  domisei domtrei highicam highisei hightrei  ///
meanicam  meanisei meantrei addicam addisei addtrei ///
z2icam  z2isei z2trei z2tradicam  z2tradisei z2tradtrei ///
ffcamsis msei fsei z2ffcamsis z2msei z2fsei ///
z2domicam z2domisei z2domtrei ///
z2highicam  z2highisei z2hightrei ///
z2meanicam  z2meanisei z2meantrei ///
z2addicam  z2addisei z2addtrei ///
fem_z2icam fem_z2isei fem_z2trei ///
fem_z2tradicam   fem_z2tradisei fem_z2tradtrei ///
fem_z2domicam   fem_z2domisei fem_z2domtrei ///
fem_z2highicam   fem_z2highisei fem_z2hightrei ///
fem_z2meanicam  fem_z2meanisei fem_z2meantrei ///
fem_z2addicam   fem_z2addisei fem_z2addtrei 

sav $c7data\usmerge1.dta, replace



use  $c7data\us1994.dta, clear 
keep   spdom ISCO88 SPISCO88 year ss lr fem age married degree sex trei isei  icam  ///
s_trei s_isei s_icam  tradicam  tradisei tradtrei ///
domicam  domisei domtrei highicam highisei hightrei  ///
meanicam  meanisei meantrei addicam addisei addtrei ///
z2icam  z2isei z2trei z2tradicam  z2tradisei z2tradtrei ///
ffcamsis msei fsei z2ffcamsis z2msei z2fsei ///
z2domicam z2domisei z2domtrei ///
z2highicam  z2highisei z2hightrei ///
z2meanicam  z2meanisei z2meantrei ///
z2addicam  z2addisei z2addtrei ///
fem_z2icam fem_z2isei fem_z2trei ///
fem_z2tradicam   fem_z2tradisei fem_z2tradtrei ///
fem_z2domicam   fem_z2domisei fem_z2domtrei ///
fem_z2highicam   fem_z2highisei fem_z2hightrei ///
fem_z2meanicam  fem_z2meanisei fem_z2meantrei ///
fem_z2addicam   fem_z2addisei fem_z2addtrei 

sav $c7data\usmerge2.dta, replace

use H:\thesis_analysis\data\my_data\c7\ukus2005.dta, clear
tab COUNTRY
keep if COUNTRY ==6
keep  spdom ISCO88 SPISCO88 year ss lr fem age married degree sex trei isei  icam  ///
s_trei s_isei s_icam  tradicam  tradisei tradtrei ///
domicam  domisei domtrei highicam highisei hightrei  ///
meanicam  meanisei meantrei addicam addisei addtrei ///
z2icam  z2isei z2trei z2tradicam  z2tradisei z2tradtrei ///
ffcamsis msei fsei z2ffcamsis z2msei z2fsei ///
z2domicam z2domisei z2domtrei ///
z2highicam  z2highisei z2hightrei ///
z2meanicam  z2meanisei z2meantrei ///
z2addicam  z2addisei z2addtrei ///
fem_z2icam fem_z2isei fem_z2trei ///
fem_z2tradicam   fem_z2tradisei fem_z2tradtrei ///
fem_z2domicam   fem_z2domisei fem_z2domtrei ///
fem_z2highicam   fem_z2highisei fem_z2hightrei ///
fem_z2meanicam  fem_z2meanisei fem_z2meantrei ///
fem_z2addicam   fem_z2addisei fem_z2addtrei 

sav $c7data\usmerge3.dta, replace

use H:\thesis_analysis\data\my_data\c7\ukus2012.dta, clear 
tab V3
keep if V3 == 840
keep   spdom ISCO88 SPISCO88 year lr  fem age married degree sex trei isei  icam  ///
s_trei s_isei s_icam  tradicam  tradisei tradtrei ///
domicam  domisei domtrei highicam highisei hightrei  ///
meanicam  meanisei meantrei addicam addisei addtrei ///
z2icam  z2isei z2trei z2tradicam  z2tradisei z2tradtrei ///
ffcamsis msei fsei z2ffcamsis z2msei z2fsei ///
z2domicam z2domisei z2domtrei ///
z2highicam  z2highisei z2hightrei ///
z2meanicam  z2meanisei z2meantrei ///
z2addicam  z2addisei z2addtrei ///
fem_z2icam fem_z2isei fem_z2trei ///
fem_z2tradicam   fem_z2tradisei fem_z2tradtrei ///
fem_z2domicam   fem_z2domisei fem_z2domtrei ///
fem_z2highicam   fem_z2highisei fem_z2hightrei ///
fem_z2meanicam  fem_z2meanisei fem_z2meantrei ///
fem_z2addicam   fem_z2addisei fem_z2addtrei 
sav $c7data\usmerge4.dta, replace

use H:\thesis_analysis\data\my_data\c7\ukus2016.dta, clear 
tab country
keep if country == 840
keep  spdom ISCO88 SPISCO88 year ss  fem age married degree sex trei isei  icam  ///
s_trei s_isei s_icam  tradicam  tradisei tradtrei ///
domicam  domisei domtrei highicam highisei hightrei  ///
meanicam  meanisei meantrei addicam addisei addtrei ///
z2icam  z2isei z2trei z2tradicam  z2tradisei z2tradtrei ///
ffcamsis msei fsei z2ffcamsis z2msei z2fsei ///
z2domicam z2domisei z2domtrei ///
z2highicam  z2highisei z2hightrei ///
z2meanicam  z2meanisei z2meantrei ///
z2addicam  z2addisei z2addtrei ///
fem_z2icam fem_z2isei fem_z2trei ///
fem_z2tradicam   fem_z2tradisei fem_z2tradtrei ///
fem_z2domicam   fem_z2domisei fem_z2domtrei ///
fem_z2highicam   fem_z2highisei fem_z2hightrei ///
fem_z2meanicam  fem_z2meanisei fem_z2meantrei ///
fem_z2addicam   fem_z2addisei fem_z2addtrei 
sav $c7data\usmerge5.dta, replace

use $c7data\usmerge1.dta, clear 
append using  $c7data\usmerge2.dta
append using  $c7data\usmerge3.dta
append using  $c7data\usmerge4.dta
append using  $c7data\usmerge5.dta
tab year
gen year2 = year
recode year2  1988=1980 1994=1990  2005=2000 2012=2010 2016=2010
tab year2
save  $c7data\usmerge, replace
