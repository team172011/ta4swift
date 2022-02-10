//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 10.02.22.
//

import Foundation
import XCTest
@testable import ta4swift

final class CachedIndicatorTest: Ta4swiftTest {
    
    func testCachedIndicatorCreation() {
        let barSeries = readBitcoinSeries("BTC")
        
        let sma = SMAIndicator(barCount: 10)
        let smaCached = sma.cached
        
        // check for correcrt values and cache misses
        for (index, _) in barSeries.bars.enumerated() {
            XCTAssertEqual(sma.calc(barSeries, index), smaCached.calc(barSeries, index))
        }
        
        // check for correct cached values count
        XCTAssertEqual(barSeries.bars.count, smaCached.cache.count)
        
        for (index, _) in barSeries.bars.enumerated() {
            let _ = smaCached.calc(barSeries, index)
        }
        
        // validet cache hits
        XCTAssertEqual(barSeries.bars.count, smaCached.cache.count)
        
        smaCached.cache.removeAll()
        
        let _ = smaCached.calc(barSeries, 0)
        let _ = smaCached.calc(barSeries, 16)
        
        XCTAssertEqual(smaCached.cache.count, 2)
    }
}
