//
//  EMAIndicatorTest.swift
//  
//
//  Created by Simon-Justus Wimmer on 25.01.22.
//

import Foundation
import XCTest

@testable import ta4swift

final class EMAIndicatorTest: Ta4swiftTest {
    
    func testBarCount3() throws {
        let bars = createBars(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18)
        let barSeries = BarSeries(name: "Test", bars: bars)
        let close = barSeries.close
        let ema = EMAIndicator(barCount: 3){ close }
        
        XCTAssertTrue(ema.calc(barSeries, 0) == 1, "EMA of index 0 should return first value of indicator base")
        XCTAssertTrue(ema.calc(barSeries, 17) == 17.00000762939453);
    }
    
    func testBarCount10() {
        let barSeries = BarSeries(name: "Test", bars:
                                    createBars(64.75, 63.79, 63.73, 63.73,
                                               63.55, 63.19, 63.91, 63.85,
                                               62.95, 63.37, 61.33, 61.51))
        
        let close = barSeries.close
        let ema = EMAIndicator(barCount: 10){ close }
        
        XCTAssertEqual(63.694826748355545, ema.calc(barSeries, 9));
        XCTAssertEqual(63.264858248654534, ema.calc(barSeries, 10));
        XCTAssertEqual(62.945793112535526, ema.calc(barSeries, 11));
    }
    
    func testFirstValueShouldBeEqualToFirstDataValue(){
        let barSeries = readAppleIncSeries("aapl")
        let sma = SMAIndicator(barCount: 20)
        let ema = EMAIndicator(barCount: 10) { sma }
        let first = sma.calc(barSeries, 0)
        
        XCTAssertEqual(first, ema.calc(barSeries, 0))
    }
}
