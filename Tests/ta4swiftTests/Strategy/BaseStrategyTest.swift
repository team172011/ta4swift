//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 17.01.22.
//

import Foundation
import ta4swift
import XCTest

public class BaseStrategyTest: Ta4swiftTest {
    
    func testCreateStrategy() throws {
        let barSeries = BarSeries(name: "Test", bars: createBars(1,2,3,4,5,6,7,8,9,1,5,10,9,8,7,6,8,9,10))
        let close = barSeries.close;
        let entryRule = CrossedUpRule(indicator1: close, treshold: 4);
        let exitRule = CrossedDownRule(indicator1: close, treshold: 4);
        
        var strategy = BaseStrategy(entryRule: entryRule, exitRule: exitRule)
        
        XCTAssertTrue(strategy.unstablePeriod == 0)
        XCTAssertFalse(strategy.isUnstableAt(index: 0))
        XCTAssertFalse(strategy.isUnstableAt(index: 1))
        
        strategy.unstablePeriod = 2
        
        XCTAssertTrue(strategy.isUnstableAt(index: 0))
        XCTAssertTrue(strategy.isUnstableAt(index: 1))
        XCTAssertFalse(strategy.isUnstableAt(index: 2))
    }
    
    func testIsSatisfied() {
        let barSeries = BarSeries(name: "Test", bars: createBars(1,2,3,4,5,6,7,8,9,1,5,10,9,8,7,6,8,9,10))
        let entryRule = BooleanRule{ true }
        let exitRule = BooleanRule{ false }
        
        let strategy = BaseStrategy(entryRule: entryRule, exitRule: exitRule)
        let tradingRecord = BaseTradingRecord()
        
        XCTAssertTrue(strategy.shouldEnter(barSeries, index: 0, record: tradingRecord))
        XCTAssertTrue(strategy.shouldEnter(barSeries, index: 1, record: tradingRecord))
        
        XCTAssertFalse(strategy.shouldExit(barSeries, index: 1, record: tradingRecord))
        XCTAssertFalse(strategy.shouldExit(barSeries, index: 1, record: tradingRecord))
    }
}
