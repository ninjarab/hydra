# Hydra

Hydra is a free tool for predicting stock prices using technical analysis powered
by Elixir GenStage feed with data from [IEX](https://iextrading.com/developer/docs/).


Investors and traders typically employ two classes of tools to decide what stocks
to buy and sell; fundamental and technical analysis, both of which aim at analyzing
and predicting shifts in supply and demand.

While fundamental analysis involves the study of company fundamentals such as revenues
and expenses, market position, annual growth rates, and so on, technical analysis is solely
concerned with price and volume data, particularly price patterns and volume spikes.

The technical analysis will rely on the following methods:

| Feature/Agent            | Generated Values            |
| -------------------------|-----------------------------|
| Trend                    | Uptrend, Downtrend, Notrend |
| Moving Average Crossover | Buy, Sell, Hold             |
| Candlestick              | Buy, Sell, Hold             |
| Stochastic               | Buy, Sell, Hold             |
| Volume                   | Strong-Volume, Weak-Volume  |
| ADX                      | Strong-Trend, Weak-Trend    |

Inspired by [Predicting Stock Prices Using Technical Analysis and Machine Learning](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.174.8858&rep=rep1&type=pdf) from Jan Ivar Larsen, Norwegian Institute of Science and Technology.
