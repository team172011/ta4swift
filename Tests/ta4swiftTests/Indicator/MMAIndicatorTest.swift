//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 20.02.22.
//

import Foundation
import XCTest

@testable import ta4swift

final class MMAIndicatorTest: Ta4swiftTest {
    
    func testUsingBarCount10() throws {
        let barSeries = BarSeries(name: "Test", bars: createBars(64.75, 63.79, 63.73, 63.73, 63.55, 63.19, 63.91, 63.85, 62.95, 63.37,61.33, 61.51))
        let mma = MMAIndicator(barCount: 10) { barSeries.close }
        printValues(barSeries, mma)
        XCTAssertEqual(63.998335482039984, mma.calc(barSeries, 9))
        XCTAssertEqual(63.731501933835986, mma.calc(barSeries, 10))
        XCTAssertEqual(63.50935174045239, mma.calc(barSeries, 11))
    }
    
    func testFirstValueShouldBeEqualsToFirstDataValue() {
        let barSeries = BarSeries(name: "Test", bars: createBars(64.75, 63.79, 63.73, 63.73, 63.55, 63.19, 63.91, 63.85, 62.95, 63.37,61.33, 61.51))
        let mma = MMAIndicator(barCount: 10) { barSeries.close }
        printValues(barSeries, mma)
        
        XCTAssertEqual(64.75, mma.calc(barSeries, 0))
    }
}
