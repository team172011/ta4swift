//
//  TypicalPriceIndicatorTest.swift
//  
//
//  Created by Simon-Justus Wimmer on 03.03.22.
//

import Foundation
import XCTest

@testable import ta4swift

final class TypicalPriceIndicatorTest: Ta4swiftTest {

    
    func testCreationAndValues() {
        let barSeries = readAppleIncSeries("test")
        let typicalPriceIndicator = TypicalPriceIndicator()
        
        for (index, bar) in barSeries.bars.enumerated() {
            let value = typicalPriceIndicator.calc(barSeries, index)
            XCTAssertEqual(value, (bar.highPrice + bar.lowPrice + bar.closePrice) / 3)
        }
    }
}
