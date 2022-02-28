/* ***************************************************************************** */
/* File Name:			assessment.do											 */
/* Written by:			Andrew Yu												 */
/* Last Updated: 		July 14th, 2021											 */
/* Updated by Silvia:															 */
/* ***************************************************************************** */

clear all
set more off

**************************
//Setting Up Directories//
**************************

local input_dir "C:\Users\ayu087\OneDrive\Dropbox\UKB\Input"
local output_dir "C:\Users\ayu087\OneDrive\Dropbox\UKB\Output"

use "`input_dir'/renamedMainData", clear

********************************
//Generate Dependent Variables//
********************************

***********************
/*1. Depression Score*/
***********************

*Criteria for Depression Score: 2050 + 2060 + 2070 + 2080
gen depressionScore = 	depressed2w_i0 + 		///
						unenthusiastic2w_i0 + 	///
						tenseness2w_i0 + 		///
						tiredness2w_i0

***********
/*2. PHQ2*/
***********

*Criteria for PHQ2: 2050 + 2060
gen phq2 =	 	depressed2w_i0 + 		///
				unenthusiastic2w_i0
				
replace phq2 = phq2 - 2
						
****************************************						
/*3. Probable Bipolar Disorder (type I)*/
*****************************************

*1st Criteria: 4642 or 4653
gen bipolar1 = 1 if manicHyper2d_i0 == 1 | ///
					irritable2d_i0 	== 1 
*2nd Criteria: At least 3 from 6156.01, 6156.02, 6156.03, 6156.04
egen nmissing = rowmiss(manicHyperSymptoms_i0_0 ///
						manicHyperSymptoms_i0_1 ///
						manicHyperSymptoms_i0_2 ///
						manicHyperSymptoms_i0_3)
gen bipolar2 = 1 if nmissing == 1 | nmissing == 0
drop nmissing
*3rd Criteria: 5663 + 5674 
gen bipolar3 = 1 if manicEpisodesLength_i0 == 13 & manicEpisodesSeverity_i0 == 12

*Assessment
gen bipolarType1 = 1 if (bipolar1 == 1 & bipolar2 == 1 & bipolar3 == 1)
replace bipolarType1 = 0 if mi(bipolarType1)
drop bipolar1 bipolar2 bipolar3

******************************************
/*4. Probable Bipolar Disorder (type II)*/
******************************************

*1st Criteria: 4642 or 4653
gen bipolar1 = 1 if manicHyper2d_i0 == 1 | ///
					irritable2d_i0 	== 1 
*2nd Criteria: At least 3 from 6156.01, 6156.02, 6156.03, 6156.04
egen nmissing = rowmiss(manicHyperSymptoms_i0_0 ///
						manicHyperSymptoms_i0_1 ///
						manicHyperSymptoms_i0_2 ///
						manicHyperSymptoms_i0_3)
gen bipolar2 = 1 if nmissing == 1 | nmissing == 0
drop nmissing
*3rd Criteria: 5663
gen bipolar3 = 1 if manicEpisodesLength_i0 == 13

*Assessment
gen bipolarType2 = 1 if bipolar1 == 1 & bipolar2 == 1 & bipolar3 == 1
replace bipolarType2 = 0 if mi(bipolarType2)
drop bipolar1 bipolar2 bipolar3

**************************************************
/*5. Single probable episode of major depression*/
**************************************************

*Criteria: 	4598 + 4609 + 4620 + 2090/2010 

gen	 mDepressionSingle 	   = 1 if 	depressedWeek_i0 		== 1 & /// 
									depressedLPeriod_i0 	>= 2 & ///
									depressedEpisodes_i0	== 1 & ///
									doctor_i0 				== 1
replace	 mDepressionSingle = 1 if	depressedWeek_i0 		== 1 & /// 
									depressedLPeriod_i0 	>= 2 & ///
									depressedEpisodes_i0	== 1 & ///
									psychiatrist_i0 		== 1

*or...		4631 + 5375 + 5386 + 2090/2100

replace mDepressionSingle = 1 if 	unenthusiasticWeek_i0 		== 1 & /// 
									unenthusiasticLPeriod_i0 	>= 2 & ///
									unenthusiasticEpisodes_i0	== 1 & ///
									doctor_i0 					== 1 
replace mDepressionSingle = 1 if 	unenthusiasticWeek_i0 		== 1 & /// 
									unenthusiasticLPeriod_i0 	>= 2 & ///
									unenthusiasticEpisodes_i0	== 1 & ///									
									psychiatrist_i0 			== 1

replace mDepressionSingle = 0 if mi(mDepressionSingle)
									
********************************************
/*6. Recurrent major depression (moderate)*/
********************************************

*Criteria:	4598 + 4609 + 4620 + 2090

gen rmDepressionModerate 	 = 1 if		depressedWeek_i0 		  == 1 	& ///
										depressedLPeriod_i0 	  >= 2 	& ///
										depressedEpisodes_i0 	  >= 2	& ///
										doctor_i0 				  == 1	& ///
										psychiatrist_i0 		  == 0

replace rmDepressionModerate = 1 if		unenthusiasticWeek_i0 	  == 1 	& ///
										unenthusiasticLPeriod_i0  >= 2 	& ///
										unenthusiasticEpisodes_i0 >= 2	& ///
										doctor_i0 				  == 1	& ///
										psychiatrist_i0 		  == 0									

replace rmDepressionModerate = 0 if mi(rmDepressionModerate)
										
******************************************
/*7. Recurrent major depression (severe)*/
******************************************

*Criteria:	4598 + 4609 + 4620 + 2100

gen rmDepressionSevere 	   = 1 if 		depressedWeek_i0 	 	  == 1 & ///
										depressedLPeriod_i0  	  >= 2 & ///
										depressedEpisodes_i0 	  >= 2 & ///
										psychiatrist_i0 	 	  == 1 

replace rmDepressionSevere = 1 if		unenthusiasticWeek_i0 	  == 1 & ///
										unenthusiasticLPeriod_i0  >= 2 & ///
										unenthusiasticEpisodes_i0 >= 2 & ///
										psychiatrist_i0 	 	  == 1 										

replace rmDepressionSevere = 0 if mi(rmDepressionSevere)

**********************************
/*8. Recurrent major depression */
**********************************

gen rmDepression = 1 if rmDepressionModerate == 1 | rmDepressionSevere == 1
replace rmDepression = 0 if mi(rmDepression)

*************
/*9. PHQ-9 */
*************

forval i = 1/9 {
	replace phq9_`i' = . if phq9_`i' == -818
}
egen phq9 		= rowtotal(phq9_*)
replace phq9 	= . if 		phq9_1 == . | phq9_2 == . | phq9_3 == . | phq9_4 == . | ///
							phq9_5 == . | phq9_6 == . | phq9_7 == . | phq9_8 == . | ///
							phq9_9 == . 
forval i = 1/9 {
	drop phq9_`i'
}

*************
/*10. GAD-7 */
*************

forval i = 1/7 {
	replace gad7_`i' = . if gad7_`i' == -818
	replace gad7_`i' = gad7_`i' - 1
	replace gad7_`i' = 0 if gad7_`i' == -1
}
egen gad7 		= rowtotal(gad7_*)
replace gad7 	= . if 		gad7_1 == . | gad7_2 == . | gad7_3 == . | gad7_4 == . | ///
							gad7_5 == . | gad7_6 == . | gad7_7 == .
forval i = 1/7 {
	drop gad7_`i'
}

***************
/*11. CIDI_SF */
***************

forval i = 1/2{
    replace cidi_core`i' = . if cidi_core`i' == -818
}
forval i = 1/3{
    replace cidi_`i' = . if cidi_`i' == -818 | cidi_`i' == -121
}
forval i = 1/6{
    replace cidiScore_`i' = . if cidiScore_`i' == -818 | cidiScore_`i' == -121
}

gen 	cidi_core3 = 1 if cidi_1 >= 3 & !mi(cidi_1)
replace cidi_core3 = 0 if cidi_1 <= 2 & !mi(cidi_1)
gen 	cidi_core4 = 1 if cidi_2 == 2 | cidi_2 == 3 & !mi(cidi_2)
replace cidi_core4 = 0 if cidi_2 < 2 & !mi(cidi_2)
gen 	cidi_core5 = 1 if cidi_3 >= 3 & !mi(cidi_3)
replace cidi_core5 = 0 if cidi_3 <= 2 & !mi(cidi_3)
drop 	cidi_1 cidi_2 cidi_3
replace cidiScore_2 = 1 if cidiScore_2 >= 2 & !mi(cidiScore_2)

gen cidiSF_score = 	cidi_core1 + cidi_core2 + cidiScore_1 + cidiScore_2 + ///
					cidiScore_3 + cidiScore_4 + cidiScore_5 + cidiScore_6
drop cidiScore_*
gen cidiSF = 1 if 	(cidi_core1 == 1 | cidi_core2 == 1) & cidi_core3 == 1 & ///
					cidi_core4 == 1 & cidi_core5 == 1 & cidiSF_score >= 5
replace cidiSF = 0 if 	(!mi(cidi_core1) | !mi(cidi_core2)) & !mi(cidi_core3) & ///
						!mi(cidi_core4) & !mi(cidi_core5) & !mi(cidiSF_score) 
						
******************
/*12. Wellbeing */
******************

replace gen_happy = . 		if gen_happy == -818 | gen_happy == -121
replace health_happy = . 	if health_happy == -818 | health_happy == -121
replace life_meaningful = . if life_meaningful == -818 | life_meaningful == -121

replace gen_happy = gen_happy + 10
replace gen_happy = 6 if gen_happy == 11
replace gen_happy = 5 if gen_happy == 12
replace gen_happy = 4 if gen_happy == 13
replace gen_happy = 3 if gen_happy == 14
replace gen_happy = 2 if gen_happy == 15
replace gen_happy = 1 if gen_happy == 16

replace health_happy = health_happy + 10
replace health_happy = 6 if health_happy == 11
replace health_happy = 5 if health_happy == 12
replace health_happy = 4 if health_happy == 13
replace health_happy = 3 if health_happy == 14
replace health_happy = 2 if health_happy == 15
replace health_happy = 1 if health_happy == 16

gen wellbeing = gen_happy + health_happy + life_meaningful

*****************
/*13. GAD Ever */
*****************

foreach i in 1 3 4_1 4_2 5_1 5_2 6 7_1 7_2 8 {
    replace GADEver`i' = . if GADEver`i' < 0
}
replace GADEver2 = . 	if 	GADEver2 == -1
replace GADEver2 = 0 	if 	GADEver2 == 0 | GADEver2 == 1 | GADEver2 == 2 | ///
							GADEver2 == 3 | GADEver2 == 4 | GADEver2 == 5
replace GADEver2 = 1 	if 	GADEver2 == -999 | GADEver2 >= 6 & !mi(GADEver2)
gen GADEver4 = 1 		if 	GADEver4_1 == 1 | GADEver4_2 == 1
replace GADEver4 = 0 	if 	GADEver4_1 == 0 & GADEver4_2 == 0
gen GADEver5 = 1 		if 	GADEver5_1 == 2 | GADEver5_2 == 1
replace GADEver5 = 0 	if 	GADEver5_1 == 1 & GADEver5_2 == 0
replace GADEver7_1 = 0 	if 	GADEver7_1 == 0 | GADEver7_1 == 1
replace GADEver7_1 = 1 	if	GADEver7_1 == 2 | GADEver7_1 == 3
replace GADEver7_2 = 0 	if 	GADEver7_2 == 0 | GADEver7_2 == 1
replace GADEver7_2 = 1 	if	GADEver7_2 == 2 | GADEver7_2 == 3
gen GADEver6new = 1 	if 	GADEver6 == 1 | GADEver7_1 == 1 | GADEver7_2 == 1
replace GADEver6new = 0 if  GADEver6 == 0 & GADEver7_1 == 0 & GADEver7_2 == 0
gen GADEver7 = 1 		if	GADEver8 == 2 | GADEver8 == 3
replace GADEver7 = 0 	if 	GADEver8 == 0 | GADEver8 == 1
drop GADEver4_1 GADEver4_2 GADEver5_1 GADEver5_2 GADEver6 GADEver7_1 GADEver7_2 GADEver8
rename GADEver6new GADEver6
forval i = 1/7{
    replace GADEverSym`i' = . if GADEverSym`i' == -121
}
egen GADEverSym = rowtotal(GADEverSym*)
replace GADEverSym = . 	if 	mi(GADEverSym1) & mi(GADEverSym2) & mi(GADEverSym3) & ///
							mi(GADEverSym4) & mi(GADEverSym5) & mi(GADEverSym6) & ///
							mi(GADEverSym7)
drop GADEverSym1 GADEverSym2 GADEverSym3 GADEverSym4 GADEverSym5 GADEverSym6 GADEverSym7
gen GADEver = 1 		if 	GADEver1 == 1 & GADEver2 == 1 & GADEver3 == 1 & /// 
							GADEver4 == 1 & GADEver5 == 1 & GADEver6 == 1 & ///
							GADEver7 == 1 & GADEverSym >= 3
replace GADEver = 0 	if 	GADEver1 == 0 | GADEver2 == 0 | GADEver3 == 0 | /// 
							GADEver4 == 0 | GADEver5 == 0 | GADEver6 == 0 | ///
							GADEver7 == 0 | GADEverSym <= 2
replace GADEver = . 	if 	GADEver1 == . | GADEver2 == . | GADEver3 == . | /// 
							GADEver4 == . | GADEver5 == . | GADEver6 == . | ///
							GADEver7 == . | GADEverSym == .
drop GADEver1 GADEver2 GADEver3 GADEver4 GADEver5 GADEver6 GADEver7 GADEverSym
							
****************************
/*Creating Year Bandwidths*/
****************************

*1 Year
gen w1 = 367 - abs(DoB) - after
		replace w1 = 0 if w1 < 0
		gen bw1 = 1 if w1 != 0
		replace bw1 = 0 if mi(bw1)
*2 Years
gen w2 = 732 - abs(DoB) - after
		replace w2 = 0 if w2 < 0
		gen bw2 = 1 if w2 != 0
		replace bw2 = 0 if mi(bw2)
*3 Years
gen w3 = 1097 - abs(DoB) - after
		replace w3 = 0 if w3 < 0
		gen bw3 = 1 if w3 != 0
		replace bw3 = 0 if mi(bw3)
*6 Years
gen w6 = 2192 - abs(DoB) - after
		replace w6 = 0 if w6 < 0
		gen bw6 = 1 if w6 != 0
		replace bw6 = 0 if mi(bw6)
*8 Years
gen w8 = 2923 - abs(DoB) - after
		replace w8 = 0 if w8 < 0
		gen bw8 = 1 if w8 != 0
		replace bw8 = 0 if mi(bw8)

gen dummy = (year_birth - 1947)*12
gen year_month = (abs(dummy) + month_birth)*(dummy/abs(dummy)) 
replace year_month = month_birth if dummy == 0

****************************************
/*Creating Gender Interaction Variable*/
****************************************

gen maleafter = male*after
gen DoBmale = DoB*male
gen age2 = age^2

rename score SWB_PGI

*****************************
/*Reverse Code happiness_i0*/
*****************************

replace happiness_i0 = -1*happiness_i0 + 7

********
//Save//
********

save "`input_dir'\cleanedMainData.dta", replace
save "`output_dir'\cleanedMainData.dta", replace
