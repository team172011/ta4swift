# ta4swift

## Content

- [About this library](#aboutthislib)
    - [Concept and key elements](#conceptandkeyelements)
        - [BarSeries](#barseries)
        - [Indicator](#indicator)
        - [Rule](#rule)
        - [Strategy](#strategy)
- [Example Code](#examplecode) 

<a name="aboutthislib"></a>
## About this library
Technical analisy for swift. A swift package following [ta4j](https://github.com/ta4j/ta4j) to enable basic functionality for technical analysis of financial data.

<a name="conceptandkeyelements"></a>
### Concept and key elements
The focus of this library lays on easy to use structs and classes enabling basic functionality to create and use indicators, trading rules and combine them into a strategy. Strategies can be used for backtesting or live trading with a trading bot.

<a name="barseries"></a>
#### BarSeries
A `BarSeries` is a class containing a **name** property and an array of `Bars`. It represents an symbol (like AAPL stocks) or an any other financial time series that should be analysed (like a crypto currency or futures).

- the **name** property should identify this bar series
- each `Bar` in the **bars** property represents a timestamp with *open*, *high*, *low*, *closed* and *volume data*

<a name="indicator"></a>
#### Indicator 
Indicators are *structs* that store a specific formular as a property called `calc`. The formular is defined as a closure and describes how a value of this indicator for a specific index is calcuated:
- `public typealias calcFuncTypeValue = (BarSeries, Int) -> Double`
    - the closure takes two arguments: the `BarSeries` on that this inidcator should be applied on and the *index* for which the value should be calculated. The index and the corresponding barSeries must be provided for each call of the closure.
    - as an example, the **calc** closure for the `SMAIndicator` would look like this:
    ``` swift
        let calc: calcFuncTypeValue = { barSeries, index in
        var sum = 0.0
        for i in Swift.max(0, index - barCount + 1)...index {
            sum += indicator.calc(barSeries, i)
        }
        return sum / Double(Swift.min(barCount, index + 1))
        }
    ```

<a name="rule"></a>
#### Rule 
*(in progress...)*

<a name="strategy"></a>
#### Strategy 
*(in progress...)*

<a name="examplecode"></a>
## Example Code

### 1 How to create a bar series, indicators, a strategy and execute the strategy
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

### 2 How to create custom indicators

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

### 3 How to combine indicators

```swift
let bars = createBars(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18)
let barSeries = BarSeries(name: "Test", bars: bars)
let close = barSeries.close
let constant = ConstantValueIndicator{ 10 }
let closePriceMinusTen = close.minus(constant)
let closePriceMinusTenAbs = closePriceMinusTen.abs()

```

### 4 Combine indicators for further calculations

```
let aaplSeries = readAppleIncSeries("AAPL")

let variance = VarianceIndicator(barCount: 10) { aaplSeries.close }

let standardDeciatationValues = variance.sqrt().valueMap(for: aaplSeries)
let varianceValues = variance.valueMap(for: aaplSeries)

for (date, value) in varianceValues{
    print("Variance(10) for \(date): \(value)")
    print("Standard Deviatation (10) for \(date): \(standardDeciatationValues[date]!)")
}
```

### 5 Re-use indicators and strategies to run it on different bar series
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
(...)
Position 20: Position[Entry: buy at: 840 Exit: sell at: 850]
Position 21: Position[Entry: buy at: 881 Exit: sell at: 890]
Position 22: Position[Entry: buy at: 902 Exit: sell at: 908]
Position 23: Position[Entry: buy at: 923 Exit: sell at: 970]
Position 24: Position[Entry: buy at: 993 Exit: sell at: 1020]
Position 25: Position[Entry: buy at: 1026 Exit: sell at: 1038]
Position 26: Position[Entry: buy at: 1075 Exit: sell at: 1083]

```
