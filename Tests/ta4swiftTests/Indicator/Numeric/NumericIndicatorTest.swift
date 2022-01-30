//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 30.01.22.
//

import Foundation

@testable import ta4swift
import XCTest

final class NumericIndicatorTest: Ta4swiftTest {
    
    func testPlus() throws {
        let bars = createBars(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18)
        let barSeries = BarSeries(name: "Test", bars: bars)
        let close = barSeries.close
        let close2 = barSeries.high
        
        let numericIndicator = NumericIndicator(of: close).plus(indicator: close2)
        
        for index in 0..<bars.count {
            XCTAssertEqual(numericIndicator.getValue(for: index), close.getValue(for: index) + close2.getValue(for: index))
        }
        
    }
    
    func testMinus() throws {
        let bars = createBars(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18)
        let barSeries = BarSeries(name: "Test", bars: bars)
        let close = barSeries.close
        let close2 = barSeries.close
        
        let numericIndicator = NumericIndicator(of: close).minus(indicator: close2)
        
        for index in 0..<bars.count {
            XCTAssertEqual(numericIndicator.getValue(for: index), close.getValue(for: index) - close2.getValue(for: index))
        }
    }
    
    func testDivide() throws {
        let bars = createBars(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18)
        let barSeries = BarSeries(name: "Test", bars: bars)
        let close = barSeries.close
        let close2 = barSeries.close
        
        let numericIndicator = NumericIndicator(of: close).divide(indicator: close2)
        
        for index in 0..<bars.count {
            XCTAssertEqual(numericIndicator.getValue(for: index), close.getValue(for: index) / close2.getValue(for: index))
        }
    }
    
    func testMultiply() throws {
        let bars = createBars(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18)
        let barSeries = BarSeries(name: "Test", bars: bars)
        let close = barSeries.close
        let close2 = barSeries.close
        
        let numericIndicator = NumericIndicator(of: close).multiply(indicator: close2)
        
        for index in 0..<bars.count {
            XCTAssertEqual(numericIndicator.getValue(for: index), close.getValue(for: index) * close2.getValue(for: index))
        }
    }
    
    func testAbs() throws {
        let bars = createBars(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18)
        let barSeries = BarSeries(name: "Test", bars: bars)
        let close = barSeries.close
        let constant = ConstantValueIndicator(barSeries: barSeries, constant: 10)
        let numericIndicator = NumericIndicator(of: close).minus(indicator: constant).abs()
        
        for index in 0..<bars.count {
            XCTAssertEqual(numericIndicator.getValue(for: index), Swift.abs(close.getValue(for: index) - 10))
        }
    }
    
    func testSqrt() throws {
        let bars = createBars(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18)
        let barSeries = BarSeries(name: "Test", bars: bars)
        let close = barSeries.close
        
        let numericIndicator = NumericIndicator(of: close).sqrt()
        
        for index in 0..<bars.count {
            XCTAssertEqual(numericIndicator.getValue(for: index), close.getValue(for: index).squareRoot())
        }
    }
}
