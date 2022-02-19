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
    
    func testCachedIndicatorWithTwoSeries() {
        let btc = readBitcoinSeries("btc")
        let goog = readGoogleSeries("goog")
        let sma = btc.sma(barCount: 20).cached
        
        assert(btc.bars != goog.bars)
        
        // get all values
        // this should fill the cache for both series with different values
        let valuesBtc = sma.valueMap(for: btc)
        let valuesGoog = sma.valueMap(for: goog)
        
        // iterate over all values and fail if there are two dates with same value
        for (_, keyValue) in valuesBtc.enumerated() {
            if let googleValue = valuesGoog[keyValue.key] {
                if googleValue == keyValue.value {
                    let cacheEntry = sma.cache.first{ (key, value) in value == keyValue.value && key.beginTime == keyValue.key}!
                    XCTFail("Same value for different series! value: \(cacheEntry.value), key: \(cacheEntry.key)")
                }
            }
        }
        
        // cache should be the size of both bar series bar count
        XCTAssertEqual(sma.cache.count, goog.bars.count + btc.bars.count)
    }
}
