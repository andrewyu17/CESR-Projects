/* ***************************************************************************** */
/* File Name:			tests.do												 */
/* Written by:			Andrew Yu												 */
/* Last Updated: 		March 3rd, 2021											 */
/* Updated by Silvia:															 */
/* ***************************************************************************** */

clear all
set more off

**************************
//Setting Up Directories//
**************************

global input_dir "C:\Users\ayu087\OneDrive\Dropbox\UKB\Input"
global output_dir "C:\Users\ayu087\OneDrive\Dropbox\UKB\Output"
global graphs "C:\Users\ayu087\OneDrive\Dropbox\UKB\Output\Graphs"

use "$output_dir/cleanedMainData", clear

ren EA_PGS EAscore

*********************
//Trends & Controls//
*********************

global trends4			"c.DoB c.DoBafter"
global gendertrends4 	"c.DoBmale c.DoBmaleafter"
global trends10 		"c.DoB##c.DoB c.DoBafter##c.DoBafter"
global gendertrends10 	"c.DoBmale##c.DoBmale c.DoBmaleafter"
global genderafter		"c.male c.maleafter"

gen DoBmaleafter = DoB*maleafter

****************
//Restrictions//
****************

drop if DoB== .
drop if edu16 == .
keep if SLA < 19
keep if England == 1 | Wales == 1 | Scotland == 1
drop if EAscore == .
drop if PC1 > 0 & PC1 ~= .
drop if PC1 == . | PC2 == . | PC3 == . | PC4 == . | PC5 == . | PC6 == . | PC7 == . | PC8 == . | PC9 == . | PC10 == . | PC11 == . | PC12 == . | PC13 == . | PC14 == . | PC15 == . | PC16 == . | PC17 == . | PC18 == . | PC19 == . | PC20 == . 

*************************
//Standardize Variables//
*************************

bysort YoB: egen number = count(edu16)

*EA
foreach var in EAscore {

	qui summ `var' [aw=w10] 	if DoB >= -365 & DoB <= -1
	qui replace `var' = -(`var' - r(mean))/r(sd)
	
}

*PCs
forvalues i = 1/20 {
	
	qui summ PC`i' [aw=w10]
	qui replace PC`i' = (PC`i' - r(mean))/r(sd)

}	

****************************
//GxE continuous variables//
****************************

foreach x in after edu16 {	
	foreach score in EAscore {
		gen `score'`x'=`score'*`x'
	}
	forvalues i = 1/20 {
		gen PC`i'`x'=PC`i'*`x'
	}			
}	

**********
//TABLES//
**********

**All

	local doit replace
	foreach depvar in EAscore male PC1 PC2 {
	
	// 4 Years Bandwidth
	regress `depvar' after $trends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/All/Tests 1.doc", `doit' addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "Yes") keep(after) nor2 dec(2) ctitle(`depvar',4 Year) 
	
	//10 Years Bandwidth
	regress `depvar' after $trends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/All/Tests 1.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "Yes") keep(after) nor2 dec(2) ctitle(`depvar',10 Year) 

	local doit append
	}
	
	local doit replace
	foreach depvar in PC3 PC4 PC5 PC6 {
	
	// 4 Years Bandwidth
	regress `depvar' after $trends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/All/Tests 2.doc", `doit' addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "Yes") keep(after) nor2 dec(2) ctitle(`depvar',4 Year) 
	
	// 10 Years Bandwidth
	regress `depvar' after $trends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/All/Tests 2.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "Yes") keep(after) nor2 dec(2) ctitle(`depvar',10 Year) 

	local doit append
	}
	
	local doit replace
	foreach depvar in PC7 PC8 PC9 PC10 {
	
	// 4 Years Bandwidth
	regress `depvar' after $trends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/All/Tests 3.doc", `doit' addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "Yes") keep(after) nor2 dec(2) ctitle(`depvar',4 Year) 
	
	// 10 Years Bandwidth
	regress `depvar' after $trends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/All/Tests 3.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "Yes") keep(after) nor2 dec(2) ctitle(`depvar',10 Year) 

	local doit append
	}

	local doit replace
	foreach depvar in PC11 PC12 PC13 PC14 {
	
	// 4 Years Bandwidth
	regress `depvar' after $trends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/All/Tests 4.doc", `doit' addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "Yes") keep(after) nor2 dec(2) ctitle(`depvar',4 Year) 
	
	// 10 Years Bandwidth
	regress `depvar' after $trends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/All/Tests 4.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "Yes") keep(after) nor2 dec(2) ctitle(`depvar',10 Year) 

	local doit append
	}		
	
	local doit replace
	foreach depvar in PC15 PC16 PC17 PC18 {
	
	// 4 Years Bandwidth
	regress `depvar' after $trends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/All/Tests 5.doc", `doit' addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "Yes") keep(after) nor2 dec(2) ctitle(`depvar',4 Year) 
	
	// 10 Years Bandwidth
	regress `depvar' after $trends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/All/Tests 5.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "Yes") keep(after) nor2 dec(2) ctitle(`depvar',10 Year) 

	local doit append
	}	
	
	local doit replace
	foreach depvar in PC19 PC20 England Wales {
	
	// 4 Years Bandwidth
	regress `depvar' after $trends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/All/Tests 6.doc", `doit' addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "Yes") keep(after) nor2 dec(2) ctitle(`depvar',4 Year) 
	
	// 10 Years Bandwidth
	regress `depvar' after $trends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/All/Tests 6.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "Yes") keep(after) nor2 dec(2) ctitle(`depvar',10 Year) 

	local doit append
	}	

	local doit replace
	foreach depvar in Scotland birthplace_East birthplace_North right_handed {
	
	// 4 Years Bandwidth
	regress `depvar' after $trends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/All/Tests 7.doc", `doit' addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "Yes") keep(after) nor2 dec(2) ctitle(`depvar',4 Year) 
	
	// 10 Years Bandwidth
	regress `depvar' after $trends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/All/Tests 7.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "Yes") keep(after) nor2 dec(2) ctitle(`depvar',10 Year) 

	local doit append
	}	

	local doit replace
	foreach depvar in left_handed adopted {
	
	// 4 Years Bandwidth
	regress `depvar' after $trends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/All/Tests 8.doc", `doit' addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "Yes") keep(after) nor2 dec(2) ctitle(`depvar',4 Year) 
	
	// 10 Years Bandwidth
	regress `depvar' after $trends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/All/Tests 8.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "Yes") keep(after) nor2 dec(2) ctitle(`depvar',10 Year) 

	local doit append
	}	
  
**With Gender Breaks

	local doit replace
	foreach depvar in EAscore PC1 {
 
	regress `depvar' after $genderafter $trends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 1.doc", `doit' addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "Yes") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',4 Year) addnote("*Date of Birth and its interactions are included in the model but omitted from the table")
	regress `depvar' after $genderafter $trends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 1.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "Yes") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',10 Year) 
	
	regress `depvar' after $genderafter $trends4 $gendertrends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 1.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "No") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',4 Year)
	regress `depvar' after $genderafter $trends10 $gendertrends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 1.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "No") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',10 Year) 

	local doit append	
	}
	
	local doit replace
	foreach depvar in PC2 PC3 {
 
	regress `depvar' after $genderafter $trends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 2.doc", `doit' addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "Yes") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',4 Year) addnote("*Date of Birth and its interactions are included in the model but omitted from the table")
	regress `depvar' after $genderafter $trends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 2.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "Yes") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',10 Year) 
	
	regress `depvar' after $genderafter $trends4 $gendertrends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 2.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "No") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',4 Year)
	regress `depvar' after $genderafter $trends10 $gendertrends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 2.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "No") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',10 Year) 

	local doit append	
	}	

	local doit replace
	foreach depvar in PC4 PC5 {
 
	regress `depvar' after $genderafter $trends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 3.doc", `doit' addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "Yes") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',4 Year) addnote("*Date of Birth and its interactions are included in the model but omitted from the table")
	regress `depvar' after $genderafter $trends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 3.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "Yes") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',10 Year) 
	
	regress `depvar' after $genderafter $trends4 $gendertrends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 3.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "No") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',4 Year)
	regress `depvar' after $genderafter $trends10 $gendertrends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 3.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "No") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',10 Year) 

	local doit append	
	}	
	
	local doit replace
	foreach depvar in PC6 PC7 {
 
	regress `depvar' after $genderafter $trends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 4.doc", `doit' addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "Yes") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',4 Year) addnote("*Date of Birth and its interactions are included in the model but omitted from the table")
	regress `depvar' after $genderafter $trends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 4.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "Yes") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',10 Year) 
	
	regress `depvar' after $genderafter $trends4 $gendertrends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 4.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "No") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',4 Year)
	regress `depvar' after $genderafter $trends10 $gendertrends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 4.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "No") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',10 Year) 

	local doit append	
	}
	
	local doit replace
	foreach depvar in PC8 PC9 {
 
	regress `depvar' after $genderafter $trends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 5.doc", `doit' addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "Yes") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',4 Year) addnote("*Date of Birth and its interactions are included in the model but omitted from the table")
	regress `depvar' after $genderafter $trends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 5.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "Yes") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',10 Year) 
	
	regress `depvar' after $genderafter $trends4 $gendertrends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 5.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "No") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',4 Year)
	regress `depvar' after $genderafter $trends10 $gendertrends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 5.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "No") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',10 Year) 

	local doit append	
	}		
	
	local doit replace
	foreach depvar in PC10 PC11 {
 
	regress `depvar' after $genderafter $trends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 6.doc", `doit' addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "Yes") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',4 Year) addnote("*Date of Birth and its interactions are included in the model but omitted from the table")
	regress `depvar' after $genderafter $trends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 6.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "Yes") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',10 Year) 
	
	regress `depvar' after $genderafter $trends4 $gendertrends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 6.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "No") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',4 Year)
	regress `depvar' after $genderafter $trends10 $gendertrends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 6.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "No") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',10 Year) 

	local doit append	
	}		
	
	local doit replace
	foreach depvar in PC12 PC13 {
 
	regress `depvar' after $genderafter $trends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 7.doc", `doit' addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "Yes") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',4 Year) addnote("*Date of Birth and its interactions are included in the model but omitted from the table")
	regress `depvar' after $genderafter $trends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 7.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "Yes") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',10 Year) 
	
	regress `depvar' after $genderafter $trends4 $gendertrends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 7.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "No") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',4 Year)
	regress `depvar' after $genderafter $trends10 $gendertrends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 7.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "No") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',10 Year) 

	local doit append	
	}		
	
	local doit replace
	foreach depvar in PC14 PC15 {
 
	regress `depvar' after $genderafter $trends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 8.doc", `doit' addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "Yes") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',4 Year) addnote("*Date of Birth and its interactions are included in the model but omitted from the table")
	regress `depvar' after $genderafter $trends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 8.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "Yes") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',10 Year) 
	
	regress `depvar' after $genderafter $trends4 $gendertrends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 8.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "No") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',4 Year)
	regress `depvar' after $genderafter $trends10 $gendertrends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 8.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "No") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',10 Year) 

	local doit append	
	}		
	
	local doit replace
	foreach depvar in PC16 PC17 {
 
	regress `depvar' after $genderafter $trends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 9.doc", `doit' addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "Yes") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',4 Year) addnote("*Date of Birth and its interactions are included in the model but omitted from the table")
	regress `depvar' after $genderafter $trends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 9.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "Yes") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',10 Year) 
	
	regress `depvar' after $genderafter $trends4 $gendertrends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 9.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "No") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',4 Year)
	regress `depvar' after $genderafter $trends10 $gendertrends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 9.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "No") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',10 Year) 

	local doit append	
	}		
	
	local doit replace
	foreach depvar in PC18 PC19 {
 
	regress `depvar' after $genderafter $trends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 10.doc", `doit' addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "Yes") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',4 Year) addnote("*Date of Birth and its interactions are included in the model but omitted from the table")
	regress `depvar' after $genderafter $trends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 10.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "Yes") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',10 Year) 
	
	regress `depvar' after $genderafter $trends4 $gendertrends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 10.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "No") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',4 Year)
	regress `depvar' after $genderafter $trends10 $gendertrends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 10.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "No") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',10 Year) 

	local doit append	
	}		
	
	local doit replace
	foreach depvar in PC20 England {
 
	regress `depvar' after $genderafter $trends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 11.doc", `doit' addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "Yes") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',4 Year) addnote("*Date of Birth and its interactions are included in the model but omitted from the table")
	regress `depvar' after $genderafter $trends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 11.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "Yes") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',10 Year) 
	
	regress `depvar' after $genderafter $trends4 $gendertrends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 11.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "No") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',4 Year)
	regress `depvar' after $genderafter $trends10 $gendertrends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 11.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "No") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',10 Year) 

	local doit append	
	}		
	
	local doit replace
	foreach depvar in Wales Scotland {
 
	regress `depvar' after $genderafter $trends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 12.doc", `doit' addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "Yes") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',4 Year) addnote("*Date of Birth and its interactions are included in the model but omitted from the table")
	regress `depvar' after $genderafter $trends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 12.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "Yes") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',10 Year) 
	
	regress `depvar' after $genderafter $trends4 $gendertrends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 12.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "No") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',4 Year)
	regress `depvar' after $genderafter $trends10 $gendertrends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 12.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "No") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',10 Year) 

	local doit append	
	}		
	
	local doit replace
	foreach depvar in birthplace_East birthplace_North {
 
	regress `depvar' after $genderafter $trends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 13.doc", `doit' addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "Yes") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',4 Year) addnote("*Date of Birth and its interactions are included in the model but omitted from the table")
	regress `depvar' after $genderafter $trends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 13.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "Yes") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',10 Year) 
	
	regress `depvar' after $genderafter $trends4 $gendertrends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 13.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "No") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',4 Year)
	regress `depvar' after $genderafter $trends10 $gendertrends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 13.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "No") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',10 Year) 

	local doit append	
	}		

	local doit replace
	foreach depvar in right_handed left_handed {
 
	regress `depvar' after $genderafter $trends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 14.doc", `doit' addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "Yes") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',4 Year) addnote("*Date of Birth and its interactions are included in the model but omitted from the table")
	regress `depvar' after $genderafter $trends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 14.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "Yes") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',10 Year) 
	
	regress `depvar' after $genderafter $trends4 $gendertrends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 14.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "No") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',4 Year)
	regress `depvar' after $genderafter $trends10 $gendertrends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 14.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "No") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',10 Year) 

	local doit append	
	}	
	
	local doit replace
	foreach depvar in adopted {
 
	regress `depvar' after $genderafter $trends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 15.doc", `doit' addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "Yes") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',4 Year) addnote("*Date of Birth and its interactions are included in the model but omitted from the table")
	regress `depvar' after $genderafter $trends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 15.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "Yes") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',10 Year) 
	
	regress `depvar' after $genderafter $trends4 $gendertrends4 [aw=w4], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 15.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Linear", Trends Restricted, "No") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',4 Year)
	regress `depvar' after $genderafter $trends10 $gendertrends10 [aw=w10], robust
	qui summ `depvar' if YoB == -1, meanonly
	local mean = round(r(mean),0.001)
	outreg2 using "$output_dir/outreg/Tests/Gender/Tests 15.doc", append addstat(Mean of Y,`mean') addtext(Polynomial, "Quadratic", Trends Restricted, "No") keep(after male maleafter) nor2 dec(2) ctitle(`depvar',10 Year) 

	local doit append	
	}	
 
*********
//Tests//
*********

collapse 	EAscore male edu16 number /// 
			PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10 /// 
			PC11 PC12 PC13 PC14 PC15 PC16 PC17 PC18 PC19 PC20 ///
			England Wales Scotland birthplace_East birthplace_North /// 
			right_handed left_handed adopted, by(YoB)   
			
*McCrary Test
twoway scatter	(number 	YoB), ///
				, ytitle("Number of Individuals") ///
				xtitle("Year of Birth") /// 
				xline(0,  lpattern(dash) lcolor(gs8)) ///
				graphregion(fcolor(white)) plotregion(lwidth(none)) ///
				scheme(s1mono) ///
				ylabel(8000(4000)20000, nogrid) ///
				title("McCrary Test", size(medium)) ///
				xlabel(-8 "9/49-8/50" -4 "9/53-8/54" 0 "9/57-8/58" 4 "9/61-8/62" 8 "9/65-8/66")
				
graph export "$graphs/Tests/McCrary Test.png", as(png) replace width(2000)

*EA PGS
twoway scatter 	(EAscore 	YoB), ///
				, ytitle("Mean EA PGS") ///
				xtitle("Year of Birth") /// 
				xline(0,  lpattern(dash) lcolor(gs8)) ///
				graphregion(fcolor(white)) plotregion(lwidth(none)) ///
				scheme(s1mono) ///
				ylabel(-1(.5)1, nogrid) ///
				title("EA PGS", size(medium)) ///
				xlabel(-7 "9/50-8/50" 0 "9/57-8/58" 7 "9/64-8/65")

graph export "$graphs/Tests/EA_PGS.png", as(png) replace width(2000)

*Fraction Male
twoway scatter 	(male 	YoB), ///
				, ytitle("Fraction Male") ///
				xtitle("Year of Birth") /// 
				xline(0,  lpattern(dash) lcolor(gs8)) ///
				graphregion(fcolor(white)) plotregion(lwidth(none)) ///
				scheme(s1mono) ///
				ylabel(.3(.1).7, nogrid) ///
				title("Fraction Male", size(medium)) ///
				xlabel(-7 "9/50-8/50" 0 "9/57-8/58" 7 "9/64-8/65")
				
graph export "$graphs/Tests/Fraction Male.png", as(png) replace width(2000)

				
*PC(1-20)
foreach n in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 {
	twoway scatter 	(PC`n' 	YoB), ///
					, ytitle("Mean Principal Component `n'") ///
					xtitle("Year of Birth") /// 
					xline(0,  lpattern(dash) lcolor(gs8)) ///
					graphregion(fcolor(white)) plotregion(lwidth(none)) ///
					scheme(s1mono) ///
					ylabel(-.1(.05).1, nogrid) ///
					title("PC `n'", size(medium)) ///
					xlabel(-7 "9/50-8/50" 0 "9/57-8/58" 7 "9/64-8/65")

	graph export "$graphs/Tests/Mean Principal Component `n'.png", as(png) replace width(2000)
}

*England
twoway scatter 	(England 	YoB), ///
				, ytitle("Fraction Born in England") ///
				xtitle("Year of Birth") /// 
				xline(0,  lpattern(dash) lcolor(gs8)) ///
				graphregion(fcolor(white)) plotregion(lwidth(none)) ///
				scheme(s1mono) ///
				ylabel(.8(.025).9, nogrid) ///
				title("Born in England", size(medium)) ///
				xlabel(-7 "9/50-8/50" 0 "9/57-8/58" 7 "9/64-8/65")
				
graph export "$graphs/Tests/England.png", as(png) replace width(2000)

*Scotland
twoway scatter 	(England 	YoB), ///
				, ytitle("Fraction Born in Scotland") ///
				xtitle("Year of Birth") /// 
				xline(0,  lpattern(dash) lcolor(gs8)) ///
				graphregion(fcolor(white)) plotregion(lwidth(none)) ///
				scheme(s1mono) ///
				ylabel(.8(.025).9, nogrid) ///
				title("Born in Scotland", size(medium)) ///
				xlabel(-7 "9/50-8/50" 0 "9/57-8/58" 7 "9/64-8/65")
				
graph export "$graphs/Tests/Scotland.png", as(png) replace width(2000)

*Wales
twoway scatter 	(Wales 	YoB), ///
				, ytitle("Fraction Born in Wales") ///
				xtitle("Year of Birth") /// 
				xline(0,  lpattern(dash) lcolor(gs8)) ///
				graphregion(fcolor(white)) plotregion(lwidth(none)) ///
				scheme(s1mono) ///
				ylabel(.03(.005).05, nogrid) ///
				title("Born in Wales", size(medium)) ///
				xlabel(-7 "9/50-8/50" 0 "9/57-8/58" 7 "9/64-8/65")
				
graph export "$graphs/Tests/Wales.png", as(png) replace width(2000)

*East-West
twoway scatter 	(birthplace_East 	YoB), ///
				, ytitle("Mean East-West Birth Coordinate") ///
				xtitle("Year of Birth") /// 
				xline(0,  lpattern(dash) lcolor(gs8)) ///
				graphregion(fcolor(white)) plotregion(lwidth(none)) ///
				scheme(s1mono) ///
				ylabel(405000(5000)420000, nogrid) ///
				title("East-West", size(medium)) ///
				xlabel(-7 "9/50-8/50" 0 "9/57-8/58" 7 "9/64-8/65")
				
graph export "$graphs/Tests/EastWest.png", as(png) replace width(2000)

*North-South
twoway scatter 	(birthplace_North 	YoB), ///
				, ytitle("Mean North-South Birth Coordinate") ///
				xtitle("Year of Birth") /// 
				xline(0,  lpattern(dash) lcolor(gs8)) ///
				graphregion(fcolor(white)) plotregion(lwidth(none)) ///
				scheme(s1mono) ///
				ylabel(350000(5000)370000, nogrid) ///
				title("North-South", size(medium)) ///
				xlabel(-7 "9/50-8/50" 0 "9/57-8/58" 7 "9/64-8/65")
				
graph export "$graphs/Tests/NorthSouth.png", as(png) replace width(2000)

*Fraction Right-Handed
twoway scatter 	(right_handed	YoB), ///
				, ytitle("Fraction Right-Handed") ///
				xtitle("Year of Birth") /// 
				xline(0,  lpattern(dash) lcolor(gs8)) ///
				graphregion(fcolor(white)) plotregion(lwidth(none)) ///
				scheme(s1mono) ///
				ylabel(.85(.025).95, nogrid) ///
				title("Fraction Right-Handed", size(medium)) ///
				xlabel(-7 "9/50-8/50" 0 "9/57-8/58" 7 "9/64-8/65")
				
graph export "$graphs/Tests/RightHanded.png", as(png) replace width(2000)

*Fraction Left-Handed
twoway scatter 	(left_handed	YoB), ///
				, ytitle("Fraction Left-Handed") ///
				xtitle("Year of Birth") /// 
				xline(0,  lpattern(dash) lcolor(gs8)) ///
				graphregion(fcolor(white)) plotregion(lwidth(none)) ///
				scheme(s1mono) ///
				ylabel(.05(.025).15, nogrid) ///
				title("Fraction Left-Handed", size(medium)) ///
				xlabel(-7 "9/50-8/50" 0 "9/57-8/58" 7 "9/64-8/65")
				
graph export "$graphs/Tests/LeftHanded.png", as(png) replace width(2000)

*Adopted
twoway scatter 	(adopted	YoB), ///
				, ytitle("Fraction Adopted") ///
				xtitle("Year of Birth") /// 
				xline(0,  lpattern(dash) lcolor(gs8)) ///
				graphregion(fcolor(white)) plotregion(lwidth(none)) ///
				scheme(s1mono) ///
				ylabel(0.000(.025).100, nogrid) ///
				title("Fraction Adopted", size(medium)) ///
				xlabel(-7 "9/50-8/50" 0 "9/57-8/58" 7 "9/64-8/65")
				
graph export "$graphs/Tests/Adopted.png", as(png) replace width(2000)

