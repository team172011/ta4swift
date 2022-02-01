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
        var tradingRecord = BaseTradingRecord()
        
        for (index, bar) in applSeries.bars.enumerated() {
            if(strategy.shouldEnter(index: index, record: tradingRecord)) {
                if(strategy.canEnter(record: tradingRecord)) {
                    print("Enter at index \(index) for bar \(bar)")
                    try! tradingRecord.addPosition(with: BaseTrade(type: TradeType.BUY, index: index))
                }
            }
            
            if(strategy.shouldExit(index: index, record: tradingRecord)) {
                if(strategy.canExit(record: tradingRecord)) {
                    print("Exit at index \(index) for bar \(bar)")
                    try! tradingRecord.closePosition(with: BaseTrade(type: TradeType.SELL, index: index))
                }
            }
        }
        
        print("Created \(tradingRecord.positions.count) positions:")
        
        for (index, position) in tradingRecord.positions.enumerated() {
            print("Position \(index): \(position)")
        }
        
    }
}
