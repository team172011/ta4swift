//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 03.03.22.
//

import Foundation
import XCTest

@testable import ta4swift

public final class MeanDeviationIndicatorTest: Ta4swiftTest {
    
    func testUsingBarCount5() {
        let barSeries = BarSeries(name: "Test", bars: createBars(1,2,7,6,3,4,5,11,3,0,9))
        let meanDeciatation = MeanDeviationIndicator(barCount: 5) { barSeries.close }
        
        assertEqualsT(2.4444444444444446, meanDeciatation.calc(barSeries, 2))
        assertEqualsT(2.5, meanDeciatation.calc(barSeries, 3))
        assertEqualsT(2.16, meanDeciatation.calc(barSeries, 7))
        assertEqualsT(2.32, meanDeciatation.calc(barSeries, 8))
        assertEqualsT(2.72, meanDeciatation.calc(barSeries, 9))
    }
    
    func testFirstValueShouldBeZero() {
        let barSeries = BarSeries(name: "Test", bars: createBars(1,2,7,6,3,4,5,11,3,0,9))
        let meanDeciatation = MeanDeviationIndicator(barCount: 5) { barSeries.close }
        
        assertEqualsT(0, meanDeciatation.calc(barSeries, 0))
    }
    
    func testmeanDeviatationShouldBeZeroWhenBarCountIs1() {
        let barSeries = BarSeries(name: "Test", bars: createBars(1,2,7,6,3,4,5,11,3,0,9))
        let meanDeciatation = MeanDeviationIndicator(barCount: 1) { barSeries.close }
        
        assertEqualsT(0, meanDeciatation.calc(barSeries, 2))
        assertEqualsT(0, meanDeciatation.calc(barSeries, 7))
    }
}
