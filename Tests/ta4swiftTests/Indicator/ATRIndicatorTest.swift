//
//  ATRIndicatorTest.swift
//  
//
//  Created by Simon-Justus Wimmer on 20.02.22.
//

import Foundation
import XCTest
@testable import ta4swift

final class ATRIndicatorTest: Ta4swiftTest {
    
    func testATR() {
        
        let barSeries = BarSeries(name: "Test")
        barSeries.bars.append(Bar(openPrice: 0, highPrice: 15, lowPrice: 8, closePrice: 12, volume: 0, beginTime: Date() + 1))
        barSeries.bars.append(Bar(openPrice: 0, highPrice: 11, lowPrice: 6, closePrice: 8, volume: 0, beginTime: Date() + 2))
        barSeries.bars.append(Bar(openPrice: 0, highPrice: 17, lowPrice: 14, closePrice: 15, volume: 0, beginTime: Date() + 3))
        barSeries.bars.append(Bar(openPrice: 0, highPrice: 17, lowPrice: 14, closePrice: 15, volume: 0, beginTime: Date() + 4))
        barSeries.bars.append(Bar(openPrice: 0, highPrice: 0, lowPrice: 0, closePrice: 0, volume: 0, beginTime: Date() + 5))
        
        let atr = ATRIndicator(barCount: 3)
        
        XCTAssertEqual(7, atr.calc(barSeries, 0))
        XCTAssertEqual(6.666666666666667, atr.calc(barSeries, 1))
        XCTAssertEqual(7.444444444444445, atr.calc(barSeries, 2))
        XCTAssertEqual(5.962962962962964, atr.calc(barSeries, 3))
        XCTAssertEqual(8.975308641975309, atr.calc(barSeries, 4))
        
    }
}
