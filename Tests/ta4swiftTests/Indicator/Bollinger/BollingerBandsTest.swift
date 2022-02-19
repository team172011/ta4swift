//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 17.02.22.
//

import Foundation

import Foundation
import XCTest
@testable import ta4swift

final class BollingerBandsIndicatorTest: Ta4swiftTest {
 
    func testCreation() {
        let aapl = readAppleIncSeries("aapl")
        
        let bbands = BollingerBands(barCount: 10, multiplier: 2)
        
        let base = bbands.base
        let lower = bbands.lower
        let middle = bbands.middle
        let upper = bbands.upper
        let percentB = bbands.percentB
        
        XCTAssertEqual(base.calc(aapl, 0), aapl.close.calc(aapl, 0))
        
        let lowerValues = lower.values(for: aapl)
        let middleValues = middle.values(for: aapl)
        let upperValues = upper.values(for: aapl)
        let percentBValues = percentB.values(for: aapl)
        
        XCTAssertEqual(lowerValues.count, middleValues.count)
        XCTAssertEqual(middleValues.count, upperValues.count)
        XCTAssertEqual(upperValues.count, percentBValues.count)
    }
    
    func testLowerBBand() {
        let barSeries = BarSeries(name: "Test", bars: createBars(1, 2, 3, 4, 3, 4, 5, 4, 3, 3, 4, 3, 2))
        let bbands = BollingerBands(barCount: 3, multiplier: 2)
        
        let bbLower = bbands.lower
        
        XCTAssertEqual(1.0, bbLower.calc(barSeries, 0))
        XCTAssertEqual(0.5, bbLower.calc(barSeries, 1))
        XCTAssertEqual(0.36700683814454793, bbLower.calc(barSeries, 2))
        XCTAssertEqual(1.367006838144548, bbLower.calc(barSeries, 3))
        XCTAssertEqual(2.3905242917512703, bbLower.calc(barSeries, 4))
        XCTAssertEqual(2.7238576250846034, bbLower.calc(barSeries, 5))
        XCTAssertEqual(2.367006838144548, bbLower.calc(barSeries, 6))
        XCTAssertEqual(3.3905242917512695, bbLower.calc(barSeries, 7))
        XCTAssertEqual(2.367006838144548, bbLower.calc(barSeries, 8))
        XCTAssertEqual(2.3905242917512703, bbLower.calc(barSeries, 9))
        XCTAssertEqual(2.3905242917512703, bbLower.calc(barSeries, 10))
        XCTAssertEqual(2.3905242917512703, bbLower.calc(barSeries, 11))
        XCTAssertEqual(1.367006838144548, bbLower.calc(barSeries, 12))
        
    }
    
    func testMiddleBBand() {
        let barSeries = BarSeries(name: "Test", bars: createBars(1, 2, 3, 4, 3, 4, 5, 4, 3, 3, 4, 3, 2))
        let bbands = BollingerBands(barCount: 3, multiplier: 2)
        let sma = SMAIndicator(barCount: 3){ barSeries.close}
        let bbMiddle = bbands.middle
        
        XCTAssertEqual(sma.calc(barSeries, 0), bbMiddle.calc(barSeries, 0))
        XCTAssertEqual(sma.calc(barSeries, 1), bbMiddle.calc(barSeries, 1))
        XCTAssertEqual(sma.calc(barSeries, 2), bbMiddle.calc(barSeries, 2))
        XCTAssertEqual(sma.calc(barSeries, 3), bbMiddle.calc(barSeries, 3))
        XCTAssertEqual(sma.calc(barSeries, 4), bbMiddle.calc(barSeries, 4))
        XCTAssertEqual(sma.calc(barSeries, 5), bbMiddle.calc(barSeries, 5))
        XCTAssertEqual(sma.calc(barSeries, 6), bbMiddle.calc(barSeries, 6))
        XCTAssertEqual(sma.calc(barSeries, 7), bbMiddle.calc(barSeries, 7))
        XCTAssertEqual(sma.calc(barSeries, 8), bbMiddle.calc(barSeries, 8))
        XCTAssertEqual(sma.calc(barSeries, 9), bbMiddle.calc(barSeries, 9))
        XCTAssertEqual(sma.calc(barSeries, 10), bbMiddle.calc(barSeries, 10))
        XCTAssertEqual(sma.calc(barSeries, 11), bbMiddle.calc(barSeries, 11))
        XCTAssertEqual(sma.calc(barSeries, 12), bbMiddle.calc(barSeries, 12))
        
    }
    
    func testUpperBBand() {
        let barSeries = BarSeries(name: "Test", bars: createBars(1, 2, 3, 4, 3, 4, 5, 4, 3, 3, 4, 3, 2))
        let bbands = BollingerBands(barCount: 3, multiplier: 2)
        
        let bbLower = bbands.upper
        
        XCTAssertEqual(1.0, bbLower.calc(barSeries, 0))
        XCTAssertEqual(2.5, bbLower.calc(barSeries, 1))
        XCTAssertEqual(3.632993161855452, bbLower.calc(barSeries, 2))
        XCTAssertEqual(4.6329931618554525, bbLower.calc(barSeries, 3))
        XCTAssertEqual(4.276142374915397, bbLower.calc(barSeries, 4))
        XCTAssertEqual(4.60947570824873, bbLower.calc(barSeries, 5))
        XCTAssertEqual(5.6329931618554525, bbLower.calc(barSeries, 6))
        XCTAssertEqual(5.276142374915397, bbLower.calc(barSeries, 7))
        XCTAssertEqual(5.6329931618554525, bbLower.calc(barSeries, 8))
        XCTAssertEqual(4.276142374915397, bbLower.calc(barSeries, 9))
        XCTAssertEqual(4.276142374915397, bbLower.calc(barSeries, 10))
        XCTAssertEqual(4.276142374915397, bbLower.calc(barSeries, 11))
        XCTAssertEqual(4.6329931618554525, bbLower.calc(barSeries, 12))
    }
    
    func testBBandPercentage() {
        let barSeries = BarSeries(name: "Test", bars: createBars(10, 12, 15, 14, 17, 20, 21, 20, 20, 19, 20, 17, 12, 12, 9, 8, 9, 10, 9, 10))
        let bbands = BollingerBands(barCount: 5, multiplier: 2)
        let percentB = bbands.percentB
        
        XCTAssertTrue(percentB.calc(barSeries, 0).isNaN)
        XCTAssertEqual(0.75, percentB.calc(barSeries, 1))
        XCTAssertEqual(0.8244428422615252, percentB.calc(barSeries, 2))
        XCTAssertEqual(0.66273613872603, percentB.calc(barSeries, 3))
        XCTAssertEqual(0.8517325026560063, percentB.calc(barSeries, 4))
        XCTAssertEqual(0.9032795663087215, percentB.calc(barSeries, 5))
        XCTAssertEqual(0.8299560087980449, percentB.calc(barSeries, 6))
        XCTAssertEqual(0.6552301051412667, percentB.calc(barSeries, 7))
        
        XCTAssertEqual(0.5, percentB.calc(barSeries, 10))
        XCTAssertEqual(0.02837889085810116, percentB.calc(barSeries, 11))
        
        XCTAssertEqual(0.5737209780774486, percentB.calc(barSeries, 17))
        XCTAssertEqual(0.5, percentB.calc(barSeries, 18))
        XCTAssertEqual(0.7672612419124247, percentB.calc(barSeries, 19))
    }
}
