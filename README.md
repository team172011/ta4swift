# ta4swift

Technical analisy for swift. A swift package following [ta4j](https://github.com/ta4j/ta4j) to enable basic functionality for technical analysis of financial data.

## Example Code

``` swift
let applSeries = readAppleIncSeries("AAPL")
let smaLong = applSeries.sma(barCount: 20)
let smaShort = applSeries.sma(barCount: 10)

let exitRule = CrossedDownRule(indicator1: smaShort, indicator2: smaLong)
let entryRule = CrossedUpRule(indicator1: smaShort, indicator2: smaLong)

let strategy = BaseStrategy(entryRule: entryRule, exitRule: exitRule)
let tradingRecord = BaseTradingRecord()

for (index, bar) in applSeries.bars.enumerated() {
    
    if(strategy.shouldEnter(index: index, record: tradingRecord)) {
        print("Enter signal at index \(index) for bar \(bar)")
    }
    
    if(strategy.shouldExit(index: index, record: tradingRecord)) {
        print("Exit signal at index \(index) for bar \(bar)")
    }
}
```
``` text
Enter at index 32 for bar Bar(openPrice: 461.1, highPrice: 462.73, lowPrice: 453.85, closePrice: 459.99, volume: 15563700, date: 2022-01-31 17:31:16 +0000)
Exit at index 37 for bar Bar(openPrice: 443.82, highPrice: 451.54, lowPrice: 437.66, closePrice: 448.97, volume: 17910700, date: 2022-01-31 17:31:16 +0000)
Enter at index 53 for bar Bar(openPrice: 457.42, highPrice: 457.63, lowPrice: 449.59, closePrice: 452.08, volume: 11023600, date: 2022-01-31 17:31:16 +0000)
Exit at index 65 for bar Bar(openPrice: 424.85, highPrice: 427.5, lowPrice: 422.49, closePrice: 426.21, volume: 10743900, date: 2022-01-31 17:31:16 +0000)
Enter at index 84 for bar Bar(openPrice: 451.31, highPrice: 453.23, lowPrice: 449.15, closePrice: 449.98, volume: 12903600, date: 2022-01-31 17:31:16 +0000)
Exit at index 98 for bar Bar(openPrice: 435.95, highPrice: 446.16, lowPrice: 435.79, closePrice: 442.14, volume: 12607900, date: 2022-01-31 17:31:16 +0000)
Enter at index 106 for bar Bar(openPrice: 445.65, highPrice: 450.72, lowPrice: 443.71, closePrice: 445.11, volume: 10378200, date: 2022-01-31 17:31:16 +0000)
Exit at index 113 for bar Bar(openPrice: 435.4, highPrice: 436.29, lowPrice: 428.5, closePrice: 430.05, volume: 9709500, date: 2022-01-31 17:31:16 +0000)
Enter at index 132 for bar Bar(openPrice: 427.65, highPrice: 429.79, lowPrice: 423.41, closePrice: 426.51, volume: 9984400, date: 2022-01-31 17:31:16 +0000)
Exit at index 172 for bar Bar(openPrice: 505.0, highPrice: 507.92, lowPrice: 503.48, closePrice: 506.17, volume: 12167400, date: 2022-01-31 17:31:16 +0000)
Enter at index 189 for bar Bar(openPrice: 485.63, highPrice: 491.8, lowPrice: 483.75, closePrice: 489.56, volume: 10328000, date: 2022-01-31 17:31:16 +0000)
Exit at index 219 for bar Bar(openPrice: 518.0, highPrice: 522.25, lowPrice: 516.96, closePrice: 520.63, volume: 7043600, date: 2022-01-31 17:31:16 +0000)
Enter at index 227 for bar Bar(openPrice: 521.02, highPrice: 525.87, lowPrice: 521.0, closePrice: 523.74, volume: 8189700, date: 2022-01-31 17:31:16 +0000)
Exit at index 247 for bar Bar(openPrice: 569.89, highPrice: 571.88, lowPrice: 566.03, closePrice: 567.67, volume: 5984100, date: 2022-01-31 17:31:16 +0000)
Created 7 positions:
Position 0: BasePosition(entry: Optional(ta4swift.BaseTrade(type: ta4swift.TradeType.BUY, index: 32)), exit: Optional(ta4swift.BaseTrade(type: ta4swift.TradeType.SELL, index: 37)))
Position 1: BasePosition(entry: Optional(ta4swift.BaseTrade(type: ta4swift.TradeType.BUY, index: 53)), exit: Optional(ta4swift.BaseTrade(type: ta4swift.TradeType.SELL, index: 65)))
Position 2: BasePosition(entry: Optional(ta4swift.BaseTrade(type: ta4swift.TradeType.BUY, index: 84)), exit: Optional(ta4swift.BaseTrade(type: ta4swift.TradeType.SELL, index: 98)))
Position 3: BasePosition(entry: Optional(ta4swift.BaseTrade(type: ta4swift.TradeType.BUY, index: 106)), exit: Optional(ta4swift.BaseTrade(type: ta4swift.TradeType.SELL, index: 113)))
Position 4: BasePosition(entry: Optional(ta4swift.BaseTrade(type: ta4swift.TradeType.BUY, index: 132)), exit: Optional(ta4swift.BaseTrade(type: ta4swift.TradeType.SELL, index: 172)))
Position 5: BasePosition(entry: Optional(ta4swift.BaseTrade(type: ta4swift.TradeType.BUY, index: 189)), exit: Optional(ta4swift.BaseTrade(type: ta4swift.TradeType.SELL, index: 219)))
Position 6: BasePosition(entry: Optional(ta4swift.BaseTrade(type: ta4swift.TradeType.BUY, index: 227)), exit: Optional(ta4swift.BaseTrade(type: ta4swift.TradeType.SELL, index: 247)))
```
