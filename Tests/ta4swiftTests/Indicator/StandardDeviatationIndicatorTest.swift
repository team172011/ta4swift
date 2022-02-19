//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 19.02.22.
//

import Foundation
import Foundation
import XCTest
@testable import ta4swift

final class StandardDeviatationIndicatorTest: Ta4swiftTest {
    
    func testBarCount4() {
        let barSeries = BarSeries(name: "Test", bars: createBars(1, 2, 3, 4, 3, 4, 5, 4, 3, 0, 9))
        let sdv = StandardDeviationIndicator(barCount: 4){ barSeries.close }
        
        XCTAssertEqual(0, sdv.calc(barSeries, 0))
        XCTAssertEqual(sqrt(0.25), sdv.calc(barSeries, 1))
        XCTAssertEqual(sqrt(2.0/3), sdv.calc(barSeries, 2))
        XCTAssertEqual(sqrt(1.25), sdv.calc(barSeries, 3))
        XCTAssertEqual(sqrt(0.5), sdv.calc(barSeries, 4))
        XCTAssertEqual(sqrt(0.25), sdv.calc(barSeries, 5))
        XCTAssertEqual(sqrt(0.5), sdv.calc(barSeries, 6))
        XCTAssertEqual(sqrt(0.5), sdv.calc(barSeries, 7))
        XCTAssertEqual(sqrt(0.5), sdv.calc(barSeries, 8))
        XCTAssertEqual(sqrt(3.5), sdv.calc(barSeries, 9))
        XCTAssertEqual(sqrt(10.5), sdv.calc(barSeries, 10))
    }
    
    func testBarCount1Variance0() {
        let barSeries = BarSeries(name: "Test", bars: createBars(1, 2, 3, 4, 3, 4, 5, 4, 3, 0, 9))
        let varianceIndicator = StandardDeviationIndicator(barCount: 1){barSeries.close}
        
        for value in varianceIndicator.values(for: barSeries) {
            XCTAssertEqual(0, value)
        }
    }
    
    func testBarCount2() {
        let barSeries = BarSeries(name: "Test", bars: createBars(1, 2, 3, 4, 3, 4, 5, 4, 3, 0, 9))
        let sdv = StandardDeviationIndicator(barCount: 2){barSeries.close}
        
        XCTAssertEqual(sqrt(0), sdv.calc(barSeries, 0))
        XCTAssertEqual(sqrt(0.25), sdv.calc(barSeries, 1))
        XCTAssertEqual(sqrt(0.25), sdv.calc(barSeries, 2))
        XCTAssertEqual(sqrt(0.25), sdv.calc(barSeries, 3))
        XCTAssertEqual(sqrt(2.25), sdv.calc(barSeries, 9))
        XCTAssertEqual(sqrt(20.25), sdv.calc(barSeries, 10))
    }
     
}
