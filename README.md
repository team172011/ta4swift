# ta4swift

Technical analisy for swift. A swift package following [ta4j](https://github.com/ta4j/ta4j) to enable basic functionality for technical analysis of financial data.

## Example Code

### How to create a bar series, indicators, a strategy and execute the strategy
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

### How to create custom indicators

```swift
let myCustomIndicator = RawIndicator(){
    { // write your custom function into the trailing closure
    (series, index) in 
    return series.bars[index].closePrice / series.bars[index].highPrice
    }
}

// create an instance of your indicator with a cache
let myCachedIndicator = myCustomIndicator.cached
```

### How to combine indicators

```swift
let bars = createBars(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18)
let barSeries = BarSeries(name: "Test", bars: bars)
let close = barSeries.close
let constant = ConstantValueIndicator{ 10 }
let closePriceMinusTen = close.minus(constant)
let closePriceMinusTenAbs = closePriceMinusTen.abs()

```

### Re-use indicators and strategies to run it on different bar series
``` swift
    
    // Closure for creating an example strategy that can be reused
    let emaShortLongStrategy: () -> Strategy = {
        // create indicators
        let smaLong = SMAIndicator(barCount: 20)
        let smaShort = SMAIndicator(barCount: 10)
        
        // create rules based on indicators
        let exitRule = CrossedDownRule(indicator1: smaShort, indicator2: smaLong)
        let entryRule = CrossedUpRule(indicator1: smaShort, indicator2: smaLong)
        
        // create a strategy based on rules
        return BaseStrategy(entryRule: entryRule, exitRule: exitRule)
    }
    
    func testExampleWithTwoSeries() {
        
        // create two series with ohlcv data
        let applSeries = readAppleIncSeries("AAPL")
        let bitcoinSeries = readBitcoinSeries("Bitcoin-USD")
        
        // create a strategy
        let strategy = emaShortLongStrategy()
        
        // run the strategy on both series
        let tradingRecords = Runner.run(barSeries: [applSeries, bitcoinSeries], strategy: strategy, type: .buy)
        
        // print result of runs
        let appleSeriesName = applSeries.name
        print("Result of run for \(appleSeriesName)")
        for (index, position) in tradingRecords[appleSeriesName]!.positions.enumerated() {
            print("Position \(index): \(position)")
        }
        
        let bitcoinSeriesName = bitcoinSeries.name
        print("Result of run for \(bitcoinSeriesName)")
        for (index, position) in tradingRecords[bitcoinSeriesName]!.positions.enumerated() {
            print("Position \(index): \(position)")
        }
    }

```
``` text

Result of run for AAPL
Position 0: Position[Entry: buy at: 32 Exit: sell at: 37]
Position 1: Position[Entry: buy at: 53 Exit: sell at: 65]
Position 2: Position[Entry: buy at: 84 Exit: sell at: 98]
Position 3: Position[Entry: buy at: 106 Exit: sell at: 113]
Position 4: Position[Entry: buy at: 132 Exit: sell at: 172]
Position 5: Position[Entry: buy at: 189 Exit: sell at: 219]
Position 6: Position[Entry: buy at: 227 Exit: sell at: 247]
Result of run for Bitcoin-USD
Position 0: Position[Entry: buy at: 26 Exit: sell at: 48]
Position 1: Position[Entry: buy at: 56 Exit: sell at: 143]
Position 2: Position[Entry: buy at: 152 Exit: sell at: 179]
Position 3: Position[Entry: buy at: 180 Exit: sell at: 182]
Position 4: Position[Entry: buy at: 201 Exit: sell at: 214]
Position 5: Position[Entry: buy at: 235 Exit: sell at: 246]
Position 6: Position[Entry: buy at: 271 Exit: sell at: 276]
Position 7: Position[Entry: buy at: 285 Exit: sell at: 301]
Position 8: Position[Entry: buy at: 328 Exit: sell at: 330]
Position 9: Position[Entry: buy at: 345 Exit: sell at: 403]
Position 10: Position[Entry: buy at: 437 Exit: sell at: 460]
Position 11: Position[Entry: buy at: 463 Exit: sell at: 496]
Position 12: Position[Entry: buy at: 504 Exit: sell at: 516]
Position 13: Position[Entry: buy at: 543 Exit: sell at: 550]
Position 14: Position[Entry: buy at: 554 Exit: sell at: 589]
Position 15: Position[Entry: buy at: 613 Exit: sell at: 622]
Position 16: Position[Entry: buy at: 631 Exit: sell at: 736]
Position 17: Position[Entry: buy at: 750 Exit: sell at: 776]
Position 18: Position[Entry: buy at: 784 Exit: sell at: 800]
Position 19: Position[Entry: buy at: 808 Exit: sell at: 828]
Position 20: Position[Entry: buy at: 840 Exit: sell at: 850]
Position 21: Position[Entry: buy at: 881 Exit: sell at: 890]
Position 22: Position[Entry: buy at: 902 Exit: sell at: 908]
Position 23: Position[Entry: buy at: 923 Exit: sell at: 970]
Position 24: Position[Entry: buy at: 993 Exit: sell at: 1020]
Position 25: Position[Entry: buy at: 1026 Exit: sell at: 1038]
Position 26: Position[Entry: buy at: 1075 Exit: sell at: 1083]

```
