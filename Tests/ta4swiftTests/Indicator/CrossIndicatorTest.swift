//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 04.02.22.
//

import Foundation
import XCTest
@testable import ta4swift

final class CrossIndicatorTest: Ta4swiftTest {
    
    func testCreation() throws {
        let bars = createBars(1,2,3,4,5,6,7,8,9,5,6,7,10,10,10,8,8,8,6)
        let barSeries = BarSeries(name: "Test", bars: bars)
        let close = barSeries.close
        let sma = CrossedIndicator(indicator1: close, constant: 8)
        
        XCTAssertFalse(sma.f(barSeries, 0))
        XCTAssertFalse(sma.f(barSeries, 1))
        XCTAssertTrue(sma.f(barSeries, 9))
        XCTAssertTrue(sma.f(barSeries, 18))
    }
}
