library(ggplot2)
library(dplyr)
library(readxl)
library(readr)
library(forecast)
library(tseries)
work_dir <- "/Users/claudioolivelli/Documents/Github proj"
data <- data.frame(read_csv2("/Users/claudioolivelli/Documents/Github proj/Inflation_rates.csv"))
data <- data[,2:3]

date <- c("1998":"2020")
TRY_inflation <- data[,1]
ITA_inflation <- data[,2]
p <- ggplot(data ,aes(date))+
  geom_line(aes(y = TRY_inflation, colour = "TRY")) + 
  geom_line(aes(y = ITA_inflation, colour = "ITA")) +
  ylab("Yearly Inflation rates 1998 - 2020") 
p

#Test stationarity of time series
adf.test(ITA_inflation) # p-value = 0.3905, cannot refuse null hyphotesis of non-stationarity.
adf.test(ITA_inflation) # p-value = 0.0978, cannot refuse null hyphotesis of non-stationarity.

ITA_inflation_diff <- diff(ITA_inflation)
adf.test(ITA_inflation_diff) # p-value = 0.01939, I can refuse null hyphotesis of non-stationarity.
TRY_inflation_diff <- diff(TRY_inflation)
adf.test(TRY_inflation_diff) # p-value = 0.4212, cannot refuse null hyphotesis of non-stationarity. Differencing data increase p-value!


#Test indipendency of the time series
acf(ITA_inflation_diff)
acf(TRY_inflation[c(-1:-7)])
Box.test(ITA_inflation_diff,lag=9,type="Ljung-Box") #pvalue >0.05 I cannot refuse the null hyph. The test has been performed with multiple lag values obtaining the same results.
Box.test(TRY_inflation[c(-1:-7)],lag=4,type="Ljung-Box") #pvalue <0.05 I cannot refuse the null hyph. The test has been performed with multiple lag values obtaining the same results.

ita_arima = auto.arima(ITA_inflation_diff, max.p = 4 , max.q = 4 , ic = "bic", trace = FALSE)
summary(ita_auto) #bad results, but better than the fit on TRY time series, lower AIC/BIC and higher log-likelihood.
try_arima = auto.arima(TRY_inflation, max.p = 4 , max.q = 4 , ic = "bic", trace = FALSE)
summary(try_arima) #quite bad results, high AIC/BIC and low log-likelihood.

#Test independency of the residuals
fitAR1=arima(ITA_inflation_diff,order=c(0,1,0)) #fitting the best arima found by auto.arima
print(fitAR1)
plot(residuals(fitAR1))
acf(residuals(fitAR1))
Box.test(residuals(fitAR1),lag=2,type="Ljung-Box",fitdf=1) 
#pvalue < 0.05. I refuse the null hyph of residuals independency. The model is not a good fit for this time series.


fitAR2=arima(TRY_inflation,order=c(0,2,0)) #fitting the best arima found by auto.arima
print(fitAR2)
plot(residuals(fitAR2))
acf(residuals(fitAR2))
Box.test(residuals(fitAR2),lag=2,type="Ljung-Box",fitdf=1) 
#pvalue <0.05 I cannot refuse the null hyph of residuals independency. The model is not a good fit for this time series.

TRY_forecast <- forecast(fitAR2, h=6)
plot(TRY_forecast, main = "Turkey CPI Inflation Rate 6Y forecast ")


ITA_forecast <- forecast(fitAR1, h=6)
plot(ITA_forecast, main = "Italy CPI Inflation Rate 6Y forecast ")

