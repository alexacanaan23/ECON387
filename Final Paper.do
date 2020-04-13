*Alexa Canaan
*ECON 387
*Final Paper

*LOAD capiq firm data
clear
use "/Users/canaan/Desktop/GitHub/ECON387/capiq_firm_income_data.dta"
joinby capiq_id datacqtr_ciq kypermno permco using "/Users/canaan/Desktop/GitHub/ECON387/capiq_firm_balancesheet_data.dta"
joinby capiq_id using "/Users/canaan/Desktop/GitHub/ECON387/capiq_firm_info_data.dta"
joinby capiq_id datacqtr_ciq kypermno permco using "/Users/canaan/Desktop/GitHub/ECON387/capiq_firm_exec_comp_data.dta"
describe
*sort by sic code to choose an industry
sort sic
*filter by sic codes for finance industry in dataset
drop if sic<6000 | sic >6999
*drop obs for years before 2019
drop if year < 2019
drop if qtr < 4

summarize

*create financial performance ratios
*ROA
gen ROA = IQ_NI_CS/IQ_TOTAL_ASSETS_CS
label var ROA "ROA"

*ROE
gen ROE = IQ_NI_CS/IQ_TOTAL_EQUITY_CS
label var ROE "ROE"

*LIQUIDITY RATIOS
*current ratio
gen CURRENT_RATIO = IQ_TOTAL_CA_CS/IQ_TOTAL_CL_CS
label var CURRENT_RATIO "CURRENT RATIO"

*cash ratio
gen CASH_RATIO = IQ_CASH_EQUIV_CS/IQ_TOTAL_CL_CS
label var CASH_RATIO "CASH RATIO"

*LEVERAGE RATIOS
*debt equity ratio
gen DEBT_EQUITY_RATIO = IQ_TOTAL_DEBT_CS/IQ_TOTAL_EQUITY_CS
label var DEBT_EQUITY_RATIO "DEBT EQUITY RATIO"

*equity multiplier
gen EQUITY_MULTIPLIER = IQ_TOTAL_ASSETS_CS/IQ_TOTAL_EQUITY_CS
label var EQUITY_MULTIPLIER "EQUITY MULTIPLIER"

*COVERAGE RATIOS
*times interest earned ratio
gen NETDEBT_EBITDA = IQ_NET_DEBT_CS/IQ_EBITDA_CS
label var NETDEBT_EBITDA "NET DEBT EBITDA RATIO"

*INVENTORY
gen INVENTORY_TURNOVER = IQ_COGS_CS/IQ_INVENTORY_CS
label var INVENTORY_TURNOVER "INVENTORY TURNOVER"

gen DAYS_SALES_INVENTORY = 365/INVENTORY_TURNOVER
label var DAYS_SALES_INVENTORY "DAYS' SALES INVENTORY"

*PROFIT MARGIN
gen PROFIT_MARGIN = IQ_NI_CS/IQ_TOTAL_REV_CS
label var PROFIT_MARGIN "PROFIT MARGIN"

gen EBITDA_SALES = IQ_EBITDA_CS/IQ_TOTAL_REV_CS
label var EBITDA_SALES "EBITDA SALES RATIO"

*EPS
gen EPS = IQ_NI_CS/IQ_TOTAL_OUTSTANDING_BS_DATE_CS
label var EPS "EPS"

*EMPLOYEE SATISFACTION - METRIC CREATION
sort conm

*overall rating
gen GD_RATING = 0
*Affiliatetd Managers Group, Inc.
replace GD_RATING = 3.6 if capiq_id == "IQ24445"
*Aflac
replace GD_RATING = 3.5 if capiq_id == "IQ250178"
*Alexandria R E Equities
replace GD_RATING = 3.9 if capiq_id == "IQ365138"
*Allstate
replace GD_RATING = 3.4 if capiq_id == "IQ18711"
*BOA
replace GD_RATING = 3.7 if capiq_id == "IQ19049"
*BNY Mellon
replace GD_RATING = 3.1 if capiq_id == "IQ135506"


*recommend to a friend
gen REC_FRIEND = 0
*Affiliatetd Managers Group, Inc.
replace REC_FRIEND = .75 if capiq_id == "IQ24445"
*Aflac
replace REC_FRIEND = .62 if capiq_id == "IQ250178"
*Alexandria R E Equities
replace REC_FRIEND = .65 if capiq_id == "IQ365138"
*Allstate
replace REC_FRIEND = .56 if capiq_id == "IQ18711"
*BOA
replace REC_FRIEND = .73 if capiq_id == "IQ19049"
*BNY Mellon
replace REC_FRIEND = .52 if capiq_id == "IQ135506"


*approve of CEO
gen APPROVE_CEO = 0
*Affiliatetd Managers Group, Inc.
replace APPROVE_CEO = .85 if capiq_id == "IQ24445"
*Aflac
replace APPROVE_CEO = .89 if capiq_id == "IQ250178"
*Alexandria R E Equities
replace APPROVE_CEO = 1 if capiq_id == "IQ365138"
*Allstate
replace APPROVE_CEO = .69 if capiq_id == "IQ18711"
*BOA
replace APPROVE_CEO = .88 if capiq_id == "IQ19049"
*BNY Mellon
replace APPROVE_CEO = .63 if capiq_id == "IQ135506"

*American express
replace GD_RATING = 4.1 if capiq_id == "IQ92001"
replace REC_FRIEND = .83 if capiq_id == "IQ92001"
replace APPROVE_CEO = .94 if capiq_id == "IQ92001"

*American international group
replace GD_RATING = 3.2 if capiq_id == "IQ250388"
replace REC_FRIEND = .53 if capiq_id == "IQ250388"
replace APPROVE_CEO = .69 if capiq_id == "IQ250388"

*American tower corp
replace GD_RATING = 3.3 if capiq_id == "IQ24766"
replace REC_FRIEND = .63 if capiq_id == "IQ24766"
replace APPROVE_CEO = .71 if capiq_id == "IQ24766"

*Ameriprise financial
replace GD_RATING = 3.6 if capiq_id == "IQ4165019"
replace REC_FRIEND = .69 if capiq_id == "IQ4165019"
replace APPROVE_CEO = .85 if capiq_id == "IQ4165019"

*Anthem inc
replace GD_RATING = 3.3 if capiq_id == "IQ160077"
replace REC_FRIEND = .59 if capiq_id == "IQ160077"
replace APPROVE_CEO = .60 if capiq_id == "IQ160077"

*AON PLC
replace GD_RATING = 3.6 if capiq_id == "IQ119853"
replace REC_FRIEND = .70 if capiq_id == "IQ119853"
replace APPROVE_CEO = .87 if capiq_id == "IQ119853"

*Apartment invest & mgmt co
replace GD_RATING = 3.7 if capiq_id == "IQ336458"
replace REC_FRIEND = .68 if capiq_id == "IQ336458"
replace APPROVE_CEO = .84 if capiq_id == "IQ336458"

*Arthur J gallagher & co
replace GD_RATING = 3.2 if capiq_id == "IQ252186"
replace REC_FRIEND = .57 if capiq_id == "IQ252186"
replace APPROVE_CEO = .78 if capiq_id == "IQ252186"

*Assurant INC
replace GD_RATING = 3.3 if capiq_id == "IQ4026111"
replace REC_FRIEND = .61 if capiq_id == "IQ4026111"
replace APPROVE_CEO = .78 if capiq_id == "IQ4026111"

*Avalonbay communities inc
replace GD_RATING = 4.2 if capiq_id == "IQ329141"
replace REC_FRIEND = .83 if capiq_id == "IQ329141"
replace APPROVE_CEO = .95 if capiq_id == "IQ329141"

*berkley (W R) corp
replace GD_RATING = 3.3 if capiq_id == "IQ254504"
replace REC_FRIEND = .51 if capiq_id == "IQ254504"
replace APPROVE_CEO = .61 if capiq_id == "IQ254504"

*BLK
replace GD_RATING = 3.8 if capiq_id == "IQ403413"
replace REC_FRIEND = .75 if capiq_id == "IQ403413"
replace APPROVE_CEO = .92 if capiq_id == "IQ403413"

*Boston properties inc
replace GD_RATING = 3.9 if capiq_id == "IQ368278"
replace REC_FRIEND = .77 if capiq_id == "IQ368278"
replace APPROVE_CEO = .96 if capiq_id == "IQ368278"

*capital one financial corp
replace GD_RATING = 3.9 if capiq_id == "IQ336241"
replace REC_FRIEND = .74 if capiq_id == "IQ336241"
replace APPROVE_CEO = .91 if capiq_id == "IQ336241"

*CBOE global markets inc
replace GD_RATING = 3.8 if capiq_id == "IQ32624297"
replace REC_FRIEND = .69 if capiq_id == "IQ32624297"
replace APPROVE_CEO = .97 if capiq_id == "IQ32624297"

*CBRE group inc
replace GD_RATING = 3.6 if capiq_id == "IQ4204816"
replace REC_FRIEND = .69 if capiq_id == "IQ4204816"
replace APPROVE_CEO = .88 if capiq_id == "IQ4204816"

*Centene corp
replace GD_RATING = 3.1 if capiq_id == "IQ26273"
replace REC_FRIEND = .57 if capiq_id == "IQ26273"
replace APPROVE_CEO = .70 if capiq_id == "IQ26273"

*Chubb ltd
replace GD_RATING = 3.3 if capiq_id == "IQ203028"
replace REC_FRIEND = .59 if capiq_id == "IQ203028"
replace APPROVE_CEO = .70 if capiq_id == "IQ203028"

*Cigna corp
replace GD_RATING = 3.5 if capiq_id == "IQ172899"
replace REC_FRIEND = .65 if capiq_id == "IQ172899"
replace APPROVE_CEO = .88 if capiq_id == "IQ172899"

*Cincinnati financial group
replace GD_RATING = 3.5 if capiq_id == "IQ260681"
replace REC_FRIEND = .70 if capiq_id == "IQ260681"
replace APPROVE_CEO = .79 if capiq_id == "IQ260681"

*citigroup inc
replace GD_RATING = 3.7 if capiq_id == "IQ391687"
replace REC_FRIEND = .72 if capiq_id == "IQ391687"
replace APPROVE_CEO = .85 if capiq_id == "IQ391687"

*Citizens financial group inc
replace GD_RATING = 3.4 if capiq_id == "IQ46051729"
replace REC_FRIEND = .61 if capiq_id == "IQ46051729"
replace APPROVE_CEO = .84 if capiq_id == "IQ46051729"

*cme group inc
replace GD_RATING = 3.5 if capiq_id == "IQ2004577"
replace REC_FRIEND = .58 if capiq_id == "IQ2004577"
replace APPROVE_CEO = .82 if capiq_id == "IQ2004577"

*comerica inc
replace GD_RATING = 3.4 if capiq_id == "IQ318670"
replace REC_FRIEND = .53 if capiq_id == "IQ318670"
replace APPROVE_CEO = .68 if capiq_id == "IQ318670"

*crown castle intl corp
replace GD_RATING = 3.5 if capiq_id == "IQ27198"
replace REC_FRIEND = .64 if capiq_id == "IQ27198"
replace APPROVE_CEO = .83 if capiq_id == "IQ27198"

*digital realty trust inc
replace GD_RATING = 4.3 if capiq_id == "IQ11041860"
replace REC_FRIEND = .88 if capiq_id == "IQ11041860"
replace APPROVE_CEO = .93 if capiq_id == "IQ11041860"

*iscover financial svcs
replace GD_RATING = 3.8 if capiq_id == "IQ3695566"
replace REC_FRIEND = .76 if capiq_id == "IQ3695566"
replace APPROVE_CEO = .85 if capiq_id == "IQ3695566"

*duke realty corp
replace GD_RATING = 4.0 if capiq_id == "IQ267906"
replace REC_FRIEND = .73 if capiq_id == "IQ267906"
replace APPROVE_CEO = 1 if capiq_id == "IQ267906"

*e trade financial corp
replace GD_RATING = 4.0 if capiq_id == "IQ27807"
replace REC_FRIEND = .77 if capiq_id == "IQ27807"
replace APPROVE_CEO = .87 if capiq_id == "IQ27807"

*equinix inc
replace GD_RATING = 3.9 if capiq_id == "IQ28202"
replace REC_FRIEND = .80 if capiq_id == "IQ28202"
replace APPROVE_CEO = .91 if capiq_id == "IQ28202"

*equity residential
replace GD_RATING = 4.2 if capiq_id == "IQ28209"
replace REC_FRIEND = .83 if capiq_id == "IQ28209"
replace APPROVE_CEO = .92 if capiq_id == "IQ28209"

*essex property trust
replace GD_RATING = 3.2 if capiq_id == "IQ332646"
replace REC_FRIEND = .54 if capiq_id == "IQ332646"
replace APPROVE_CEO = .76 if capiq_id == "IQ332646"

*everest re group ltd
replace GD_RATING = 3.2 if capiq_id == "IQ340813"
replace REC_FRIEND = .66 if capiq_id == "IQ340813"
replace APPROVE_CEO = .86 if capiq_id == "IQ340813"

*extra space storage inc
replace GD_RATING = 4.2 if capiq_id == "IQ8057672"
replace REC_FRIEND = .84 if capiq_id == "IQ8057672"
replace APPROVE_CEO = .89 if capiq_id == "IQ8057672"

*federal realty investment tr
replace GD_RATING = 3.5 if capiq_id == "IQ271305"
replace REC_FRIEND = .64 if capiq_id == "IQ271305"
replace APPROVE_CEO = 1 if capiq_id == "IQ271305"

*fifth third bancorp
replace GD_RATING = 3.4 if capiq_id == "IQ270961"
replace REC_FRIEND = .62 if capiq_id == "IQ270961"
replace APPROVE_CEO = .78 if capiq_id == "IQ270961"

*first republic bank
replace GD_RATING = 3.7 if capiq_id == "IQ272383"
replace REC_FRIEND = .69 if capiq_id == "IQ272383"
replace APPROVE_CEO = .93 if capiq_id == "IQ272383"

*franklin resources inc
replace GD_RATING = 3.8 if capiq_id == "IQ28703"
replace REC_FRIEND = .74 if capiq_id == "IQ28703"
replace APPROVE_CEO = .87 if capiq_id == "IQ28703"

*globe life inc
replace GD_RATING = 3.0 if capiq_id == "IQ308916"
replace REC_FRIEND = .48 if capiq_id == "IQ308916"
replace APPROVE_CEO = .57 if capiq_id == "IQ308916"

*goldman sachs group inc
replace GD_RATING = 4.0 if capiq_id == "IQ398625"
replace REC_FRIEND = .77 if capiq_id == "IQ398625"
replace APPROVE_CEO = .89 if capiq_id == "IQ398625"

*hartford financial services
replace GD_RATING = 3.9 if capiq_id == "IQ341546"
replace REC_FRIEND = .75 if capiq_id == "IQ341546"
replace APPROVE_CEO = .88 if capiq_id == "IQ341546"

*healthpeak properties inc ******NO DATA

*host hotels and resorts inc
replace GD_RATING = 3.1 if capiq_id == "IQ29574"
replace REC_FRIEND = .45 if capiq_id == "IQ29574"
replace APPROVE_CEO = .49 if capiq_id == "IQ29574"

*humana inc
replace GD_RATING = 3.5 if capiq_id == "IQ29618"
replace REC_FRIEND = .61 if capiq_id == "IQ29618"
replace APPROVE_CEO = .75 if capiq_id == "IQ29618"

*huntington bancshares
replace GD_RATING = 3.5 if capiq_id == "IQ278614"
replace REC_FRIEND = .64 if capiq_id == "IQ278614"
replace APPROVE_CEO = .87 if capiq_id == "IQ278614"

*intercontinental exchange
replace GD_RATING = 3.0 if capiq_id == "IQ1081952"
replace REC_FRIEND = .53 if capiq_id == "IQ1081952"
replace APPROVE_CEO = .72 if capiq_id == "IQ1081952"

*invesco ltd
replace GD_RATING = 3.6 if capiq_id == "IQ384779"
replace REC_FRIEND = .63 if capiq_id == "IQ384779"
replace APPROVE_CEO = .70 if capiq_id == "IQ384779"

*iron mountain inc
replace GD_RATING = 3.1 if capiq_id == "IQ30292"
replace REC_FRIEND = .51 if capiq_id == "IQ30292"
replace APPROVE_CEO = .57 if capiq_id == "IQ30292"

*jpmorgan chase & co
replace GD_RATING = 3.9 if capiq_id == "IQ658776"
replace REC_FRIEND = .80 if capiq_id == "IQ658776"
replace APPROVE_CEO = .92 if capiq_id == "IQ658776"

*keycorp
replace GD_RATING = 3.4 if capiq_id == "IQ329376"
replace REC_FRIEND = .62 if capiq_id == "IQ329376"
replace APPROVE_CEO = .85 if capiq_id == "IQ329376"

*kimco realty corp
replace GD_RATING = 3.5 if capiq_id == "IQ320371"
replace REC_FRIEND = .72 if capiq_id == "IQ320371"
replace APPROVE_CEO = 1 if capiq_id == "IQ320371"

*lincoln national corp
replace GD_RATING = 3.4 if capiq_id == "IQ867423"
replace REC_FRIEND = .60 if capiq_id == "IQ867423"
replace APPROVE_CEO = .81 if capiq_id == "IQ867423"

*loews corp
replace GD_RATING = 3.2 if capiq_id == "IQ285930"
replace REC_FRIEND = .57 if capiq_id == "IQ285930"
replace APPROVE_CEO = .76 if capiq_id == "IQ285930"

*m&t bank corp
replace GD_RATING = 3.4 if capiq_id == "IQ272285"
replace REC_FRIEND = .58 if capiq_id == "IQ272285"
replace APPROVE_CEO = .77 if capiq_id == "IQ272285"

*macerich co
replace GD_RATING = 3.6 if capiq_id == "IQ332172"
replace REC_FRIEND = .61 if capiq_id == "IQ332172"
replace APPROVE_CEO = .56 if capiq_id == "IQ332172"

*marketaxess holdings inc
replace GD_RATING = 4.3 if capiq_id == "IQ109450"
replace REC_FRIEND = .87 if capiq_id == "IQ109450"
replace APPROVE_CEO = .96 if capiq_id == "IQ109450"

*marsh & mclennan cos
replace GD_RATING = 3.5 if capiq_id == "IQ473342"
replace REC_FRIEND = .66 if capiq_id == "IQ473342"
replace APPROVE_CEO = .82 if capiq_id == "IQ473342"

*mastercard inc
replace GD_RATING = 4.1 if capiq_id == "IQ6477196"
replace REC_FRIEND = .81 if capiq_id == "IQ6477196"
replace APPROVE_CEO = .96 if capiq_id == "IQ6477196"

*metlife inc
replace GD_RATING = 3.7 if capiq_id == "IQ185648"
replace REC_FRIEND = .74 if capiq_id == "IQ185648"
replace APPROVE_CEO = .89 if capiq_id == "IQ185648"

*mid-america apt cmntys inc
replace GD_RATING = 3.7 if capiq_id == "IQ332358"
replace REC_FRIEND = .70 if capiq_id == "IQ332358"
replace APPROVE_CEO = .84 if capiq_id == "IQ332358"

*morgan stanley
replace GD_RATING = 3.8 if capiq_id == "IQ472898"
replace REC_FRIEND = .75 if capiq_id == "IQ472898"
replace APPROVE_CEO = .90 if capiq_id == "IQ472898"

*msci inc
replace GD_RATING = 3.6 if capiq_id == "IQ7844318"
replace REC_FRIEND = .71 if capiq_id == "IQ7844318"
replace APPROVE_CEO = .89 if capiq_id == "IQ7844318"

*nasdaq inc
replace GD_RATING = 3.8 if capiq_id == "IQ740535"
replace REC_FRIEND = .79 if capiq_id == "IQ740535"
replace APPROVE_CEO = .96 if capiq_id == "IQ740535"

*northern trust corp
replace GD_RATING = 3.7 if capiq_id == "IQ291896"
replace REC_FRIEND = .77 if capiq_id == "IQ291896"
replace APPROVE_CEO = .91 if capiq_id == "IQ291896"

*people's united finl inc
replace GD_RATING = 3.3 if capiq_id == "IQ295774"
replace REC_FRIEND = .61 if capiq_id == "IQ295774"
replace APPROVE_CEO = .75 if capiq_id == "IQ295774"

*perrigo co plc **** NOT FINANCE?
replace GD_RATING = 3.3 if capiq_id == "IQ319092"
replace REC_FRIEND = .65 if capiq_id == "IQ319092"
replace APPROVE_CEO = .71 if capiq_id == "IQ319092"

*pnc financial svcs group inc
replace GD_RATING = 3.4 if capiq_id == "IQ294585"
replace REC_FRIEND = .61 if capiq_id == "IQ294585"
replace APPROVE_CEO = .80 if capiq_id == "IQ294585"

*price (t. rowe) group
replace GD_RATING = 3.7 if capiq_id == "IQ23217"
replace REC_FRIEND = .67 if capiq_id == "IQ23217"
replace APPROVE_CEO = .85 if capiq_id == "IQ23217"

*principal financial grp inc
replace GD_RATING = 3.7 if capiq_id == "IQ201105"
replace REC_FRIEND = .72 if capiq_id == "IQ201105"
replace APPROVE_CEO = .90 if capiq_id == "IQ201105"

*progressive corp-ohio
replace GD_RATING = 3.6 if capiq_id == "IQ8057672"
replace REC_FRIEND = .70 if capiq_id == "IQ8057672"
replace APPROVE_CEO = .91 if capiq_id == "IQ8057672"

*prologis inc
replace GD_RATING = 4.0 if capiq_id == "IQ33352"
replace REC_FRIEND = .70 if capiq_id == "IQ33352"
replace APPROVE_CEO = .98 if capiq_id == "IQ33352"

*prudential financial inc
replace GD_RATING = 3.6 if capiq_id == "IQ1038328"
replace REC_FRIEND = .65 if capiq_id == "IQ1038328"
replace APPROVE_CEO = .82 if capiq_id == "IQ1038328"

*public storage 
replace GD_RATING = 3.3 if capiq_id == "IQ305520"
replace REC_FRIEND = .54 if capiq_id == "IQ305520"
replace APPROVE_CEO = .66 if capiq_id == "IQ305520"

*raymond james financial group
replace GD_RATING = 3.7 if capiq_id == "IQ22623"
replace REC_FRIEND = .69 if capiq_id == "IQ22623"
replace APPROVE_CEO = .89 if capiq_id == "IQ22623"

*realty income corp
replace GD_RATING = 4.5 if capiq_id == "IQ339305"
replace REC_FRIEND = .82 if capiq_id == "IQ339305"
replace APPROVE_CEO = .69 if capiq_id == "IQ339305"

*regency centers corp
replace GD_RATING = 4.0 if capiq_id == "IQ816889"
replace REC_FRIEND = .83 if capiq_id == "IQ816889"
replace APPROVE_CEO = 1 if capiq_id == "IQ816889"

*regions financial corp
replace GD_RATING = 3.2 if capiq_id == "IQ271409"
replace REC_FRIEND = .56 if capiq_id == "IQ271409"
replace APPROVE_CEO = .74 if capiq_id == "IQ271409"

*sba communications corp
replace GD_RATING = 3.2 if capiq_id == "IQ34071"
replace REC_FRIEND = .51 if capiq_id == "IQ34071"
replace APPROVE_CEO = .83 if capiq_id == "IQ34071"

*schwab corp
replace GD_RATING = 3.6 if capiq_id == "IQ34093"
replace REC_FRIEND = .66 if capiq_id == "IQ34093"
replace APPROVE_CEO = .87 if capiq_id == "IQ34093"

*simon property group inc
replace GD_RATING = 2.9 if capiq_id == "IQ34378"
replace REC_FRIEND = .50 if capiq_id == "IQ34378"
replace APPROVE_CEO = .49 if capiq_id == "IQ34378"

*sl green realty corp
replace GD_RATING = 3.4 if capiq_id == "IQ364744"
replace REC_FRIEND = .59 if capiq_id == "IQ364744"
replace APPROVE_CEO = .83 if capiq_id == "IQ364744"

*state street corp
replace GD_RATING = 3.1 if capiq_id == "IQ188785"
replace REC_FRIEND = .47 if capiq_id == "IQ188785"
replace APPROVE_CEO = .56 if capiq_id == "IQ188785"

*svb financial group
replace GD_RATING = 3.3 if capiq_id == "IQ187662"
replace REC_FRIEND = .59 if capiq_id == "IQ187662"
replace APPROVE_CEO = .86 if capiq_id == "IQ187662"

*synchrony financial
replace GD_RATING = 3.9 if capiq_id == "IQ260334235"
replace REC_FRIEND = .78 if capiq_id == "IQ260334235"
replace APPROVE_CEO = .92 if capiq_id == "IQ260334235"

*travelers cos inc
replace GD_RATING = 3.9 if capiq_id == "IQ392856"
replace REC_FRIEND = .75 if capiq_id == "IQ392856"
replace APPROVE_CEO = .88 if capiq_id == "IQ392856"

*truist financial corp
replace GD_RATING = 3.4 if capiq_id == "IQ19109"
replace REC_FRIEND = .83 if capiq_id == "IQ19109"
replace APPROVE_CEO = 1 if capiq_id == "IQ19109"

*u s bancorp
replace GD_RATING = 3.4 if capiq_id == "IQ305304"
replace REC_FRIEND = .59 if capiq_id == "IQ305304"
replace APPROVE_CEO = .73 if capiq_id == "IQ305304"

*udr inc
replace GD_RATING = 3.9 if capiq_id == "IQ310667"
replace REC_FRIEND = .82 if capiq_id == "IQ310667"
replace APPROVE_CEO = .92 if capiq_id == "IQ310667"

*unitedhealth group inc
replace GD_RATING = 3.4 if capiq_id == "IQ104673"
replace REC_FRIEND = .62 if capiq_id == "IQ104673"
replace APPROVE_CEO = .75 if capiq_id == "IQ104673"

*unum group
replace GD_RATING = 3.6 if capiq_id == "IQ166762"
replace REC_FRIEND = .61 if capiq_id == "IQ166762"
replace APPROVE_CEO = .50 if capiq_id == "IQ166762"

*ventas inc
replace GD_RATING = 3.5 if capiq_id == "IQ398549"
replace REC_FRIEND = .66 if capiq_id == "IQ398549"
replace APPROVE_CEO = .85 if capiq_id == "IQ398549"

*verisk analytics inc
replace GD_RATING = 3.6 if capiq_id == "IQ1027055"
replace REC_FRIEND = .68 if capiq_id == "IQ1027055"
replace APPROVE_CEO = .88 if capiq_id == "IQ1027055"

*visa inc
replace GD_RATING = 3.7 if capiq_id == "IQ38043467"
replace REC_FRIEND = .71 if capiq_id == "IQ38043467"
replace APPROVE_CEO = .91 if capiq_id == "IQ38043467"

*vornado realty trust
replace GD_RATING = 4.1 if capiq_id == "IQ312648"
replace REC_FRIEND = .74 if capiq_id == "IQ312648"
replace APPROVE_CEO = .52 if capiq_id == "IQ312648"

*wells fargo & co
replace GD_RATING = 3.6 if capiq_id == "IQ292891"
replace REC_FRIEND = .68 if capiq_id == "IQ292891"
replace APPROVE_CEO = .77 if capiq_id == "IQ292891"

*welltower inc
replace GD_RATING = 2.4 if capiq_id == "IQ277914"
replace REC_FRIEND = .37 if capiq_id == "IQ277914"
replace APPROVE_CEO = .27 if capiq_id == "IQ277914"

*western union co
replace GD_RATING = 3.3 if capiq_id == "IQ909408"
replace REC_FRIEND = .58 if capiq_id == "IQ909408"
replace APPROVE_CEO = .63 if capiq_id == "IQ909408"

*willis towers watson plc
replace GD_RATING = 3.6 if capiq_id == "IQ36623"
replace REC_FRIEND = .67 if capiq_id == "IQ36623"
replace APPROVE_CEO = .79 if capiq_id == "IQ36623"

*zions bancorporation na
replace GD_RATING = 3.3 if capiq_id == "IQ315476"
replace REC_FRIEND = .61 if capiq_id == "IQ315476"
replace APPROVE_CEO = .78 if capiq_id == "IQ315476"

*INTRODUCTORY FIGURES-----------------------------------------------------------
*summary statistics
capture ssc install estout
estpost summarize GD_RATING REC_FRIEND APPROVE_CEO ROA ROE, detail
esttab . using sumstat.rtf, ///
   cells("mean(fmt(%5.2f) label(Mean)) sd(label(SD)) min(label(Min)) max(label(Max))  count(fmt(%9.0f) label(N))") ///
   noobs label nonum replace mlabels(none) title(Summary Statistics)
   
capture ssc install estout
estpost summarize IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS, detail
esttab . using sumstat.rtf, ///
   cells("mean(fmt(%5.2f) label(Mean)) sd(label(SD)) min(label(Min)) max(label(Max))  count(fmt(%9.0f) label(N))") ///
   noobs label nonum replace mlabels(none) title(Summary Statistics)
   
capture ssc install estout
estpost summarize CASH_RATIO CURRENT_RATIO DEBT_EQUITY_RATIO EQUITY_MULTIPLIER NETDEBT_EBITDA INVENTORY_TURNOVER DAYS_SALES_INVENTORY PROFIT_MARGIN EBITDA_SALES EPS, detail
esttab . using sumstat.rtf, ///
   cells("mean(fmt(%5.2f) label(Mean)) sd(label(SD)) min(label(Min)) max(label(Max))  count(fmt(%9.0f) label(N))") ///
   noobs label nonum replace mlabels(none) title(Summary Statistics)
   
*figures
graph box ROA
graph box ROE
histogram GD_RATING
histogram REC_FRIEND
histogram APPROVE_CEO
   
*REGRESSIONS--------------------------------------------------------------------

reg ROA GD_RATING 
reg ROA REC_FRIEND
reg ROA APPROVE_CEO
reg ROA GD_RATING REC_FRIEND APPROVE_CEO

reg ROA GD_RATING IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg ROA REC_FRIEND IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg ROA APPROVE_CEO IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg ROA GD_RATING REC_FRIEND APPROVE_CEO IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS

reg ROE GD_RATING
reg ROE REC_FRIEND
reg ROE APPROVE_CEO
reg ROE GD_RATING REC_FRIEND APPROVE_CEO

reg ROE GD_RATING IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg ROE REC_FRIEND IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg ROE APPROVE_CEO IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg ROE GD_RATING REC_FRIEND APPROVE_CEO IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS

reg CURRENT_RATIO GD_RATING IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg CURRENT_RATIO REC_FRIEND IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg CURRENT_RATIO APPROVE_CEO IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg CURRENT_RATIO GD_RATING REC_FRIEND APPROVE_CEO IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS

reg CASH_RATIO GD_RATING IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg CASH_RATIO REC_FRIEND IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg CASH_RATIO APPROVE_CEO IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg CASH_RATIO GD_RATING REC_FRIEND APPROVE_CEO IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS

reg DEBT_EQUITY_RATIO GD_RATING IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg DEBT_EQUITY_RATIO REC_FRIEND IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg DEBT_EQUITY_RATIO APPROVE_CEO IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg DEBT_EQUITY_RATIO GD_RATING REC_FRIEND APPROVE_CEO IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS

reg EQUITY_MULTIPLIER GD_RATING IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg EQUITY_MULTIPLIER REC_FRIEND IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg EQUITY_MULTIPLIER APPROVE_CEO IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg EQUITY_MULTIPLIER GD_RATING REC_FRIEND APPROVE_CEO IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS

reg NETDEBT_EBITDA GD_RATING IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg NETDEBT_EBITDA REC_FRIEND IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg NETDEBT_EBITDA APPROVE_CEO IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg NETDEBT_EBITDA GD_RATING REC_FRIEND APPROVE_CEO IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS

reg INVENTORY_TURNOVER GD_RATING IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg INVENTORY_TURNOVER REC_FRIEND IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
*reg INVENTORY_TURNOVER APPROVE_CEO IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg INVENTORY_TURNOVER GD_RATING REC_FRIEND APPROVE_CEO IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS

reg DAYS_SALES_INVENTORY GD_RATING IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg DAYS_SALES_INVENTORY REC_FRIEND IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg DAYS_SALES_INVENTORY APPROVE_CEO IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg DAYS_SALES_INVENTORY GD_RATING REC_FRIEND APPROVE_CEO IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS

reg PROFIT_MARGIN GD_RATING IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg PROFIT_MARGIN REC_FRIEND IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg PROFIT_MARGIN APPROVE_CEO IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg PROFIT_MARGIN GD_RATING REC_FRIEND APPROVE_CEO IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS

reg EBITDA_SALES GD_RATING IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg EBITDA_SALES REC_FRIEND IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
*reg EBITDA_SALES APPROVE_CEO IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg EBITDA_SALES GD_RATING REC_FRIEND APPROVE_CEO IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS

reg EPS GD_RATING IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg EPS REC_FRIEND IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg EPS APPROVE_CEO IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg EPS GD_RATING REC_FRIEND APPROVE_CEO IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS


reg GD_RATING ROA
reg GD_RATING ROE 
reg GD_RATING ROA REC_FRIEND
reg GD_RATING ROE REC_FRIEND
reg GD_RATING ROA REC_FRIEND APPROVE_CEO
reg GD_RATING ROE REC_FRIEND APPROVE_CEO
reg GD_RATING ROA REC_FRIEND APPROVE_CEO IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg GD_RATING ROE REC_FRIEND APPROVE_CEO IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg GD_RATING ROA REC_FRIEND APPROVE_CEO IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS

reg GD_RATING ROA REC_FRIEND APPROVE_CEO CASH_RATIO CURRENT_RATIO DEBT_EQUITY_RATIO EQUITY_MULTIPLIER NETDEBT_EBITDA INVENTORY_TURNOVER DAYS_SALES_INVENTORY PROFIT_MARGIN EBITDA_SALES EPS
reg GD_RATING ROE REC_FRIEND APPROVE_CEO CASH_RATIO CURRENT_RATIO DEBT_EQUITY_RATIO EQUITY_MULTIPLIER NETDEBT_EBITDA INVENTORY_TURNOVER DAYS_SALES_INVENTORY PROFIT_MARGIN EBITDA_SALES EPS
reg GD_RATING ROA REC_FRIEND APPROVE_CEO CASH_RATIO CURRENT_RATIO DEBT_EQUITY_RATIO EQUITY_MULTIPLIER NETDEBT_EBITDA INVENTORY_TURNOVER DAYS_SALES_INVENTORY PROFIT_MARGIN EBITDA_SALES EPS IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS
reg GD_RATING ROE REC_FRIEND APPROVE_CEO CASH_RATIO CURRENT_RATIO DEBT_EQUITY_RATIO EQUITY_MULTIPLIER NETDEBT_EBITDA INVENTORY_TURNOVER DAYS_SALES_INVENTORY PROFIT_MARGIN EBITDA_SALES EPS IQ_PROFESSIONAL_SALARY IQ_PROFESSIONAL_CALCULATED_COMP IQ_PROFESSIONAL_RESTRICTED_STOCK IQ_PROFESSIONAL_OPTION_AWARDS


. ssc install estout, replace
eststo A : reg ROA GD_RATING REC_FRIEND APPROVE_CEO
eststo B : reg ROE GD_RATING REC_FRIEND APPROVE_CEO
eststo C : reg 
eststo D : reg 
eststo E : reg 
esttab A B C D E using OLSreg.doc, se r2

*-------------------------------------------------------------------------------
*Extra code 
*use "/Users/canaan/Desktop/GitHub/ECON387/capiq_firm_data.dta"
*use "/Users/canaan/Desktop/GitHub/ECON387/capiq_firm_balancesheet_data.dta"
*use "/Users/canaan/Desktop/GitHub/ECON387/capiq_firm_cashflow_data.dta"
*use "/Users/canaan/Desktop/GitHub/ECON387/capiq_firm_income_data.dta"
*use "/Users/canaan/Desktop/GitHub/ECON387/capiq_firm_other_data.dta"
*use "/Users/canaan/Desktop/GitHub/ECON387/capiq_firm_info_data.dta"


*interact w size, market cap
*reverse the direction of the OLS equation

