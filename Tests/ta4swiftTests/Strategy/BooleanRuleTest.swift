//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 25.01.22.
//

import Foundation
import XCTest

@testable import ta4swift

final class BooleanRuleTest: Ta4swiftTest {
    
    func testBooleanRule() throws {
        let barSeries = BarSeries(name: "Test");
        let trueRule = BooleanRule{ true }
        let falseRule = BooleanRule{ false }
        
        XCTAssertTrue(trueRule.isSatisfied(barSeries, for: 0))
        XCTAssertTrue(trueRule.isSatisfied(barSeries, for: 100))
        
        XCTAssertFalse(falseRule.isSatisfied(barSeries, for: 0))
        XCTAssertFalse(falseRule.isSatisfied(barSeries, for: 100))
    }
}
