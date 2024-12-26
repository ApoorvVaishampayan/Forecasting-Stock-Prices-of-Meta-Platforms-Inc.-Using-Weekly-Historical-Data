library(tseries)
library(TSA)
library(lmtest)
md = read.csv("META.US_W1.csv")
head(md)
summary(md)
sum(is.na(md))

summary(md)
head(md)
str(md)

md$datetime <- as.POSIXct(md$datetime)
str(md)

#Time series plot 
x = ts(md[, 5], start = c(2012,5), frequency = 52)
par(mfrow = c(1, 1))
plot(x, type='l', xlab='time', ylab='stock-market')
adf.test(x)

#Making data stationary
logx = log(x)
plot(logx, type='l', xlab='time', ylab='log(stock-market)')
adf.test(logx)

dlogx = diff(logx)

plot(dlogx, type='l', xlab='time', ylab='Diff(log(stock-market))')
adf.test(dlogx)


par(mfrow = c(1, 1))
acf(dlogx,main='Sample ACF of differenced log-stock-market data',lag = 300)
pacf(dlogx,main='Sample PACF of differenced log-stock-market data',lag = 300)

eacf(dlogx)

out = arima(dlogx, c(0, 0 , 3))
out
coeftest(out)	

out2 = arima(dlogx , c(1, 0, 4))
out2
coeftest(out2)

out3 = arima(dlogx , c(2, 0, 4))
out3
coeftest(out3)

out4 = arima(dlogx , c(3, 0, 3))
out4
coeftest(out4)

out11 = arima(dlogx , c(0, 0, 3), include.mean = T, fixed = c( 0 , 0 , 0, NA))
out11
coeftest(out11)

out21 = arima(dlogx , c(1, 0, 4), include.mean = F, fixed = c(NA, NA , 0 , 0 , NA))
out21
coeftest(out21)

out31 = arima(dlogx , c(2, 0, 4), include.mean = T, fixed = c(NA, NA , NA , NA , 0, 0,NA))
out31
coeftest(out31)

out41 = arima(dlogx , c(3, 0, 3), include.mean = T, fixed = c(NA, NA , NA , NA , NA, NA, NA))
out41
coeftest(out41)

AIC(out11)
BIC(out11)

AIC(out21)
BIC(out21)

AIC(out31)
BIC(out31)

AIC(out41)
BIC(out41)

Box.test(out11$residuals, lag = 12, type = 'Ljung')

par(mfrow = c(1, 3))
plot(out11$residuals, main = 'Residual for MA(3)')
acf(out11$residuals, main='Sample ACF for residual-MA(3)',lag = 300)
pacf(out11$residuals, main='Sample PACF for residual-MA(3))',lag = 300)

Box.test(out21$residuals, lag = 12, type = 'Ljung')

par(mfrow = c(1, 3))
plot(out21$residuals, main = 'Residual for ARMA(1,4)')
acf(out21$residuals, main='Sample ACF for residual-ARMA(1,4)',lag = 300)
pacf(out21$residuals, main='Sample PACF for residual-ARMA(1,4)',lag = 300)

Box.test(out31$residuals, lag = 12, type = 'Ljung')

par(mfrow = c(1, 3))
plot(out31$residuals, main = 'Residual for ARMA(2,4)')
acf(out31$residuals, main='Sample ACF for residual- ARMA(2,4)',lag = 300)
pacf(out31$residuals, main='Sample PACF for residual- ARMA(2,4)',lag = 300)

Box.test(out41$residuals, lag = 12, type = 'Ljung')

c
plot(out41$residuals, main = 'Residual for ARMA(3,3)')
acf(out41$residuals, main='Sample ACF for residual-ARMA(3,3)',lag = 300)
pacf(out41$residuals, main='Sample PACF for residual-ARMA(3,3)',lag = 300)


polyroot(c(1, -out21$coef[1]))
abs(polyroot(c(1, -out21$coef[1])))

polyroot(c(1, out21$coef[2:5]))
abs(polyroot(c(1, out21$coef[2:5])))

polyroot(c(1, -out31$coef[1:2]))
abs(polyroot(c(1, -out31$coef[1:2])))

polyroot(c(1, out31$coef[3:6]))
abs(polyroot(c(1, out31$coef[3:6])))

polyroot(c(1, -out41$coef[1:3]))
abs(polyroot(c(1, -out41$coef[1:3])))

polyroot(c(1, out41$coef[4:6]))
abs(polyroot(c(1, out41$coef[4:6])))

source("rolling.forecast.R")
rolling.forecast(dlogx,5, length(dlogx)-100, c(0,0,3))
rolling.forecast(dlogx,5, length(dlogx)-100, c(1,0,4))
rolling.forecast(dlogx,5, length(dlogx)-100, c(2,0,4))
rolling.forecast(dlogx,5, length(dlogx)-100, c(3,0,3))

par(mfrow = c(1, 1))
# Load required libraries

library(forecast)

# Predict next 10 weeks
pp <- predict(out21, n.ahead = 10)

# Get the last log-transformed value of the time series
last_log_value <- as.numeric(tail(logx, 1))

# Compute cumulative sum of predictions and transform back to original scale
log_predictions <- cumsum(pp$pred) + last_log_value
pred <- ts(exp(log_predictions), start = c(2023.8, 1), frequency = 52)

# Calculate 95% prediction intervals (upper and lower bounds)
pred.upp <- ts(exp(log_predictions + 2 * pp$se), start = c(2023.8, 1), frequency = 52)
pred.low <- ts(exp(log_predictions - 2 * pp$se), start = c(2023.8, 1), frequency = 52)


nb <- 615
nn <- length(logx)  # Total number of observations
tt <- (nn - nb ):nn  # Indices of historical data to include
start_year <- 2012  # Adjust the starting year based on your data set
xxx <- ts(x[tt], start = c(start_year, 5), frequency = 52)

# Plot the historical data and predictions with 95% confidence intervals
xlim <- c(2012, 2024)  # Set the x-axis limits
plot(xxx, type = 'o', pch = 3, xlim = xlim, ylim = rr,
     xlab = 'Time', ylab = 'Stock Price',
     main = 'Weekly Stock Price Prediction')

lines(pred, col = "red", lwd = 2)
lines(pred.upp, lty = 2, col = "red")
lines(pred.low, lty = 2, col = "red")

legend("topleft", legend = c("Historical Data", "Predicted Values", "Prediction Interval"),
       col = c("black", "red", "red"), pch = c(3, 2, NA), lty = c(NA, 1, 2))

