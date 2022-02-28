/* ***************************************************************************** */
/* File Name:			assessment.do											 */
/* Written by:			Andrew Yu												 */
/* Last Updated: 		July 6th, 2021											 */
/* Updated by Silvia:															 */
/* ***************************************************************************** */

clear all
set more off

**************************
//Setting Up Directories//
**************************

local input_dir "C:\Users\ayu087\OneDrive\Dropbox\UKB\Input"
local output_dir "C:\Users\ayu087\OneDrive\Dropbox\UKB\Output"

use "`input_dir'/MainData", clear

merge 1:1 Carvalho_ID using "`input_dir'/SWB_PGI_vs2", nogen keep(1 3)

save "`input_dir'/MatchedMainData.dta", replace
