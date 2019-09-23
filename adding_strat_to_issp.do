

**********************ADDING STRATIFICATION MESURES*******************************************

*****ADDING isei  siops and 10 category erikson goldthorpe porticero using HEDRICKS files 

**************************************individual*********************************************************

*checking isco88 is 4-digit isco as required
tab ISCO88

*creating self employed varible

tab  self_emp 


*creating supervises varible
tab  superv  



* make 3 new vars - isei score (SES) and siops (treiman) prestige score and erikson goldthorpe porticero 
capture drop isei
capture drop trei
capture drop egp

*defining programs

global hendrickx_files "H:\thesis_analysis\do_files\my_dofiles\hendrickx\"

capture program drop iskotrei
capture program drop iskoisei
capture program drop iskoegp

do $hendrickx_files\Hendrick5.do /* defines the trei prog */
do $hendrickx_files\Hendrick6.do /* defines the isei prog  */
do $hendrickx_files\Hendrick2.do /* defines the egp prog  */

iskotrei trei, isko(ISCO88)
iskoisei isei , isko(ISCO88)
iskoegp egp ,isko(ISCO88) sempl(self_emp) supvis(superv)
summarize ISCO88 trei isei egp



capture drop egp6
gen egp6 =egp
recode egp6 1=1 2=1 3=2 4=3 5=3 6=4 7=4 8=4 9=5 10=6 11=6

label define egp6 1 "service class" 2 "routine non-manual" 3 "petty bourgeoisie" 4 "skilled manual" 5 "unskilled manual" 6 "farmer & farm laborer"
label values egp6 egp6
tab egp egp6

**************************************partner*********************************************************


*checking isco88 is 4-digit isco as required
tab SPISCO88

*creating self employed varible
tab  s_self_emp
*creating supervises varible

tab  s_superv 



* make 3 new vars - isei score (SES) and siops (treiman) prestige score and erikson goldthorpe porticero 
capture drop s_isei
capture drop s_trei
capture drop s_egp

*defining programs


global hendrickx_files "H:\thesis_analysis\do_files\my_dofiles\hendrickx\"

capture program drop iskotrei
capture program drop iskoisei
capture program drop iskoegp

do "$hendrickx_files\Hendrick5.do" /* defines the trei prog */
do "$hendrickx_files\Hendrick6.do" /* defines the isei prog  */
do "$hendrickx_files\Hendrick2.do" /* defines the egp prog  */

iskotrei s_trei, isko(SPISCO88)
iskoisei s_isei, isko(SPISCO88)
iskoegp s_egp, isko(SPISCO88) sempl(s_self_emp) supvis(s_superv)

summarize  s_trei s_isei s_egp

tab s_egp

capture drop s_egp6
gen s_egp6 =s_egp
recode s_egp6 1=1 2=1 3=2 4=3 5=3 6=4 7=4 8=4 9=5 10=6 11=6

label define s_egp6 1 "service class" 2 "routine non-manual" 3 "petty bourgeoisie" 4 "skilled manual" 5 "unskilled manual" 6 "farmer & farm laborer"
label values s_egp6 s_egp6
tab s_egp s_egp6



******************************************************************************

******ADDING ICAM  



* generating international camsis 

capture drop icam
gen icam = ISCO88
do "H:\thesis_analysis\do_files\my_dofiles\other\icam.do"
rename icam i_icam

capture drop icam
gen icam =  SPISCO88
do "H:\thesis_analysis\do_files\my_dofiles\other\icam.do"
capture drop s_icam
rename icam s_icam
rename i_icam icam
summarize icam s_icam




********************************************************************************

******************************************************************************


********************************************************************************
*ADDING CAMISIS FEMALE FRIEND
rename ISCO88 isco88
sort isco88
merge m:1 isco88  using H:\thesis_analysis\data\my_data\camsis_creation\cb_camsis_isco
tab _merge 
drop dup
drop if _merge == 2
drop _merge 
rename isco88 ISCO88
rename cbcamsis_isco ffcamsis


rename SPISCO88 isco88
sort isco88
merge m:1  isco88 using H:\thesis_analysis\data\my_data\camsis_creation\cb_camsis_isco
tab _merge 
drop if _merge == 2
drop _merge 
rename isco88 SPISCO88
rename cbcamsis_isco spffcamsis
drop dup




********************************************************************************
********************************************************************************
*ADDING gender spesific sei 

rename ISCO88 isco88
sort isco88
merge m:1 isco88  using H:\thesis_analysis\data\my_data\measures_3\sei\cbseiisco88.dta
tab _merge  
drop if _merge == 2
drop _merge 
rename isco88 ISCO88
rename mseiisco msei
rename fseiisco fsei

rename SPISCO88 isco88
sort isco88
merge m:1  isco88 using  H:\thesis_analysis\data\my_data\measures_3\sei\cbseiisco88.dta
tab _merge 
drop if _merge == 2
drop _merge 
rename isco88 SPISCO88
rename mseiisco spmsei
rename fseiisco spfsei



********************************************************************************

*****ADDING ISCO GROUPS 

tab ISCO88
capture drop iscogroup
gen iscogroup = ISCO88 if !missing(ISCO88) 
recode iscogroup 1/999 =0 1000/1999=1 2000/2999=2 3000/3999=3 4000/4999=4 5000/5999=5 6000/6999=6 7000/7999=7 8000/8999=8 9000/9999=9 
tab iscogroup

tab SPISCO88
capture drop s_iscogroup
gen s_iscogroup = SPISCO88 if !missing(SPISCO88 ) 
recode s_iscogroup 1/999 =0 1000/1999=1 2000/2999=2 3000/3999=3 4000/4999=4 5000/5999=5 6000/6999=6 7000/7999=7 8000/8999=8 9000/9999=9 
tab s_iscogroup


label define iscogroup1 1 "Legislators, senior officials and managers"  2 "Professionals" 3 "Technicians and associate professionals" 4 "Clerks" 5 "Service workers and shop and market sales workers" 6 "Skilled agricultural and fishery workers" 7 "Craft and related trades workers" 8 "Plant and machine operators and assemblers" 9 "Elementary occupations" 
label values iscogroup iscogroup1
label values s_iscogroup iscogroup1



********************************************************************************
****************household approaches

******traditional  

capture drop tradicam
gen tradicam =icam
replace tradicam= s_icam if  missing(icam )
replace tradicam =s_icam if sex==2 & !missing(s_icam)


capture drop tradisei
gen tradisei =isei
replace tradisei= s_isei if  missing(isei)
replace tradisei =s_isei if sex==2 & !missing(s_isei)

capture drop tradtrei
gen tradtrei = trei
replace tradtrei= s_trei if  missing(trei)
replace tradtrei=s_trei if sex==2 & !missing(s_trei)



******dominance 
 
*fulltime
tab1 fulltime s_fulltime
capture drop spdom
gen spdom =0
replace spdom =1 if s_fulltime==1 & fulltime==0


*selfemp

tab self_emp s_self_emp
replace spdom =1 if  s_self_emp ==1 & self_emp==0

*nonmanual

capture drop manual
gen manual =0
replace manual =1 if egp6 == 4
replace manual =1 if egp6 == 5
tab manual egp6

capture drop s_manual
gen s_manual =0
replace s_manual =1 if s_egp6 == 4
replace s_manual =1 if s_egp6 == 5
tab s_manual s_egp6

replace spdom =1 if s_manual==0 & manual ==1

***

capture drop domicam
gen domicam =icam
replace domicam= s_icam if  missing(icam )
replace domicam =s_icam if spdom ==1 & !missing(s_icam )

capture drop domisei
gen domisei =isei
replace domisei= s_isei if  missing(isei)
replace domisei =s_isei if spdom ==1  & !missing(s_isei)

capture drop domtrei
gen domtrei = trei
replace domtrei= s_trei if  missing(trei)
replace domtrei=s_trei if spdom ==1  & !missing(s_trei)



 
******higher 
 
capture drop highicam
gen highicam =icam
replace highicam= s_icam if  missing(icam )
replace highicam =s_icam if s_icam > icam & !missing(s_icam )


capture drop highisei
gen highisei =isei
replace highisei= s_isei if  missing(isei)
replace highisei =s_isei if s_isei > isei & !missing(s_isei)

capture drop hightrei
gen hightrei = trei
replace hightrei= s_trei if  missing(trei)
replace hightrei=s_trei if s_trei > trei & !missing(s_trei)



 
 
******combineda - mean 

capture drop meanicam
gen meanicam =icam
replace meanicam= s_icam if  missing(icam )
replace meanicam = (icam + s_icam) /2 if !missing(s_icam )& !missing(icam )

capture drop meanisei
gen meanisei =isei
replace meanisei= s_isei if  missing(isei)
replace  meanisei = (s_isei+ isei) /2 if !missing(isei)& !missing(s_isei)

capture drop meantrei
gen meantrei =trei
replace meantrei= s_trei if  missing(trei)
replace  meantrei = (s_trei+ trei) /2 if !missing(trei)& !missing(s_trei)



******combinedb - add

capture drop addicam
gen addicam =icam
replace addicam= s_icam if  missing(icam )
replace addicam = icam + s_icam if !missing(s_icam )& !missing(icam )

capture drop addisei
gen addisei =isei
replace addisei= s_isei if  missing(isei)
replace  addisei = s_isei+ isei if !missing(isei)& !missing(s_isei)

capture drop addtrei
gen addtrei =trei
replace addtrei= s_trei if  missing(trei)
replace  addtrei = s_trei+ trei if !missing(trei)& !missing(s_trei)


*********************standardising 
***************************************
egen	z2icam  		=	std(icam )
egen	z2isei			=	std(isei)
egen	z2trei			=	std(trei)
egen	z2ffcamsis		=	std(ffcamsis)
egen	z2msei			=	std(msei)
egen	z2fsei			=	std(fsei)
					
egen	z2tradicam  	=	std(tradicam)
egen	z2tradisei  	=	std(tradisei)
egen	z2tradtrei 		=	std(tradtrei)
					
egen	z2domicam   	=	std(domicam)
egen	z2domisei   	=	std(domisei)
egen	z2domtrei  		=	std(domtrei)
					
egen	z2highicam   	=	std(highicam)
egen	z2highisei   	=	std(highisei)
egen	z2hightrei  	=	std(hightrei)
					
egen	z2meanicam   	=	std(meanicam)
egen	z2meanisei   	=	std(meanisei)
egen	z2meantrei  	=	std(meantrei)
					
egen	z2addicam 		=	std(addicam)
egen	z2addisei 		=	std(addisei)
egen	z2addtrei 		=	std(addtrei)



************************ingteractions 

gen	fem_z2icam	=	z2icam*fem
gen	fem_z2isei	=	z2isei*fem
gen	fem_z2trei	=	z2trei*fem
						
gen	fem_z2tradicam	=	z2tradicam*fem
gen	fem_z2tradisei	=	z2tradisei*fem
gen	fem_z2tradtrei	=	z2tradtrei*fem
						
gen	fem_z2domicam	=	z2domicam*fem
gen	fem_z2domisei	=	z2domisei*fem
gen	fem_z2domtrei	=	z2domtrei*fem
						
gen	fem_z2highicam	=	z2highicam*fem
gen	fem_z2highisei	=	z2highisei*fem
gen	fem_z2hightrei	=	z2hightrei*fem
						
gen	fem_z2meanicam	=	z2meanicam*fem
gen	fem_z2meanisei	=	z2meanisei*fem
gen	fem_z2meantrei	=	z2meantrei*fem

gen	fem_z2addicam	=	z2addicam*fem
gen	fem_z2addisei	=	z2addisei*fem
gen	fem_z2addtrei	=	z2addtrei*fem

