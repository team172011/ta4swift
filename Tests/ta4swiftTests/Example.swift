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
}
