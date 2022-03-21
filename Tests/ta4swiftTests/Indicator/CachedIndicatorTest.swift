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
    
    func testCachingVsNoneCaching() {
        let logger = Logger(label: #function)
        let barSeries = readBitcoinSeries("BTC")
        let std = StandardDeviationIndicator(barCount: 15) {barSeries.close}
        let sma = SMAIndicator(barCount: 10){ std }
        let cacheSize = (barSeries.bars.last!.beginTime - barSeries.bars.first!.beginTime)
        let updateInterval = 60 * 24 * 7
        
        var startTimer = Date()
        calcAllValues(barSeries, sma, 105)
        let endTimeNoCache = Date() - startTimer
        
        startTimer = Date()
        calcAllValues(barSeries, sma.cached(timeInterval: cacheSize, updateInterval: Double(updateInterval)), 5)
        let endTimeCache = Date() - startTimer
        
        logger.info("No cache: \(endTimeNoCache) vs cache: \(endTimeCache)")
        
        XCTAssertTrue(endTimeNoCache > endTimeCache)
    }
    
    func calcAllValues<T>(_ barSeries: BarSeries, _ indicator: T, _ times: Int = 1) where T: ValueIndicator {
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
        let smaCached = sma.cached(timeInterval:  cacheSize, updateInterval: 1)
        
        // check for correcrt values
        for (index, _) in barSeries.bars.enumerated() {
            XCTAssertEqual(sma.calc(barSeries, index), smaCached.calc(barSeries, index))
        }
        
        // check for correct cached values count
        XCTAssertEqual(barSeries.bars.count, smaCached.exportCache(for: barSeries)!.values.count)
    
        
        smaCached.clearCache(for: "BTC")
        
        let _ = smaCached.calc(barSeries, 0)
        let _ = smaCached.calc(barSeries, 16)
        
        XCTAssertEqual(smaCached.exportCache(for: barSeries)?.values.count, 2)
        
        // create another instance with half cache size
        let smaCached2 = sma.cached(timeInterval:  cacheSize / 2, updateInterval: 1)
        
        // fill cache by calculating all values
        let _ = smaCached2.values(for: barSeries)
        
        XCTAssertEqual(barSeries.bars.count / 2 + 1, smaCached2.exportCache(for: barSeries)?.values.count)
        
        // create another instance with very large update intervall
        let smaCached3 = sma.cached(timeInterval: cacheSize, updateInterval: 1000000)
        
        // fill cache by calculating all values
        let _ = smaCached3.values(for: barSeries)
        
        XCTAssertEqual(barSeries.bars.count, smaCached3.exportCache(for: barSeries)?.values.count)
        
        logger.info("Time for test: \(Date() - startTime)")
    }
    
    func testCachedIndicatorWithTwoSeriesAndNoUpdates() {
        let btc = readBitcoinSeries("btc")
        let goog = readGoogleSeries("goog")
        
        // update interval is every second, timeSpan is maxvalue -> the cache schould never be cleaned
        let sma = CachedIndicator.of(btc.sma(barCount: 20), timeSpan: Double.greatestFiniteMagnitude, updateInterval: 1)
        
        assert(btc.bars != goog.bars)
        XCTAssertNil(sma.exportCache(for: "btc"))
        XCTAssertNil(sma.exportCache(for: "goog"))
        
        // get all values
        // this should fill the cache for both series with different values
        let btcValues = sma.valueMap(for: btc)
        let googValues = sma.valueMap(for: goog)
        
        let exportedCacheBtc = sma.exportCache(for: "btc")!
        let exportedCacheGoog = sma.exportCache(for: "goog")!
        
        for (date, value) in btcValues {
            assertEqualsT(value, exportedCacheBtc.values[date]!)
        }
        
        for (date, value) in googValues {
            assertEqualsT(value, exportedCacheGoog.values[date]!)
        }
        
        // cache should be the size of both bar series bar count
        XCTAssertEqual(sma.seriesCaches.count, 2)
        XCTAssertEqual(exportedCacheBtc.values.count + exportedCacheGoog.values.count , goog.bars.count + btc.bars.count)
        
        // update interval is max value, timeSpan is one second -> the cache schould never be cleaned
        let sma2 = CachedIndicator.of(btc.sma(barCount: 20), timeSpan: 1, updateInterval: Double.greatestFiniteMagnitude)
        
        XCTAssertNil(sma2.exportCache(for: "btc"))
        XCTAssertNil(sma2.exportCache(for: "goog"))
        
        // fil caches
        let _ = sma2.valueMap(for: btc)
        let _ = sma2.valueMap(for: goog)

        // get copies of caches
        let exportedCacheBtc2 = sma2.exportCache(for: "btc")!
        let exportedCacheGoog2 = sma2.exportCache(for: "goog")!
        
        // check for correct values
        for (date, value) in btcValues {
            assertEqualsT(value, exportedCacheBtc2.values[date]!)
        }
        
        for (date, value) in googValues {
            assertEqualsT(value, exportedCacheGoog2.values[date]!)
        }
        
        XCTAssertEqual(exportedCacheBtc2.values.count, btc.bars.count)
        XCTAssertEqual(exportedCacheGoog2.values.count, goog.bars.count)
    }
    
    func testCacheWithDuration(){
        let barSeries = readBitcoinSeries("BTC") // daily data
        
        let sma = SMAIndicator(barCount: 10){ ClosePriceIndicator() }
        
        let cacheSize = Double(60*60*24*7*4) // store values of last 28 days
        let updateInterval = Double(60*60*24*7) // udpate once per week the cache
        print("Cache size: \(cacheSize)")
        print("Update intervall: \(updateInterval)")
        
        let smaCached = CachedIndicator(of: sma, timeSpan: cacheSize, updateInterval: updateInterval)
        
        for (index, _) in barSeries.bars.enumerated() {
            if index != 0 {
                let value = smaCached.calc(barSeries, index)
                let smaValue = sma.calc(barSeries, index)
                assertEqualsT(value, smaValue)
                XCTAssertTrue(smaCached.exportCache(for: "BTC")!.values.count < 40)
                
            }
        }
        
        let exportedCache = smaCached.exportCache(for: "BTC")
        print("BarSeries size \(barSeries.bars.count)")
        print("BarSeries intervall: \(barSeries.bars.last!.beginTime - barSeries.bars.first!.beginTime)")
        print(exportedCache!.values.count)
    }
}
