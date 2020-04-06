*Alexa Canaan
*ECON 387
*Final Paper

*LOAD capiq firm data
clear
use "/Users/canaan/Desktop/GitHub/ECON387/capiq_firm_income_data.dta"
append using "/Users/canaan/Desktop/GitHub/ECON387/capiq_firm_balancesheet_data.dta"
merge m:1 capiq_id using "/Users/canaan/Desktop/GitHub/ECON387/capiq_firm_info_data.dta"
describe
*sort by sic code to choose an industry
sort sic
*filter by sic codes for commercial banks 6020
drop if sic!=6020
*drop obs for years before 2008
*no glassdoor data before 2008
drop if year < 2008


use "/Users/canaan/Desktop/GitHub/ECON387/capiq_firm_data.dta"
use "/Users/canaan/Desktop/GitHub/ECON387/capiq_firm_balancesheet_data.dta"
use "/Users/canaan/Desktop/GitHub/ECON387/capiq_firm_cashflow_data.dta"
use "/Users/canaan/Desktop/GitHub/ECON387/capiq_firm_income_data.dta"
use "/Users/canaan/Desktop/GitHub/ECON387/capiq_firm_other_data.dta"



