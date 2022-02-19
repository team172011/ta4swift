//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 30.01.22.
//

import Foundation
import XCTest

@testable import ta4swift

final class Example: Ta4swiftTest {
    
    // Example 1
    func testBasicExample() {
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
    }
    
    // Example 2
    
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
    
    // Example 3
    
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
    
    // Example 4
    
    func testExampleWithValues() {
        let aaplSeries = readAppleIncSeries("AAPL")
        
        let variance = VarianceIndicator(barCount: 10) { aaplSeries.close }
        
        let standardDeciatationValues = variance.sqrt().valueMap(for: aaplSeries)
        let varianceValues = variance.valueMap(for: aaplSeries)
        
        for (date, value) in varianceValues{
            print("Variance(10) for \(date): \(value)")
            print("Standard Deviatation (10) for \(date): \(standardDeciatationValues[date]!)")
        }
    }
}
