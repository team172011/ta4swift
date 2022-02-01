# ta4swift

Technical analisy for swift. A swift package following [ta4j](https://github.com/ta4j/ta4j) to enable basic functionality for technical analysis of financial data.

## Example Code

``` swift
// create a series with ohlcv data
let applSeries = readAppleIncSeries("AAPL")

// create indicators
let smaLong = applSeries.sma(barCount: 20)
let smaShort = applSeries.sma(barCount: 10)

// create rules based on indicators
let exitRule = CrossedDownRule(indicator1: smaShort, indicator2: smaLong)
let entryRule = CrossedUpRule(indicator1: smaShort, indicator2: smaLong)

// create a strategy based on rules
let strategy = BaseStrategy(entryRule: entryRule, exitRule: exitRule)

// run the strategy on the series
let tradingRecord = Runner.run(barSeries: applSeries, strategy: strategy, type: .buy)

// print result of run
for (index, position) in tradingRecord.positions.enumerated() {
    print("Position \(index): \(position)")
}
```
``` text
Position 0: Position[Entry: buy at: 32 Exit: sell at: 37]
Position 1: Position[Entry: buy at: 53 Exit: sell at: 65]
Position 2: Position[Entry: buy at: 84 Exit: sell at: 98]
Position 3: Position[Entry: buy at: 106 Exit: sell at: 113]
Position 4: Position[Entry: buy at: 132 Exit: sell at: 172]
Position 5: Position[Entry: buy at: 189 Exit: sell at: 219]
Position 6: Position[Entry: buy at: 227 Exit: sell at: 247]
```
