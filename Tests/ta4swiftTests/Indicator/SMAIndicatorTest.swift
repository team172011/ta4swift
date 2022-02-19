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
    
    func testBarCount3() throws {
        let bars = createBars(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18)
        let barSeries = BarSeries(name: "Test", bars: bars)
        let close = ClosePriceIndicator()
        let sma = SMAIndicator(barCount: 3) { close }
        printValues(barSeries, sma)
        XCTAssertEqual(sma.calc(barSeries, 0), 1)
        XCTAssertEqual(sma.calc(barSeries, 1), 1.5)
        XCTAssertEqual(sma.calc(barSeries, 2), 2)
        XCTAssertEqual(sma.calc(barSeries, 3), 3)
        XCTAssertEqual(sma.calc(barSeries, 17), 17);
    }
    
    func testAnotherBarCount3() throws {
        let bars = createBars(1, 2, 3, 4, 3, 4, 5, 4, 3, 3, 4, 3, 2)
        let barSeries = BarSeries(name: "Test", bars: bars)
        let close = ClosePriceIndicator()
        let sma = SMAIndicator(barCount: 3) { close }
        printValues(barSeries, sma)
        XCTAssertEqual(sma.calc(barSeries, 0), 1)
        XCTAssertEqual(sma.calc(barSeries, 1), 1.5)
        XCTAssertEqual(sma.calc(barSeries, 2), 2)
        XCTAssertEqual(sma.calc(barSeries, 3), 3)
        XCTAssertEqual(sma.calc(barSeries, 9), 10/3.0)
        XCTAssertEqual(sma.calc(barSeries, 10), 10/3.0)
        XCTAssertEqual(sma.calc(barSeries, 11), 10/3.0)
        XCTAssertEqual(sma.calc(barSeries, 12), 3);
    }
    
    func testBarCount1ValueEqualToDataValue() {
        let barSeries = BarSeries(name: "Test", bars: createBars(1, 2, 3, 4, 3, 4, 5, 4, 3, 0, 9))
        let sma = SMAIndicator(barCount: 1){barSeries.close}
        
        for (index, value) in sma.values(for: barSeries).enumerated() {
            XCTAssertEqual(barSeries.close.calc(barSeries, index), value)
        }
    }
}
