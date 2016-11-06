/* set the path as the external folder "myfolders" and put data under "data" folder */
%let path=/folders/myfolders/data;
libname mydata "&path";

/* copy sashelp.prdsale to a new file in the working folder */
data tempData;
	set sashelp.prdsale;
run;

/* look at the type of data (content) in the database */
proc contents data=tempData varnum;
run;

/* sort data in descending order */
proc sort data=tempData;
	by descending actual;
run;

/* print data */
proc print data=tempData (obs=20);
run;

/* find the mean and STDEV */
proc means data=tempData;
	var actual;
run;

/* find the median */
proc means data=tempData median;
	var actual;
	class country;
run;

/* find the mode */
proc means data=tempData mode;
	var quarter;
run;

/* find the Variance*/
proc means data=tempData var;
	var actual;
run;

/* find the STDEV*/
proc means data=tempData std;
	var actual;
	class country;
run;

/* The following is the code for the mean and median */
Proc means data=tempData mean median;
	var actual;
run;

/* quantiles */
proc univariate data=tempData;
	var actual;
run;

/* boxplot*/
proc univariate data=tempData plot;
	var actual;
run;

/* taking outliers out of the boxplot simply use "where" to exclude the above or below values */
proc univariate data=tempData plot;
	var actual;
	where actual < 900;
run;

/* the following is a short guide of how to import and clean the data */
/*Import .txt file data into SAS with space delimiter, input give the column names, unspecified number of records */
data housing;
	infile '/folders/myfolders/data/fhlmc_sf2013a_loans.txt' delimiter=' ';
	input Enterprice_Flag Record_Number MSA_Code Percent_Minority 
		Tract_Income_Ratio Borrower_Income_Ratio Loan_To_Value_Ratio Purpose_Of_Loan 
		Federal_Guarantee Race;
run;

proc print data=housing (obs=100);
run;

/* look at data and determine whether the variables are discrete or continuous */
/* to convert N/A or other strings in variables to numbers,
 * there will be warning messages indicate string to number conversions*/
data newData;
	set originalData;
	newVariable=originalVariable * 1;
run;

/* when come across an unknown variable, use univariate to look at the range of the variable,
 * use "plot" after proc statement to visually inspect the data */
proc univariate data=yourData;
	var yourVariable;
run;

/* every variable needs to be examined for missing values.
 * If there are too many missing (ie. 30%) this issue need to be treated */
proc freq data=yourData;
	table yourVariable;
run;

/* if a variable is missing a bunch of values, it is possible that they are simply not there
 * and you have to determine what those vales are.
 * Such as whether these people should be given credit according their risk ratio */
/* when a variable have consistent values that doesn't make sense, it could a default variable
 * such as 99, 0, 1, or ** */
/* generally, removing or replacing outliers is not a viable solution */
/* if the problem of outliers and missing values cannot be treated, these questions may be answered in the cleaning step */
/* one way to impute (replace missing variable) is to use the mean or median */
/* another way of impute missing variable is to use strong correlations
 * with another variable to predict the most reasonable value */
/* if there are too many values missing (>50%), use an indicator variable
 * to indicate whether the variable have missing variables like 0 and 1 */
/* <10% missing discrete data: impute based on related variable
 * 10% - 50% missing discrete data: impute based on related variable and create dummy new variable
 * > 50% missing discrete data: do not used the missing variable, create a indicate dummy variable
 * <10% missing continuous variable: impute based on mean/median value
 * 10% - 50% missing continuous data: impute and create dummy indicator variable
 * > 50% missing continuous variable: create dummy variable and do not use the missing variable */
/* check the descriptive stats on conditioned variable */
Proc univariate data=cust_cred_raw_v1 plot;
	Var oldVariable;
	Where oldVariable <=1;
run;

/* copy data from raw database to new database with condition in a variable */
data cust_cred_raw_v2;
	set cust_cred_raw_v1;

	if oldVariable > 1 then
		newVariable=0.304325;
	else
		newVariable=oldVariable;
run;

/* copy to a new database, replace empty fields ".", with a sensible data */
data cust_cred_raw_v2;
	set cust_cred_raw_v2;

	if oldVariable=. then
		newVariable=1;
	else
		newVariable=0;
run;

/* if a field is a certain value, replace it with the desired variable */
data cust_cred_raw_v2;
	set cust_cred_raw_v2;

	if oldVariable in (96, 98) then
		newVariable=6;
	else
		newVariable=oldVariable;
run;

/*
Z-test: if your sample statistic is sample mean for a large sample
T-test: if your sample statistic is sample mean for a small sample, or you don't know the standard deviation
T-test: sample mean is small (<30), so it might not follow normal distribution
test if H0, the null hypothesis is true against a variable
*/
proc ttest data=Expenses H0=4500;
	var expense;
run;

/*
Testing sample mean with large sample											Population mean = X1																	Z-test
Testing sample mean with small sample											Population mean = X2																	T-test
Testing the independence of two variables										The two variables are independent														Chi-square test
Testing correlation between two variables										Correlation The correlation between two variables is zero								Person correlation test
Testing the significance of an independent variable on a dependent variables 	Coefficient The coefficient of independent variable is zero in the regression model		Test for Beta
Testing the difference in variance of two populations							There is no difference in the variance between two populations							F-test
Testing the proportion of a particular class in a variable in populations 		The population proportion = P1															Z-test for proportion
*/
/*			H0 is true		H0 is false
Reject H0	Type 1 error	Right inference
Accept H0	Right inference	Type 2 error

Type 1 error: rejecting the H0 when it is true. Normally at 5 percent
Type 2 error: accepting the H0 when it is false.
*/
/*
Look for linear correlations between two variables
Generally, >0.75 is a strong correlation
The size of data needs to be sufficiently large
Watch for outliers in data, remove a few may result in strong
correlations.
Often, there is a third variable that cause both variable to change
*/
proc corr data=add_budget;
	var Online_Budget Responses_online;
run;

/* Scatter plot for x= variable1, y = variable2 */
proc gplot data=telecom;
	plot variable1 * variable2;
run;

/* Regression is a modeling technique, which gives the actual relationship between two variables in the form of an equation */
/* to get linear regression with burgers=y and visitors=x */
proc reg data=burgers;
	model burgers=visitors;
run;

/* To test how good the model is, use "sum of squares of error" to quantity and compare between models
R squared measures how much the variance can be explained.
No variance explained < R - Squared < Explained100% of variance
R squared needs to be minimum of 80%.
If it is a non-linear relationship, try log(x), e(x), sqrt(x) etc.
Linear regression assumes normality, outliers are often the problem. Refers to cleaning outliers and missing data. Use histogram plot */
/* P-P plot: A normal probability versus residual probability distribution plot */
/* The dependent variable cannot be dependent on it's own previous variables
Autocorrelation (ACF) can detect dependencies. If there is a seasonal dependency, then you might get seasonal indices, and the data can be adjusted accordingly. If the data shows a clear trend, then some smoothing techniques might be used to correct or adjust the data. In such cases, even variable transformation using various mathematical functions can be considered.
Homoscedasticity, dependent variable has the same variance across all points of independent variables. The opposite is hetroscendasticity. */
/* Four linear regression assumptions:
Linearity
Normality
Self-dependency
Homoscedasticity */

/* Multiple Regression line when consider many variables */
proc reg data=mobiles;
	model sales=Ratings Price Num_new_features Stock_market_ind 
		Market_promo_budget;
run;

/*Statistical measures:
The F-test tells whether there is at least one variable in the model that has a significant impact on the dependent variable.
The T-test tells whether a variable is useful in the model to describe the data (> 0.05 means it is not useful).
Drop a variable from the model and see if it affects R squared. Check how important each variable is at inference by dropping each one.
When using regression from multiple variables, it is easy to increase R squared if there is few data points and the model is junk. This is shown by decreasing adjusted R squared value when increasing the number of variables in the model. */
/* Multicollinearity (MCL) is a phenomenon where you see a high interdependency between the independent variables.
When a variable is not significant in a model by t-test score, it might still be useful in a model. It may be highly correlative with another variable in the model. So while it does not improve the model, it is useful on its own to make predictions.
Multicollinearity variables often have high standard deviations.
Similar variables in a model cause MCL. Identify by finding highly correlated variables. A R squared > 0.8 may also be an indication.
Variance inflation factor (VIF) is used to indicate MCL.
Tolerance = 1 / VIF
VIF of higher than 5 should be considered for MCL.
Removing a variable in a pair with similar VIF to take away MCL. */
/* include VIF value in regression analysis */
proc reg data=sat_score;
	model SAT=General_knowledge Aptitude Mathematics Science/VIF;
run;

/* Although you can drop high VIF variables, MCL can also be treated with:
Use principle components
Collect more unbiased sample
Keep all variables
Ridge regression
Data transformation */
/* Steps regression analysis (FRAVT):
F-test
R-squared
Adjusted R-squared
VIF
T-test for each variable */
/* When encountering yes or no situation, logistic regression is a good test.
logistic model */

Proc logistic data=ice_cream_sales;
	model buy_ind=age;
run;

/* SAS logistic regression model build with lower value as Yes. */
/* For model fit summary, AIC and SC with the lower value is a better model */
/* Likelihood, Score and Walk tests shows if there is at least one variable have impact on the model (<0.05). */
/* Maximum likelihood estimates: estimate is either the y-intercept or the coefficient of Beta */
/* Chi-square test tell if a variable have an impact on the model to predict the result. */
/* Concordance is the probability of correctly predicting Yes vs. No for the model given the data. */
/* Any concordance greater than 70 percent is good; greater than 80 percent is ideal */
/* When there is more than one levels, such as win/loss/draw, you need to use multinomial logistic regression. */
/* Time series */
/* Auto-regressive integrated moving average (ARIMA). */
/* A time series is said to be stationary if there is no systematic change in mean (no trend). */
/* To use Box-Jenkins approach, if a time series is not stationary, it needed to be transformed into a stationary series. */
/* Testing if a series is stationary using Dickey Fuller test. >0.05 means non-stationary */
proc arima data=ms;
	identify var=stock_price stationarity=(DICKEY);
run;

/* Look for the "single mean" in "augmented Dickey-Fuller unit root tests". */
/* If Pr<Rho and Pr<Tau values are bigger than 0.05, then the series is not stationary. */
/* If the series is not stationary, differentiated time series can be created for modeling */
data ms1;
	set ms;
	diff_stock_price=stock_price-lag1(stock_price);
run;

/* if the second order differentiated value is not stationary, then another type of transformation is needed */
proc arima data=ms1;
	identify var=diff_stock_price stationarity=(DICKEY);
run;

/* after the prediction, you need to add the previous values, or integrate to get the actual number and not just the change */
data ms2;
	set ms2;
	integrated_stock_price=diff_stock_price+lag1(stock_price);
run;

/* autocorrelation graphs are used determine whether a times series is AR, MA, or ARMA */
/* Use plots=all parameter */
proc arima data=ts15 plots=all;
	identify var=Series_Values ;
run;

/* To identify an AR process, 
ACF: Slowly tails off or diminishes to zero. Either reduces in one direction or reduces in a sinusoidal (sine wave) passion.
PACF: Cuts off. The cutoff lag indicates the order of the AR process. */
/* To identify an MA process, it is the reverse
ACF: Cuts off. The cutoff lag indicates the order of the MA process.
PACF: Slowly tails off or diminishes to zero. Either reduces in one direction or reduces in a
sinusoidal or sine wave pattern. */
/* It is almost impossible to recognize ARMA process easily,
although you should see all ACF, PACF and IACF ramp down quickly */
/* if a series is ARMA (p,q), then the ESACF plot is a triangle with
 (p,q) as the vertex. And the SCAN plot is a rectangle with (p,q) 
 as the vertex. */
proc arima data= TS13 plots=all;
	identify var=x SCAN ESACF ;
run;
/* If the series is already determined to be stationary, p+d = p, since
 d = 0 */
/* Use optimization technique to find the parameters of the time-series 
 equation. You can use the maximum likelihood estimator technique
 to guess the model parameters. The method=ML option indicates 
 the maximum likelihood. MU is the intercept or the mean of the series */
proc arima data=web_views;
	identify var=Visitors ;
	estimate p=1 q=0 method=ML;
run;

/* The AIC and SBC values help you to compare between two models. Low AIC and SBC value models
are preferred. */
/* use residue plot to check for unexplained patterns. If there are 
obvious patterns or high white noise values, then some other pattern 
should be used */
/* to predict or forecast a value using the existing model */
proc arima data=web_views;
	Identify var=Visitors;
	Estimate p=1 q=0 method=ml;
	Forecast lead=7;
run;

/* Use only related historical data. 
Only forecast 10% of the of data points into the future */
/* Steps for time series forecast:
Testing stationarity
Identify model type by ACF and PACF
Estimating parameters
Forecasting */

* format data into date format. Date in US format, balance in dollar format;
title "Listing of FINANCIAL";
proc print data=financial;
	format DOB mmddyy10.
		Balance dollar11.2;
run;

* when data does not need to be created, use _null_;
data _null_;
	set learn.test_scores;
	if score1 ge 95 or score2 ge 95 or score3 ge 95 then
		put ID= Score1= Score2= Score3=;
run;
