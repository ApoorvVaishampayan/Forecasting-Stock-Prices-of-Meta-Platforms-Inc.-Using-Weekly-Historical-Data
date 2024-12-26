# Forecasting-Stock-Prices-of-Meta-Platforms-Inc.-Using-Weekly-Historical-Data
**Forecasting Stock Prices of Meta Platforms Inc. Using Weekly Historical Data**  

**Authors:** Apoorv Vaishampayan   
**Date:** December 11, 2024  

## Overview  
This project forecasts the stock prices of Meta Platforms Inc. using weekly historical data spanning over 11 years (May 2012 to March 2024). The study employs advanced time series analysis techniques, including transformations, diagnostics, and ARIMA modeling, to provide insights into Meta's stock trends and predict future prices.  

## Table of Contents  
1. [Executive Summary](#executive-summary)  
2. [Discovery and Data Preparation](#discovery-and-data-preparation)  
3. [Model Diagnostics](#model-diagnostics)  
4. [Prediction](#prediction)  
5. [Conclusion](#conclusion)  
6. [References](#references)  

---

## Executive Summary  
Meta Platforms Inc.'s stock has shown significant fluctuations since its IPO in 2012. This analysis explores trends, seasonality, and key drivers like AI investments, renewable energy efforts, and metaverse spending, while addressing challenges such as competition and economic pressures. Utilizing stationarity techniques, we developed a predictive ARIMA(1,0,4) model to forecast future stock prices, aiding stakeholders in informed decision-making.  

---

## Discovery and Data Preparation  

### Data Source  
The dataset comprises 618 entries of weekly stock prices, including the following attributes:  
- **Opening Price**: Weekly starting price  
- **Closing Price**: Weekly ending price  
- **High/Low Price**: Weekly price range  
- **Volume**: Total shares traded  
- **Datetime**: Week-ending date  

### Data Transformation  
The data exhibited non-stationarity, as confirmed by the Augmented Dickey-Fuller (ADF) test (p = 0.8012). A log transformation followed by differencing achieved stationarity (p = 0.01).  

---

## Model Diagnostics  

### Selected Models and Evaluation  
Four models—MA(3), ARMA(1,4), ARMA(2,4), and ARMA(3,3)—were compared using the following metrics:  
- **Akaike Information Criterion (AIC)**  
- **Residual Cleanliness (ACF/PACF)**  
- **Box-Ljung Test (p-value)**  
- **Rolling Forecast Error**  

The ARIMA(1,0,4) model demonstrated:  
- Low AIC: -1870.995  
- Clean residuals with white noise (p = 0.9523)  
- No redundancy (roots outside the root circle)  

### Residual Analysis  
Plots of residuals, ACF, PACF, and polynomial roots confirmed the validity of the selected model.  

---

## Prediction  

Using ARIMA(1,0,4), we forecasted Meta's stock prices for the next 10 weeks, accounting for a 95% prediction interval. The model follows the overall upward trend with some deviations. This predictive analysis can guide investors and financial analysts in strategic decision-making.  

---

## Conclusion  
This study provides valuable insights into Meta's stock performance, highlighting the influence of AI, renewable energy, and financial strategies on its trajectory. The ARIMA-based model predicts a continued upward trend, though market volatility remains a key factor.  

---

## References  
- Meta Platforms Inc. (2024, December 10). [Meta Platforms (META) Price Prediction and Forecast 2025-2030](https://247wallst.com/technology-3/2024/12/10/meta-platforms-meta-price-prediction-and-forecast-2025-2030/)  
- MarketBeat. [Meta Platforms Inc. (META) Stock Chart](https://www.marketbeat.com/stocks/NASDAQ/META/chart/)  
- Barchart. [Meta Platforms Inc. (META) Price History](https://www.barchart.com/stocks/quotes/META/price-history/historical)  
- TradingView. [Meta Platforms Inc. (META) Stock Symbol](https://www.tradingview.com/symbols/NASDAQ-META/)  
