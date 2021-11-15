library(ggplot2)
library(dplyr)
library(readxl)
library(readr)
library(forecast)
work_dir <- "/Users/claudioolivelli/Documents/GitHub/Python lab/Turkey-Italy-salary-vs-inflation"
data <- data.frame(read_csv2("/Users/claudioolivelli/Documents/GitHub/Python lab/Turkey-Italy-salary-vs-inflation/Inflation_rates.csv"))
data <- data[,2:3]

date <- c("1998":"2020")
TRY_inflation <- data[,1]
ITA_inflation <- data[,2]
p <- ggplot(data ,aes(date))+
  geom_line(aes(y = TRY_inflation, colour = "TRY")) + 
  geom_line(aes(y = ITA_inflation, colour = "ITA")) +
  ylab("Yearly Inflation rates 1998 - 2020") 
p

acf(ITA_inflation)
acf(TRY_inflation[c(-1:-7)])
Box.test(ITA_inflation,lag=9,type="Ljung-Box") #pvalue <0.05 I cannot refuse the null hyph of null acf. I tried also with different lags
Box.test(TRY_inflation[c(-1:-7)],lag=4,type="Ljung-Box") #pvalue <0.05 I cannot refuse the null hyph of null acf. I tried also with different lags

ita_auto = auto.arima(ITA_inflation, max.p = 4 , max.q = 4 , ic = "bic", trace = FALSE)
summary(ita_auto)
auto.arima(TRY_inflation, max.p = 4 , max.q = 4 , ic = "bic", trace = FALSE)


fitAR1=arima(ITA_inflation,order=c(0,1,0))
print(fitAR1)
plot(residuals(fitAR1))
acf(residuals(fitAR1))
Box.test(residuals(fitAR1),lag=2,type="Ljung-Box",fitdf=1)