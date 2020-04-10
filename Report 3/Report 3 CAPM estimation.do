clear

*import daily return estimates
import delimited "/Users/canaan/Desktop/TBILL.csv"

recode tbillrft = tbillrft/365
*--------------------ESTIMATE CAPM----------------------------------------------
*generate Y variables for S&P sector and individual companies
gen Ysp = sphhprit - tbillrft
gen Ykmb = kmb - tbillrft
gen Yclx = clx - tbillrft
gen Ycl = cl - tbillrft
gen Ypg = pg - tbillrft

*generate market risk premium variable
gen X = sprmt - tbillrft

*estimate CAPM using the given regression
. ssc install estout, replace
eststo A : reg Ysp X
eststo B : reg Ykmb X
eststo C : reg Yclx X
eststo D : reg Ycl X
eststo E : reg Ypg X
esttab A B C D E using OLSreg.doc, se r2

*--------------------CALCULATE EXPECTED RETURNS---------------------------------
*calculate expected return on the market
gen Erm = tbillrft + X

*calculate expected returns for each covered company's share price + SP sector
gen ERsp = tbillrft + 0.749*(Erm-tbillrft)
gen ERkmb = tbillrft + 0.0488*(Erm-tbillrft)
gen ERclx = tbillrft + 0.151*(Erm-tbillrft)
gen ERcl = tbillrft + 0.0428*(Erm-tbillrft)
gen ERpg = tbillrft + 0.810*(Erm-tbillrft)
