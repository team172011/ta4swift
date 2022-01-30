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
    
    let falseRule = BooleanRule(false)
    let falseRule2 = BooleanRule(false)
    let trueRule = BooleanRule(true)
    let trueRule2 = BooleanRule(true)
    
    func testLogicRule() throws {

        let andRule = AndRule(rule1: falseRule, rule2: trueRule);
        
        XCTAssertFalse(andRule.isSatisfied(for: 0))
        XCTAssertFalse(andRule.isSatisfied(for: 5))
        XCTAssertFalse(andRule.isSatisfied(for: 100))
        
        let andRule2 = AndRule(rule1: trueRule, rule2: trueRule2)
        
        XCTAssertTrue(andRule2.isSatisfied(for: 0))
        XCTAssertTrue(andRule2.isSatisfied(for: 5))
        XCTAssertTrue(andRule2.isSatisfied(for: 100))
        
        let orRule = XOrRule(rule1: trueRule, rule2: falseRule)
        
        XCTAssertTrue(orRule.isSatisfied(for: 0))
        XCTAssertTrue(orRule.isSatisfied(for: 5))
        
        let orRule2 = OrRule(rule1: trueRule, rule2: trueRule2)
        
        XCTAssertTrue(orRule2.isSatisfied(for: 0))
        XCTAssertTrue(orRule2.isSatisfied(for: 5))
        
        let orRule3 = OrRule(rule1: falseRule, rule2: falseRule2)
        
        XCTAssertFalse(orRule3.isSatisfied(for: 0))
        XCTAssertFalse(orRule3.isSatisfied(for: 5))
        
        let xOrRule = OrRule(rule1: trueRule, rule2: falseRule)
        
        XCTAssertTrue(xOrRule.isSatisfied(for: 0))
        XCTAssertTrue(xOrRule.isSatisfied(for: 5))
        
        let xOrRule2 = XOrRule(rule1: trueRule, rule2: trueRule2)
        
        XCTAssertFalse(xOrRule2.isSatisfied(for: 0))
        XCTAssertFalse(xOrRule2.isSatisfied(for: 5))
    }

    func testCrossedDownRule() throws {
        let barSeries = BarSeries(name: "Test", bars: createBars(1,2,3,4,5,6,7,8,9,10,11,10,9,3,7,3,8,9,10))
        let close = barSeries.close;
        let rule = CrossedDownRule(indicator1: close, treshold: 4);
        printValues(rule, barSeries)
        XCTAssertFalse(rule.isSatisfied(for: 0))
        XCTAssertFalse(rule.isSatisfied(for: 3))
        XCTAssertFalse(rule.isSatisfied(for: 10))
        XCTAssertTrue(rule.isSatisfied(for: 13))
        XCTAssertTrue(rule.isSatisfied(for: 15))
    }

    func testCrossedUpRule() throws {
        let barSeries = BarSeries(name: "Test", bars: createBars(1,2,3,4,5,6,7,8,9,1,5,10,9,8,7,6,8,9,10))
        let close = barSeries.close;
        let rule = CrossedUpRule(indicator1: close, treshold: 4);
        printValues(rule, barSeries)
        XCTAssertFalse(rule.isSatisfied(for: 0))
        XCTAssertFalse(rule.isSatisfied(for: 3))
        XCTAssertTrue(rule.isSatisfied(for: 4))
        XCTAssertFalse(rule.isSatisfied(for: 9))
        XCTAssertTrue(rule.isSatisfied(for: 10))
        XCTAssertFalse(rule.isSatisfied(for: 13))
    }
}
