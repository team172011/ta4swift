//
//  VarianceIndicatorTest.swift
//  
//
//  Created by Simon-Justus Wimmer on 17.02.22.
//

import Foundation
import XCTest
@testable import ta4swift

final class VarianceIndicatorTest: Ta4swiftTest {
    
    func testBarCount4() {
        let barSeries = BarSeries(name: "Test", bars: createBars(1, 2, 3, 4, 3, 4, 5, 4, 3, 0, 9))
        let varianceIndicator = VarianceIndicator(barCount: 4){ barSeries.close }
        
        XCTAssertEqual(0, varianceIndicator.calc(barSeries, 0))
        XCTAssertEqual(0.25, varianceIndicator.calc(barSeries, 1))
        XCTAssertEqual(2.0/3, varianceIndicator.calc(barSeries, 2))
        XCTAssertEqual(1.25, varianceIndicator.calc(barSeries, 3))
        XCTAssertEqual(0.5, varianceIndicator.calc(barSeries, 4))
        XCTAssertEqual(0.25, varianceIndicator.calc(barSeries, 5))
        XCTAssertEqual(0.5, varianceIndicator.calc(barSeries, 6))
        XCTAssertEqual(0.5, varianceIndicator.calc(barSeries, 7))
        XCTAssertEqual(0.5, varianceIndicator.calc(barSeries, 8))
        XCTAssertEqual(3.5, varianceIndicator.calc(barSeries, 9))
        XCTAssertEqual(10.5, varianceIndicator.calc(barSeries, 10))
    }
    
    func testBarCount1Variance0() {
        let barSeries = BarSeries(name: "Test", bars: createBars(1, 2, 3, 4, 3, 4, 5, 4, 3, 0, 9))
        let varianceIndicator = VarianceIndicator(barCount: 1){barSeries.close}
        
        for value in varianceIndicator.values(for: barSeries) {
            XCTAssertEqual(0, value)
        }
        
    }
    
    func testBarCount2() {
        let barSeries = BarSeries(name: "Test", bars: createBars(1, 2, 3, 4, 3, 4, 5, 4, 3, 0, 9))
        let varianceIndicator = VarianceIndicator(barCount: 2){barSeries.close}
        
        XCTAssertEqual(0, varianceIndicator.calc(barSeries, 0))
        XCTAssertEqual(0.25, varianceIndicator.calc(barSeries, 1))
        XCTAssertEqual(0.25, varianceIndicator.calc(barSeries, 2))
        XCTAssertEqual(0.25, varianceIndicator.calc(barSeries, 3))
        XCTAssertEqual(2.25, varianceIndicator.calc(barSeries, 9))
        XCTAssertEqual(20.25, varianceIndicator.calc(barSeries, 10))
    }
     
}
