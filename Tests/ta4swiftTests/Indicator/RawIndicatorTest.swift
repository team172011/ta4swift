//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 30.01.22.
//

import Foundation

@testable import ta4swift
import XCTest

final class RawIndicatorTest: Ta4swiftTest {
    
    func testPlus() throws {
        let bars = createBars(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18)
        let barSeries = BarSeries(name: "Test", bars: bars)
        let close = barSeries.close
        let close2 = barSeries.high
        
        let numericIndicator = close.plus(close2)
        
        for index in 0..<bars.count {
            XCTAssertEqual(numericIndicator.calc(barSeries, index), close.calc(barSeries, index) + close2.calc(barSeries, index))
        }
        
    }
    
    func testRawIndicatorCreation() {
        let bars = createBars(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18)
        let barSeries = BarSeries(name: "Test", bars: bars)
        let closeDividedByHigh = RawIndicator(){
            {(series, index) in return series.bars[index].closePrice / series.bars[index].highPrice}
        }
        printValues(barSeries, closeDividedByHigh)
        
        XCTAssertEqual(closeDividedByHigh.calc(barSeries, 0), barSeries.bars[0].closePrice / barSeries.bars[0].highPrice)
        XCTAssertEqual(closeDividedByHigh.calc(barSeries, 5), barSeries.bars[5].closePrice / barSeries.bars[5].highPrice)
        XCTAssertEqual(closeDividedByHigh.calc(barSeries, 6), barSeries.bars[6].closePrice / barSeries.bars[6].highPrice)
        XCTAssertEqual(closeDividedByHigh.calc(barSeries, 8), barSeries.bars[8].closePrice / barSeries.bars[8].highPrice)
    }
    
    func testMinus() throws {
        let bars = createBars(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18)
        let barSeries = BarSeries(name: "Test", bars: bars)
        let close = barSeries.close
        let close2 = barSeries.close
        
        let numericIndicator = close.minus(close2)
        
        for index in 0..<bars.count {
            XCTAssertEqual(numericIndicator.calc(barSeries, index), close.calc(barSeries, index) - close2.calc(barSeries, index))
        }
    }
    
    func testDivide() throws {
        let bars = createBars(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18)
        let barSeries = BarSeries(name: "Test", bars: bars)
        let close = barSeries.close
        let close2 = barSeries.close
        
        let numericIndicator = close.divide(close2)
        
        for index in 0..<bars.count {
            XCTAssertEqual(numericIndicator.calc(barSeries, index), close.calc(barSeries, index) / close2.calc(barSeries, index))
        }
    }
    
    func testMultiply() throws {
        let bars = createBars(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18)
        let barSeries = BarSeries(name: "Test", bars: bars)
        let close = barSeries.close
        let close2 = barSeries.close
        
        let numericIndicator = close.multiply(close2)
        
        for index in 0..<bars.count {
            XCTAssertEqual(numericIndicator.calc(barSeries, index), close.calc(barSeries, index) * close2.calc(barSeries, index))
        }
    }
    
    func testAbs() throws {
        let bars = createBars(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18)
        let barSeries = BarSeries(name: "Test", bars: bars)
        let close = barSeries.close
        let constant = ConstantValueIndicator{ 10 }
        let closePriceMinusTen = close.minus(constant).abs()
        
        for index in 0..<bars.count {
            XCTAssertEqual(closePriceMinusTen.calc(barSeries, index), Swift.abs(close.calc(barSeries, index) - 10))
        }
    }
    
    func testSqrt() throws {
        let bars = createBars(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18)
        let barSeries = BarSeries(name: "Test", bars: bars)
        let close = barSeries.close
        
        let numericIndicator = close.sqrt()
        
        for index in 0..<bars.count {
            XCTAssertEqual(numericIndicator.calc(barSeries, index), close.calc(barSeries, index).squareRoot())
        }
    }
}
