***********************************************************************************
*****************************UK****************************************************
***********************************************************************************

use  $c7data\ukmerge.dta, replace

gen icam2 =icam 
recode icam2 .=0
 tab icam2 
replace icam2 =1 if icam2>0
tab icam2 
tab icam2 year2  if sex ==1, col
tab icam2 year2 if sex ==2 , col

gen icam3=icam2
replace icam3 =1 if !missing(s_icam)
tab icam3 
tab icam3 year2  if sex ==1, col
tab icam3 year2 if sex ==2 , col

 
**************************************

capture drop ffhead
gen ffhead=.
replace ffhead =0 if sex==1 & !missing(ISCO88) & missing(SPISCO88)
replace ffhead =1 if sex==1 & missing(ISCO88) & !missing(SPISCO88)
replace ffhead =1 if sex==2 & !missing(ISCO88) & missing(SPISCO88)
replace ffhead =0 if sex==2 & missing(ISCO88) & !missing(SPISCO88 )

replace ffhead  =0 if !missing(SPISCO88, ISCO88)

tab ffhead year2 , col

capture drop ffhead2
gen ffhead2=.
replace ffhead2  =0 if !missing(SPISCO88, ISCO88)

tab ffhead2 year2 , col
*********************

capture drop ffdom
gen ffdom=.
replace ffdom =0 if sex==1 & !missing(ISCO88) & missing(SPISCO88)
replace ffdom =1 if sex==1 & missing(ISCO88) & !missing(SPISCO88)
replace ffdom =1 if sex==2 & !missing(ISCO88) & missing(SPISCO88)
replace ffdom =0 if sex==2 & missing(ISCO88) & !missing(SPISCO88 )

replace ffdom =1 if sex==1 & spdom==1 & !missing(SPISCO88, ISCO88)
replace ffdom =0 if sex==1 & spdom==0 & !missing(SPISCO88, ISCO88)
replace ffdom =1 if sex==2 & spdom==0 & !missing(SPISCO88, ISCO88 )
replace ffdom =0 if sex==2 & spdom==1 & !missing(SPISCO88, ISCO88 )
tab ffdom year2, col 


capture drop ffdom2
gen ffdom2=.
replace ffdom2 =1 if sex==1 & spdom==1 & !missing(SPISCO88, ISCO88)
replace ffdom2 =0 if sex==1 & spdom==0 & !missing(SPISCO88, ISCO88)
replace ffdom2 =1 if sex==2 & spdom==0 & !missing(SPISCO88, ISCO88 )
replace ffdom2 =0 if sex==2 & spdom==1 & !missing(SPISCO88, ISCO88 )
tab ffdom2 year2, col 




************


capture drop ffhigh
gen ffhigh=.
replace ffhigh =0 if sex==1 & !missing(icam) & missing(s_icam )
replace ffhigh =1 if sex==1 & missing(icam) & !missing(s_icam )
replace ffhigh =1 if sex==2 & !missing(icam) & missing(s_icam )
replace ffhigh =0 if sex==2 & missing(icam) & !missing(s_icam )
replace ffhigh =1 if sex==1 & s_icam > icam & !missing(s_icam, icam)
replace ffhigh =0 if sex==1 & icam > s_icam & !missing(s_icam, icam)
replace ffhigh =1 if sex==2 & s_icam < icam & !missing(s_icam, icam )
replace ffhigh =0 if sex==2 & s_icam > icam & !missing(s_icam, icam )
tab ffhigh year2, col 

capture drop ffhigh2
gen ffhigh2=.
replace ffhigh2 =1 if sex==1 & s_icam > icam & !missing(s_icam, icam)
replace ffhigh2 =0 if sex==1 & icam > s_icam & !missing(s_icam, icam)
replace ffhigh2 =1 if sex==2 & s_icam < icam & !missing(s_icam, icam )
replace ffhigh2 =0 if sex==2 & s_icam > icam & !missing(s_icam, icam )
tab ffhigh2 year2, col 


capture drop ffhigh
gen ffhigh=.
replace ffhigh =0 if sex==1 & !missing(isei) & missing(s_isei )
replace ffhigh =1 if sex==1 & missing(isei) & !missing(s_isei )
replace ffhigh =1 if sex==2 & !missing(isei) & missing(s_isei )
replace ffhigh =0 if sex==2 & missing(isei) & !missing(s_isei )
replace ffhigh =1 if sex==1 & s_isei> isei & !missing(s_isei, isei)
replace ffhigh =0 if sex==1 & isei > s_isei & !missing(s_isei, isei)
replace ffhigh =1 if sex==2 & s_isei < isei & !missing(s_isei, isei )
replace ffhigh =0 if sex==2 & s_isei > isei & !missing(s_isei, isei )
tab ffhigh year2, col 

capture drop ffhigh2
gen ffhigh2=.
replace ffhigh2 =1 if sex==1 & s_isei > isei & !missing(s_isei, isei)
replace ffhigh2 =0 if sex==1 & isei > s_isei & !missing(s_isei, isei)
replace ffhigh2 =1 if sex==2 & s_isei < isei & !missing(s_isei, isei)
replace ffhigh2 =0 if sex==2 & s_isei > isei & !missing(s_isei, isei)
tab ffhigh2 year2, col 


capture drop ffhigh
gen ffhigh=.
replace ffhigh =0 if sex==1 & !missing(trei) & missing(s_trei )
replace ffhigh =1 if sex==1 & missing(trei) & !missing(s_trei )
replace ffhigh =1 if sex==2 & !missing(trei) & missing(s_trei )
replace ffhigh =0 if sex==2 & missing(trei) & !missing(s_trei )
replace ffhigh =1 if sex==1 & s_trei > trei& !missing(s_trei, trei)
replace ffhigh =0 if sex==1 & trei > s_trei & !missing(s_trei, trei)
replace ffhigh =1 if sex==2 & s_trei < trei & !missing(s_trei, trei )
replace ffhigh =0 if sex==2 & s_trei > trei & !missing(s_trei, trei )
tab ffhigh year2, col 

capture drop ffhigh2
gen ffhigh2=.
replace ffhigh2 =1 if sex==1 & s_trei > trei & !missing(s_trei, trei)
replace ffhigh2 =0 if sex==1 & trei > s_trei & !missing(s_trei, trei)
replace ffhigh2 =1 if sex==2 & s_trei < trei & !missing(s_trei, trei )
replace ffhigh2 =0 if sex==2 & s_trei > trei & !missing(s_trei, trei )
tab ffhigh2 year2, col 

/*gen ss1 =  ss 
recode ss1 1/2=1 3/5=2 6=3 7/9=4 10=5 if year ==2016

tab ss1 year2, col*/


tab lr year2 , col




gen fem_deg = fem*degree
gen fem_mar = fem*married
gen fem_age = fem*age


*sample  
capture drop touse
gen touse = !missing(fem, age, married, degree, ///
				z2icam,  	z2tradicam,  	z2domicam,   	z2highicam,   	z2meanicam,   	z2addicam, ///
				z2isei,		z2tradisei,  	z2domisei,   	z2highisei,   	z2meanisei,   	z2addisei, ///
				z2trei,		z2tradtrei, 	z2domtrei,  	z2hightrei,  	z2meantrei,  	z2addtrei)	


***********************************************************************************
***********************************************************************************
***********************************************************************************
*self rated strat 

est drop _all

foreach var in  z2icam  	z2tradicam  	z2domicam   	z2highicam   	z2meanicam   	z2addicam ///
				z2isei		z2tradisei  	z2domisei   	z2highisei   	z2meanisei   	z2addisei ///
				z2trei		z2tradtrei 		z2domtrei  		z2hightrei  	z2meantrei  	z2addtrei {

reg  ss fem age married degree fem_deg fem_mar fem_age `var' fem_`var'  if year2 ==1980 &  touse==1
est store ss_`var'_80_i


reg ss  fem age married degree fem_deg fem_mar fem_age `var'  fem_`var'  if year2 ==1990 &  touse==1
est store ss_`var'_90_i


reg ss fem age married degree fem_deg fem_mar fem_age `var'  fem_`var'   if year2 ==2010 &  touse==1
est store ss_`var'_10_i

}

foreach var in  z2icam  	z2tradicam  	z2domicam   	z2highicam   	z2meanicam   	z2addicam ///
				z2isei		z2tradisei  	z2domisei   	z2highisei   	z2meanisei   	z2addisei ///
				z2trei		z2tradtrei 		z2domtrei  		z2hightrei  	z2meantrei  	z2addtrei {

reg  ss fem age married degree  `var' if year2 ==1980 &  touse==1
est store ss_`var'_80


reg ss fem age married degree `var'  if year2 ==1990 &  touse==1
est store ss_`var'_90


reg ss fem age married degree  `var'  if year2 ==2010 &  touse==1
est store ss_`var'_10

}

foreach var in  z2icam  	z2tradicam  	z2domicam   	z2highicam   	z2meanicam   	z2addicam ///
				z2isei		z2tradisei  	z2domisei   	z2highisei   	z2meanisei   	z2addisei ///
				z2trei		z2tradtrei 		z2domtrei  		z2hightrei  	z2meantrei  	z2addtrei {

reg  ss `var' if year2 ==1980 &  touse==1
est store ss_`var'_80_n


reg ss `var'  if year2 ==1990 &  touse==1
est store ss_`var'_90_n


reg ss `var'  if year2 ==2010 &  touse==1
est store ss_`var'_10_n

}


esttab  ss_z2isei_80_n  ss_z2tradisei_80_n   ss_z2domisei_80_n    ss_z2highisei_80_n  	 ss_z2meanisei_80_n 	 ss_z2addisei_80_n ///
		ss_z2isei_90_n  ss_z2tradisei_90_n   ss_z2domisei_90_n    ss_z2highisei_90_n  	 ss_z2meanisei_90_n 	 ss_z2addisei_90_n ///
		ss_z2isei_10_n  ss_z2tradisei_10_n   ss_z2domisei_10_n    ss_z2highisei_10_n  	 ss_z2meanisei_10_n 	 ss_z2addisei_10_n ///
								using $c7data\ukisein.csv, r2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles	 
								
esttab  ss_z2isei_80  ss_z2tradisei_80   ss_z2domisei_80    ss_z2highisei_80  	 ss_z2meanisei_80 	 ss_z2addisei_80 ///
		ss_z2isei_90  ss_z2tradisei_90   ss_z2domisei_90    ss_z2highisei_90  	 ss_z2meanisei_90 	 ss_z2addisei_90 ///
		ss_z2isei_10  ss_z2tradisei_10   ss_z2domisei_10    ss_z2highisei_10  	 ss_z2meanisei_10 	 ss_z2addisei_10 ///
								using $c7data\ukisei.csv,  append r2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles	 

esttab  ss_z2isei_80_i  ss_z2tradisei_80_i   ss_z2domisei_80_i    ss_z2highisei_80_i  	 ss_z2meanisei_80_i 	 ss_z2addisei_80_i ///
		ss_z2isei_90_i  ss_z2tradisei_90_i   ss_z2domisei_90_i    ss_z2highisei_90_i  	 ss_z2meanisei_90_i 	 ss_z2addisei_90_i ///
		ss_z2isei_10_i  ss_z2tradisei_10_i   ss_z2domisei_10_i    ss_z2highisei_10_i  	 ss_z2meanisei_10_i 	 ss_z2addisei_10_i ///
								using $c7data\ukiseii.csv, append  r2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles	 

****
esttab ss_z2trei_80_n  ss_z2tradtrei_80_n   ss_z2domtrei_80_n    ss_z2hightrei_80_n  	 ss_z2meantrei_80_n 	 ss_z2addtrei_80_n ///
		ss_z2trei_90_n  ss_z2tradtrei_90_n   ss_z2domtrei_90_n    ss_z2hightrei_90_n  	 ss_z2meantrei_90_n 	 ss_z2addtrei_90_n ///
		ss_z2trei_10_n  ss_z2tradtrei_10_n   ss_z2domtrei_10_n    ss_z2hightrei_10_n  	 ss_z2meantrei_10_n 	 ss_z2addtrei_10_n ///
								using $c7data\uktrein.csv ,r2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		

esttab ss_z2trei_80  ss_z2tradtrei_80   ss_z2domtrei_80    ss_z2hightrei_80  	 ss_z2meantrei_80 	 ss_z2addtrei_80 ///
		ss_z2trei_90  ss_z2tradtrei_90   ss_z2domtrei_90    ss_z2hightrei_90  	 ss_z2meantrei_90 	 ss_z2addtrei_90 ///
		ss_z2trei_10  ss_z2tradtrei_10   ss_z2domtrei_10    ss_z2hightrei_10  	 ss_z2meantrei_10 	 ss_z2addtrei_10 ///
								using $c7data\uktrei.csv ,r2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles	
								
esttab ss_z2trei_80_i  ss_z2tradtrei_80_i   ss_z2domtrei_80_i    ss_z2hightrei_80_i  	 ss_z2meantrei_80_i 	 ss_z2addtrei_80_i ///
		ss_z2trei_90_i  ss_z2tradtrei_90_i   ss_z2domtrei_90_i    ss_z2hightrei_90_i  	 ss_z2meantrei_90_i 	 ss_z2addtrei_90_i ///
		ss_z2trei_10_i  ss_z2tradtrei_10_i   ss_z2domtrei_10_i    ss_z2hightrei_10_i  	 ss_z2meantrei_10_i 	 ss_z2addtrei_10_i ///
								using $c7data\uktreii.csv ,r2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		

						
****
esttab ss_z2icam_80_n  ss_z2tradicam_80_n   ss_z2domicam_80_n    ss_z2highicam_80_n  	 ss_z2meanicam_80_n 	 ss_z2addicam_80_n ///
	ss_z2icam_90_n  ss_z2tradicam_90_n  ss_z2domicam_90_n   ss_z2highicam_90_n  	 ss_z2meanicam_90_n 	 ss_z2addicam_90_n ///
	ss_z2icam_10_n  ss_z2tradicam_10_n   ss_z2domicam_10_n   ss_z2highicam_10_n  	 ss_z2meanicam_10_n 	 ss_z2addicam_10_n ///
							using $c7data\ukicamn.csv , r2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		

esttab ss_z2icam_80  ss_z2tradicam_80   ss_z2domicam_80    ss_z2highicam_80  	 ss_z2meanicam_80 	 ss_z2addicam_80 ///
	ss_z2icam_90  ss_z2tradicam_90   ss_z2domicam_90    ss_z2highicam_90  	 ss_z2meanicam_90 	 ss_z2addicam_90 ///
	ss_z2icam_10  ss_z2tradicam_10   ss_z2domicam_10    ss_z2highicam_10  	 ss_z2meanicam_10 	 ss_z2addicam_10 ///
							using $c7data\ukicam.csv , r2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		

esttab ss_z2icam_80_i  ss_z2tradicam_80_i   ss_z2domicam_80_i    ss_z2highicam_80_i  	 ss_z2meanicam_80_i 	 ss_z2addicam_80_i ///
	ss_z2icam_90_i  ss_z2tradicam_90_i   ss_z2domicam_90_i    ss_z2highicam_90_i  	 ss_z2meanicam_90_i 	 ss_z2addicam_90_i ///
	ss_z2icam_10_i  ss_z2tradicam_10_i   ss_z2domicam_10_i    ss_z2highicam_10_i  	 ss_z2meanicam_10_i 	 ss_z2addicam_10_i ///
							using $c7data\ukicami.csv ,r2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		

******************************************************************************************************
est drop _all

foreach var in  z2icam  	z2tradicam  	z2domicam   	z2highicam   	z2meanicam   	z2addicam ///
				z2isei		z2tradisei  	z2domisei   	z2highisei   	z2meanisei   	z2addisei ///
				z2trei		z2tradtrei 		z2domtrei  		z2hightrei  	z2meantrei  	z2addtrei {

reg  ss fem age married degree fem_deg fem_mar fem_age `var' fem_`var'  if year2 ==1980 &  touse==1 & sex==1
est store mss_`var'_80_i 


reg ss  fem age married degree fem_deg fem_mar fem_age `var'  fem_`var'  if year2 ==1990 &  touse==1 & sex==1
est store mss_`var'_90_i


reg ss fem age married degree fem_deg fem_mar fem_age `var'  fem_`var'   if year2 ==2010 &  touse==1 & sex==1
est store mss_`var'_10_i

}

foreach var in  z2icam  	z2tradicam  	z2domicam   	z2highicam   	z2meanicam   	z2addicam ///
				z2isei		z2tradisei  	z2domisei   	z2highisei   	z2meanisei   	z2addisei ///
				z2trei		z2tradtrei 		z2domtrei  		z2hightrei  	z2meantrei  	z2addtrei {

reg  ss fem age married degree  `var' if year2 ==1980 &  touse==1 & sex==1
est store mss_`var'_80


reg ss fem age married degree `var'  if year2 ==1990 &  touse==1 & sex==1
est store mss_`var'_90


reg ss fem age married degree  `var'  if year2 ==2010 &  touse==1 & sex==1
est store mss_`var'_10

}

foreach var in  z2icam  	z2tradicam  	z2domicam   	z2highicam   	z2meanicam   	z2addicam ///
				z2isei		z2tradisei  	z2domisei   	z2highisei   	z2meanisei   	z2addisei ///
				z2trei		z2tradtrei 		z2domtrei  		z2hightrei  	z2meantrei  	z2addtrei {

reg  ss `var' if year2 ==1980 &  touse==1 & sex==1
est store mss_`var'_80_n


reg ss `var'  if year2 ==1990 &  touse==1 & sex==1
est store mss_`var'_90_n


reg ss `var'  if year2 ==2010 &  touse==1 & sex==1
est store mss_`var'_10_n

}


esttab  mss_z2isei_80_n  mss_z2tradisei_80_n   mss_z2domisei_80_n    mss_z2highisei_80_n  	 mss_z2meanisei_80_n 	 mss_z2addisei_80_n ///
		mss_z2isei_90_n  mss_z2tradisei_90_n   mss_z2domisei_90_n    mss_z2highisei_90_n  	 mss_z2meanisei_90_n 	 mss_z2addisei_90_n ///
		mss_z2isei_10_n  mss_z2tradisei_10_n   mss_z2domisei_10_n    mss_z2highisei_10_n  	 mss_z2meanisei_10_n 	 mss_z2addisei_10_n ///
								using $c7data\mukisein.csv, r2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles	 
								
esttab  mss_z2isei_80  mss_z2tradisei_80   mss_z2domisei_80    mss_z2highisei_80  	mss_z2meanisei_80 	 mss_z2addisei_80 ///
		mss_z2isei_90  mss_z2tradisei_90   mss_z2domisei_90    mss_z2highisei_90  	 mss_z2meanisei_90 	 mss_z2addisei_90 ///
		mss_z2isei_10  mss_z2tradisei_10   mss_z2domisei_10    mss_z2highisei_10  	 mss_z2meanisei_10 	 mss_z2addisei_10 ///
								using $c7data\mukisei.csv,  append r2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles	 

esttab  mss_z2isei_80_i  mss_z2tradisei_80_i   mss_z2domisei_80_i    mss_z2highisei_80_i  	 mss_z2meanisei_80_i 	 mss_z2addisei_80_i ///
		mss_z2isei_90_i  mss_z2tradisei_90_i   mss_z2domisei_90_i    mss_z2highisei_90_i  	 mss_z2meanisei_90_i 	 mss_z2addisei_90_i ///
		mss_z2isei_10_i  mss_z2tradisei_10_i   mss_z2domisei_10_i    mss_z2highisei_10_i  	 mss_z2meanisei_10_i 	 mss_z2addisei_10_i ///
								using $c7data\mukiseii.csv, append  r2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles	 

****
esttab mss_z2trei_80_n  mss_z2tradtrei_80_n   mss_z2domtrei_80_n    mss_z2hightrei_80_n  	 mss_z2meantrei_80_n 	 mss_z2addtrei_80_n ///
		mss_z2trei_90_n  mss_z2tradtrei_90_n   mss_z2domtrei_90_n    mss_z2hightrei_90_n  	 mss_z2meantrei_90_n 	 mss_z2addtrei_90_n ///
		mss_z2trei_10_n  mss_z2tradtrei_10_n   mss_z2domtrei_10_n    mss_z2hightrei_10_n  	 mss_z2meantrei_10_n 	 mss_z2addtrei_10_n ///
								using $c7data\muktrein.csv ,r2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		

esttab mss_z2trei_80  mss_z2tradtrei_80   mss_z2domtrei_80    mss_z2hightrei_80  	 mss_z2meantrei_80 	 mss_z2addtrei_80 ///
		mss_z2trei_90  mss_z2tradtrei_90   mss_z2domtrei_90    mss_z2hightrei_90  	 mss_z2meantrei_90 	 mss_z2addtrei_90 ///
		mss_z2trei_10  mss_z2tradtrei_10   mss_z2domtrei_10    mss_z2hightrei_10  	 mss_z2meantrei_10 	 mss_z2addtrei_10 ///
								using $c7data\muktrei.csv ,r2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles	
								
esttab mss_z2trei_80_i  mss_z2tradtrei_80_i   mss_z2domtrei_80_i    mss_z2hightrei_80_i  	 mss_z2meantrei_80_i 	 mss_z2addtrei_80_i ///
		mss_z2trei_90_i  mss_z2tradtrei_90_i   mss_z2domtrei_90_i    mss_z2hightrei_90_i  	 mss_z2meantrei_90_i 	 mss_z2addtrei_90_i ///
		mss_z2trei_10_i  mss_z2tradtrei_10_i   mss_z2domtrei_10_i    mss_z2hightrei_10_i  	 mss_z2meantrei_10_i 	 mss_z2addtrei_10_i ///
								using $c7data\muktreii.csv ,r2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		

						
****
esttab mss_z2icam_80_n  mss_z2tradicam_80_n   mss_z2domicam_80_n    mss_z2highicam_80_n  	 mss_z2meanicam_80_n 	 mss_z2addicam_80_n ///
	mss_z2icam_90_n  mss_z2tradicam_90_n  mss_z2domicam_90_n   mss_z2highicam_90_n  	 mss_z2meanicam_90_n 	 mss_z2addicam_90_n ///
	mss_z2icam_10_n  mss_z2tradicam_10_n   mss_z2domicam_10_n   mss_z2highicam_10_n  	 mss_z2meanicam_10_n 	 mss_z2addicam_10_n ///
							using $c7data\mukicamn.csv , r2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		

esttab mss_z2icam_80  mss_z2tradicam_80   mss_z2domicam_80    mss_z2highicam_80  	 mss_z2meanicam_80 	 mss_z2addicam_80 ///
	mss_z2icam_90  mss_z2tradicam_90   mss_z2domicam_90    mss_z2highicam_90  	 mss_z2meanicam_90 	 mss_z2addicam_90 ///
	mss_z2icam_10  mss_z2tradicam_10   mss_z2domicam_10    mss_z2highicam_10  	 mss_z2meanicam_10 	 mss_z2addicam_10 ///
							using $c7data\mukicam.csv , r2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		

esttab mss_z2icam_80_i  mss_z2tradicam_80_i   mss_z2domicam_80_i    mss_z2highicam_80_i  	 mss_z2meanicam_80_i 	 mss_z2addicam_80_i ///
	mss_z2icam_90_i  mss_z2tradicam_90_i   mss_z2domicam_90_i    mss_z2highicam_90_i  	 mss_z2meanicam_90_i 	 mss_z2addicam_90_i ///
	mss_z2icam_10_i  mss_z2tradicam_10_i   mss_z2domicam_10_i    mss_z2highicam_10_i  	 mss_z2meanicam_10_i 	 mss_z2addicam_10_i ///
							using $c7data\mukicami.csv ,r2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		
						
								
								
								
								
***************************************************************************************************
est drop _all

foreach var in  z2icam  	z2tradicam  	z2domicam   	z2highicam   	z2meanicam   	z2addicam ///
				z2isei		z2tradisei  	z2domisei   	z2highisei   	z2meanisei   	z2addisei ///
				z2trei		z2tradtrei 		z2domtrei  		z2hightrei  	z2meantrei  	z2addtrei {

reg  ss fem age married degree fem_deg fem_mar fem_age `var' fem_`var'  if year2 ==1980 &  touse==1 & sex==2
est store fss_`var'_80_i 


reg ss  fem age married degree fem_deg fem_mar fem_age `var'  fem_`var'  if year2 ==1990 &  touse==1 & sex==2
est store fss_`var'_90_i


reg ss fem age married degree fem_deg fem_mar fem_age `var'  fem_`var'   if year2 ==2010 &  touse==1 & sex==2
est store fss_`var'_10_i

}

foreach var in  z2icam  	z2tradicam  	z2domicam   	z2highicam   	z2meanicam   	z2addicam ///
				z2isei		z2tradisei  	z2domisei   	z2highisei   	z2meanisei   	z2addisei ///
				z2trei		z2tradtrei 		z2domtrei  		z2hightrei  	z2meantrei  	z2addtrei {

reg  ss fem age married degree  `var' if year2 ==1980 &  touse==1 & sex==2
est store fss_`var'_80


reg ss fem age married degree `var'  if year2 ==1990 &  touse==1 & sex==2
est store fss_`var'_90


reg ss fem age married degree  `var'  if year2 ==2010 &  touse==1 & sex==2
est store fss_`var'_10

}

foreach var in  z2icam  	z2tradicam  	z2domicam   	z2highicam   	z2meanicam   	z2addicam ///
				z2isei		z2tradisei  	z2domisei   	z2highisei   	z2meanisei   	z2addisei ///
				z2trei		z2tradtrei 		z2domtrei  		z2hightrei  	z2meantrei  	z2addtrei {

reg  ss `var' if year2 ==1980 &  touse==1 & sex==2
est store fss_`var'_80_n


reg ss `var'  if year2 ==1990 &  touse==1 & sex==2
est store fss_`var'_90_n


reg ss `var'  if year2 ==2010 &  touse==1 & sex==2
est store fss_`var'_10_n

}


esttab  fss_z2isei_80_n  fss_z2tradisei_80_n   fss_z2domisei_80_n    fss_z2highisei_80_n  	 fss_z2meanisei_80_n 	 fss_z2addisei_80_n ///
		fss_z2isei_90_n  fss_z2tradisei_90_n   fss_z2domisei_90_n    fss_z2highisei_90_n  	 fss_z2meanisei_90_n 	 fss_z2addisei_90_n ///
		fss_z2isei_10_n  fss_z2tradisei_10_n   fss_z2domisei_10_n    fss_z2highisei_10_n  	 fss_z2meanisei_10_n 	 fss_z2addisei_10_n ///
								using $c7data\fukisein.csv, r2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles	 
								
esttab  fss_z2isei_80  fss_z2tradisei_80   fss_z2domisei_80    fss_z2highisei_80  	 fss_z2meanisei_80 	 fss_z2addisei_80 ///
		fss_z2isei_90  fss_z2tradisei_90   fss_z2domisei_90    fss_z2highisei_90  	 fss_z2meanisei_90 	 fss_z2addisei_90 ///
		fss_z2isei_10  fss_z2tradisei_10   fss_z2domisei_10    fss_z2highisei_10  	 fss_z2meanisei_10 	 fss_z2addisei_10 ///
								using $c7data\fukisei.csv,  append r2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles	 

esttab  fss_z2isei_80_i  fss_z2tradisei_80_i   fss_z2domisei_80_i    fss_z2highisei_80_i  	 fss_z2meanisei_80_i 	 fss_z2addisei_80_i ///
		fss_z2isei_90_i  fss_z2tradisei_90_i   fss_z2domisei_90_i    fss_z2highisei_90_i  	 fss_z2meanisei_90_i 	 fss_z2addisei_90_i ///
		fss_z2isei_10_i  fss_z2tradisei_10_i   fss_z2domisei_10_i    fss_z2highisei_10_i  	 fss_z2meanisei_10_i 	 fss_z2addisei_10_i ///
								using $c7data\fukiseii.csv, append  r2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles	 

****
esttab fss_z2trei_80_n  fss_z2tradtrei_80_n   fss_z2domtrei_80_n    fss_z2hightrei_80_n  	 fss_z2meantrei_80_n 	 fss_z2addtrei_80_n ///
		fss_z2trei_90_n  fss_z2tradtrei_90_n   fss_z2domtrei_90_n    fss_z2hightrei_90_n  	 fss_z2meantrei_90_n 	 fss_z2addtrei_90_n ///
		fss_z2trei_10_n  fss_z2tradtrei_10_n   fss_z2domtrei_10_n    fss_z2hightrei_10_n  	 fss_z2meantrei_10_n 	 fss_z2addtrei_10_n ///
								using $c7data\fuktrein.csv ,r2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		

esttab fss_z2trei_80  fss_z2tradtrei_80   fss_z2domtrei_80    fss_z2hightrei_80  	 fss_z2meantrei_80 	 fss_z2addtrei_80 ///
		fss_z2trei_90  fss_z2tradtrei_90   fss_z2domtrei_90    fss_z2hightrei_90  	 fss_z2meantrei_90 	 fss_z2addtrei_90 ///
		fss_z2trei_10  fss_z2tradtrei_10   fss_z2domtrei_10    fss_z2hightrei_10  	 fss_z2meantrei_10 	 fss_z2addtrei_10 ///
								using $c7data\fuktrei.csv ,r2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles	
								
esttab fss_z2trei_80_i  fss_z2tradtrei_80_i   fss_z2domtrei_80_i    fss_z2hightrei_80_i  	 fss_z2meantrei_80_i 	 fss_z2addtrei_80_i ///
		fss_z2trei_90_i  fss_z2tradtrei_90_i   fss_z2domtrei_90_i    fss_z2hightrei_90_i  	 fss_z2meantrei_90_i 	 fss_z2addtrei_90_i ///
		fss_z2trei_10_i  fss_z2tradtrei_10_i   fss_z2domtrei_10_i    fss_z2hightrei_10_i  	 fss_z2meantrei_10_i 	 fss_z2addtrei_10_i ///
								using $c7data\fuktreii.csv ,r2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		

						
****
esttab fss_z2icam_80_n  fss_z2tradicam_80_n   fss_z2domicam_80_n    fss_z2highicam_80_n  	 fss_z2meanicam_80_n 	 fss_z2addicam_80_n ///
	fss_z2icam_90_n  fss_z2tradicam_90_n  fss_z2domicam_90_n   fss_z2highicam_90_n  	 fss_z2meanicam_90_n 	 fss_z2addicam_90_n ///
	fss_z2icam_10_n  fss_z2tradicam_10_n   fss_z2domicam_10_n   fss_z2highicam_10_n  	 fss_z2meanicam_10_n 	 fss_z2addicam_10_n ///
							using $c7data\fukicamn.csv , r2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		

esttab fss_z2icam_80  fss_z2tradicam_80   fss_z2domicam_80    fss_z2highicam_80  	 fss_z2meanicam_80 	 fss_z2addicam_80 ///
	fss_z2icam_90  fss_z2tradicam_90   fss_z2domicam_90    fss_z2highicam_90  	 fss_z2meanicam_90 	 fss_z2addicam_90 ///
	fss_z2icam_10  fss_z2tradicam_10   fss_z2domicam_10    fss_z2highicam_10  	 fss_z2meanicam_10 	 fss_z2addicam_10 ///
							using $c7data\fukicam.csv , r2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		

esttab fss_z2icam_80_i  fss_z2tradicam_80_i   fss_z2domicam_80_i    fss_z2highicam_80_i  	 fss_z2meanicam_80_i 	 fss_z2addicam_80_i ///
	fss_z2icam_90_i  fss_z2tradicam_90_i   fss_z2domicam_90_i    fss_z2highicam_90_i  	 fss_z2meanicam_90_i 	 fss_z2addicam_90_i ///
	fss_z2icam_10_i  fss_z2tradicam_10_i   fss_z2domicam_10_i    fss_z2highicam_10_i  	 fss_z2meanicam_10_i 	 fss_z2addicam_10_i ///
							using $c7data\fukicami.csv ,r2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		
*********************************************************************************************************



***********************************************************************************
***********************************************************************************
***********************************************************************************
*political 

est drop _all

foreach var in  z2icam  	z2tradicam  	z2domicam   	z2highicam   	z2meanicam   	z2addicam ///
				z2isei		z2tradisei  	z2domisei   	z2highisei   	z2meanisei   	z2addisei ///
				z2trei		z2tradtrei 		z2domtrei  		z2hightrei  	z2meantrei  	z2addtrei {

logit  lr fem age married degree fem_deg fem_mar fem_age `var' fem_`var'  if year2 ==1980 &  touse==1
est store ss_`var'_80_i


logit  lr  fem age married degree fem_deg fem_mar fem_age `var'  fem_`var'  if year2 ==1990 &  touse==1
est store ss_`var'_90_i

logit  lr fem age married degree fem_deg fem_mar fem_age `var'  fem_`var'   if year2 ==2000 &  touse==1
est store ss_`var'_00_i



logit  lr fem age married degree fem_deg fem_mar fem_age `var'  fem_`var'   if year2 ==2010 &  touse==1
est store ss_`var'_10_i

}

foreach var in  z2icam  	z2tradicam  	z2domicam   	z2highicam   	z2meanicam   	z2addicam ///
				z2isei		z2tradisei  	z2domisei   	z2highisei   	z2meanisei   	z2addisei ///
				z2trei		z2tradtrei 		z2domtrei  		z2hightrei  	z2meantrei  	z2addtrei {

logit   lr fem age married degree  `var' if year2 ==1980 &  touse==1
est store ss_`var'_80


logit  lr fem age married degree `var'  if year2 ==1990 &  touse==1
est store ss_`var'_90

logit  lr fem age married degree  `var'     if year2 ==2000 &  touse==1
est store ss_`var'_00


logit  lr fem age married degree  `var'  if year2 ==2010 &  touse==1
est store ss_`var'_10

}

foreach var in  z2icam  	z2tradicam  	z2domicam   	z2highicam   	z2meanicam   	z2addicam ///
				z2isei		z2tradisei  	z2domisei   	z2highisei   	z2meanisei   	z2addisei ///
				z2trei		z2tradtrei 		z2domtrei  		z2hightrei  	z2meantrei  	z2addtrei {

logit   lr `var' if year2 ==1980 &  touse==1
est store ss_`var'_80_n


logit  lr `var'  if year2 ==1990 &  touse==1
est store ss_`var'_90_n

logit lr  `var'   if year2 ==2000 &  touse==1
est store ss_`var'_00_n


logit  lr `var'  if year2 ==2010 &  touse==1
est store ss_`var'_10_n

}


esttab  ss_z2isei_80_n  ss_z2tradisei_80_n   ss_z2domisei_80_n    ss_z2highisei_80_n  	 ss_z2meanisei_80_n 	 ss_z2addisei_80_n ///
		ss_z2isei_90_n  ss_z2tradisei_90_n   ss_z2domisei_90_n    ss_z2highisei_90_n  	 ss_z2meanisei_90_n 	 ss_z2addisei_90_n ///
		ss_z2isei_00_n  ss_z2tradisei_00_n   ss_z2domisei_00_n    ss_z2highisei_00_n  	 ss_z2meanisei_00_n 	 ss_z2addisei_00_n ///
		ss_z2isei_10_n  ss_z2tradisei_10_n   ss_z2domisei_10_n    ss_z2highisei_10_n  	 ss_z2meanisei_10_n 	 ss_z2addisei_10_n ///
								using $c7data\usisein.csv, pr2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles	 
								
esttab  ss_z2isei_80  ss_z2tradisei_80   ss_z2domisei_80    ss_z2highisei_80  	 ss_z2meanisei_80 	 ss_z2addisei_80 ///
		ss_z2isei_90  ss_z2tradisei_90   ss_z2domisei_90    ss_z2highisei_90  	 ss_z2meanisei_90 	 ss_z2addisei_90 ///
		ss_z2isei_00  ss_z2tradisei_00   ss_z2domisei_00    ss_z2highisei_00  	 ss_z2meanisei_00 	 ss_z2addisei_00 ///
		ss_z2isei_10  ss_z2tradisei_10   ss_z2domisei_10    ss_z2highisei_10  	 ss_z2meanisei_10 	 ss_z2addisei_10 ///
								using $c7data\usisei.csv,  append pr2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles	 

esttab  ss_z2isei_80_i  ss_z2tradisei_80_i   ss_z2domisei_80_i    ss_z2highisei_80_i  	 ss_z2meanisei_80_i 	 ss_z2addisei_80_i ///
		ss_z2isei_90_i  ss_z2tradisei_90_i   ss_z2domisei_90_i    ss_z2highisei_90_i  	 ss_z2meanisei_90_i 	 ss_z2addisei_90_i ///
		ss_z2isei_00_i  ss_z2tradisei_00_i   ss_z2domisei_00_i    ss_z2highisei_00_i  	 ss_z2meanisei_00_i 	 ss_z2addisei_00_i ///
		ss_z2isei_10_i  ss_z2tradisei_10_i   ss_z2domisei_10_i    ss_z2highisei_10_i  	 ss_z2meanisei_10_i 	 ss_z2addisei_10_i ///
								using $c7data\usiseii.csv, append  pr2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles	 

****
esttab ss_z2trei_80_n  ss_z2tradtrei_80_n   ss_z2domtrei_80_n    ss_z2hightrei_80_n  	 ss_z2meantrei_80_n 	 ss_z2addtrei_80_n ///
		ss_z2trei_90_n  ss_z2tradtrei_90_n   ss_z2domtrei_90_n    ss_z2hightrei_90_n  	 ss_z2meantrei_90_n 	 ss_z2addtrei_90_n ///
		ss_z2trei_00_n  ss_z2tradtrei_00_n   ss_z2domtrei_00_n    ss_z2hightrei_00_n  	 ss_z2meantrei_00_n 	 ss_z2addtrei_00_n ///
		ss_z2trei_10_n  ss_z2tradtrei_10_n   ss_z2domtrei_10_n    ss_z2hightrei_10_n  	 ss_z2meantrei_10_n 	 ss_z2addtrei_10_n ///
								using $c7data\ustrein.csv ,pr2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		

esttab ss_z2trei_80  ss_z2tradtrei_80   ss_z2domtrei_80    ss_z2hightrei_80  	 ss_z2meantrei_80 	 ss_z2addtrei_80 ///
		ss_z2trei_90  ss_z2tradtrei_90   ss_z2domtrei_90    ss_z2hightrei_90  	 ss_z2meantrei_90 	 ss_z2addtrei_90 ///
		ss_z2trei_00  ss_z2tradtrei_00   ss_z2domtrei_00    ss_z2hightrei_00  	 ss_z2meantrei_00 	 ss_z2addtrei_00 ///
		ss_z2trei_10  ss_z2tradtrei_10   ss_z2domtrei_10    ss_z2hightrei_10  	 ss_z2meantrei_10 	 ss_z2addtrei_10 ///
								using $c7data\ustrei.csv ,pr2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles	
								
esttab ss_z2trei_80_i  ss_z2tradtrei_80_i   ss_z2domtrei_80_i    ss_z2hightrei_80_i  	 ss_z2meantrei_80_i 	 ss_z2addtrei_80_i ///
		ss_z2trei_90_i  ss_z2tradtrei_90_i   ss_z2domtrei_90_i    ss_z2hightrei_90_i  	 ss_z2meantrei_90_i 	 ss_z2addtrei_90_i ///
		ss_z2trei_00_i  ss_z2tradtrei_00_i   ss_z2domtrei_00_i    ss_z2hightrei_00_i  	 ss_z2meantrei_00_i 	 ss_z2addtrei_00_i ///
		ss_z2trei_10_i  ss_z2tradtrei_10_i   ss_z2domtrei_10_i    ss_z2hightrei_10_i  	 ss_z2meantrei_10_i 	 ss_z2addtrei_10_i ///
								using $c7data\ustreii.csv ,pr2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		

						
****
esttab ss_z2icam_80_n  ss_z2tradicam_80_n   ss_z2domicam_80_n    ss_z2highicam_80_n  	 ss_z2meanicam_80_n 	 ss_z2addicam_80_n ///
	ss_z2icam_90_n  ss_z2tradicam_90_n  ss_z2domicam_90_n   ss_z2highicam_90_n  	 ss_z2meanicam_90_n 	 ss_z2addicam_90_n ///
	ss_z2icam_00_n  ss_z2tradicam_00_n  ss_z2domicam_00_n   ss_z2highicam_00_n  	 ss_z2meanicam_00_n 	 ss_z2addicam_00_n ///
	ss_z2icam_10_n  ss_z2tradicam_10_n   ss_z2domicam_10_n   ss_z2highicam_10_n  	 ss_z2meanicam_10_n 	 ss_z2addicam_10_n ///
							using $c7data\usicamn.csv , pr2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		

esttab ss_z2icam_80  ss_z2tradicam_80   ss_z2domicam_80    ss_z2highicam_80  	 ss_z2meanicam_80 	 ss_z2addicam_80 ///
	ss_z2icam_90  ss_z2tradicam_90   ss_z2domicam_90    ss_z2highicam_90  	 ss_z2meanicam_90 	 ss_z2addicam_90 ///
	ss_z2icam_00  ss_z2tradicam_00   ss_z2domicam_00    ss_z2highicam_00  	 ss_z2meanicam_00 	 ss_z2addicam_00 ///
	ss_z2icam_10  ss_z2tradicam_10   ss_z2domicam_10    ss_z2highicam_10  	 ss_z2meanicam_10 	 ss_z2addicam_10 ///
							using $c7data\usicam.csv , pr2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		

esttab ss_z2icam_80_i  ss_z2tradicam_80_i   ss_z2domicam_80_i    ss_z2highicam_80_i  	 ss_z2meanicam_80_i 	 ss_z2addicam_80_i ///
	ss_z2icam_90_i  ss_z2tradicam_90_i   ss_z2domicam_90_i    ss_z2highicam_90_i  	 ss_z2meanicam_90_i 	 ss_z2addicam_90_i ///
	ss_z2icam_00_i  ss_z2tradicam_00_i   ss_z2domicam_00_i    ss_z2highicam_00_i  	 ss_z2meanicam_00_i 	 ss_z2addicam_00_i ///
	ss_z2icam_10_i  ss_z2tradicam_10_i   ss_z2domicam_10_i    ss_z2highicam_10_i  	 ss_z2meanicam_10_i 	 ss_z2addicam_10_i ///
							using $c7data\usicami.csv ,pr2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		

******************************************************************************************************
est drop _all



foreach var in  z2icam  	z2tradicam  	z2domicam   	z2highicam   	z2meanicam   	z2addicam ///
				z2isei		z2tradisei  	z2domisei   	z2highisei   	z2meanisei   	z2addisei ///
				z2trei		z2tradtrei 		z2domtrei  		z2hightrei  	z2meantrei  	z2addtrei {

logit  lr  age married degree  `var' if year2 ==1980 &  touse==1 & sex==1
est store mss_`var'_80


logit  lr  age married degree `var'  if year2 ==1990 &  touse==1 & sex==1
est store mss_`var'_90

logit  lr  age married degree  `var'  if year2 ==2000 &  touse==1 & sex==1
est store mss_`var'_00

logit  lr  age married degree  `var'  if year2 ==2010 &  touse==1 & sex==1
est store mss_`var'_10

}

foreach var in  z2icam  	z2tradicam  	z2domicam   	z2highicam   	z2meanicam   	z2addicam ///
				z2isei		z2tradisei  	z2domisei   	z2highisei   	z2meanisei   	z2addisei ///
				z2trei		z2tradtrei 		z2domtrei  		z2hightrei  	z2meantrei  	z2addtrei {

logit   lr `var' if year2 ==1980 &  touse==1 & sex==1
est store mss_`var'_80_n


logit  lr `var'  if year2 ==1990 &  touse==1 & sex==1
est store mss_`var'_90_n

logit  lr `var'  if year2 ==2000 &  touse==1 & sex==1
est store mss_`var'_00_n

logit  lr `var'  if year2 ==2010 &  touse==1 & sex==1
est store mss_`var'_10_n

}


esttab  mss_z2isei_80_n  mss_z2tradisei_80_n   mss_z2domisei_80_n    mss_z2highisei_80_n  	 mss_z2meanisei_80_n 	 mss_z2addisei_80_n ///
		mss_z2isei_90_n  mss_z2tradisei_90_n   mss_z2domisei_90_n    mss_z2highisei_90_n  	 mss_z2meanisei_90_n 	 mss_z2addisei_90_n ///
		mss_z2isei_00_n  mss_z2tradisei_00_n   mss_z2domisei_00_n    mss_z2highisei_00_n  	 mss_z2meanisei_00_n 	 mss_z2addisei_00_n ///
		mss_z2isei_10_n  mss_z2tradisei_10_n   mss_z2domisei_10_n    mss_z2highisei_10_n  	 mss_z2meanisei_10_n 	 mss_z2addisei_10_n ///
								using $c7data\musisein.csv, pr2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles	 
								
esttab  mss_z2isei_80  mss_z2tradisei_80   mss_z2domisei_80    mss_z2highisei_80  	mss_z2meanisei_80 	 mss_z2addisei_80 ///
		mss_z2isei_90  mss_z2tradisei_90   mss_z2domisei_90    mss_z2highisei_90  	 mss_z2meanisei_90 	 mss_z2addisei_90 ///
		mss_z2isei_00  mss_z2tradisei_00   mss_z2domisei_00    mss_z2highisei_00  	 mss_z2meanisei_00 	 mss_z2addisei_00 ///
		mss_z2isei_10  mss_z2tradisei_10   mss_z2domisei_10    mss_z2highisei_10  	 mss_z2meanisei_10 	 mss_z2addisei_10 ///
								using $c7data\musisei.csv,  append pr2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles	 


****
esttab mss_z2trei_80_n  mss_z2tradtrei_80_n   mss_z2domtrei_80_n    mss_z2hightrei_80_n  	 mss_z2meantrei_80_n 	 mss_z2addtrei_80_n ///
		mss_z2trei_90_n  mss_z2tradtrei_90_n   mss_z2domtrei_90_n    mss_z2hightrei_90_n  	 mss_z2meantrei_90_n 	 mss_z2addtrei_90_n ///
		mss_z2trei_00_n  mss_z2tradtrei_00_n   mss_z2domtrei_00_n    mss_z2hightrei_00_n  	 mss_z2meantrei_00_n 	 mss_z2addtrei_00_n ///
		mss_z2trei_10_n  mss_z2tradtrei_10_n   mss_z2domtrei_10_n    mss_z2hightrei_10_n  	 mss_z2meantrei_10_n 	 mss_z2addtrei_10_n ///
								using $c7data\mustrein.csv ,pr2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		

esttab mss_z2trei_80  mss_z2tradtrei_80   mss_z2domtrei_80    mss_z2hightrei_80  	 mss_z2meantrei_80 	 mss_z2addtrei_80 ///
		mss_z2trei_90  mss_z2tradtrei_90   mss_z2domtrei_90    mss_z2hightrei_90  	 mss_z2meantrei_90 	 mss_z2addtrei_90 ///
		mss_z2trei_00  mss_z2tradtrei_00   mss_z2domtrei_00    mss_z2hightrei_00  	 mss_z2meantrei_00 	 mss_z2addtrei_00 ///
		mss_z2trei_10  mss_z2tradtrei_10   mss_z2domtrei_10    mss_z2hightrei_10  	 mss_z2meantrei_10 	 mss_z2addtrei_10 ///
								using $c7data\mustrei.csv ,pr2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles	
								

						
****
esttab mss_z2icam_80_n  mss_z2tradicam_80_n   mss_z2domicam_80_n    mss_z2highicam_80_n  	 mss_z2meanicam_80_n 	 mss_z2addicam_80_n ///
	mss_z2icam_90_n  mss_z2tradicam_90_n  mss_z2domicam_90_n   mss_z2highicam_90_n  	 mss_z2meanicam_90_n 	 mss_z2addicam_90_n ///
	mss_z2icam_00_n  mss_z2tradicam_00_n  mss_z2domicam_00_n   mss_z2highicam_00_n  	 mss_z2meanicam_00_n 	 mss_z2addicam_00_n ///
	mss_z2icam_10_n  mss_z2tradicam_10_n   mss_z2domicam_10_n   mss_z2highicam_10_n  	 mss_z2meanicam_10_n 	 mss_z2addicam_10_n ///
							using $c7data\musicamn.csv , pr2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		

esttab mss_z2icam_80  mss_z2tradicam_80   mss_z2domicam_80    mss_z2highicam_80  	 mss_z2meanicam_80 	 mss_z2addicam_80 ///
	mss_z2icam_90  mss_z2tradicam_90   mss_z2domicam_90    mss_z2highicam_90  	 mss_z2meanicam_90 	 mss_z2addicam_90 ///
	mss_z2icam_00  mss_z2tradicam_00   mss_z2domicam_00    mss_z2highicam_00  	 mss_z2meanicam_00 	 mss_z2addicam_00 ///
	mss_z2icam_10  mss_z2tradicam_10   mss_z2domicam_10    mss_z2highicam_10  	 mss_z2meanicam_10 	 mss_z2addicam_10 ///
							using $c7data\musicam.csv , pr2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		


								
								
								
								
***************************************************************************************************
est drop _all


foreach var in  z2icam  	z2tradicam  	z2domicam   	z2highicam   	z2meanicam   	z2addicam ///
				z2isei		z2tradisei  	z2domisei   	z2highisei   	z2meanisei   	z2addisei ///
				z2trei		z2tradtrei 		z2domtrei  		z2hightrei  	z2meantrei  	z2addtrei {

logit   lr age married degree  `var' if year2 ==1980 &  touse==1 & sex==2
est store fss_`var'_80


logit  lr  age married degree `var'  if year2 ==1990 &  touse==1 & sex==2
est store fss_`var'_90

logit  lr  age married degree  `var'  if year2 ==2000 &  touse==1 & sex==2
est store fss_`var'_00

logit lr  age married degree  `var'  if year2 ==2010 &  touse==1 & sex==2
est store fss_`var'_10

}

foreach var in  z2icam  	z2tradicam  	z2domicam   	z2highicam   	z2meanicam   	z2addicam ///
				z2isei		z2tradisei  	z2domisei   	z2highisei   	z2meanisei   	z2addisei ///
				z2trei		z2tradtrei 		z2domtrei  		z2hightrei  	z2meantrei  	z2addtrei {

logit   lr `var' if year2 ==1980 &  touse==1 & sex==2
est store fss_`var'_80_n


logit  lr `var'  if year2 ==1990 &  touse==1 & sex==2
est store fss_`var'_90_n

logit  lr `var'  if year2 ==2000 &  touse==1 & sex==2
est store fss_`var'_00_n


logit  lr `var'  if year2 ==2010 &  touse==1 & sex==2
est store fss_`var'_10_n

}


esttab  fss_z2isei_80_n  fss_z2tradisei_80_n   fss_z2domisei_80_n    fss_z2highisei_80_n  	 fss_z2meanisei_80_n 	 fss_z2addisei_80_n ///
		fss_z2isei_90_n  fss_z2tradisei_90_n   fss_z2domisei_90_n    fss_z2highisei_90_n  	 fss_z2meanisei_90_n 	 fss_z2addisei_90_n ///
		fss_z2isei_00_n  fss_z2tradisei_00_n   fss_z2domisei_00_n    fss_z2highisei_00_n  	 fss_z2meanisei_00_n 	 fss_z2addisei_00_n ///
		fss_z2isei_10_n  fss_z2tradisei_10_n   fss_z2domisei_10_n    fss_z2highisei_10_n  	 fss_z2meanisei_10_n 	 fss_z2addisei_10_n ///
								using $c7data\fusisein.csv, pr2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles	 
								
esttab  fss_z2isei_80  fss_z2tradisei_80   fss_z2domisei_80    fss_z2highisei_80  	 fss_z2meanisei_80 	 fss_z2addisei_80 ///
		fss_z2isei_90  fss_z2tradisei_90   fss_z2domisei_90    fss_z2highisei_90  	 fss_z2meanisei_90 	 fss_z2addisei_90 ///
		fss_z2isei_00  fss_z2tradisei_00   fss_z2domisei_00    fss_z2highisei_00  	 fss_z2meanisei_00 	 fss_z2addisei_00 ///
		fss_z2isei_10  fss_z2tradisei_10   fss_z2domisei_10    fss_z2highisei_10  	 fss_z2meanisei_10 	 fss_z2addisei_10 ///
								using $c7data\fusisei.csv,  append pr2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles	 


****
esttab fss_z2trei_80_n  fss_z2tradtrei_80_n   fss_z2domtrei_80_n    fss_z2hightrei_80_n  	 fss_z2meantrei_80_n 	 fss_z2addtrei_80_n ///
		fss_z2trei_90_n  fss_z2tradtrei_90_n   fss_z2domtrei_90_n    fss_z2hightrei_90_n  	 fss_z2meantrei_90_n 	 fss_z2addtrei_90_n ///
		fss_z2trei_00_n  fss_z2tradtrei_00_n   fss_z2domtrei_00_n    fss_z2hightrei_00_n  	 fss_z2meantrei_00_n 	 fss_z2addtrei_00_n ///
		fss_z2trei_10_n  fss_z2tradtrei_10_n   fss_z2domtrei_10_n    fss_z2hightrei_10_n  	 fss_z2meantrei_10_n 	 fss_z2addtrei_10_n ///
								using $c7data\fustrein.csv ,pr2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		

esttab fss_z2trei_80  fss_z2tradtrei_80   fss_z2domtrei_80    fss_z2hightrei_80  	 fss_z2meantrei_80 	 fss_z2addtrei_80 ///
		fss_z2trei_90  fss_z2tradtrei_90   fss_z2domtrei_90    fss_z2hightrei_90  	 fss_z2meantrei_90 	 fss_z2addtrei_90 ///
		fss_z2trei_00  fss_z2tradtrei_00   fss_z2domtrei_00    fss_z2hightrei_00  	 fss_z2meantrei_00 	 fss_z2addtrei_00 ///
		fss_z2trei_10  fss_z2tradtrei_10   fss_z2domtrei_10    fss_z2hightrei_10  	 fss_z2meantrei_10 	 fss_z2addtrei_10 ///
								using $c7data\fustrei.csv ,pr2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles	
								


						
****
esttab fss_z2icam_80_n  fss_z2tradicam_80_n   fss_z2domicam_80_n    fss_z2highicam_80_n  	 fss_z2meanicam_80_n 	 fss_z2addicam_80_n ///
	fss_z2icam_90_n  fss_z2tradicam_90_n  fss_z2domicam_90_n   fss_z2highicam_90_n  	 fss_z2meanicam_90_n 	 fss_z2addicam_90_n ///
	fss_z2icam_00_n  fss_z2tradicam_00_n  fss_z2domicam_00_n   fss_z2highicam_00_n  	 fss_z2meanicam_00_n 	 fss_z2addicam_00_n ///
	fss_z2icam_10_n  fss_z2tradicam_10_n   fss_z2domicam_10_n   fss_z2highicam_10_n  	 fss_z2meanicam_10_n 	 fss_z2addicam_10_n ///
							using $c7data\fusicamn.csv , pr2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		

esttab fss_z2icam_80  fss_z2tradicam_80   fss_z2domicam_80    fss_z2highicam_80  	 fss_z2meanicam_80 	 fss_z2addicam_80 ///
	fss_z2icam_90  fss_z2tradicam_90   fss_z2domicam_90    fss_z2highicam_90  	 fss_z2meanicam_90 	 fss_z2addicam_90 ///
	fss_z2icam_00  fss_z2tradicam_00   fss_z2domicam_00    fss_z2highicam_00  	 fss_z2meanicam_00 	 fss_z2addicam_00 ///
	fss_z2icam_10  fss_z2tradicam_10   fss_z2domicam_10    fss_z2highicam_10  	 fss_z2meanicam_10 	 fss_z2addicam_10 ///
							using $c7data\fusicam.csv , pr2 aic bic /// 
								cells(b(star fmt(%9.2f)))   ///
                                starlevels(* .05 ** .01 *** .001) ///
								mtitles		




