//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 10.02.22.
//

import Foundation
import XCTest
import Logging

@testable import ta4swift

final class CachedIndicatorTest: Ta4swiftTest {
    
    func testCachingVsNoneCachingDateCache() {
        let logger = Logger(label: #function)
        let barSeries = readBitcoinSeries("BTC")
        let std = StandardDeviationIndicator(barCount: 15) {barSeries.close}
        let sma = SMAIndicator(barCount: 10){ std }
        let cacheSize = (barSeries.bars.last!.beginTime - barSeries.bars.first!.beginTime)
        let updateInterval = 60 * 24 * 7
        
        var startTime = Date()
        calcAllValues(barSeries, sma, 105)
        let endTimeNoCache = startTime.distance(to: Date())
        
        startTime = Date()
        calcAllValues(barSeries, sma.cached{DateCache(timeSpan: cacheSize, updateInterval: Double(updateInterval))}, 5)
        let endTimeCache = startTime.distance(to: Date())
        
        logger.info("No cache: \(endTimeNoCache) vs cache: \(endTimeCache)")
        
        XCTAssertTrue(endTimeNoCache > endTimeCache)
    }
    
    func testCachingVsNoneCachingSimpleCache() {
        let logger = Logger(label: #function)
        let barSeries = readBitcoinSeries("BTC")
        let std = StandardDeviationIndicator(barCount: 15) {barSeries.close}
        let sma = SMAIndicator(barCount: 10){ std }

        var startTime = Date()
        calcAllValues(barSeries, sma, 105)
        let endTimeNoCache = startTime.distance(to: Date())
        
        startTime = Date()
        calcAllValues(barSeries, sma.cached(), 5)
        let endTimeCache = startTime.distance(to: Date())
        
        logger.info("No cache: \(endTimeNoCache) vs cache: \(endTimeCache)")
        
        XCTAssertTrue(endTimeNoCache > endTimeCache)
    }
    
    func calcAllValues(_ barSeries: BarSeries, _ indicator: ValueIndicator, _ times: Int = 1) {
        for _ in 1...times {
            for i in 0..<barSeries.bars.count{
                let _ = indicator.calc(barSeries, i)
            }
        }
    }
    
    func testCacheSizeAndUpdateIntervall() {
        let logger = Logger(label: #function)
        let startTime = Date();
        
        let barSeries = readBitcoinSeries("BTC")
        
        let sma = SMAIndicator(barCount: 10)
        
        // Create sma indicator that is cached and the cache has a size of first to last bar series and gets updated every second
        let cacheSize = barSeries.bars.last!.beginTime - barSeries.bars.first!.beginTime
        let smaCached = sma.cached{ DateCache(timeSpan: cacheSize, updateInterval: 1) }
        
        // check for correcrt values
        for (index, _) in barSeries.bars.enumerated() {
            XCTAssertEqual(sma.calc(barSeries, index), smaCached.calc(barSeries, index))
        }
        
        // check for correct cached values count
        XCTAssertEqual(barSeries.bars.count, smaCached.exportCache(for: barSeries)!.size)
    
        
        smaCached.clearCache(for: "BTC")
        
        let _ = smaCached.calc(barSeries, 0)
        let _ = smaCached.calc(barSeries, 16)
        
        XCTAssertEqual(smaCached.exportCache(for: barSeries)?.size, 2)
        
        // create another instance with half cache size
        let smaCached2 = sma.cached{ DateCache(timeSpan: cacheSize / 2, updateInterval: 1) }
        
        // fill cache by calculating all values
        let _ = smaCached2.values(for: barSeries)
        
        XCTAssertEqual(barSeries.bars.count / 2 + 1, smaCached2.exportCache(for: barSeries)?.size)
        
        // create another instance with very large update intervall
        let smaCached3 = sma.cached{ DateCache(timeSpan: cacheSize, updateInterval: 1000000) }
        
        // fill cache by calculating all values
        let _ = smaCached3.values(for: barSeries)
        
        XCTAssertEqual(barSeries.bars.count, smaCached3.exportCache(for: barSeries)?.size)
        
        logger.info("Time for test: \(Date() - startTime)")
    }
    
    func testCachedIndicatorWithTwoSeriesAndNoUpdates() {
        let btc = readBitcoinSeries("btc")
        let goog = readGoogleSeries("goog")
        
        // update interval is every second, timeSpan is maxvalue -> the cache schould never be cleaned
        let sma = btc.sma(barCount: 20).cached{DateCache(timeSpan: Double.greatestFiniteMagnitude, updateInterval: 1) }
        
        assert(btc.bars != goog.bars)
        XCTAssertNil(sma.exportCache(for: "btc"))
        XCTAssertNil(sma.exportCache(for: "goog"))
        
        // get all values
        // this should fill the cache for both series with different values
        let btcValues = sma.valueMap(for: btc)
        let googValues = sma.valueMap(for: goog)
        
        let exportedCacheBtc = sma.exportCache(for: "btc")!
        let exportedCacheGoog = sma.exportCache(for: "goog")!
        
        for (index, _) in btcValues.enumerated() {
            assertEqualsT(btcValues[btc.bars[index].beginTime]!, sma.calc(btc, index))
        }
        
        for (index, _) in googValues.enumerated() {
            assertEqualsT(googValues[goog.bars[index].beginTime]!, sma.calc(goog, index))
        }
        
        // cache should be the size of both bar series bar count
        XCTAssertEqual(exportedCacheBtc.size + exportedCacheGoog.size , goog.bars.count + btc.bars.count)
        
        // update interval is max value, timeSpan is one second -> the cache schould never be cleaned
        let sma2 = btc.sma(barCount: 20).cached{ DateCache(timeSpan: 1, updateInterval: Double.greatestFiniteMagnitude) }
        
        XCTAssertNil(sma2.exportCache(for: "btc"))
        XCTAssertNil(sma2.exportCache(for: "goog"))
        
        // fil caches
        let _ = sma2.valueMap(for: btc)
        let _ = sma2.valueMap(for: goog)

        // get copies of caches
        let exportedCacheBtc2 = sma2.exportCache(for: "btc")!
        let exportedCacheGoog2 = sma2.exportCache(for: "goog")!
        
        // check for correct values
        for (index, _) in btcValues.enumerated() {
            assertEqualsT(btcValues[btc.bars[index].beginTime]!, sma2.calc(btc, index))
        }
        
        for (index, _) in googValues.enumerated() {
            assertEqualsT(googValues[goog.bars[index].beginTime]!, sma2.calc(goog, index))
        }
        
        XCTAssertEqual(exportedCacheBtc2.size, btc.bars.count)
        XCTAssertEqual(exportedCacheGoog2.size, goog.bars.count)
    }
    
    func testCacheWithDuration(){
        let barSeries = readBitcoinSeries("BTC") // daily data
        
        let sma = SMAIndicator(barCount: 10){ ClosePriceIndicator() }
        
        let cacheSize = Double(60*60*24*7*4) // store values of last 28 days
        let updateInterval = Double(60*60*24*7) // udpate once per week the cache
        print("Cache size: \(cacheSize)")
        print("Update intervall: \(updateInterval)")
        
        let smaCached = sma.cached{ DateCache(timeSpan: cacheSize, updateInterval: updateInterval) }
        
        for (index, _) in barSeries.bars.enumerated() {
            if index != 0 {
                let value = smaCached.calc(barSeries, index)
                let smaValue = sma.calc(barSeries, index)
                assertEqualsT(value, smaValue)
                XCTAssertTrue(smaCached.exportCache(for: "BTC")!.size < 40)
                
            }
        }
        
        let exportedCache = smaCached.exportCache(for: "BTC")
        print("BarSeries size \(barSeries.bars.count)")
        print("BarSeries intervall: \(barSeries.bars.last!.beginTime - barSeries.bars.first!.beginTime)")
        print(exportedCache!.size)
    }
}
