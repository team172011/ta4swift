//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 04.02.22.
//

import Foundation
import XCTest
@testable import ta4swift

final class IndicatorTest: Ta4swiftTest {
    
    func testUsageOnDifferentBaseries() {
        let barSeriesA = BarSeries(name: "A", bars: createBars(1,2,3,4,5,6,7))
        let barSeriesB = BarSeries(name: "B", bars: createBars(8,9,10,11,12,13,14))
        
        let close = ClosePriceIndicator()
        XCTAssertEqual(1, close.f(barSeriesA, 0))
        XCTAssertEqual(2, close.f(barSeriesA, 1))
        XCTAssertEqual(6, close.f(barSeriesA, 5))
        XCTAssertEqual(7, close.f(barSeriesA, 6))

        XCTAssertEqual(8, close.f(barSeriesB, 0))
        XCTAssertEqual(9, close.f(barSeriesB, 1))
        XCTAssertEqual(13, close.f(barSeriesB, 5))
        XCTAssertEqual(14, close.f(barSeriesB, 6))
        
    }
}
