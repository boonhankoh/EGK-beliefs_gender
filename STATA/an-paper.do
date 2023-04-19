*** Do women receive less blame than men? Attribution of outcomes in a prosocial setting ***

/*
Authors:
Nisvan ERKAL
Lata GANGADHARAN
Boon Han KOH
*/

*******************************************************************************

** CHANGE DIRECTORY HERE **

cd "DIRECTORY NAME"

*******************************************************************************

** Initialisation **

capture log close _all
clear all
set more off

cap mkdir "Figures"

log using "beliefs_gender-log.log", replace name(BeliefsGender)

*******************************************************************************

/*
Table 2: OLS regressions of evaluators' posterior belief that the leader has chosen high investment, at pooled level and by the leader's gender
*/

use "Data/beliefs_gender-merged-state.dta", clear
keep if LTRoleMember
keep if LTInconsistent==0 & LTNonupdate==0

reg LogitPosterior LogitPrior LogitStateGood LogitStateBad, nocon vce(cluster ID)
lincom LogitPrior-1
lincom LogitStateGood-1
lincom LogitStateBad-1

reg LogitPosterior LogitPrior LogitStateGood LogitStateBad if surveyLeaderMale, nocon vce(cluster ID)
lincom LogitPrior-1
lincom LogitStateGood-1
lincom LogitStateBad-1

reg LogitPosterior LogitPrior LogitStateGood LogitStateBad if surveyLeaderFemale, nocon vce(cluster ID)
lincom LogitPrior-1
lincom LogitStateGood-1
lincom LogitStateBad-1

reg LogitPosterior i.surveyLeaderFemale#c.LogitPrior i.surveyLeaderFemale#c.LogitStateGood i.surveyLeaderFemale#c.LogitStateBad, nocon vce(cluster ID)
testparm surveyLeaderFemale#c.LogitPrior, equal
testparm surveyLeaderFemale#c.LogitStateGood, equal
testparm surveyLeaderFemale#c.LogitStateBad, equal

*******************************************************************************

/*
Table 3: OLS regressions of evaluators' posterior belief that the leader has chosen high investment, by the leader's gender and evaluator's gender
*/

use "Data/beliefs_gender-merged-state.dta", clear
keep if LTRoleMember
keep if LTInconsistent==0 & LTNonupdate==0

reg LogitPosterior LogitPrior LogitStateGood LogitStateBad if Female & surveyLeaderMale, nocon vce(cluster ID)
lincom LogitPrior-1
lincom LogitStateGood-1
lincom LogitStateBad-1

reg LogitPosterior LogitPrior LogitStateGood LogitStateBad if Female & surveyLeaderFemale, nocon vce(cluster ID)
lincom LogitPrior-1
lincom LogitStateGood-1
lincom LogitStateBad-1

reg LogitPosterior i.surveyLeaderFemale#c.LogitPrior i.surveyLeaderFemale#c.LogitStateGood i.surveyLeaderFemale#c.LogitStateBad if Female, nocon vce(cluster ID)
testparm surveyLeaderFemale#c.LogitPrior, equal
testparm surveyLeaderFemale#c.LogitStateGood, equal
testparm surveyLeaderFemale#c.LogitStateBad, equal

reg LogitPosterior LogitPrior LogitStateGood LogitStateBad if !Female & surveyLeaderMale, nocon vce(cluster ID)
lincom LogitPrior-1
lincom LogitStateGood-1
lincom LogitStateBad-1

reg LogitPosterior LogitPrior LogitStateGood LogitStateBad if !Female & surveyLeaderFemale, nocon vce(cluster ID)
lincom LogitPrior-1
lincom LogitStateGood-1
lincom LogitStateBad-1

reg LogitPosterior i.surveyLeaderFemale#c.LogitPrior i.surveyLeaderFemale#c.LogitStateGood i.surveyLeaderFemale#c.LogitStateBad if !Female, nocon vce(cluster ID)
testparm surveyLeaderFemale#c.LogitPrior, equal
testparm surveyLeaderFemale#c.LogitStateGood, equal
testparm surveyLeaderFemale#c.LogitStateBad, equal

*******************************************************************************

/*
Table 4: OLS regressions of evaluators' posterior belief that the leader has chosen high investment, by the leader's gender and evaluator's investment decision
*/

use "Data/beliefs_gender-merged-state.dta", clear
keep if LTRoleMember
keep if LTInconsistent==0 & LTNonupdate==0

reg LogitPosterior LogitPrior LogitStateGood LogitStateBad if !LTHighEff & surveyLeaderMale, nocon vce(cluster ID)
lincom LogitPrior-1
lincom LogitStateGood-1
lincom LogitStateBad-1

reg LogitPosterior LogitPrior LogitStateGood LogitStateBad if !LTHighEff & surveyLeaderFemale, nocon vce(cluster ID)
lincom LogitPrior-1
lincom LogitStateGood-1
lincom LogitStateBad-1

reg LogitPosterior i.surveyLeaderFemale#c.LogitPrior i.surveyLeaderFemale#c.LogitStateGood i.surveyLeaderFemale#c.LogitStateBad if !LTHighEff, nocon vce(cluster ID)
testparm surveyLeaderFemale#c.LogitPrior, equal
testparm surveyLeaderFemale#c.LogitStateGood, equal
testparm surveyLeaderFemale#c.LogitStateBad, equal

reg LogitPosterior LogitPrior LogitStateGood LogitStateBad if LTHighEff & surveyLeaderMale, nocon vce(cluster ID)
lincom LogitPrior-1
lincom LogitStateGood-1
lincom LogitStateBad-1

reg LogitPosterior LogitPrior LogitStateGood LogitStateBad if LTHighEff & surveyLeaderFemale, nocon vce(cluster ID)
lincom LogitPrior-1
lincom LogitStateGood-1
lincom LogitStateBad-1

reg LogitPosterior i.surveyLeaderFemale#c.LogitPrior i.surveyLeaderFemale#c.LogitStateGood i.surveyLeaderFemale#c.LogitStateBad if LTHighEff, nocon vce(cluster ID)
testparm surveyLeaderFemale#c.LogitPrior, equal
testparm surveyLeaderFemale#c.LogitStateGood, equal
testparm surveyLeaderFemale#c.LogitStateBad, equal

*******************************************************************************

/*
Figure 1: Evaluators' posterior beliefs that the leader has chosen high investment against Bayesian posteriors, by the leader's outcomes
*/

use "Data/beliefs_gender-merged-state.dta", clear
keep if LTRoleMember
keep if LTInconsistent==0 & LTNonupdate==0

global covariates "Age i.Economics i.UG i.Australian PastExp CRTScore"

local p=0.75
local q=1-`p'
gen LTBeliefTheory=.
replace LTBeliefTheory = ((`p'*LTBeliefPrior/100)/(`p'*LTBeliefPrior/100+`q'*(1-LTBeliefPrior/100)))*100 if StateSuccess
replace LTBeliefTheory = ((`q'*LTBeliefPrior/100)/(`q'*LTBeliefPrior/100+`p'*(1-LTBeliefPrior/100)))*100 if StateFailure

// Panel (a): Low outcomes

qui reg LTBeliefPosterior i.surveyLeaderMale##c.LTBeliefTheory i.LTHighEff RGNumRiskyChoice ParameterReturnDiff i.ParameterZero $covariates i.Round if StateFailure, vce(cluster ID)

lincom _cons
global cons_f=r(estimate)
lincom _cons+1.surveyLeaderMale
global cons_m=r(estimate)
lincom LTBeliefTheory
global slope_f=r(estimate)
lincom LTBeliefTheory+1.surveyLeaderMale#c.LTBeliefTheory
global slope_m=r(estimate)

twoway (function y = x, range(0 100) lcolor(black%100) lpattern(longdash) lwidth(thin)) ///
	(function y = x*$slope_m + $cons_m, range(0 100) lcolor(black%25) lpattern(solid) lwidth(thick)) ///
	(function y = x*$slope_f + $cons_f, range(0 100) lcolor(black%100) lpattern(shortdash_dot) lwidth(thick)) ///
	, ///
	legend(order(2 "Male leaders" 3 "Female leaders")) ///
	xtitle("Bayesian Posterior") xscale(range(0 100)) xlabel(0(20)100) ///
	ytitle("Reported Posterior") yscale(range(0 100)) ylabel(0(20)100) ///
	graphregion(color(white)) bgcolor(white)
graph export "Figures/Figure1a.png", replace
window manage close graph _all

// Panel (b): High outcomes

qui reg LTBeliefPosterior i.surveyLeaderMale##c.LTBeliefTheory i.LTHighEff RGNumRiskyChoice ParameterReturnDiff i.ParameterZero $covariates i.Round if StateSuccess, vce(cluster ID)

lincom _cons
global cons_f=r(estimate)
lincom _cons+1.surveyLeaderMale
global cons_m=r(estimate)
lincom LTBeliefTheory
global slope_f=r(estimate)
lincom LTBeliefTheory+1.surveyLeaderMale#c.LTBeliefTheory
global slope_m=r(estimate)

twoway (function y = x, range(0 100) lcolor(black%100) lpattern(longdash) lwidth(thin)) ///
	(function y = x*$slope_m + $cons_m, range(0 100) lcolor(black%25) lpattern(solid) lwidth(thick)) ///
	(function y = x*$slope_f + $cons_f, range(0 100) lcolor(black%100) lpattern(shortdash_dot) lwidth(thick)) ///
	, ///
	legend(order(2 "Male leaders" 3 "Female leaders")) ///
	xtitle("Bayesian Posterior") xscale(range(0 100)) xlabel(0(20)100) ///
	ytitle("Reported Posterior") yscale(range(0 100)) ylabel(0(20)100) ///
	graphregion(color(white)) bgcolor(white)
graph export "Figures/Figure1b.png", replace
window manage close graph _all

*******************************************************************************

/*
Figure 2: Evaluators' prior belief that the leader has chosen high investment and leaders' investment decisions, by the leader's gender
*/

// Panel (a): Evaluator's average prior belief that leader has chosen high investment

use "Data/beliefs_gender-merged-long.dta", clear
keep if LTRoleMember
keep if LTInconsistent==0 & LTNonupdate==0

collapse (mean) mean_prior=LTBeliefPrior (sd) sd_prior=LTBeliefPrior (count) n_prior=LTBeliefPrior, by(surveyLeaderMale surveyLeaderFemale)

generate hi_prior = mean_prior + invttail(n_prior-1,0.025)*(sd_prior / sqrt(n_prior))
generate lo_prior = mean_prior - invttail(n_prior-1,0.025)*(sd_prior / sqrt(n_prior))

gen group=.
replace group=1 if surveyLeaderMale==1
replace group=2 if surveyLeaderFemale==1

twoway (bar mean_prior group, fcolor(gs6) lcolor(gs6) barwidth(0.75)) ///
	(rcap hi_prior lo_prior group, lcolor(black)), ///
	xtitle(" ") xlabel(1 "Male Leader" 2 "Female Leader", noticks) ///
	xscale(range(0.25 2.75)) ///
	yscale(range(0 60)) ylabel(0(20)60, labsize(medlarge) angle(horizontal)) ///
	ytitle("Average belief that leader chose high investment", size(medlarge)) ///
	legend(off) ///
	graphregion(color(white)) bgcolor(white)
graph export "Figures/Figure2a.png", replace
window manage close graph _all

// Panel (b): Proportion of high investment decisions by leaders

use "Data/beliefs_gender-merged-long.dta", clear

collapse (mean) mean_higheff=LTHighEff (sd) sd_higheff=LTHighEff (count) n_higheff=LTHighEff, by(Female)

generate hi_higheff = mean_higheff + invttail(n_higheff-1,0.025)*(sd_higheff / sqrt(n_higheff))
generate lo_higheff = mean_higheff - invttail(n_higheff-1,0.025)*(sd_higheff / sqrt(n_higheff))

gen group=.
replace group=1 if !Female
replace group=2 if Female

twoway (bar mean_higheff group, fcolor(gs6) lcolor(gs6) barwidth(0.75)) ///
	(rcap hi_higheff lo_higheff group, lcolor(black)), ///
	xtitle(" ") xlabel(1 "Male Leader" 2 "Female Leader", noticks) ///
	xscale(range(0.25 2.75)) ///
	yscale(range(0 0.6)) ylabel(0(0.2)0.6, labsize(medlarge) angle(horizontal)) ///
	ytitle("Proportion of leaders choosing high investment", size(medlarge)) ///
	legend(off) ///
	graphregion(color(white)) bgcolor(white)
graph export "Figures/Figure2b.png", replace
window manage close graph _all

*******************************************************************************

/*
Table B1: OLS regressions of evaluators' posterior belief that the leader has chosen high investment against Bayesian posteriors
*/

use "Data/beliefs_gender-merged-state.dta", clear
keep if LTRoleMember
keep if LTInconsistent==0 & LTNonupdate==0

global covariates "Age i.Economics i.UG i.Australian PastExp CRTScore"

local p=0.75
local q=1-`p'
gen LTBeliefTheory=.
replace LTBeliefTheory = ((`p'*LTBeliefPrior/100)/(`p'*LTBeliefPrior/100+`q'*(1-LTBeliefPrior/100)))*100 if StateSuccess
replace LTBeliefTheory = ((`q'*LTBeliefPrior/100)/(`q'*LTBeliefPrior/100+`p'*(1-LTBeliefPrior/100)))*100 if StateFailure

reg LTBeliefPosterior i.surveyLeaderMale##c.LTBeliefTheory i.Round if StateFailure, vce(cluster ID)
reg LTBeliefPosterior i.surveyLeaderMale##c.LTBeliefTheory i.LTHighEff RGNumRiskyChoice ParameterReturnDiff i.ParameterZero $covariates i.Round if StateFailure, vce(cluster ID)

reg LTBeliefPosterior i.surveyLeaderMale##c.LTBeliefTheory i.Round if StateSuccess, vce(cluster ID)
reg LTBeliefPosterior i.surveyLeaderMale##c.LTBeliefTheory i.LTHighEff RGNumRiskyChoice ParameterReturnDiff i.ParameterZero $covariates i.Round if StateSuccess, vce(cluster ID)

*******************************************************************************

/*
Table B2: Probit regressions of leaders' investment decision
*/

use "Data/beliefs_gender-merged-long.dta", clear
global covariates "Age i.Economics i.UG i.Australian PastExp CRTScore"

qui probit LTHighEff i.Female DGGivePerc RGNumRiskyChoice ParameterReturnDiff i.ParameterZero i.Round, vce(cluster ID)
margins, dydx(*) post

qui probit LTHighEff i.Female DGGivePerc RGNumRiskyChoice ParameterReturnDiff i.ParameterZero i.Round $covariates, vce(cluster ID)
margins, dydx(*) post

*******************************************************************************

/*
Table B3: OLS regressions of evaluators' prior belief that the leader has chosen high investment
*/

use "Data/beliefs_gender-merged-long.dta", clear
keep if LTRoleMember
keep if LTInconsistent==0 & LTNonupdate==0
global covariates "Age i.Economics i.UG i.Australian PastExp CRTScore"

reg LTBeliefPrior ib0.surveyLeaderFemale ib0.Female i.LTHighEff RGNumRiskyChoice ParameterReturnDiff i.ParameterZero i.Round, vce(cluster ID)

reg LTBeliefPrior ib0.surveyLeaderFemale ib0.Female i.LTHighEff RGNumRiskyChoice ParameterReturnDiff i.ParameterZero i.Round $covariates, vce(cluster ID)

*******************************************************************************

/*
Table B4: OLS regressions of evaluators' posterior belief that the leader has chosen high investment, at the pooled level and separately by the evaluator's gender
*/

use "Data/beliefs_gender-merged-state.dta", clear
keep if LTRoleMember
keep if LTInconsistent==0 & LTNonupdate==0

global covariates "Age i.Economics i.UG i.Australian PastExp CRTScore"

local p=0.75
local q=1-`p'
gen LTBeliefTheory=.
replace LTBeliefTheory = ((`p'*LTBeliefPrior/100)/(`p'*LTBeliefPrior/100+`q'*(1-LTBeliefPrior/100)))*100 if StateSuccess
replace LTBeliefTheory = ((`q'*LTBeliefPrior/100)/(`q'*LTBeliefPrior/100+`p'*(1-LTBeliefPrior/100)))*100 if StateFailure

reg LTBeliefPosterior i.surveyLeaderMale##i.StateFailure c.LTBeliefTheory i.Round, vce(cluster ID)
lincom 1.surveyLeaderMale + 1.surveyLeaderMale#1.StateFailure
reg LTBeliefPosterior i.surveyLeaderMale##i.StateFailure c.LTBeliefTheory i.LTHighEff RGNumRiskyChoice ParameterReturnDiff i.ParameterZero $covariates i.Round, vce(cluster ID)
lincom 1.surveyLeaderMale + 1.surveyLeaderMale#1.StateFailure

reg LTBeliefPosterior i.surveyLeaderMale##i.StateFailure c.LTBeliefTheory i.Round if !Female, vce(cluster ID)
lincom 1.surveyLeaderMale + 1.surveyLeaderMale#1.StateFailure
reg LTBeliefPosterior i.surveyLeaderMale##i.StateFailure c.LTBeliefTheory i.LTHighEff RGNumRiskyChoice ParameterReturnDiff i.ParameterZero $covariates i.Round if !Female, vce(cluster ID)
lincom 1.surveyLeaderMale + 1.surveyLeaderMale#1.StateFailure

reg LTBeliefPosterior i.surveyLeaderMale##i.StateFailure c.LTBeliefTheory i.Round if Female, vce(cluster ID)
lincom 1.surveyLeaderMale + 1.surveyLeaderMale#1.StateFailure
reg LTBeliefPosterior i.surveyLeaderMale##i.StateFailure c.LTBeliefTheory i.LTHighEff RGNumRiskyChoice ParameterReturnDiff i.ParameterZero $covariates i.Round if Female, vce(cluster ID)
lincom 1.surveyLeaderMale + 1.surveyLeaderMale#1.StateFailure

*******************************************************************************

/*
Figure C1: Distribution of inconsistent and non-updates by evaluators
*/

// Panel (a): Inconsistent updates

use "Data/beliefs_gender-merged.dta", clear
keep if LTRoleMember

twoway histogram LTBeliefIncTotal, discrete width(1) start(0) percent ///
	yscale(range(0 60)) ylabel(0(20)60, labsize(medlarge) angle(horizontal)) ///
	xscale(range(0 10)) xlabel(0(1)10, labsize(medlarge)) ///
	xtitle("# updates in wrong direction", size(medlarge)) ///
	ytitle("% evaluators", size(medlarge)) ///
	graphregion(color(white)) bgcolor(white) fcolor(gs6) lcolor(gs12)
graph export "Figures/FigureC1a.png", replace
window manage close graph _all

// Panel (b): Non-updates

use "Data/beliefs_gender-merged.dta", clear
keep if LTRoleMember

twoway histogram LTBeliefNonTotal, discrete width(1) start(0) percent ///
	yscale(range(0 60)) ylabel(0(20)60, labsize(medlarge) angle(horizontal)) ///
	xscale(range(0 10)) xlabel(0(1)10, labsize(medlarge)) ///
	xtitle("# non-updates", size(medlarge)) ///
	ytitle("% evaluators", size(medlarge)) ///
	graphregion(color(white)) bgcolor(white) fcolor(gs6) lcolor(gs12)
graph export "Figures/FigureC1b.png", replace
window manage close graph _all

*******************************************************************************

/*
Table C1: OLS regressions of evaluators' posterior belief that the leader has chosen high investment, at pooled level and by the leader's gender (full sample)
*/

use "Data/beliefs_gender-merged-state.dta", clear
keep if LTRoleMember

reg LogitPosterior LogitPrior LogitStateGood LogitStateBad, nocon vce(cluster ID)
lincom LogitPrior-1
lincom LogitStateGood-1
lincom LogitStateBad-1

reg LogitPosterior LogitPrior LogitStateGood LogitStateBad if surveyLeaderMale, nocon vce(cluster ID)
lincom LogitPrior-1
lincom LogitStateGood-1
lincom LogitStateBad-1

reg LogitPosterior LogitPrior LogitStateGood LogitStateBad if surveyLeaderFemale, nocon vce(cluster ID)
lincom LogitPrior-1
lincom LogitStateGood-1
lincom LogitStateBad-1

reg LogitPosterior i.surveyLeaderFemale#c.LogitPrior i.surveyLeaderFemale#c.LogitStateGood i.surveyLeaderFemale#c.LogitStateBad, nocon vce(cluster ID)
testparm surveyLeaderFemale#c.LogitPrior, equal
testparm surveyLeaderFemale#c.LogitStateGood, equal
testparm surveyLeaderFemale#c.LogitStateBad, equal

*******************************************************************************

/*
Table C2: OLS regressions of evaluators' posterior belief that the leader has chosen high investment, by the leader's gender and evaluator's gender (full sample)
*/

use "Data/beliefs_gender-merged-state.dta", clear
keep if LTRoleMember

reg LogitPosterior LogitPrior LogitStateGood LogitStateBad if Female & surveyLeaderMale, nocon vce(cluster ID)
lincom LogitPrior-1
lincom LogitStateGood-1
lincom LogitStateBad-1

reg LogitPosterior LogitPrior LogitStateGood LogitStateBad if Female & surveyLeaderFemale, nocon vce(cluster ID)
lincom LogitPrior-1
lincom LogitStateGood-1
lincom LogitStateBad-1

reg LogitPosterior i.surveyLeaderFemale#c.LogitPrior i.surveyLeaderFemale#c.LogitStateGood i.surveyLeaderFemale#c.LogitStateBad if Female, nocon vce(cluster ID)
testparm surveyLeaderFemale#c.LogitPrior, equal
testparm surveyLeaderFemale#c.LogitStateGood, equal
testparm surveyLeaderFemale#c.LogitStateBad, equal

reg LogitPosterior LogitPrior LogitStateGood LogitStateBad if !Female & surveyLeaderMale, nocon vce(cluster ID)
lincom LogitPrior-1
lincom LogitStateGood-1
lincom LogitStateBad-1

reg LogitPosterior LogitPrior LogitStateGood LogitStateBad if !Female & surveyLeaderFemale, nocon vce(cluster ID)
lincom LogitPrior-1
lincom LogitStateGood-1
lincom LogitStateBad-1

reg LogitPosterior i.surveyLeaderFemale#c.LogitPrior i.surveyLeaderFemale#c.LogitStateGood i.surveyLeaderFemale#c.LogitStateBad if !Female, nocon vce(cluster ID)
testparm surveyLeaderFemale#c.LogitPrior, equal
testparm surveyLeaderFemale#c.LogitStateGood, equal
testparm surveyLeaderFemale#c.LogitStateBad, equal

*******************************************************************************

/*
Table C3: OLS regressions of evaluators' posterior belief that the leader has chosen high investment, by the leader's gender and evaluator's investment decision (full sample)
*/

use "Data/beliefs_gender-merged-state.dta", clear
keep if LTRoleMember

reg LogitPosterior LogitPrior LogitStateGood LogitStateBad if !LTHighEff & surveyLeaderMale, nocon vce(cluster ID)
lincom LogitPrior-1
lincom LogitStateGood-1
lincom LogitStateBad-1

reg LogitPosterior LogitPrior LogitStateGood LogitStateBad if !LTHighEff & surveyLeaderFemale, nocon vce(cluster ID)
lincom LogitPrior-1
lincom LogitStateGood-1
lincom LogitStateBad-1

reg LogitPosterior i.surveyLeaderFemale#c.LogitPrior i.surveyLeaderFemale#c.LogitStateGood i.surveyLeaderFemale#c.LogitStateBad if !LTHighEff, nocon vce(cluster ID)
testparm surveyLeaderFemale#c.LogitPrior, equal
testparm surveyLeaderFemale#c.LogitStateGood, equal
testparm surveyLeaderFemale#c.LogitStateBad, equal

reg LogitPosterior LogitPrior LogitStateGood LogitStateBad if LTHighEff & surveyLeaderMale, nocon vce(cluster ID)
lincom LogitPrior-1
lincom LogitStateGood-1
lincom LogitStateBad-1

reg LogitPosterior LogitPrior LogitStateGood LogitStateBad if LTHighEff & surveyLeaderFemale, nocon vce(cluster ID)
lincom LogitPrior-1
lincom LogitStateGood-1
lincom LogitStateBad-1

reg LogitPosterior i.surveyLeaderFemale#c.LogitPrior i.surveyLeaderFemale#c.LogitStateGood i.surveyLeaderFemale#c.LogitStateBad if LTHighEff, nocon vce(cluster ID)
testparm surveyLeaderFemale#c.LogitPrior, equal
testparm surveyLeaderFemale#c.LogitStateGood, equal
testparm surveyLeaderFemale#c.LogitStateBad, equal

*******************************************************************************

capture log close _all