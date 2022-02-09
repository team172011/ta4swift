//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 25.01.22.
//

import Foundation
import XCTest

@testable import ta4swift

final class SMAIndicatorTest: Ta4swiftTest {
    
    func testCreation() throws {
        let bars = createBars(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18)
        let barSeries = BarSeries(name: "Test", bars: bars)
        let close = ClosePriceIndicator()
        let sma = SMAIndicator(indicator: close, barCount: 3)
        printValues(barSeries, sma)
        XCTAssertTrue(sma.calc(barSeries, 0) == 0, "SMA of index 0 should return 0")
        XCTAssertTrue(sma.calc(barSeries, 1) == 0, "SMA of index 1 should return 0")
        XCTAssertTrue(sma.calc(barSeries, 3) == 3)
        XCTAssertTrue(sma.calc(barSeries, 17) == 17);
    }
}
