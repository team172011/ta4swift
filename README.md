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
