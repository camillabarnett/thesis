


*****  PAUL LAMBERT, UNIV. STIRLING, 29 MAR 2011
*** Stata code for derivation of CAMSIS scale scores using data on pairs of socially connected occupations 
**    using correspondence analysis 
*** 
** CODE EDITED BY CAMILLA BARNETT , to work on SOC90 rather than ISCO88 
** and for data set of women and womens freinds 
**data is structured so that each case is counted twice to maximase occupations represented. 
** code still produces two scores but they should be identical therefore only one is needed.


*************************************************************
**** DATA INPUT AND FORMAT REQUIREMENTS

** [1] Input microdata (PATHC): a rectangular Stata format file featuring data on 
*          two socially connected occupations, variable names to be given as programme arguments 
*          (example: husbands occupation; wive's occupation). The data may be unweighted, or 
*          may have integer frequency weights in a named variable (which need be specified as a programme argument)
*         Up to three variables are saved from this file (the two occupation variables, and the frequency weight 
*          indicator if it exists. Any name can be used for these variables, except for 'cfreq' which is used 
*          in the programme 

global pathc H:\thesis_analysis\data\my_data\camsis_creation\appended_f.dta

** [2] Output file name (PATHD): the programme will create an output file with this name 
*      with occupations listed alongside the recommended scale scores 
*      (User notice: In most instances, don't expect the first run of the programme to generate useful 
*        scale scores, there will probably be a need for some iterative analysis identifying and excluding 
*        'pseudo-diagonal' occupational combinations)

global cb_female_camsis

** [3] Pseudo-diagonal indicator file (PATHB)
*      This is a file which lists pairs of occupational combinations to be treated as 'pseudo-diagonals'.
*      This file must be tab-delimited with four columns and column headers named respectively 
*      lower_1 upper_1 lower_2 upper_2 
*      The nature of this file and its preparation (for instance via MS Excel) is explained at 
*      www.camsis.stir.ac.uk/make_camsis 
*      If you have not specified any such pairs, it is still necessary to specify this file. A file with missing 
*      category codes can be used (the net effect being that no pairs are treated as pseudo-diagonals, 
*      an example is available at http://www.camsis.stir.ac.uk/make_camsis/templates/camsis_psds_blank.txt, so 
*      a sensible default is to specify: 
*        ' global pathb "http://www.camsis.stir.ac.uk/make_camsis/templates/camsis_psds_blank.txt" ' 
*
global pathb "http://www.camsis.stir.ac.uk/make_camsis/templates/camsis_psds_blank.txt"

** [4] [Not needed here] Occ codes with an expected correlate ('PATHA')
*       For information, in other automated macros this file is used to help decide the direction of the 
*         scale; for ISCO88, there is no need for this since we expect a negative correlation with isco88 values


*[Not needed here] i dont think this is needed for soc either but I could be wrong******

** [5] OCC template file (PATHE) 
*      This is a database of every possible individual occ in the scheme used,  
*      For ISCO88, a generic template is available at the CAMSIS site: 
*      http://www.camsis.stir.ac.uk/make_camsis/templates/isco88templateoccs4.dat


global pathe "H:\thesis_analysis\data\my_data\camsis_creation\soc90.csv"


** [6] Output microdata (PATHF): this will be generated by the programme, and will comprise a 
*          version of the input microdata, but now with additional information on the recoded occupational 
*          units on which the scale itself is derived (the natural units of the two occupational 
*          categories, say 'hocc' and 'wocc',  are recoded into new variables 'occ1s' and 'occ2s' which usually 
*          have some differences in coding due to sparse categories from the former being merged in the latter). 



global pathf "H:\thesis_analysis\data\my_data\camsis_creation"



 *The additional global argument 'occtype' is used to denote a name for the occupational unit group to which the 
*  occupational scores are being derived, such as hisco, isco88, soc2000, etc.


global occtype "soc90"

*temporary file 

global path9 H:\thesis_analysis\data\my_data\camsis_creation\temp

*/

use $pathc, clear 

******************************
******************************
******************************
******************************


** Data construction (0): Generate fallback occupations for men and for women
* (the fall-backs are the most populous occupation in the group)

* Men
use $pathc, clear 
capture drop cfreq
gen cfreq=1
capture replace cfreq= 1
keep jbsoc cfreq 
gen soc1=floor(jbsoc /100)
gen soc2=floor(jbsoc /10)
gen soc3=jbsoc 


* Find the most common occs within the 1,2,3,4 digit units
* 1
capture drop rcount
capture drop rprop
egen rcount=sum(cfreq), by(soc1)
egen rprop=sum(cfreq), by(jbsoc) 
replace rprop=rprop / rcount 
gsort +soc1 -rprop
capture drop tocc
gen tocc=jbsoc
replace tocc=0 if (soc1[_n-1]==soc1 )
egen mod1_m=max(tocc), by(soc1)
* 2 
capture drop rcount
capture drop rprop
egen rcount=sum(cfreq), by(soc2)
egen rprop=sum(cfreq), by(jbsoc) 
replace rprop=rprop / rcount 
gsort +soc2  -rprop
capture drop tocc
gen tocc=jbsoc
replace tocc=0 if (soc2[_n-1]==soc2 )
egen mod2_m=max(tocc), by(soc2 )
* 3 
capture drop rcount
capture drop rprop
egen rcount=sum(cfreq), by(soc3)
egen rprop=sum(cfreq), by(jbsoc) 
replace rprop=rprop / rcount 
gsort +soc3  -rprop
capture drop tocc
gen tocc=jbsoc
replace tocc=0 if (soc3[_n-1]==soc3 )
egen mod3_m=max(tocc), by(soc3 )

* 
codebook jbsoc  mod1_m mod2_m mod3_m  , compact
keep jbsoc  mod1_m mod2_m mod3_m  
sort jbsoc
egen tagi=tag(jbsoc)
tab tagi
keep if tagi==1
drop tagi
summarize
sav $path9\males_recodes.dta, replace
* (This is a matrix with the original occ measure, and recodes at higher levels of aggregation)



* Women
use $pathc, clear
capture drop cfreq
gen cfreq=1
capture replace cfreq=1
keep netsoc cfreq 
gen soc1=floor(netsoc /100)
gen soc2=floor(netsoc /10)
gen soc3=netsoc

* Find the most common occs within the 1,2,3,4 digit units 


* 1 
capture drop rcount
capture drop rprop
egen rcount=sum(cfreq), by(soc1)
egen rprop=sum(cfreq), by(netsoc) 
replace rprop=rprop / rcount 
gsort +soc1 -rprop
capture drop tocc
gen tocc=netsoc
replace tocc=0 if (soc1[_n-1]==soc1 )
egen mod1_f=max(tocc), by(soc1 )
* 2 
capture drop rcount
capture drop rprop
egen rcount=sum(cfreq), by(soc2 )
egen rprop=sum(cfreq), by(netsoc) 
replace rprop=rprop / rcount 
gsort +soc2  -rprop
capture drop tocc
gen tocc=netsoc
replace tocc=0 if (soc2[_n-1]==soc2 )
egen mod2_f=max(tocc), by(soc2 )
* 3 
capture drop rcount
capture drop rprop
egen rcount=sum(cfreq), by(soc3 )
egen rprop=sum(cfreq), by(netsoc) 
replace rprop=rprop / rcount 
gsort +soc3  -rprop
capture drop tocc
gen tocc=netsoc
replace tocc=0 if (soc3[_n-1]==soc3 )
egen mod3_f=max(tocc), by(soc3 )
 

* 
codebook netsoc  mod1_f mod2_f mod3_f  , compact
keep netsoc mod1_f mod2_f mod3_f  
sort netsoc
egen tagi=tag(netsoc)
tab tagi
keep if tagi==1
drop tagi
summarize
sav $path9\females_recodes.dta, replace
* (This is a matrix with the original occ measure, and recodes at higher levels of aggregation)
*
dir $path9\*_recodes.dta 
**



*********************************************


** Data construction (i): convert microdata into 'table' format

use $pathc, clear
drop if jbsoc == 592
drop if netsoc == 592
capture drop cfreq
gen cfreq=1
capture replace cfreq=1
keep jbsoc netsoc cfreq 
sort jbsoc netsoc 
collapse (sum) cfreq, by(jbsoc netsoc)
summarize
sav $path9\temp1.dta, replace



*********************************************


** Data construction (ii): Exclude any diagonal pairs according to digit specifier 

use $path9\temp1.dta, clear
capture drop cs_dig
gen cs_dig=0
capture replace cs_dig=0
tab cs_dig
capture drop cs_dig2
gen cs_dig2=10^cs_dig
capture drop cs_d_1
gen cs_d_1=floor(jbsoc/cs_dig2)
capture drop cs_d_2
gen cs_d_2=floor(netsoc/cs_dig2)
capture drop psd1
gen psd1=(cs_d_1==cs_d_2)
tab psd1 [fw=cfreq]
sort jbsoc netsoc 
sav $path9\temp2.dta, replace



*********************************************

** Data construction (iii): Exclude any diagonals according to specific combinations specified

** Exclude pseudo-diagonals
use  $path9\temp2.dta, clear 
capture drop psd2
gen psd2=0

do H:\thesis_analysis\do_files\my_dofiles\ch4_measures\camsis\pseudo_digonals.do


tab psd2 [fw=cfreq]
tab psd1 psd2 [fw=cfreq]

*replace psd2=1 if jbsoc==592
*replace psd2=1 if netsoc==592


sav $path9\temp3.dta, replace




*********************************************


** Data construction (iv): Recode sparse categories after making exclusions 


use $path9\temp3.dta, clear

gen cfreq2=cfreq*(psd1==0 & psd2==0)

** Merges so each has 10+ - in most cases based on inspection of fall back options created in data construction (0) but also best judgement of resercher where these do not seem appropriate: 


sort jbsoc
capture drop n_occ1
egen n_occ1=sum(cfreq2), by(jbsoc)
sort netsoc
capture drop n_occ2
egen n_occ2=sum(cfreq2), by(netsoc)

capture drop occ1s 
capture drop occ2s 
gen occ1s=jbsoc
gen occ2s=netsoc


tab jbsoc if n_occ1 <10
*do merge_sparse_occs2.do

tab netsoc if n_occ2 <10
*do merge_sparse_occs2_2.do

sort occ1s
capture drop n_occ1s
egen n_occ1s=sum(cfreq2), by(occ1s)
sort occ2s
capture drop n_occ2s
egen n_occ2s=sum(cfreq2), by(occ2s)


tab occ1s if n_occ1s <10

tab occ2s if n_occ2s <10




** The recoded occupational categories used in CA analysis, non-psd cases only
tab1 occ1s occ2s [fw=cfreq2]



** 


sav $path9\temp4.dta, replace

keep if psd1==0 & psd2==0
summarize jbsoc occ1s netsoc occ2s
summarize jbsoc [fw=cfreq]
scalar usedN = r(N)
di usedN
sav $path9\temp5.dta, replace


** Summary table file with original and recoded occupations, psd indicators, and frequency weights:
use $path9\temp4.dta, clear
summarize jbsoc occ1s netsoc occ2s psd1 psd2 cfreq
keep jbsoc occ1s netsoc occ2s psd1 psd2 cfreq
sav $pathf\summerytable, replace




** Summary data on number of cases including ps1 and psd2 : 
use $path9\temp4.dta, clear
gen cases_1=1
collapse (sum) cases_1 [fw=cfreq], by(jbsoc)
sort jbsoc
sav $path9\o1.dta, replace
use $path9\temp4.dta, clear
gen cases_2=1
collapse (sum) cases_2 [fw=cfreq], by(netsoc)
rename netsoc jbsoc
sort jbsoc
sav $path9\o2.dta, replace





*********************




** Data construction (x): Expand data twofold in order to force rows and columns to be equal
***  [WON'T BE IMPLEMENTED IN THIS EXAMPLE] 
/*
use $path9\temp5.dta, clear
keep jbsoc occ1s netsoc occ2s cfreq 
gen half=1
sav $path9\bit1.dta, replace
capture drop temp
rename jbsoc  temp
rename netsoc jbsoc 
rename temp netsoc 
rename occ1s  temp
rename occ2s occ1s 
rename temp occ2s 
recode half 1=2
sav $path9\bit2.dta, replace
use $path9\bit1.dta, clear
append using $path9\bit2.dta
tab half
gen freq2=floor( (cfreq+1) /2)
summarize
sav $path9\temp6.dta, replace 
*** [NOT USED IN THIS DERIVATION]
*/


*****************************************


use $path9\temp5.dta, clear
keep jbsoc occ1s netsoc occ2s cfreq 
gen freq2=cfreq


** First CA
capture log close
capture log using $path9\cb_camsis__ca1.txt, replace text
table occ1s, c(sum freq2 min jbsoc max jbsoc)
table occ2s, c(sum freq2 min netsoc max netsoc)
ca occ1s occ2s  [fweight=freq2], dim(2)
capture log close


* 1 round of possible psds leading to a second CA excluding the extreme cases: 
capture drop m1fit
predict m1fit, fit 
sort jbsoc netsoc 
capture drop n_comb
egen n_comb=sum(freq2), by(jbsoc netsoc)
regress n_comb m1fit [fweight=freq2]
capture drop caresid
predict caresid, rstandard
capture drop psd2
gen psd2=0
replace psd2=1 if (caresid > 5 | caresid  < -5)
tab psd2 [fweight=freq2]
** Second CA 
ca jbsoc netsoc [fweight=freq2] if psd2==0, dim(2) 



*** Extract scores associatd with occ1s and occ2s respectively
capture drop rawsc1
capture drop rawsc2
capture drop rawsc3
capture drop rawsc4
predict rawsc1, rowscore(1)
predict rawsc2, rowscore(2)
predict rawsc3, colscore(1)
predict rawsc4, colscore(2)
sav $path9\ca.dta, replace


****** occ1s: the scores for the rows (respontent occupations)
use $path9\ca.dta, clear 
sort jbsoc 
correlate rawsc1 rawsc2 rawsc3 rawsc4 occ1s jbsoc 
correlate rawsc1 jbsoc 
capture scalar drop c1
scalar c1=r(rho)
correlate rawsc2 jbsoc
capture scalar drop c2
scalar c2=r(rho)
capture drop dimused
gen dimused=1
replace dimused=2 if ( (c2*c2)>(c1*c1) )
tab dimused
gen rawsc=rawsc1
replace rawsc=rawsc2 if (dimused==2)
gen rawsc_2=rawsc2
replace rawsc_2=rawsc1 if (dimused==2)
capture drop dimused
sav $path9\cb_camsis__row.dta, replace
capture drop rawsc1
capture drop rawsc2 
* Tool to convert dimension score sign if necessary
correlate rawsc jbsoc
capture scalar drop corel /* If the sign is negative, that's correct already; if it's positive, we want to reverse it */
scalar corel=r(rho)
gen corelv=corel 
gen sign=1
replace sign=-1 if corelv > 0
rename rawsc temp
gen rawsc=sign*temp
drop temp
correlate rawsc_2 jbsoc
capture scalar drop corel2
scalar corel2=r(rho)
gen corelv2=corel2
gen sign2=1
replace sign2=-1 if corelv2 > 0
rename rawsc_2 temp
gen rawsc_2=sign2*temp
drop temp
summarize occ1s rawsc rawsc_2   
keep occ1s rawsc rawsc_2  
sort occ1s
collapse (mean) rawsc rawsc_2 , by(occ1s) 
summarize
sort occ1s
sav $path9\scores_a.dta, replace

****** occ2s: the scores for the columns (womens occupations)
use $path9\ca.dta, clear 
sort netsoc 
correlate rawsc3 rawsc4 occ2s netsoc
correlate rawsc3 netsoc
capture scalar drop c1
scalar c1=r(rho)
correlate rawsc4 netsoc
capture scalar drop c2
scalar c2=r(rho)
capture drop dimused
gen dimused=1
replace dimused=2 if ( (c2*c2)>(c1*c1) )
tab dimused
gen rawsc=rawsc3
replace rawsc=rawsc4 if (dimused==2)
gen rawsc_2=rawsc4
replace rawsc_2=rawsc3 if (dimused==2)
capture drop dimused
sav $path9\cb_camsis_col.dta, replace
capture drop rawsc3
capture drop rawsc4 
* Tool to convert dimension score sign if necessary
correlate rawsc netsoc
capture scalar drop corel
scalar corel=r(rho)
gen corelv=corel
gen sign3=1
replace sign3=-1 if corelv > 0
rename rawsc temp
gen rawsc=sign3*temp
drop temp
correlate rawsc_2 netsoc
capture scalar drop corel2
scalar corel2=r(rho)
gen corelv2=corel2
gen sign4=1
replace sign4=-1 if corelv2 > 0
rename rawsc_2 temp
gen rawsc_2=sign4*temp
drop temp
summarize occ2s rawsc rawsc_2   
keep occ2s rawsc rawsc_2  
sort occ2s
collapse (mean) rawsc rawsc_2 , by(occ2s) 
summarize
sort occ2s
sav $path9\scores_b.dta, replace


* Retrieve the full microdata including non-psds for purposes of scaling, and match
*   scale scores against it: 
* Standardise scaled score to population level mean 50, sd 15:

use $path9\temp4.dta, clear
summarize jbsoc occ1s netsoc occ2s cfreq cfreq2
keep jbsoc occ1s  cfreq cfreq2
gen par=0
sort occ1s
merge occ1s using $path9\scores_a.dta
tab _merge
keep if _merge==1 | _merge==3
drop _merge
sav $path9\bit1.dta, replace

use $path9\temp4.dta, clear
summarize jbsoc occ1s netsoc occ2s cfreq cfreq2
keep netsoc occ2s  cfreq cfreq2
gen par=1
sort occ2s
merge occ2s using $path9\scores_b.dta
tab _merge
keep if _merge==1 | _merge==3
drop _merge
rename occ2s occ1s
rename netsoc jbsoc
sav $path9\bit2.dta, replace

use $path9\bit1.dta, clear
append using $path9\bit2.dta
tab par
summarize
sort occ1s
* At this stage, the two derivd variables are rawsc and rawsc2 for both men and women; for men 
* when par=0 and for women when par=1



* Calculate a zscore for the raw scores for the male and female total populations: 



summarize rawsc [fw=cfreq] if par==0 
gen zm1= (rawsc - r(mean)) / r(sd) 
summarize rawsc_2 [fw=cfreq] if par==0
gen zm2= (rawsc_2 - r(mean)) / r(sd)
summarize zm1 zm2 [fw=cfreq] if par==0 

summarize rawsc [fw=cfreq] if par==1 
gen zf1= (rawsc - r(mean)) / r(sd) 
summarize rawsc_2 [fw=cfreq] if par==1
gen zf2= (rawsc_2 - r(mean)) / r(sd)
summarize zf1 zf2 [fw=cfreq] if par==1 




* Re-scale the zscore to the CAMSIS standard range 
gen cb_camsis_m = (zm1*(15)) + 50 
replace cb_camsis_m = 99 if cb_camsis_m >= 99
replace cb_camsis_m = 1 if cb_camsis_m <= 1
gen cb_camsis_m2 = (zm2*(15)) + 50 
replace cb_camsis_m2 = 99 if cb_camsis_m2 >= 99
replace cb_camsis_m2 = 1 if cb_camsis_m2 <= 1

gen cb_camsis_f = (zf1*(15)) + 50 
replace cb_camsis_f = 99 if cb_camsis_f >= 99
replace cb_camsis_f = 1 if cb_camsis_f <= 1
gen cb_camsis_f2 = (zf2*(15)) + 50 
replace cb_camsis_f2 = 99 if cb_camsis_f2 >= 99
replace cb_camsis_f2 = 1 if cb_camsis_f2 <= 1

sav $path9\temp12.dta, replace

* Split this into a file for rows (typically males) and another for columns (females): 
use $path9\temp12.dta, clear
keep if par==0
sav $path9\temp12m.dta, replace

use $path9\temp12.dta, clear
keep if par==1
sav $path9\temp12f.dta, replace



** Attribute scores plus proportions in occupations: 
use $path9\temp12m.dta, clear
sort occ1s
egen used_m=sum(cfreq2), by(occ1s)
sort jbsoc
collapse (mean) cb_camsis_m (mean) cb_camsis_m2 (mean) used [fw=cfreq] , by(jbsoc) 
list jbsoc cb_camsis_m cb_camsis_m2
sort jbsoc
sav $path9\bit1.dta, replace

use $path9\temp12f.dta, clear
sort occ1s
egen used_f=sum(cfreq2), by(occ1s)
sort jbsoc
collapse (mean) cb_camsis_f (mean) cb_camsis_f2 (mean) used [fw=cfreq] , by(jbsoc) 
list jbsoc cb_camsis_f cb_camsis_f2
sort jbsoc
sav $path9\bit2.dta, replace

use $path9\bit1.dta, clear
summarize
sort jbsoc
merge jbsoc using $path9\bit2.dta
tab _merge
* (keep all merge permutations) 
drop _merge


rename jbsoc tempnname /* two stage rename in case occ1 and occtype are the same */
rename tempnname $occtype
sort $occtype
label variable cb_camsis_m "respondent CAMSIS for $occtype (cb_camsis_m)"
label variable cb_camsis_m2 "Dim 2 CAMSIS for $occtype (cb_camsis_m2)"
label variable cb_camsis_f "Freind CAMSIS for $occtype (cb_camsis_f)"
label variable cb_camsis_f2 "Dim 2 friend CAMSIS for $occtype (cb_camsis_f2)"

sav $path9\cb_camsis__details.dta, replace
keep $occtype cb_camsis_m cb_camsis_m2 cb_camsis_f cb_camsis_f2
codebook, compact
summarize
gen orig=1
sort $occtype 
sav $path9\s1.dta, replace
use $path9\s1.dta, clear 
*** These are the scores according to occupations represented in the data on their recoded forms 



***************************************



**  Next, distribute scores to all known socs, with the 'orig' indicator to show if soc was represented in 
*     version-specific derivation
* (The commands below will calculate group soc scores as weighted means, then link these with template data if necessary) 


* Get data on the original representation of occs in the samples, merged with the derived scores

use $path9\s1.dta, clear
keep $occtype  cb_camsis_m cb_camsis_m2
rename $occtype occ1s
sav $path9\m1.dta, replace
use jbsoc occ1s cfreq using $path9\temp4.dta, clear
sort jbsoc 
sav $path9\bit7a.dta, replace
use jbsoc using $pathc, clear
sort jbsoc
merge jbsoc using $path9\bit7a.dta
drop _merge
sort occ1s 
merge occ1s using $path9\m1.dta
drop _merge
summarize
rename jbsoc tempnname
rename tempnname $occtype /* In two stages in case occ1 and occtype are the same */
gen one=1
collapse (sum) mfreq=one (mean) cb_camsis_m cb_camsis_m2 , by($occtype)
sort $occtype
sav $path9\f1.dta, replace
* -> a dataset of all male occs from original analysis, with numbers per occ 

use $path9\s1.dta, clear
keep $occtype  cb_camsis_f cb_camsis_f2
rename $occtype occ2s
sav $path9\m1.dta, replace
use netsoc occ2s cfreq using $path9\temp4.dta, clear
sort netsoc 
sav $path9\bit7a.dta, replace
use netsoc using $pathc, clear
sort netsoc
merge netsoc using $path9\bit7a.dta
drop _merge
sort occ2s 
merge occ2s using $path9\m1.dta
drop _merge
summarize
rename netsoc $occtype
gen one=1
collapse (sum) ffreq=one (mean) cb_camsis_f cb_camsis_f2, by($occtype)
sort $occtype
sav $path9\f2.dta, replace
* -> a dataset of all female occs from original analysis, with numbers per occ 

********************************************


********************************************
 
* Link these with the unit group template file
insheet using $pathe, clear
capture rename soc $occtype  
sort $occtype
sav $path9\f3.dta, replace

* Merge the template file  with the scores files: 
use $path9\f3.dta, clear
sort $occtype 
merge $occtype using $path9\f1.dta, _merge(orig_m)
sort $occtype
merge $occtype using $path9\f2.dta, _merge(orig_f)
summarize

* Find subgroup averages for row and columns based on the scores files only: 
capture drop occ3r
gen occ3r=floor($occtype/10)
capture drop occ2r
gen occ2r=floor($occtype/100)


sav $path9\f5.dta, replace

use $path9\f5.dta, clear
collapse (mean) occ3rm=cb_camsis_m [fw=mfreq], by(occ3r)
summarize
sort occ3r 
sav $path9\f5ma.dta, replace
use $path9\f5.dta, clear
collapse (mean) occ2rm=cb_camsis_m [fw=mfreq], by(occ2r)
summarize
sort occ2r 
sav $path9\f5mb.dta, replace



use $path9\f5.dta, clear
collapse (mean) occ3rf=cb_camsis_f [fw=ffreq], by(occ3r)
summarize
sort occ3r 
sav $path9\f5fa.dta, replace
use $path9\f5.dta, clear
collapse (mean) occ2rf=cb_camsis_f [fw=ffreq], by(occ2r)
summarize
sort occ2r 
sav $path9\f5fb.dta, replace



use $path9\f5.dta, clear
sort occ3r 
merge occ3r using $path9\f5ma.dta
drop _merge
sort occ3r 
merge occ3r using $path9\f5fa.dta
drop _merge
sort occ2r 
merge occ2r using $path9\f5mb.dta
drop _merge
sort occ2r 
merge occ2r using $path9\f5fb.dta
drop _merge


* We've now matched on subgroup averages conditional on employment status; there should be sufficient
*   to distribute to all groups 




summarize cb_camsis_m cb_camsis_m2  cb_camsis_f cb_camsis_f2  orig_m orig_f 
replace orig_m=0 if missing(orig_m)
replace orig_f=0 if missing(orig_f)
label variable orig_m "Occupation was represented in the original dataset (by respondents) "
label variable orig_f "Occupation was represented in the original dataset (by freiends) "

replace cb_camsis_m=occ3rm if missing(cb_camsis_m) 
replace cb_camsis_f=occ3rf if missing(cb_camsis_f) 
summarize cb_camsis_m cb_camsis_m2  cb_camsis_f cb_camsis_f2  orig_m orig_f 
replace cb_camsis_m=occ2rm if missing(cb_camsis_m) 
replace cb_camsis_f=occ2rf if missing(cb_camsis_f) 
summarize cb_camsis_m cb_camsis_m2  cb_camsis_f cb_camsis_f2  orig_m orig_f 






*****************************************************************
*****************************************************************
*****************************************************************



keep $occtype cb_camsis_m cb_camsis_f cb_camsis_m2 cb_camsis_f2 orig_m orig_f
order $occtype cb_camsis_m cb_camsis_f cb_camsis_m2 cb_camsis_f2 orig_m orig_f

label variable $occtype "Occupational unit - $occtype"
label variable cb_camsis_m " respondent CAMSIS score for $occtype" 
label variable cb_camsis_f "Freind CAMSIS score for $occtype" 

label variable cb_camsis_m2 "Dim 2 scale for respondent  for $occtype" 
label variable cb_camsis_f2 "Dim 2 scale for freinds for $occtype" 



drop if missing($occtype)
codebook, compact
summarize
sav $path9\cb_camsis__details_all.dta, replace

use $path9\cb_camsis__details_all.dta, clear 


keep $occtype cb_camsis_m cb_camsis_f /*these codes are idetical becuase of data structure*/ 
codebook, compact
summarize
sav $path9\cb_camsis__all.dta, replace

****************************************************************************************************
*exploring finished scale properties 
************************************************************************************************
import excel using  "H:\thesis_analysis\data\secondary_data\camsis\britian\gb91soc90excel.xls", firstrow clear 
rename SOC90 soc90
sort soc90
sav $path9\merge2.dta, replace

use  $path9\cb_camsis__details.dta, clear 
sort soc90
merge  soc90  using $path9\merge2.dta
drop _merge 

rename MaleCAMSISSOC90score camsism
rename FemaleCAMSISSOC90score camsisf




scatter  cb_camsis_m cb_camsis_f  [w=used_m], msymbol(circle_hollow) /*occupations added by hand*/ 



gen socmajor =0
replace socmajor =1 if soc90 >=100 & soc90 <=199
replace socmajor =2 if soc90 >=200 & soc90 <=299
replace socmajor =3 if soc90 >=300 & soc90 <=399
replace socmajor =4 if soc90 >=400 & soc90 <=499
replace socmajor =5 if soc90 >=500 & soc90 <=599
replace socmajor =6 if soc90 >=600 & soc90 <=699
replace socmajor =7 if soc90 >=700 & soc90 <=799
replace socmajor =8 if soc90 >=800 & soc90 <=899
replace socmajor =9 if soc90 >=900 & soc90 <=999


twoway (scatter   cb_camsis_f camsisf  if socmajor ==1, ytitle("Female Freindship CAMSIS") xtitle("Female CAMSIS") mcolor(black) msymbol(circle_hollow) )  ///
       (scatter   cb_camsis_f camsisf  if socmajor ==2, mcolor(blue) msymbol(circle_hollow) )  ///
       (scatter   cb_camsis_f camsisf  if socmajor ==3, mcolor(cranberry) msymbol(circle_hollow) )  ///
       (scatter   cb_camsis_f camsisf  if socmajor ==4, mcolor(midgreen) msymbol(circle_hollow) ) ///
	   (scatter   cb_camsis_f camsisf  if socmajor ==5, mcolor(dkorange) msymbol(circle_hollow) ) ///
       (scatter   cb_camsis_f camsisf  if socmajor ==6, mcolor(brown) msymbol(circle_hollow) )  ///
       (scatter   cb_camsis_f camsisf  if socmajor ==7, mcolor(pink) msymbol(circle_hollow) )  ///
       (scatter   cb_camsis_f camsisf  if socmajor ==8, mcolor(lavender) msymbol(circle_hollow) ) ///
	   (scatter   cb_camsis_f camsisf  if socmajor ==9, mcolor(ltblue) msymbol(circle_hollow) ) 
*

capture drop outlier
gen outlier =0 
replace outlier = 1 if cb_camsis_f - camsisf <= -15
replace outlier = 1 if cb_camsis_f - camsisf >= 15

scatter cb_camsis_f camsisf if outlier == 1, ytitle("Female Freindship CAMSIS") xtitle("Female CAMSIS")mlabel(SOC90label) mlabsize(tiny) msize(tiny) mlabpos(2) 


list soc90 cb_camsis_f camsisf if outlier ==1



************returning to orginal sample to check outlier charateristics 

use	$pathf\appended_fem.dta,	clear

gen socmajor2 =0
replace socmajor2 =1 if netsoc >=100 &  netsoc <=199
replace socmajor2 =2 if netsoc  >=200 & netsoc  <=299
replace socmajor2 =3 if netsoc  >=300 & netsoc  <=399
replace socmajor2 =4 if netsoc  >=400 & netsoc  <=499
replace socmajor2 =5 if netsoc  >=500 & netsoc  <=599
replace socmajor2 =6 if netsoc  >=600 & netsoc  <=699
replace socmajor2 =7 if netsoc  >=700 & netsoc  <=799
replace socmajor2 =8 if netsoc  >=800 & netsoc  <=899
replace socmajor2 =9 if netsoc  >=900 & netsoc  <=999

gen socmajor3 =0
replace socmajor3 =1 if spsoc >=100 & spsoc <=199
replace socmajor3 =2 if spsoc >=200 & spsoc <=299
replace socmajor3 =3 if spsoc >=300 & spsoc <=399
replace socmajor3 =4 if spsoc >=400 & spsoc <=499
replace socmajor3 =5 if spsoc >=500 & spsoc <=599
replace socmajor3 =6 if spsoc >=600 & spsoc <=699
replace socmajor3 =7 if spsoc >=700 & spsoc <=799
replace socmajor3 =8 if spsoc >=800 & spsoc <=899
replace socmajor3 =9 if spsoc  >=900 & spsoc <=999

recode spsoc -9=. 
recode spsoc -8=. 
recode socmajor3 0=.

tab socmajor2 if jbsoc == 461,  
tab socmajor3 if jbsoc == 461,

tab socmajor2 if jbsoc == 661,  
tab socmajor3 if jbsoc == 661,

tab socmajor2 if jbsoc == 791,  
tab socmajor3 if jbsoc == 791,


*********************************************
*graphs
*******************************************
drop cb_camsis_f cb_camsis_f2 orig_f /* duplicated of 'm' scores bescue of data contruction'*/


gen soc90_ = soc90
*do labelssoc90.do 
label values soc90 soc90l


sort cb_camsis_m
sort soc90

export excel using "H:\thesis_analysis\data\my_data\camsis_creation\temp\3nd_newscaleaftercamsiscomparison_nodentaltech_all", replace

sav "H:\thesis_analysis\data\my_data\camsis_creation\temp\cb_camsis__details_all.dta"

use $path9\cb_camsis__details.dta, clear 
keep soc90 cb_camsis_m used_m
sort soc90
sav $path9\merge.dta, replace 


use "H:\thesis_analysis\data\my_data\camsis_creation\temp\cb_camsis__details_all.dta", clear
sort soc90
merge  soc90  using $path9\merge.dta


scatter  cb_camsis_m soc90  [w=used_m], msymbol(circle_hollow)


twoway (scatter soc90 cb_camsis_m, mlabel(soc90_)mlabsize(tiny) msize (tiny) mlabpos(2))  (lfit soc90 cb_camsis_m, legend(off)) 


twoway lfit  soc90 cb_camsis_m  , mlabel(soc90_)mlabsize(tiny) msize (tiny) mlabpos(2) 


scatter  cb_camsis_m cb_camsis_f  [w=used_m], msymbol(circle_hollow)
