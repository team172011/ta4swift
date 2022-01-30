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
    }
}
