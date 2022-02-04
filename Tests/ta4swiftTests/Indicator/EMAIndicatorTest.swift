//
//  File 2.swift
//  
//
//  Created by Simon-Justus Wimmer on 25.01.22.
//

import Foundation
import XCTest

@testable import ta4swift

final class EMAIndicatorTest: Ta4swiftTest {
    
    func testCreation() throws {
        let bars = createBars(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18)
        let barSeries = BarSeries(name: "Test", bars: bars)
        let close = barSeries.close
        let ema = EMAIndicator(indicator: close, barCount: 3)
        
        XCTAssertTrue(ema.f(barSeries, 0) == 1, "EMA of index 0 should return first value of indicator base")
        XCTAssertTrue(ema.f(barSeries, 17) == 17.00000762939453);
    }
}
