*********Chapter 6 
global isspsport  "H:\thesis_analysis\data\secondary_data\issp\sport_leisure"

global isspgender "H:\thesis_analysis\data\secondary_data\issp\gender_inequality"

global isspwork  "H:\thesis_analysis\data\secondary_data\issp\work"

global output "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational"

global graphmac "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\graphs\macro"

*
/*stage one country level analysis with World Bank data – 
 how differences between countries influence -  gender roles, work, leisure*/
 
use $isspgender\g3.dta, clear 
 

*looking at which countries driving the effect 

graph twoway scatter wb_lab2 wb_lab2, mlabel (COUNTRY) mlabsize (vsmall) msymbol(smcircle )  mlabgap (vsmall)
graph twoway scatter pt_WOMEN pt_WOMEN, mlabel (COUNTRY) mlabsize (vsmall) msymbol(smcircle )  mlabgap (vsmall)
graph twoway scatter  wb_manage  wb_manage , mlabel (COUNTRY) mlabsize (tiny )  mlabgap (vsmall) 
graph twoway scatter wb_seats wb_seats,  mlabel (COUNTRY) mlabsize (vsmall)  mlabgap (vsmall) 
graph twoway scatter wb_matpay wb_matpay, mlabel (COUNTRY) mlabsize (vsmall)  mlabgap (vsmall) 
graph twoway scatter gii gii ,mlabel (COUNTRY) mlabsize (vsmall)  mlabgap (vsmall) 
graph combine $graphmac\Graphlab.gph $graphmac\Graphmanage.gph $graphmac\graphptw.gph $graphmac\Graphseats.gph $graphmac\Graphmatpay.gph $graphmac\Graphgii.gph, cols(2)

*looking at how indicators correlated with gdp 
gen loggdp 	=	log(gdp )

correlate loggdp wb_lab2 pt_WOMEN  wb_manage wb_seats  wb_matpay gii pt_WOMEN

*corrlating micro DV and macro IV

*gender IV

foreach x in 3 3m 3f  3d 3md 3fd  3nd 3mnd 3fnd  3a1 3ma1 3fa1 3a2 3ma2 3fa2 3a3 3ma3 3fa3    {
use $isspgender\g`x'.dta, clear 
capture drop ptdiff 
capture drop loggdp
gen ptdiff  =  pt_WOMEN - pt_men 
gen loggdp 	=	log(gdp )
foreach var in _v4 _v5 _v7 _v6 _v11 factor1 factor2 factor3  {
log using g`x'`var', replace 
cor `var' wb_lab2 pt_WOMEN  wb_manage wb_seats  wb_matpay gii  
pcorrmat `var' wb_lab2 pt_WOMEN  wb_manage wb_seats  wb_matpay gii   , part(loggdp)
log close 
}

sav  $isspgender\g`x'.dta, replace 
}

 
 
 
 *work
 
 foreach x in 3 3m 3f  3d 3md 3fd  3nd 3mnd 3fnd  3a1 3ma1 3fa1 3a2 3ma2 3fa2 3a3 3ma3 3fa3    {
use $isspwork\w`x'.dta, clear 
capture drop ptdiff 
capture drop loggdp
gen ptdiff  =  pt_WOMEN - pt_men 
gen loggdp 	=	log(gdp )
foreach var in  _v29 _v30 _v31 _v32 _v33 _v51  _v41 _v42 _v43 factor1 factor2  {
log using w`x'`var', replace
cor `var' wb_lab2 pt_WOMEN  wb_manage wb_seats  wb_matpay gii  
pcorrmat `var' wb_lab2 pt_WOMEN  wb_manage wb_seats  wb_matpay gii   , part(loggdp)
log close 
}

sav  $isspwork\w`x'.dta, replace 
}


 


 * sport 
  foreach x in 3 3m 3f  3d 3md 3fd  3nd 3mnd 3fnd  3a1 3ma1 3fa1 3a2 3ma2 3fa2 3a3 3ma3 3fa3    {
use $isspsport\s`x'.dta, clear 
capture drop ptdiff 
capture drop loggdp
gen ptdiff  =  pt_WOMEN - pt_men 
gen loggdp 	=	log(gdp )
foreach var in  _V21 _V22 _V23 _V24 factor1 {
log using s`x'`var'
cor `var' wb_lab2 pt_WOMEN  wb_manage wb_seats  wb_matpay gii  
pcorrmat `var' wb_lab2 pt_WOMEN  wb_manage wb_seats  wb_matpay gii   , part(loggdp)
log close 
}

sav  $isspsport\s`x'.dta, replace 
}


 
}


**************************************************************************************
*stage two selected welfare state 
**************************************************************************************
*gender 
use $isspgender\g4.dta, clear 
capture drop welstate
gen welstate =. 
replace welstate =1 if COUNTRY ==2
replace welstate =1 if COUNTRY ==28
replace welstate =1 if COUNTRY ==7
replace welstate =2 if COUNTRY ==1
replace welstate =2 if COUNTRY ==4
replace welstate =2 if COUNTRY ==19
replace welstate =2 if COUNTRY ==6
replace welstate =3 if COUNTRY ==32
replace welstate =3 if COUNTRY ==13
replace welstate =3 if COUNTRY ==37
label define welstate1 1 "Con" 2 "Lib" 3 "SD"
label values welstate welstate1 

log using welfairgender, replace
tab welstate

foreach var in  _v5 _v6 _v7 _v11 {
tab  welstate `var',  chi2 gamma  V   row
}
oneway factor1 welstate , tabulate

log close 
sav $isspgender\g4.dta, replace 

*work 
use $isspwork\w4.dta, clear 
capture drop welstate
gen welstate=. 
replace welstate =1 if COUNTRY ==2
replace welstate =1 if COUNTRY ==28
replace welstate =1 if COUNTRY ==7
replace welstate =2 if COUNTRY ==1
replace welstate =2 if COUNTRY ==4
replace welstate =2 if COUNTRY ==19
replace welstate =2 if COUNTRY ==6
replace welstate =3 if COUNTRY ==32
replace welstate =3 if COUNTRY ==13
replace welstate =3 if COUNTRY ==37
label define welstate1 1 "Con" 2 "Lib" 3 "SD"
label values welstate welstate1 

log using welfairwork, replace
tab welstate

foreach var in   _v29 _v30 _v31 _v32 _v33 _v51  _v41 _v42 _v43 {
tab  welstate `var',  chi2 gamma  V   row
}

oneway factor1 welstate , tabulate

log close 
sav $isspwork\w4.dta, replace

*sport 
use $isspsport\s4.dta, clear 
capture drop welstate
gen welstate=.
replace welstate =1 if COUNTRY ==2
replace welstate =1 if COUNTRY ==28
replace welstate =1 if COUNTRY ==7

replace welstate =2 if COUNTRY ==1
replace welstate =2 if COUNTRY ==4
replace welstate =2 if COUNTRY ==19
replace welstate =2 if COUNTRY ==6

replace welstate =3 if COUNTRY ==32
replace welstate =3 if COUNTRY ==13
replace welstate =3 if COUNTRY ==37

label define welstate1 1 "Con" 2 "Lib" 3 "SD"
label values welstate welstate1 

log using welfairsport, replace
tab welstate

foreach var in  _V21 _V22 _V23 _V24 {
tab  welstate `var',  chi2 gamma  V   row
}

log close 
sav $isspsport\s4.dta, replace 
 
 /*stage three selected micro level analysis – 
 how micro lever demographics influence -  gender roles, work, leisure with in each selcted country */

 /*z2icam  	z2ukcamsis 	z2secamsis	z2isei	z2trei
z2tradicam  	z2tradukcamsis	z2tradsecamsis	z2tradisei  	z2tradtrei 
z2domicam   	z2domukcamsis	z2domsecamsis	z2domisei   	z2domtrei  
z2highicam   	z2highukcamsis	z2highsecamsis	z2highisei   	z2hightrei  
z2meanicam   	z2meanukcamsis	z2meansecamsis	z2meanisei   	z2meantrei  
z2addicam 	z2addukcamsis	z2addsecamsis	z2addisei 	z2addtrei */


 
 *gender 
do $output\gselectedmicrodatamanagement.do  
use $isspgender\g4.dta, clear 
* uk = 4 *france=28 *sweden=13

*sample  
capture drop touse
gen touse = !missing(fem, age, married, ted, ///
				z2icam,  	z2tradicam,  	z2domicam,   	z2highicam,   	z2meanicam,   	z2addicam, ///
				z2ukcamsis, z2tradukcamsis, z2domukcamsis,  z2highukcamsis, z2meanukcamsis, z2addukcamsis, ///
				z2secamsis, z2tradsecamsis, z2domsecamsis,  z2highsecamsis, z2meansecamsis, z2addsecamsis, ///
				z2isei,		z2tradisei,  	z2domisei,   	z2highisei,   	z2meanisei,   	z2addisei)	




foreach var in  z2icam  	z2tradicam  	z2domicam   	z2highicam   	z2meanicam   	z2addicam ///
				z2ukcamsis 	z2tradukcamsis  z2domukcamsis   z2highukcamsis  z2meanukcamsis  z2addukcamsis ///
				z2secamsis  z2tradsecamsis  z2domsecamsis   z2highsecamsis  z2meansecamsis 	z2addsecamsis ///
				z2isei		z2tradisei  	z2domisei   	z2highisei   	z2meanisei   	z2addisei ///
				 {

reg factor1 `var'   fem age married ted fem_ted fem_mar fem_age fem_`var' if COUNTRY==4 &  touse==1
est store `var'_uk


reg factor1  `var'   fem age married ted fem_ted fem_mar fem_age fem_`var'  if COUNTRY==28 &  touse==1
est store `var'_fr


reg factor1 `var'   fem age married ted fem_ted fem_mar fem_age fem_`var'  if COUNTRY==13 &  touse==1
est store `var'_se

}

gen touse2 = !missing(fem, age, married, ted, z2ffcamsis, z2ukcamsis, z2secamsis, z2icam) 

foreach var in z2ffcamsis z2ukcamsis z2secamsis z2icam{
reg factor1 `var'   age married ted  if COUNTRY==4 &  touse2==1 & fem==1
est store gs_`var'_uk


reg factor1 `var'  age married ted  if COUNTRY==13 &  touse2==1 &fem==1
est store gs_`var'_se

}
gen touse3 = !missing(fem, age, married, ted, z2isei, z2fsei) 
 
foreach var in z2isei z2fsei{
reg factor1 `var'   age married ted  if COUNTRY==4 &  touse3==1 & fem==1
est store gs_`var'_uk


reg factor1 `var'  age married ted  if COUNTRY==13 &  touse3==1 &fem==1
est store gs_`var'_se

}

*uk
*icam
esttab z2icam_uk	z2tradicam_uk	z2domicam_uk	z2highicam_uk 	z2meanicam_uk	z2addicam_uk , r2 aic bic  ///
                                 cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		
*camsis								
esttab z2ukcamsis_uk 	z2tradukcamsis_uk  z2domukcamsis_uk   z2highukcamsis_uk  z2meanukcamsis_uk  z2addukcamsis_uk, r2 aic bic  ///
                                 cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles									
*isei
esttab z2isei_uk	z2tradisei_uk  z2domisei_uk   z2highisei_uk   z2meanisei_uk   z2addisei_uk ,r2 aic bic  ///
                                 cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		
*gs

esttab gs_z2ffcamsis_uk gs_z2ukcamsis_uk gs_z2icam_uk gs_z2isei_uk gs_z2fsei_uk,r2 aic bic  ///
                                cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles									
						
*France 
*Icam
esttab z2icam_fr	z2tradicam_fr	z2domicam_fr	z2highicam_fr 	z2meanicam_fr	z2addicam_fr, r2 aic bic  ///
                                 cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		
*camsis								
esttab z2ukcamsis_fr 	z2tradukcamsis_fr  z2domukcamsis_fr   z2highukcamsis_fr  z2meanukcamsis_fr  z2addukcamsis_fr, r2 aic bic  ///
                                 cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles									
*isei
esttab z2isei_fr	z2tradisei_fr  z2domisei_fr   z2highisei_fr   z2meanisei_fr   z2addisei_fr ,r2 aic bic  ///
                                 cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		

*Sweden 
*Icam
esttab z2icam_se	z2tradicam_se	z2domicam_se	z2highicam_se 	z2meanicam_se	z2addicam_se , r2 aic bic  ///
                                 cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		
*camsis								
esttab z2secamsis_se 	z2tradsecamsis_se  z2domsecamsis_se   z2highsecamsis_se  z2meansecamsis_se  z2addsecamsis_se, r2 aic bic  ///
                                 cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles									
*isei
esttab z2isei_se	z2tradisei_se  z2domisei_se   z2highisei_se   z2meanisei_se   z2addisei_se ,r2 aic bic  ///
                                 cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		
esttab gs_z2ffcamsis_se gs_z2secamsis_se gs_z2icam_se gs_z2isei_se gs_z2fsei_se ,r2 aic bic  ///
                                cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles	

 
 
 *work
do $output\wselectedmicrodatamanagement.do
use $isspwork\w4.dta, clear 
* uk = 4 *france=28 *sweden=13

capture drop touse
gen touse = !missing(fem, age, married, ted, ///
				z2icam,  	z2tradicam,  	z2domicam,   	z2highicam,   	z2meanicam,   	z2addicam, ///
				z2ukcamsis, z2tradukcamsis, z2domukcamsis,  z2highukcamsis, z2meanukcamsis, z2addukcamsis, ///
				z2secamsis, z2tradsecamsis, z2domsecamsis,  z2highsecamsis, z2meansecamsis, z2addsecamsis, ///
				z2isei,		z2tradisei,  	z2domisei,   	z2highisei,   	z2meanisei,   	z2addisei)	




foreach var in  z2icam  	z2tradicam  	z2domicam   	z2highicam   	z2meanicam   	z2addicam ///
				z2ukcamsis 	z2tradukcamsis  z2domukcamsis   z2highukcamsis  z2meanukcamsis  z2addukcamsis ///
				z2secamsis  z2tradsecamsis  z2domsecamsis   z2highsecamsis  z2meansecamsis 	z2addsecamsis ///
				z2isei		z2tradisei  	z2domisei   	z2highisei   	z2meanisei   	z2addisei ///
				 {

reg factor1 `var'   fem age married ted fem_ted fem_mar fem_age fem_`var' if COUNTRY==4 &  touse==1
est store `var'_uk


reg factor1  `var'   fem age married ted fem_ted fem_mar fem_age fem_`var'  if COUNTRY==28 &  touse==1
est store `var'_fr


reg factor1 `var'   fem age married ted fem_ted fem_mar fem_age fem_`var'  if COUNTRY==13 &  touse==1
est store `var'_se

}

gen touse2 = !missing(fem, age, married, ted, z2ffcamsis, z2ukcamsis, z2secamsis, z2icam) 

foreach var in z2ffcamsis z2ukcamsis z2secamsis z2icam{
reg factor1 `var'   age married ted  if COUNTRY==4 &  touse2==1 & fem==1
est store gs_`var'_uk


reg factor1 `var'  age married ted  if COUNTRY==13 &  touse2==1 &fem==1
est store gs_`var'_se

}
gen touse3 = !missing(fem, age, married, ted, z2isei, z2fsei) 
 
foreach var in z2isei z2fsei{
reg factor1 `var'   age married ted  if COUNTRY==4 &  touse3==1 & fem==1
est store gs_`var'_uk


reg factor1 `var'  age married ted  if COUNTRY==13 &  touse3==1 &fem==1
est store gs_`var'_se

}

*uk
*icam
esttab z2icam_uk	z2tradicam_uk	z2domicam_uk	z2highicam_uk 	z2meanicam_uk	z2addicam_uk , r2 aic bic  ///
                                 cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		
*camsis								
esttab z2ukcamsis_uk 	z2tradukcamsis_uk  z2domukcamsis_uk   z2highukcamsis_uk  z2meanukcamsis_uk  z2addukcamsis_uk, r2 aic bic  ///
                                 cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles									
*isei
esttab z2isei_uk	z2tradisei_uk  z2domisei_uk   z2highisei_uk   z2meanisei_uk   z2addisei_uk ,r2 aic bic  ///
                                 cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		
*gs

esttab gs_z2ffcamsis_uk gs_z2ukcamsis_uk gs_z2icam_uk gs_z2isei_uk gs_z2fsei_uk,r2 aic bic  ///
                                cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles									
						
*France 
*Icam
esttab z2icam_fr	z2tradicam_fr	z2domicam_fr	z2highicam_fr 	z2meanicam_fr	z2addicam_fr, r2 aic bic  ///
                                 cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		
*camsis								
esttab z2ukcamsis_fr 	z2tradukcamsis_fr  z2domukcamsis_fr   z2highukcamsis_fr  z2meanukcamsis_fr  z2addukcamsis_fr, r2 aic bic  ///
                                 cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles									
*isei
esttab z2isei_fr	z2tradisei_fr  z2domisei_fr   z2highisei_fr   z2meanisei_fr   z2addisei_fr ,r2 aic bic  ///
                                 cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		

*Sweden 
*Icam
esttab z2icam_se	z2tradicam_se	z2domicam_se	z2highicam_se 	z2meanicam_se	z2addicam_se , r2 aic bic  ///
                                 cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		
*camsis								
esttab z2secamsis_se 	z2tradsecamsis_se  z2domsecamsis_se   z2highsecamsis_se  z2meansecamsis_se  z2addsecamsis_se, r2 aic bic  ///
                                 cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles									
*isei
esttab z2isei_se	z2tradisei_se  z2domisei_se   z2highisei_se   z2meanisei_se   z2addisei_se ,r2 aic bic  ///
                                 cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		
esttab gs_z2ffcamsis_se gs_z2secamsis_se gs_z2icam_se gs_z2isei_se gs_z2fsei_se ,r2 aic bic  ///
                                cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles	

 
 **sport 
 
do $output\sselectedmicrodatamanagement.do
use $isspsport\s4.dta, clear 

* uk = 4 *france=28 *sweden=13
*sample  
capture drop touse
gen touse = !missing(fem, age, married, ted, ///
				z2icam,  	z2tradicam,  	z2domicam,   	z2highicam,   	z2meanicam,   	z2addicam, ///
				z2ukcamsis, z2tradukcamsis, z2domukcamsis,  z2highukcamsis, z2meanukcamsis, z2addukcamsis, ///
				z2secamsis, z2tradsecamsis, z2domsecamsis,  z2highsecamsis, z2meansecamsis, z2addsecamsis, ///
				z2isei,		z2tradisei,  	z2domisei,   	z2highisei,   	z2meanisei,   	z2addisei)	




foreach var in  z2icam  	z2tradicam  	z2domicam   	z2highicam   	z2meanicam   	z2addicam ///
				z2ukcamsis 	z2tradukcamsis  z2domukcamsis   z2highukcamsis  z2meanukcamsis  z2addukcamsis ///
				z2secamsis  z2tradsecamsis  z2domsecamsis   z2highsecamsis  z2meansecamsis 	z2addsecamsis ///
				z2isei		z2tradisei  	z2domisei   	z2highisei   	z2meanisei   	z2addisei ///
				 {

logit _V23 `var'   fem age married ted fem_ted fem_mar fem_age fem_`var' if COUNTRY==4 &  touse==1
est store `var'_uk


logit _V23 `var'   fem age married ted fem_ted fem_mar fem_age fem_`var'  if COUNTRY==28 &  touse==1
est store `var'_fr


logit _V23 `var'   fem age married ted fem_ted fem_mar fem_age fem_`var'  if COUNTRY==13 &  touse==1
est store `var'_se

}

gen touse2 = !missing(fem, age, married, ted, z2ffcamsis, z2ukcamsis, z2secamsis, z2icam) 

foreach var in z2ffcamsis z2ukcamsis z2secamsis z2icam{
logit _V23 `var'   age married ted  if COUNTRY==4 &  touse2==1 & fem==1
est store gs_`var'_uk


logit _V23 `var'  age married ted  if COUNTRY==13 &  touse2==1 &fem==1
est store gs_`var'_se

}
gen touse3 = !missing(fem, age, married, ted, z2isei, z2fsei) 
 
foreach var in z2isei z2fsei{
logit _V23 `var'   age married ted  if COUNTRY==4 &  touse3==1 & fem==1
est store gs_`var'_uk


logit _V23 `var'  age married ted  if COUNTRY==13 &  touse3==1 &fem==1
est store gs_`var'_se

}

*uk
*icam
esttab z2icam_uk	z2tradicam_uk	z2domicam_uk	z2highicam_uk 	z2meanicam_uk	z2addicam_uk , pr2  bic  ///
                                 cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		
*camsis								
esttab z2ukcamsis_uk 	z2tradukcamsis_uk  z2domukcamsis_uk   z2highukcamsis_uk  z2meanukcamsis_uk  z2addukcamsis_uk, pr2  bic  ///
                                 cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles									
*isei
esttab z2isei_uk	z2tradisei_uk  z2domisei_uk   z2highisei_uk   z2meanisei_uk   z2addisei_uk ,pr2  bic  ///
                                 cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		
*gs

esttab gs_z2ffcamsis_uk gs_z2ukcamsis_uk gs_z2icam_uk gs_z2isei_uk gs_z2fsei_uk ,pr2  bic  ///
                                cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles									
						
*France 
*Icam
esttab z2icam_fr	z2tradicam_fr	z2domicam_fr	z2highicam_fr 	z2meanicam_fr	z2addicam_fr, pr2 aic bic  ///
                                 cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		
								
*isei
esttab z2isei_fr	z2tradisei_fr  z2domisei_fr   z2highisei_fr   z2meanisei_fr   z2addisei_fr ,pr2  bic  ///
                                 cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		

*Sweden 
*Icam
esttab z2icam_se	z2tradicam_se	z2domicam_se	z2highicam_se 	z2meanicam_se	z2addicam_se , pr2  bic  ///
                                 cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		
*camsis								
esttab z2secamsis_se 	z2tradsecamsis_se  z2domsecamsis_se   z2highsecamsis_se  z2meansecamsis_se  z2addsecamsis_se, pr2  bic  ///
                                 cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles									
*isei
esttab z2isei_se	z2tradisei_se  z2domisei_se   z2highisei_se   z2meanisei_se   z2addisei_se ,pr2  bic  ///
                                 cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		
esttab gs_z2ffcamsis_se gs_z2secamsis_se gs_z2icam_se gs_z2isei_se gs_z2fsei_se ,pr2  bic  ///
                                cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles	

 
 

*********************************************************************
*stage four pooled micro level analysis – 

*********************************************************************
*PRELIMINARY PHASE: Centering Variables (corresponding to Sub-Appendix A)



import excel using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\worldbank_indicators.xlsx", firstrow clear 
sort COUNTRY
sav "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta" , replace 

use $isspgender\g4.dta, clear 
sort COUNTRY
merge m:1 COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace 
tab _merge
drop if _merge ==2
drop _merge 
capture drop z2age 
capture drop z2ted
capture drop fem_z2age
capture drop fem_z2ted
egen z2factor1 = std(factor1)
egen z2age 	=	std(age)
egen z2ted  =	std(ted)
gen fem_z2age = fem*z2age
gen fem_z2ted = fem*z2ted

fem_loggdp

gen fem_gii  = fem*gii
gen fem_loggdp = fem*loggdp 
gen fem_wb_proftech = fem*wb_proftech 
gen fem_wb_matpay = fem*wb_matpay
gen fem_wb_pteach = fem*wb_pteach
gen fem_wb_steach = fem*wb_steach 
gen fem_wb_edwork = fem*wb_edwork

gen loggdp 	=	log(gdp )

sav $isspgender\g5.dta, replace


import excel using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\worldbank_indicators.xlsx", firstrow clear 
sort COUNTRY
sav "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta" , replace 

use $isspwork\w4.dta, clear 

sort COUNTRY
merge m:1 COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace 
tab _merge
drop if _merge ==2
drop _merge 

egen z2factor1 = std(factor1)
egen z2age 	=	std(age)
egen z2ted  =	std(ted)
gen fem_gii  = fem*gii
gen fem_loggdp = fem*loggdp

gen fem_z2age = fem*z2age
gen fem_z2ted = fem*z2ted
gen fem_wb_lab2 = fem*wb_lab2
gen fem_wb_seats = fem*wb_seats 
gen fem_wb_proftech = fem*wb_proftech 
gen fem_wb_matpay = fem*wb_matpay
gen fem_wb_pteach = fem*wb_pteach
gen fem_wb_steach = fem*wb_steach 
gen fem_wb_edwork = fem*wb_edwork

gen loggdp 	=	log(gdp )
sav  $isspwork\w5.dta, replace


import excel using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\worldbank_indicators.xlsx", firstrow clear 
sort COUNTRY
sav "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta" , replace 

use $isspsport\s4.dta, clear 

sort COUNTRY
merge m:1 COUNTRY using "H:\thesis_analysis\do_files\my_dofiles\ch6_crossnational\wworldbank_indicators.dta"
destring, replace 
tab _merge
drop if _merge ==2
drop _merge 

egen z2age =	std(age)
egen z2ted  =	std(ted)
gen fem_gii  = fem*gii
gen fem_loggdp = fem*loggdp
gen fem_z2age = fem*z2age
gen fem_z2ted = fem*z2ted
gen fem_wb_lab2 = fem*wb_lab2
gen fem_wb_seats = fem*wb_seats 
gen fem_wb_proftech = fem*wb_proftech 
gen fem_wb_matpay = fem*wb_matpay
gen fem_wb_pteach = fem*wb_pteach
gen fem_wb_steach = fem*wb_steach 
gen fem_wb_edwork = fem*wb_edwork

gen loggdp 	=	log(gdp )
sav $isspsport\s5.dta, replace

*STEP #1: Building the Empty Model (corresponding to Sub-Appendix B)*


*Below are the commands to run an empty model, that is, a model containing no predictors, 
//and calculate the intraclass correlation coefficient (ICC; the degree of homogeneity of the outcome within clusters).

use $isspgender\g5.dta, clear 
xtmixed z2factor1 || COUNTRY:, var
estat icc

use $isspwork\w5.dta, clear 
xtmixed z2factor1 || COUNTRY:, var
estat icc

use $isspsport\s5.dta, clear 
xtmelogit _V23 || COUNTRY:, var
estat icc


*****************************************************************************
*STEP #2: Building the Intermediate Models (corresponding to Sub-Appendix C)*
*****************************************************************************

*If you focus on the between-observation effect of the (level-1) variable, you can use the grand-mean centered variable 
*If you focus on the within-cluster effect, use the cluster-mean centered variable 


*Below are the commands to run the constrained intermediate model (CIM; 
//the model contains all level-1 variables, all level-2 variables well as all intra-level interactions) 
//and store its deviance (the smaller the deviance, the better the fit).

use $isspgender\g5.dta, clear 
xtmixed z2factor1   fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam gii   loggdp  || COUNTRY:, var
display "FYI: The deviance of the CIM is:" -2*e(ll)
estimate store CIMi

use $isspwork\w5.dta, clear 
xtmixed z2factor1   fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam gii  loggdp  || COUNTRY:, var
display "FYI: The deviance of the CIM is:" -2*e(ll)
estimate store CIMii

use $isspsport\s5.dta, clear 
xtmelogit _V23  fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam gii   loggdp || COUNTRY:, var
display "FYI: The deviance of the CIM is:" -2*e(ll)
estimate store CIMiii

*Below are the commands to run the augmented intermediate model (AIM; 
//the model similar to the constrained intermediate model with the exception that it includes the random slope term of “gpa_cmc”) 
//and store its deviance.


*sex 
use $isspgender\g5.dta, clear 
xtmixed z2factor1   fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam gii  loggdp  || COUNTRY:fem , var
display "FYI: The deviance of the AIM is " -2*e(ll)
estimate store AIMai

use $isspwork\w5.dta, clear 
xtmixed z2factor1   fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam gii loggdp || COUNTRY: fem, var
display "FYI: The deviance of the AIM is " -2*e(ll)
estimate store AIMaii

use $isspsport\s5.dta, clear 
xtmelogit _V23  fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam gii  loggdp || COUNTRY: fem , var
display "FYI: The deviance of the AIM is " -2*e(ll)
estimate store AIMaiii

*age
use $isspgender\g5.dta, clear 
xtmixed z2factor1   fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam gii   loggdp || COUNTRY:z2age, var
display "FYI: The deviance of the AIM is " -2*e(ll)
estimate store AIMbi

use $isspwork\w5.dta, clear 
xtmixed z2factor1   fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam gii   loggdp || COUNTRY: z2age, var
display "FYI: The deviance of the AIM is " -2*e(ll)
estimate store AIMbii

use $isspsport\s5.dta, clear 
xtmelogit _V23  fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam gii   loggdp || COUNTRY:z2age , var
display "FYI: The deviance of the AIM is " -2*e(ll)
estimate store AIMbiii


*married 
use $isspgender\g5.dta, clear 
xtmixed z2factor1  fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam gii   loggdp  || COUNTRY:married , var
display "FYI: The deviance of the AIM is " -2*e(ll)
estimate store AIMci

use $isspwork\w5.dta, clear 
xtmixed z2factor1   fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam gii  loggdp  || COUNTRY: married , var
display "FYI: The deviance of the AIM is " -2*e(ll)
estimate store AIMcii

use $isspsport\s5.dta, clear 
xtmelogit _V23  fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam gii   loggdp  || COUNTRY:married  , var
display "FYI: The deviance of the AIM is " -2*e(ll)
estimate store AIMciii

*ted 
use $isspgender\g5.dta, clear 
xtmixed z2factor1   fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam gii   loggdp || COUNTRY:z2ted , var
display "FYI: The deviance of the AIM is " -2*e(ll)
estimate store AIMdi

use $isspwork\w5.dta, clear 
xtmixed z2factor1   fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam gii   loggdp || COUNTRY: z2ted , var
display "FYI: The deviance of the AIM is " -2*e(ll)
estimate store AIMdii

use $isspsport\s5.dta, clear 
xtmelogit _V23  fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam gii  loggdp   || COUNTRY:z2ted , var
display "FYI: The deviance of the AIM is " -2*e(ll)
estimate store AIMdiii

*soc strat 
use $isspgender\g5.dta, clear 
xtmixed z2factor1   fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam gii   loggdp || COUNTRY:z2icam , var
display "FYI: The deviance of the AIM is " -2*e(ll)
estimate store AIMei

use $isspwork\w5.dta, clear 
xtmixed z2factor1   fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam gii    loggdp || COUNTRY: z2icam , var
display "FYI: The deviance of the AIM is " -2*e(ll)
estimate store AIMeii

use $isspsport\s5.dta, clear 
xtmelogit _V23  fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam gii  loggdp || COUNTRY:z2icam , var
display "FYI: The deviance of the AIM is " -2*e(ll)
estimate store AIMeiii


*Below is the command to determine whether including the random slope of “gpa_cmc” improves the model. 
*The software performs a likelihood-ratio test LR X(1)²,  comparing the deviance of the CIM with the deviance of the AIM.
lrtest CIMi AIMai
lrtest CIMi AIMbi
lrtest CIMi AIMci
lrtest CIMi AIMdi
lrtest CIMi AIMei

lrtest CIMii AIMaii
lrtest CIMii AIMbii
lrtest CIMii AIMcii
lrtest CIMii AIMdii
lrtest CIMii AIMeii

lrtest CIMiii AIMaiii
lrtest CIMiii AIMbiii
lrtest CIMiii AIMciii
lrtest CIMiii AIMdiii
lrtest CIMiii AIMeiii



**********************checking for covariance 
*fem
use $isspgender\g5.dta, clear 
xtmixed z2factor1   fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam gii   loggdp  || COUNTRY:fem , var cov(unstructured) 
display "FYI: The deviance of the AIM is " -2*e(ll)
estimate store AIMai2

use $isspwork\w5.dta, clear 
xtmixed z2factor1   fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam gii  loggdp  || COUNTRY: fem, var cov(unstructured) 
display "FYI: The deviance of the AIM is " -2*e(ll)
estimate store AIMaii2

use $isspsport\s5.dta, clear 
xtmelogit _V23  fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam gii  loggdp || COUNTRY: fem , var cov(unstructured) 
display "FYI: The deviance of the AIM is " -2*e(ll)
estimate store AIMaiii2

*age
use $isspgender\g5.dta, clear 
xtmixed z2factor1   fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam gii  loggdp  || COUNTRY:z2age, var cov(unstructured) 
display "FYI: The deviance of the AIM is " -2*e(ll)
estimate store AIMbi2

use $isspwork\w5.dta, clear 
xtmixed z2factor1   fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam gii  loggdp  || COUNTRY: z2age, var cov(unstructured)
display "FYI: The deviance of the AIM is " -2*e(ll)
estimate store AIMbii2

use $isspsport\s5.dta, clear 
xtmelogit _V23  fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam gii   loggdp || COUNTRY:z2age , var cov(unstructured)
display "FYI: The deviance of the AIM is " -2*e(ll)
estimate store AIMbiii2


*married 
use $isspgender\g5.dta, clear 
xtmixed z2factor1  fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam gii  loggdp || COUNTRY:married , var cov(unstructured)
display "FYI: The deviance of the AIM is " -2*e(ll)
estimate store AIMci2

use $isspwork\w5.dta, clear 
xtmixed z2factor1   fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam gii  loggdp || COUNTRY: married , var cov(unstructured)
display "FYI: The deviance of the AIM is " -2*e(ll)
estimate store AIMcii2

use $isspsport\s5.dta, clear 
xtmelogit _V23  fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam gii   loggdp  || COUNTRY:married  , var cov(unstructured)
display "FYI: The deviance of the AIM is " -2*e(ll)
estimate store AIMciii2

*ted 
use $isspgender\g5.dta, clear 
xtmixed z2factor1   fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam gii  loggdp || COUNTRY:z2ted , var cov(unstructured)
display "FYI: The deviance of the AIM is " -2*e(ll)
estimate store AIMdi2

use $isspwork\w5.dta, clear 
xtmixed z2factor1   fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam gii  loggdp || COUNTRY: z2ted , var cov(unstructured)
display "FYI: The deviance of the AIM is " -2*e(ll)
estimate store AIMdii2

use $isspsport\s5.dta, clear 
xtmelogit _V23  fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam gii  loggdp  || COUNTRY:z2ted , var cov(unstructured)
display "FYI: The deviance of the AIM is " -2*e(ll)
estimate store AIMdiii2

*soc strat 
use $isspgender\g5.dta, clear 
xtmixed z2factor1   fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam gii  loggdp  || COUNTRY:z2icam , var cov(unstructured)
display "FYI: The deviance of the AIM is " -2*e(ll)
estimate store AIMei2

use $isspwork\w5.dta, clear 
xtmixed z2factor1   fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam gii  loggdp    || COUNTRY: z2icam , var cov(unstructured)
display "FYI: The deviance of the AIM is " -2*e(ll)
estimate store AIMeii2

use $isspsport\s5.dta, clear 
xtmelogit _V23  fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam gii  loggdp || COUNTRY:z2icam , var cov(unstructured)
display "FYI: The deviance of the AIM is " -2*e(ll)
estimate store AIMeiii2

**********************checking if covariance improves model fit 
lrtest AIMai AIMai2
lrtest AIMbi AIMbi2
lrtest AIMci AIMci2
lrtest AIMdi AIMdi2
lrtest AIMei AIMei2

lrtest AIMaii AIMaii2
lrtest AIMbii AIMbii2
lrtest AIMcii AIMcii2
lrtest AIMdii AIMdii2
lrtest AIMeii AIMeii2

lrtest AIMaiii AIMaiii2
lrtest AIMbiii AIMbiii2
lrtest AIMciii AIMciii2
lrtest AIMdiii AIMdiii2
lrtest AIMeiii AIMeiii2



*********************************************************************
*STEP #3: Building the Final Model (corresponding to Sub-Appendix D)*
*********************************************************************




*Below is the command to run the model (adding the cross-level interaction(s)).


use $isspgender\g5.dta, clear 
xtmixed z2factor1  fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam  gii  loggdp  fem_gii  fem_loggdp  || COUNTRY:  fem married z2age z2ted z2icam , var
estimate store gender1 

use $isspwork\w5.dta, clear 
xtmixed z2factor1  fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam gii  loggdp  fem_gii  fem_loggdp  || COUNTRY: married z2age z2ted z2icam , var
estimate store work1


use $isspsport\s5.dta, clear 
xtmelogit _V23  fem z2age married z2ted z2icam fem_z2ted fem_mar fem_z2age fem_z2icam gii  loggdp   fem_gii  fem_loggdp  || COUNTRY: fem married z2ted z2icam , var
estimate store sport1

*Below is the command to run the final model (removing unsignifcant predictors).


use $isspgender\g5.dta, clear 
xtmixed z2factor1  fem z2age married z2ted z2icam  fem_mar fem_z2age fem_z2icam  gii  loggdp  fem_gii  fem_loggdp  || COUNTRY: z2age z2ted z2icam , var
estimate store gender 

use $isspwork\w5.dta, clear 
xtmixed z2factor1  fem z2age married z2ted z2icam  fem_z2age fem_z2icam gii  loggdp  fem_gii  fem_loggdp  || COUNTRY: z2age z2icam , var
estimate store work 

use $isspsport\s5.dta, clear 
xtmelogit _V23  fem z2age married z2ted z2icam fem_mar fem_z2age  gii  fem_gii || COUNTRY: fem  z2ted  , var
estimate store sport
************************************

*Graphing slopes 

use $isspgender\g5.dta, clear 

xtmixed z2factor1  fem z2age married z2ted z2icam  fem_mar fem_z2age fem_z2icam  gii  loggdp  fem_gii  fem_loggdp  || COUNTRY: married  , var
estimate store gender1 
capture drop ebs 
capture drop ebi
predict ebs ebi, reffects
table COUNTRY, c(mean ebi mean ebs mean z2factor1) 
scatter ebi z2factor1
* Comment: the mean of factorone is the country mean irrespective of other factors; 
*     the ebi is the country residual controlling for other factors

capture drop p1
gen p1 = _b[_cons]   ///
    + ebi + (_b[married]+ebs)*married /* Empirical bayes adjusted linear predictor */

capture drop p1l
gen p1l = _b[_cons] + _b[married]*married   /* Linear predictor */

sort COUNTRY married
graph twoway (scatter z2factor1 married, mcolor(gs10) msymbol(smcircle) msize(vsmall) ) /// 
    (line p1 married, connect(ascending)  lwidth(thin) lcolor(gs4) lpattern(solid) ) ///
    (line p1l married, sort  lwidth(thick) lcolor(orange) lpattern(solid) )  ///
     , xtitle("married") ytitle("factor 1") title("Random coefficients") ///
    legend(cols(2) order(2 3) label(2 "group resids") label(3 "Overall")  )  
graph save $output\bit1.gph, replace




xtmixed z2factor1  fem z2age married z2ted z2icam  fem_mar fem_z2age fem_z2icam  gii  loggdp  fem_gii  fem_loggdp  || COUNTRY: z2age  , var
estimate store gender2 
capture drop ebs 
capture drop ebi
predict ebs ebi, reffects
table COUNTRY, c(mean ebi mean ebs mean z2factor1) 
scatter ebi z2factor1
* Comment: the mean of factorone is the country mean irrespective of other factors; 
*     the ebi is the country residual controlling for other factors

capture drop p2
gen p2 = _b[_cons]   ///
    + ebi + (_b[z2age]+ebs)*z2age /* Empirical bayes adjusted linear predictor */

capture drop p2l
gen p2l = _b[_cons] + _b[z2age]*z2age   /* Linear predictor */

sort COUNTRY z2age
graph twoway (scatter z2factor1 z2age, mcolor(gs10) msymbol(smcircle) msize(vsmall) ) /// 
    (line p2 z2age, connect(ascending)  lwidth(thin) lcolor(gs4) lpattern(solid) ) ///
    (line p2l z2age, sort  lwidth(thick) lcolor(orange) lpattern(solid) )  ///
     , xtitle("age") ytitle("factor 1") title("Random coefficients") ///
    legend(cols(2) order(2 3) label(2 "group resids") label(3 "Overall")  )  
graph save $output\bit2.gph, replace


xtmixed z2factor1  fem z2age married z2ted z2icam  fem_mar fem_z2age fem_z2icam  gii  loggdp  fem_gii  fem_loggdp  || COUNTRY:  z2ted  , var
estimate store gender3
capture drop ebs 
capture drop ebi
predict ebs ebi, reffects
table COUNTRY, c(mean ebi mean ebs mean z2factor1) 
scatter ebi z2factor1
* Comment: the mean of factorone is the country mean irrespective of other factors; 
*     the ebi is the country residual controlling for other factors

capture drop p3
gen p3 = _b[_cons]   ///
    + ebi + (_b[z2ted]+ebs)*z2ted /* Empirical bayes adjusted linear predictor */

capture drop p3l
gen p3l = _b[_cons] + _b[z2ted]*z2ted   /* Linear predictor */

sort COUNTRY z2ted
graph twoway (scatter z2factor1 z2ted, mcolor(gs10) msymbol(smcircle) msize(vsmall) ) /// 
    (line p3 z2ted, connect(ascending)  lwidth(thin) lcolor(gs4) lpattern(solid) ) ///
    (line p3l z2ted, sort  lwidth(thick) lcolor(orange) lpattern(solid) )  ///
     , xtitle("years of schooling") ytitle("factor 1") title("Random coefficients") ///
    legend(cols(2) order(2 3) label(2 "group resids") label(3 "Overall")  )  
graph save $output\bit3.gph, replace


xtmixed z2factor1  fem z2age married z2ted z2icam  fem_mar fem_z2age fem_z2icam  gii  loggdp  fem_gii  fem_loggdp  || COUNTRY: z2icam , var
estimate store gender4
capture drop ebs 
capture drop ebi
predict ebs ebi, reffects
table COUNTRY, c(mean ebi mean ebs mean z2factor1) 
scatter ebi factor1
* Comment: the mean of factorone is the country mean irrespective of other factors; 
*     the ebi is the country residual controlling for other factors

capture drop p4
gen p4 = _b[_cons]   ///
    + ebi + (_b[z2icam]+ebs)*z2icam /* Empirical bayes adjusted linear predictor */

capture drop p4l
gen p4l = _b[_cons] + _b[z2icam]*z2icam   /* Linear predictor */

sort COUNTRY z2age
graph twoway (scatter z2factor1 z2icam, mcolor(gs10) msymbol(smcircle) msize(vsmall) ) /// 
    (line p4 z2icam, connect(ascending)  lwidth(thin) lcolor(gs4) lpattern(solid) ) ///
    (line p4l z2icam, sort  lwidth(thick) lcolor(orange) lpattern(solid) )  ///
     , xtitle("ICAM") ytitle("factor 1") title("Random coefficients") ///
    legend(cols(2) order(2 3) label(2 "group resids") label(3 "Overall")  )  
graph save $output\bit4.gph, replace



graph combine $output\bit1.gph $output\bit2.gph $output\bit3.gph $output\bit4.gph  ///
   , cols(2) title("Attidudes towards working mothers of individuals clustered in countries" " Graph of country level random slopes") ///
    note("Source: ISSP 2002 Family and Changing Gender Roles module") 


*********************************************************

use $isspwork\w5.dta, clear 
xtmixed z2factor1  fem z2age married z2ted z2icam  fem_z2age fem_z2icam gii  loggdp  fem_gii  fem_loggdp  || COUNTRY: z2age  , var
estimate store work1
capture drop ebs 
capture drop ebi
predict ebs ebi, reffects
table COUNTRY, c(mean ebi mean ebs mean z2factor1) 
scatter ebi z2factor1
* Comment: the mean of factorone is the country mean irrespective of other factors; 
*     the ebi is the country residual controlling for other factors

capture drop p2
gen p2 = _b[_cons]   ///
    + ebi + (_b[z2age]+ebs)*z2age /* Empirical bayes adjusted linear predictor */

capture drop p2l
gen p2l = _b[_cons] + _b[z2age]*z2age   /* Linear predictor */

sort COUNTRY z2age
graph twoway (scatter z2factor1 z2age, mcolor(gs10) msymbol(smcircle) msize(vsmall) ) /// 
    (line p2 z2age, connect(ascending)  lwidth(thin) lcolor(gs4) lpattern(solid) ) ///
    (line p2l z2age, sort  lwidth(thick) lcolor(orange) lpattern(solid) )  ///
     , xtitle("age") ytitle("factor 1") title("Random coefficients") ///
    legend(cols(2) order(2 3) label(2 "group resids") label(3 "Overall")  )  
graph save $output\bit2a.gph, replace

xtmixed z2factor1  fem z2age married z2ted z2icam  fem_z2age fem_z2icam gii  loggdp  fem_gii  fem_loggdp  || COUNTRY: z2age  , var
estimate store work2
capture drop ebs 
capture drop ebi
predict ebs ebi, reffects
table COUNTRY, c(mean ebi mean ebs mean z2factor1) 
scatter ebi factor1
* Comment: the mean of factorone is the country mean irrespective of other factors; 
*     the ebi is the country residual controlling for other factors

capture drop p4
gen p4 = _b[_cons]   ///
    + ebi + (_b[z2icam]+ebs)*z2icam /* Empirical bayes adjusted linear predictor */

capture drop p4l
gen p4l = _b[_cons] + _b[z2icam]*z2icam   /* Linear predictor */

sort COUNTRY z2age
graph twoway (scatter z2factor1 z2icam, mcolor(gs10) msymbol(smcircle) msize(vsmall) ) /// 
    (line p4 z2icam, connect(ascending)  lwidth(thin) lcolor(gs4) lpattern(solid) ) ///
    (line p4l z2icam, sort  lwidth(thick) lcolor(orange) lpattern(solid) )  ///
     , xtitle("ICAM") ytitle("factor 1") title("Random coefficients") ///
    legend(cols(2) order(2 3) label(2 "group resids") label(3 "Overall")  )  
graph save $output\bit2b.gph, replace



graph combine $output\bit2a.gph $output\bit2b.gph  ///
   , cols(2) title("Job quality of individuals clustered in countries" " Graph of country level random slopes") ///
    note("Source: ISSP 2005 Work Orientations  module") 


****************************************************************************************
use $isspsport\s5.dta, clear 
xtmelogit _V23  fem z2age married z2ted z2icam fem_mar fem_z2age  gii  fem_gii || COUNTRY: fem    , var
estimate store sport2

capture drop ebs 
capture drop ebi
predict ebs ebi, reffects
table COUNTRY, c(mean ebi mean ebs mean _V23) 
scatter ebi _V23
* Comment: the mean of factorone is the country mean irrespective of other factors; 
*     the ebi is the country residual controlling for other factors

capture drop p4
gen p4 = _b[_cons]   ///
    + ebi + (_b[fem ]+ebs)*fem  /* Empirical bayes adjusted linear predictor */

capture drop p4l
gen p4l = _b[_cons] + _b[fem ]*fem    /* Linear predictor */

sort COUNTRY fem 
graph twoway (scatter _V23 fem , mcolor(gs10) msymbol(smcircle) msize(vsmall) ) /// 
    (line p4 fem , connect(ascending)  lwidth(thin) lcolor(gs4) lpattern(solid) ) ///
    (line p4l fem , sort  lwidth(thick) lcolor(orange) lpattern(solid) )  ///
     , xtitle("female") ytitle("enjoyment of physical activity") title("Random coefficients") ///
    legend(cols(2) order(2 3) label(2 "group resids") label(3 "Overall")  )  
graph save $output\bit3a.gph, replace


xtmelogit _V23  fem z2age married z2ted z2icam fem_mar fem_z2age  gii  fem_gii || COUNTRY:  z2ted  , var
estimate store sport2

capture drop ebs 
capture drop ebi
predict ebs ebi, reffects
table COUNTRY, c(mean ebi mean ebs mean _V23) 
scatter ebi _V23
* Comment: the mean of factorone is the country mean irrespective of other factors; 
*     the ebi is the country residual controlling for other factors

capture drop p4
gen p4 = _b[_cons]   ///
    + ebi + (_b[z2ted]+ebs)*z2ted /* Empirical bayes adjusted linear predictor */

capture drop p4l
gen p4l = _b[_cons] + _b[z2ted]*z2ted   /* Linear predictor */

sort COUNTRY z2ted
graph twoway (scatter _V23 z2ted, mcolor(gs10) msymbol(smcircle) msize(vsmall) ) /// 
    (line p4 z2ted, connect(ascending)  lwidth(thin) lcolor(gs4) lpattern(solid) ) ///
    (line p4l z2ted, sort  lwidth(thick) lcolor(orange) lpattern(solid) )  ///
     , xtitle("years of schooling") ytitle("enjoyment of physical activity") title("Random coefficients") ///
    legend(cols(2) order(2 3) label(2 "group resids") label(3 "Overall")  )  
graph save $output\bit3b.gph, replace





graph combine $output\bit3a.gph $output\bit3b.gph  ///
   , cols(2) title("Reported enjoyment of physical activities of individuals clustered in countries" " Graph of country level random slopes") ///
    note("Source: ISSP 2007 Leisure Time and Sports module") 




***************************cross classified

*creating strata varible 

use $isspgender\g5.dta, clear 

tab fem 
tab married
tab v205
capture drop education3
gen education3 =  v205
recode education3 0=1 1=1 2=2 3=2 4=3 5=3
tab v205 education3
tab age
capture drop age3
gen age3 =age 
recode age3 15/35 =1 36/55=2 56/96=3
tab age3
tab icam
xtile icam4=icam, n(4)
tab icam icam4 

capture drop intid
egen intid = group(fem icam4 age3 education3 married) 
tab intid
sav $isspgender\g5_1.dta, replace 
gen cfreq =1
collapse (sum) cfreq, by(intid )
summarize
sort cfreq
capture drop intid1 
gen intid1 = 0
replace intid1 =1 if cfreq <10
replace intid1 =2 if cfreq >=10 & cfreq <=20
replace intid1 =3 if cfreq >20
replace intid1 =4 if cfreq >100
tab intid1

use $isspgender\g5_1.dta, clear 

egen intid_c = group(intid COUNTRY) 
sav $isspgender\g5_1.dta, replace 
gen cfreq =1
collapse (sum) cfreq, by(intid_c )
summarize
sort cfreq
capture drop intid1 
gen intid1 = 0
replace intid1 =1 if cfreq <10
replace intid1 =2 if cfreq >=10 & cfreq <=20
replace intid1 =3 if cfreq >20
replace intid1 =4 if cfreq >100
tab intid1


use $isspgender\g5_1.dta, clear 

gen touse = !missing(icam4, fem, married, education3, age3)

*null
mixed  z2factor1  if touse ==1  ||COUNTRY:,
est store null
estat icc

*main 
mixed    z2factor1  icam4  fem  married education3 age3  if touse ==1||COUNTRY:, 
est store main 
estat icc



*null
mixed  z2factor1  if touse ==1  ||intid:,
est store null1
estat icc

*main 
mixed    z2factor1  icam4  fem  married education3 age3  if touse ==1||intid:, 
est store main1 
estat icc

*null2
mixed  z2factor1  if touse ==1  || _all:R.COUNTRY, ||  intid:
est store null2


*main2
mixed    z2factor1  icam4  fem  married education3 age3  if touse ==1  || _all:R.COUNTRY, ||  intid: 
est store main2 

*null3
mixed  z2factor1  if touse ==1  || _all:R.COUNTRY, ||  intid: || intid_c:
est store null3


*main3
mixed    z2factor1  icam4  fem  married education3 age3  if touse ==1  || _all:R.COUNTRY, ||  intid: || intid_c:
est store main3


lrtest null null2 
lrtest null1 null2
lrtest null2 null3


lrtest main main2 
lrtest main1 main2
lrtest main2 main3
 
 
 **********************
 
 use $isspwork\w5.dta, clear 

tab fem 
tab married
tab DEGREE
capture drop education3
gen education3 = DEGREE
recode education3 0=1 1=1 2=2 3=2 4=3 5=3 7=.
tab DEGREE education3
tab age
capture drop age3
gen age3 =age 
recode age3 15/35 =1 36/55=2 56/100=3
tab age3
tab icam
xtile icam4=icam, n(4)
tab icam icam4 

capture drop intid
egen intid = group(fem icam4 age3 education3 married) 
tab intid
sav $isspwork\w5_1.dta, replace 
gen cfreq =1
collapse (sum) cfreq, by(intid )
summarize
sort cfreq
capture drop intid1 
gen intid1 = 0
replace intid1 =1 if cfreq <10
replace intid1 =2 if cfreq >=10 & cfreq <=20
replace intid1 =3 if cfreq >20
replace intid1 =4 if cfreq >100
tab intid1

use $isspwork\w5_1.dta, clear 

egen intid_c = group(intid COUNTRY) 
sav $isspwork\w5_1.dta, replace 
gen cfreq =1
collapse (sum) cfreq, by(intid_c )
summarize
sort cfreq
capture drop intid1 
gen intid1 = 0
replace intid1 =1 if cfreq <10
replace intid1 =2 if cfreq >=10 & cfreq <=20
replace intid1 =3 if cfreq >20
replace intid1 =4 if cfreq >100
tab intid1


use $isspwork\w5_1.dta, clear 

gen touse = !missing(icam4, fem, married, education3, age3)

*null
mixed  z2factor1  if touse ==1  ||COUNTRY:,
est store null
estat icc

*main 
mixed    z2factor1  icam4  fem  married education3 age3  if touse ==1||COUNTRY:, 
est store main 
estat icc



*null
mixed  z2factor1  if touse ==1  ||intid:,
est store null1
estat icc

*main 
mixed    z2factor1  icam4  fem  married education3 age3  if touse ==1||intid:, 
est store main1 
estat icc

*null2
mixed  z2factor1  if touse ==1  || _all:R.COUNTRY, ||  intid:
est store null2


*main2
mixed    z2factor1  icam4  fem  married education3 age3  if touse ==1  || _all:R.COUNTRY, ||  intid: 
est store main2 

*null3
mixed  z2factor1  if touse ==1  || _all:R.COUNTRY, ||  intid: || intid_c:
est store null3


*main3
mixed    z2factor1  icam4  fem  married education3 age3  if touse ==1  || _all:R.COUNTRY, ||  intid: || intid_c:
est store main3


lrtest null null2 
lrtest null1 null2
lrtest null2 null3


lrtest main main2 
lrtest main1 main2
lrtest main2 main3
 