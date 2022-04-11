//
//  TRIndicatorTest.swift
//  
//
//  Created by Simon-Justus Wimmer on 20.02.22.
//

import Foundation
import XCTest
@testable import ta4swift

final class TRIndicatorTest: Ta4swiftTest {
    
    func testTrueRange() {
        let barSeries = BarSeries(name: "Test")
        barSeries.bars.append(Bar(openPrice: 0, highPrice: 15, lowPrice: 8, closePrice: 12, volume: 0, beginTime: Date() + 1))
        barSeries.bars.append(Bar(openPrice: 0, highPrice: 11, lowPrice: 6, closePrice: 8, volume: 0, beginTime: Date() + 1))
        barSeries.bars.append(Bar(openPrice: 0, highPrice: 17, lowPrice: 14, closePrice: 15, volume: 0, beginTime: Date() + 1))
        barSeries.bars.append(Bar(openPrice: 0, highPrice: 17, lowPrice: 14, closePrice: 15, volume: 0, beginTime: Date() + 1))
        barSeries.bars.append(Bar(openPrice: 0, highPrice: 0, lowPrice: 0, closePrice: 0, volume: 0, beginTime: Date() + 1))
        
        let tr = TRIndicator()
        
        XCTAssertEqual(7, tr.calc(barSeries, 0))
        XCTAssertEqual(6, tr.calc(barSeries, 1))
        XCTAssertEqual(9, tr.calc(barSeries, 2))
        XCTAssertEqual(3, tr.calc(barSeries, 3))
        XCTAssertEqual(15, tr.calc(barSeries, 4))
    }
}
