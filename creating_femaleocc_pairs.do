clear all
set more off
capture log close
set scheme s1mono

global pathdata "H:\thesis_analysis\data\my_data\"
global pathbhps "H:\thesis_analysis\data\secondary_data\bhps\"
global pathdo "H:\thesis_analysis\do_files\"
global pathb "http://www.camsis.stir.ac.uk/make_camsis/templates/camsis_psds_blank.txt"
global pathf "H:\thesis_analysis\data\my_data\camsis_creation\"
global pathe "http://www.camsis.stir.ac.uk/make_camsis/templates/isco88templateoccs4.dat"
**************************************************

***mergeing bhps waves that have freinds occ 

foreach wav in   b  d  h  j  l n  p  r { 
 use  pid `wav'sex `wav'casmin `wav'doby `wav'paygl ///
  `wav'jbhrs `wav'jssize `wav'payuw `wav'jbsemp `wav'jbmngr `wav'jbsize ///
  `wav'jsboss `wav'hid `wav'pno `wav'dobm  `wav'jbstat `wav'race `wav'mlstat  ///
  `wav'netsx1 `wav'netsx2 `wav'netsx3 `wav'net1wr `wav'net2wr `wav'net3wr ///
  `wav'net1ag `wav'net2ag `wav'net3ag ///
   `wav'net1ph `wav'net2ph `wav'net3ph ///
   `wav'net1jb `wav'net2jb `wav'net3jb ///
   `wav'qfedhi `wav'jbseg `wav'jbgold `wav'jbrgsc `wav'jbisco `wav'jbsoc ///
  `wav'jbcssm `wav'jbcssf `wav'jbsec `wav'spsoc `wav'netsoc `wav'vote4 using $pathbhps\`wav'indresp.dta, clear  
  renpfix `wav'  
  capture rename id pid  
  gen wave=" `wav' " 
  sav $pathf\m_`wav'.dta, replace 
 }
  
   
  

foreach wav in    b  d    h  j  l n  p  r { 
  append using $pathf\m_`wav'.dta
 }
sav $pathf\m_append.dta, replace 


**************************************************

use $pathf/m_append.dta, clear
numlabel _all, add
encode wav, gen(year)
tab wav year, nolabel 

*soc own occ 
tab jbsoc
*best friends occupation SOC code  
tab net1jb
tab netsoc 

 
 *******************************************************************************
 *Restrict data to those withg occupational info

tab jbsoc 
drop if jbsoc <100
tab jbsoc 

tab netsoc
tab netsoc if year ==1
tab netsoc if year ==2
tab netsoc if year ==3
tab netsoc if year ==4
tab netsoc if year ==5/* 2 digit*/
tab netsoc if year ==6
tab netsoc if year ==7/* 4 digit*/
tab netsoc if year ==8/* 4 digit*/

**removing years that arn't 3 digit 
drop if year == 5
drop if year ==7 
drop if year ==8
tab wav year, nolabel 

tab netsoc
drop if netsoc <100/* less than 3 didgit and invaild i.e student retierd */
drop if netsoc == 997/* isuffient detail label */

*from inspection some netsoc values are not valdi
drop if netsoc == 273
drop if netsoc == 407
drop if netsoc == 426
drop if netsoc == 456
drop if netsoc == 726
drop if netsoc == 992

sav $pathf\appended_1.dta, replace


***********************************
***creating female only sample
use $pathf\appended_1.dta, clear
tab sex
drop if sex ==1
*creating female female freind sample
tab netsx1 
keep if netsx1 ==2
sav $pathf\appended_fem.dta, replace


*duplicating so each occ counts twice 
use $pathf\appended_fem.dta, clear
rename netsoc temp 
rename jbsoc netsoc
rename temp jbsoc
save $pathf\friendrecode.dta, replace

use $pathf\appended_fem.dta, clear
append  using $pathf\friendrecode.dta
sav $pathf\appended_f.dta, replace


use $pathf\appended_f.dta, clear /*each occupation pair counted twice*/

***creating male only sample
