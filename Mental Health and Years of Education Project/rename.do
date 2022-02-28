/* ***************************************************************************** */
/* File Name:			rename.do												 */
/* Written by:			Andrew Yu												 */
/* Last Updated: 		April 12th, 2021										 */
/* Updated by Silvia:															 */
/* ***************************************************************************** */

clear all
set more off

**************************
//Setting Up Directories//
**************************

local input_dir "C:\Users\ayu087\OneDrive\Dropbox\UKB\Input"
local output_dir "C:\Users\ayu087\OneDrive\Dropbox\UKB\Output"

*******************
//Clean Main Data//
*******************

use "`input_dir'/MatchedMainData", clear

rename n_1920_0_0 moodSwings_i0
rename n_1920_1_0 moodSwings_i1
rename n_1920_2_0 moodSwings_i2
rename n_1920_3_0 moodSwings_i3

rename n_1930_0_0 miserableness_i0
rename n_1930_1_0 miserableness_i1
rename n_1930_2_0 miserableness_i2
rename n_1930_3_0 miserableness_i3

rename n_1940_0_0 irritability_i0
rename n_1940_1_0 irritability_i1
rename n_1940_2_0 irritability_i2
rename n_1940_3_0 irritability_i3

rename n_1950_0_0 sensitivity_i0
rename n_1950_1_0 sensitivity_i1
rename n_1950_2_0 sensitivity_i2
rename n_1950_3_0 sensitivity_i3

rename n_1960_0_0 fedUp_i0
rename n_1960_1_0 fedUp_i1
rename n_1960_2_0 fedUp_i2
rename n_1960_3_0 fedUp_i3

rename n_1970_0_0 nervous_i0
rename n_1970_1_0 nervous_i1
rename n_1970_2_0 nervous_i2
rename n_1970_3_0 nervous_i3

rename n_1980_0_0 worryAnxious_i0
rename n_1980_1_0 worryAnxious_i1
rename n_1980_2_0 worryAnxious_i2
rename n_1980_3_0 worryAnxious_i3

rename n_1990_0_0 tense_i0
rename n_1990_1_0 tense_i1
rename n_1990_2_0 tense_i2
rename n_1990_3_0 tense_i3

rename n_2000_0_0 worryEmbarassment_i0
rename n_2000_1_0 worryEmbarassment_i1
rename n_2000_2_0 worryEmbarassment_i2
rename n_2000_3_0 worryEmbarassment_i3

rename n_2010_0_0 sufferNerves_i0
rename n_2010_1_0 sufferNerves_i1
rename n_2010_2_0 sufferNerves_i2
rename n_2010_3_0 sufferNerves_i3

rename n_2020_0_0 loneliness_i0
rename n_2020_1_0 loneliness_i1
rename n_2020_2_0 loneliness_i2
rename n_2020_3_0 loneliness_i3

rename n_2030_0_0 guilty_i0
rename n_2030_1_0 guilty_i1
rename n_2030_2_0 guilty_i2
rename n_2030_3_0 guilty_i3

rename n_2040_0_0 risk_i0
rename n_2040_1_0 risk_i1
rename n_2040_2_0 risk_i2
rename n_2040_3_0 risk_i3

rename n_2050_0_0 depressed2w_i0
rename n_2050_1_0 depressed2w_i1
rename n_2050_2_0 depressed2w_i2
rename n_2050_3_0 depressed2w_i3

rename n_2060_0_0 unenthusiastic2w_i0
rename n_2060_1_0 unenthusiastic2w_i1
rename n_2060_2_0 unenthusiastic2w_i2
rename n_2060_3_0 unenthusiastic2w_i3

rename n_2070_0_0 tenseness2w_i0
rename n_2070_1_0 tenseness2w_i1
rename n_2070_2_0 tenseness2w_i2
rename n_2070_3_0 tenseness2w_i3

rename n_2080_0_0 tiredness2w_i0
rename n_2080_1_0 tiredness2w_i1
rename n_2080_2_0 tiredness2w_i2
rename n_2080_3_0 tiredness2w_i3

rename n_2090_0_0 doctor_i0
rename n_2090_1_0 doctor_i1
rename n_2090_2_0 doctor_i2
rename n_2090_3_0 doctor_i3

rename n_2100_0_0 psychiatrist_i0
rename n_2100_1_0 psychiatrist_i1
rename n_2100_2_0 psychiatrist_i2
rename n_2100_3_0 psychiatrist_i3

rename n_4526_0_0 happiness_i0
rename n_4526_1_0 happiness_i1
rename n_4526_2_0 happiness_i2
rename n_4526_3_0 happiness_i3

rename n_4537_0_0 satisfactionWork_i0
rename n_4537_1_0 satisfactionWork_i1
rename n_4537_2_0 satisfactionWork_i2
rename n_4537_3_0 satisfactionWork_i3

rename n_4548_0_0 satisfactionHealth_i0
rename n_4548_1_0 satisfactionHealth_i1
rename n_4548_2_0 satisfactionHealth_i2
rename n_4548_3_0 satisfactionHealth_i3

rename n_4559_0_0 satisfactionFamily_i0
rename n_4559_1_0 satisfactionFamily_i1
rename n_4559_2_0 satisfactionFamily_i2
rename n_4559_3_0 satisfactionFamily_i3

rename n_4570_0_0 satisfactionFriendships_i0
rename n_4570_1_0 satisfactionFriendships_i1
rename n_4570_2_0 satisfactionFriendships_i2
rename n_4570_3_0 satisfactionFriendships_i3

rename n_4581_0_0 satisfactionFinancial_i0
rename n_4581_1_0 satisfactionFinancial_i1
rename n_4581_2_0 satisfactionFinancial_i2
rename n_4581_3_0 satisfactionFinancial_i3

rename n_4598_0_0 depressedWeek_i0
rename n_4598_1_0 depressedWeek_i2
rename n_4598_2_0 depressedWeek_i3
rename n_4598_3_0 depressedWeek_i4

rename n_4609_0_0 depressedLPeriod_i0
rename n_4609_1_0 depressedLPeriod_i1
rename n_4609_2_0 depressedLPeriod_i2
rename n_4609_3_0 depressedLPeriod_i3

rename n_4620_0_0 depressedEpisodes_i0
rename n_4620_1_0 depressedEpisodes_i1
rename n_4620_2_0 depressedEpisodes_i2
rename n_4620_3_0 depressedEpisodes_i3

rename n_4631_0_0 unenthusiasticWeek_i0
rename n_4631_1_0 unenthusiasticWeek_i1
rename n_4631_2_0 unenthusiasticWeek_i2
rename n_4631_3_0 unenthusiasticWeek_i3

rename n_4642_0_0 manicHyper2d_i0
rename n_4642_1_0 manicHyper2d_i1
rename n_4642_2_0 manicHyper2d_i2
rename n_4642_3_0 manicHyper2d_i3

rename n_4653_0_0 irritable2d_i0
rename n_4653_1_0 irritable2d_i1
rename n_4653_2_0 irritable2d_i2
rename n_4653_3_0 irritable2d_i3

rename n_5375_0_0 unenthusiasticLPeriod_i0
rename n_5375_1_0 unenthusiasticLPeriod_i1
rename n_5375_2_0 unenthusiasticLPeriod_i2
rename n_5375_3_0 unenthusiasticLPeriod_i3

rename n_5386_0_0 unenthusiasticEpisodes_i0
rename n_5386_1_0 unenthusiasticEpisodes_i1
rename n_5386_2_0 unenthusiasticEpisodes_i2
rename n_5386_3_0 unenthusiasticEpisodes_i3

rename n_5663_0_0 manicEpisodesLength_i0
rename n_5663_1_0 manicEpisodesLength_i1
rename n_5663_2_0 manicEpisodesLength_i2
rename n_5663_3_0 manicEpisodesLength_i3

rename n_5674_0_0 manicEpisodesSeverity_i0
rename n_5674_1_0 manicEpisodesSeverity_i1
rename n_5674_2_0 manicEpisodesSeverity_i2
rename n_5674_3_0 manicEpisodesSeverity_i3

rename n_6145_0_0 illness2y_i0_0
rename n_6145_0_1 illness2y_i0_1
rename n_6145_0_2 illness2y_i0_2
rename n_6145_0_3 illness2y_i0_3
rename n_6145_0_4 illness2y_i0_4
rename n_6145_0_5 illness2y_i0_5
rename n_6145_1_0 illness2y_i1_0
rename n_6145_1_1 illness2y_i1_1
rename n_6145_1_2 illness2y_i1_2
rename n_6145_1_3 illness2y_i1_3
rename n_6145_1_4 illness2y_i1_4
rename n_6145_2_0 illness2y_i2_0
rename n_6145_2_1 illness2y_i2_1
rename n_6145_2_2 illness2y_i2_2
rename n_6145_2_3 illness2y_i2_3
rename n_6145_2_4 illness2y_i2_4
rename n_6145_3_0 illness2y_i3_0
rename n_6145_3_1 illness2y_i3_1
rename n_6145_3_2 illness2y_i3_2
rename n_6145_3_3 illness2y_i3_3

rename n_6156_0_0 manicHyperSymptoms_i0_0
rename n_6156_0_1 manicHyperSymptoms_i0_1
rename n_6156_0_2 manicHyperSymptoms_i0_2
rename n_6156_0_3 manicHyperSymptoms_i0_3
rename n_6156_1_0 manicHyperSymptoms_i1_0
rename n_6156_1_1 manicHyperSymptoms_i1_1
rename n_6156_1_2 manicHyperSymptoms_i1_2
rename n_6156_1_3 manicHyperSymptoms_i1_3
rename n_6156_2_0 manicHyperSymptoms_i2_0
rename n_6156_2_1 manicHyperSymptoms_i2_1
rename n_6156_2_2 manicHyperSymptoms_i2_2
rename n_6156_2_3 manicHyperSymptoms_i2_3
rename n_6156_3_0 manicHyperSymptoms_i3_0
rename n_6156_3_1 manicHyperSymptoms_i3_1
rename n_6156_3_2 manicHyperSymptoms_i3_2

forvalues i = 0/28 {
	rename n_20002_0_`i' illnessCode_i0_`i'  
}
forvalues i = 0/15 {
	rename n_20002_1_`i' illnessCode_i1_`i'  
}
forvalues i = 0/33 {
	rename n_20002_2_`i' illnessCode_i2_`i'  
}
forvalues i = 0/17 {
	rename n_20002_3_`i' illnessCode_i3_`i'  
}

rename n_20127_0_0 neuroticismScore

foreach var of varlist moodSwings_i0-neuroticismScore {
	replace `var' = . if `var' < 0
}

gen temp = (year_birth*12 + month_birth) - (1957*12 + 9)
gen YoB = floor(temp/12)
bysort YoB: egen min=min(DoB)
bysort YoB: egen max=max(DoB)
gen x = (min + max)/2
replace x = round(x)

tempfile part1
save `part1'

use "`input_dir'/MHQ", clear

keep 	Carvalho_ID n_20506_0_0 n_20509_0_0 n_20520_0_0 n_20515_0_0 n_20516_0_0 ///
		n_20505_0_0 n_20512_0_0 n_20514_0_0 n_20510_0_0 n_20517_0_0 n_20519_0_0 ///
		n_20511_0_0 n_20507_0_0 n_20508_0_0 n_20518_0_0 n_20513_0_0 n_20446_0_0 ///
		n_20441_0_0 n_20436_0_0 n_20439_0_0 n_20440_0_0 n_20449_0_0 n_20536_0_0 ///
		n_20532_0_0 n_20435_0_0 n_20450_0_0 n_20437_0_0 n_20458_0_0 n_20459_0_0 ///
		n_20460_0_0 n_20421_0_0 n_20420_0_0 n_20538_0_0 n_20425_0_0 n_20542_0_0 ///
		n_20543_0_0 n_20540_0_0 n_20541_0_0 n_20539_0_0 n_20537_0_0 n_20418_0_0 ///
		n_20426_0_0 n_20423_0_0 n_20429_0_0 n_20419_0_0 n_20422_0_0 n_20417_0_0 ///
		n_20427_0_0

*GAD7 Variables

rename n_20506_0_0 gad7_1
rename n_20509_0_0 gad7_2
rename n_20520_0_0 gad7_3
rename n_20515_0_0 gad7_4
rename n_20516_0_0 gad7_5
rename n_20505_0_0 gad7_6
rename n_20512_0_0 gad7_7

*PHQ9 Variables

rename n_20514_0_0 phq9_1
rename n_20510_0_0 phq9_2
rename n_20517_0_0 phq9_3
rename n_20519_0_0 phq9_4
rename n_20511_0_0 phq9_5
rename n_20507_0_0 phq9_6
rename n_20508_0_0 phq9_7
rename n_20518_0_0 phq9_8
rename n_20513_0_0 phq9_9

*CIDI_SF Variables

rename	n_20446_0_0 cidi_core1
rename	n_20441_0_0 cidi_core2
rename	n_20436_0_0 cidi_1
rename	n_20439_0_0 cidi_2
rename	n_20440_0_0 cidi_3
rename	n_20449_0_0 cidiScore_1
rename	n_20536_0_0 cidiScore_2 
rename	n_20532_0_0 cidiScore_3
rename	n_20435_0_0 cidiScore_4 
rename	n_20450_0_0 cidiScore_5 
rename	n_20437_0_0 cidiScore_6

*Wellbeing Variables

rename n_20458_0_0 gen_happy 
rename n_20459_0_0 health_happy
rename n_20460_0_0 life_meaningful

*GADEver Variables

rename n_20421_0_0 GADEver1
rename n_20420_0_0 GADEver2 
rename n_20538_0_0 GADEver3 
rename n_20425_0_0 GADEver4_1 
rename n_20542_0_0 GADEver4_2 
rename n_20543_0_0 GADEver5_1 
rename n_20540_0_0 GADEver5_2
rename n_20541_0_0 GADEver6 
rename n_20539_0_0 GADEver7_1 
rename n_20537_0_0 GADEver7_2 
rename n_20418_0_0 GADEver8 
rename n_20426_0_0 GADEverSym1
rename n_20423_0_0 GADEverSym2 
rename n_20429_0_0 GADEverSym3 
rename n_20419_0_0 GADEverSym4 
rename n_20422_0_0 GADEverSym5 
rename n_20417_0_0 GADEverSym6 
rename n_20427_0_0 GADEverSym7

merge 1:1 Carvalho_ID using `part1', nogen

save "`input_dir'\renamedMainData.dta", replace
save "`output_dir'\renamedMainData.dta", replace
