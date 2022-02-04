//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 24.01.22.
//

import Foundation
@testable import ta4swift
import XCTest

final class RuleTes: Ta4swiftTest {
    
    let falseRule = BooleanRule{ false }
    let falseRule2 = BooleanRule{ false }
    let trueRule = BooleanRule{ true }
    let trueRule2 = BooleanRule{ true }
    
    func testLogicRule() throws {
        let barSeries = BarSeries(name: "Test", bars: createBars(1,2,3,4,5,6,7,8,9,10,11,10,9,3,7,3,8,9,10))
        let andRule = AndRule{[falseRule, trueRule]};
        
        XCTAssertFalse(andRule.isSatisfied(barSeries, for: 0))
        XCTAssertFalse(andRule.isSatisfied(barSeries, for: 5))
        XCTAssertFalse(andRule.isSatisfied(barSeries, for: 100))
        
        let andRule2 = AndRule{[trueRule, trueRule2]}
        
        XCTAssertTrue(andRule2.isSatisfied(barSeries, for: 0))
        XCTAssertTrue(andRule2.isSatisfied(barSeries, for: 5))
        XCTAssertTrue(andRule2.isSatisfied(barSeries, for: 100))
        
        let orRule = XOrRule{(trueRule, falseRule)}
        
        XCTAssertTrue(orRule.isSatisfied(barSeries, for: 0))
        XCTAssertTrue(orRule.isSatisfied(barSeries, for: 5))
        
        let orRule2 = OrRule{[trueRule, trueRule2]}
        
        XCTAssertTrue(orRule2.isSatisfied(barSeries, for: 0))
        XCTAssertTrue(orRule2.isSatisfied(barSeries, for: 5))
        
        let orRule3 = OrRule{[falseRule, falseRule2]}
        
        XCTAssertFalse(orRule3.isSatisfied(barSeries, for: 0))
        XCTAssertFalse(orRule3.isSatisfied(barSeries, for: 5))
        
        let xOrRule = OrRule{[trueRule, falseRule]}
        
        XCTAssertTrue(xOrRule.isSatisfied(barSeries, for: 0))
        XCTAssertTrue(xOrRule.isSatisfied(barSeries, for: 5))
        
        let xOrRule2 = XOrRule{(trueRule, trueRule2)}
        
        XCTAssertFalse(xOrRule2.isSatisfied(barSeries, for: 0))
        XCTAssertFalse(xOrRule2.isSatisfied(barSeries, for: 5))
    }

    func testCrossedDownRule() throws {
        let barSeries = BarSeries(name: "Test", bars: createBars(1,2,3,4,5,6,7,8,9,10,11,10,9,3,7,3,8,9,10))
        let close = barSeries.close;
        let rule = CrossedDownRule(indicator1: close, treshold: 4);
        printValues(rule, barSeries)
        XCTAssertFalse(rule.isSatisfied(barSeries, for: 0))
        XCTAssertFalse(rule.isSatisfied(barSeries, for: 3))
        XCTAssertFalse(rule.isSatisfied(barSeries, for: 10))
        XCTAssertTrue(rule.isSatisfied(barSeries, for: 13))
        XCTAssertTrue(rule.isSatisfied(barSeries, for: 15))
    }

    func testCrossedUpRule() throws {
        let barSeries = BarSeries(name: "Test", bars: createBars(1,2,3,4,5,6,7,8,9,1,5,10,9,8,7,6,8,9,10))
        let close = barSeries.close;
        let rule = CrossedUpRule(indicator1: close, treshold: 4);
        printValues(rule, barSeries)
        XCTAssertFalse(rule.isSatisfied(barSeries, for: 0))
        XCTAssertFalse(rule.isSatisfied(barSeries, for: 3))
        XCTAssertTrue(rule.isSatisfied(barSeries, for: 4))
        XCTAssertFalse(rule.isSatisfied(barSeries, for: 9))
        XCTAssertTrue(rule.isSatisfied(barSeries, for: 10))
        XCTAssertFalse(rule.isSatisfied(barSeries, for: 13))
    }
}
