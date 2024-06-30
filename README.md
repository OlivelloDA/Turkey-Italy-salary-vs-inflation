# Turkey-Italy-salary-vs-inflation
My girlfriend is Turkish and she has some debatable opinions about how Turkish vs Italian (or more in general EU) inflation rates will progress in the future.

She believes it would be easy to forecast what's gonna happen to inflation rates in the next 5-10 years in Europe. I had to show show her she's wrong. 

Data source: World Bank 

- Analysis of Turkey and Italian CPI inflation from 1998 to 2020.

- 6Y CPI inflation rate forecast comparison using ARIMA fitted on 22y yearly historical data.


# Findings
- The TRY time series show no stationarity and high autocorrelation even after differentiation
- The ITA time series show stationarity and low autocorrelation after differentiation
- For both ITA and TRY time series we cannot refuse independency of ARIMA residuals null hyphothesis. The model doesn't fit quite well with the time series.
- Based on the available time series data and the modelling technique used, it's difficult to forecast future CPI inflation rates for both countries, but more difficult for TRY.
  
![ITALY_inflation](https://github.com/OlivelloDA/Turkey-Italy-salary-vs-inflation/assets/81319553/16dd7ec1-58db-45c4-ac2f-93857d9a44e3)
![TRY_inflation](https://github.com/OlivelloDA/Turkey-Italy-salary-vs-inflation/assets/81319553/975ce8e1-eb57-48b5-a11d-24d160b8e93b)
