//
//  ROCVIndicatorTest.swift
//  
//
//  Created by Simon-Justus Wimmer on 11.04.22.
//

import Foundation
import XCTest

@testable import ta4swift

final class ROCVIndicatorTest: Ta4swiftTest {
    
    func testValues() {
        let barSeries = BarSeries(name: "test", bars: createBars(
            (1355.69, 1000), (1325.51, 3000), (1335.02, 3500), (1313.72, 2200), (1319.99, 2300),
            (1331.85, 200), (1329.04, 2700), (1362.16, 5000), (1365.51, 1000), (1374.02, 2500)))
        let rocv = ROCVIndicator(barCount: 3)
        
        assertEqualsT(0, rocv.calc(barSeries, 0))
        assertEqualsT(200, rocv.calc(barSeries, 1))
        assertEqualsT(250, rocv.calc(barSeries, 2))
        assertEqualsT(120, rocv.calc(barSeries, 3))
        assertEqualsT(-23.3333333333, rocv.calc(barSeries, 4))
        assertEqualsT(-94.28571428571429, rocv.calc(barSeries, 5))
        assertEqualsT(22.727272727272727, rocv.calc(barSeries, 6))
        assertEqualsT(117.3913043478261, rocv.calc(barSeries, 7))
        assertEqualsT(400, rocv.calc(barSeries, 8))
        assertEqualsT(-7.407407407407407, rocv.calc(barSeries, 9))
    }
}
