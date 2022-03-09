//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 16.02.22.
//

import Foundation

/**
 A CachedIndicator is a wrapper class for an indicator structure. The result of the calc Closure will be cached in
 an external cache property
 */
public final class CachedIndicator<T: ValueIndicator>: ValueIndicator {
    
    public var calc: calcFuncTypeValue = {a,b in return 0.0}
    var seriesCaches: Dictionary<String, DateCache> = Dictionary()
    
    /**
        Size of cache in seconds e.g. one day or a week
     */
    var timeSpan: TimeInterval
    
    /**
     How hoften the cache size gets cleaned in seconds e.g. once per day or once in a week
     */
    var updateInverval: TimeInterval
    
    public init (of indicator: T, timeSpan: TimeInterval = 1, updateInterval: TimeInterval = 1) {
        self.timeSpan = timeSpan
        self.updateInverval = updateInterval
        self.calc = {
            barSeries, index in
            let beginTime = barSeries.bars[index].beginTime
            let seriesCache = self.getSeriesCache(barSeries.name)
            if let cachedValue = seriesCache.values[beginTime] {
                #if Xcode
                print("cache hit")
                #endif
                return cachedValue
            } else {
                let value = indicator.calc(barSeries, index)
                seriesCache.update(for: beginTime, with: value)
                #if Xcode
                print("cache miss")
                #endif
                return value
            }
        }
    }
    
    public func seriesCacheSize() -> Int {
        return self.seriesCaches.count
    }
    
    public func clearCache(for seriesName: String) {
        self.seriesCaches[seriesName]?.clear()
    }
    
    public func exportCache(for seriesName: String) -> DateCache? {
        return seriesCaches[seriesName]
    }
    
    private func getSeriesCache(_ seriesName: String) -> DateCache {
        if let seriesCache = self.seriesCaches[seriesName] {
            return seriesCache
        } else {
            let seriesCache = DateCache(timeSpan: timeSpan, updateInterval: updateInverval)
            self.seriesCaches[seriesName] = seriesCache
            return seriesCache
        }
    }
    
    static func of(_ indicator: T) -> CachedIndicator {
        return CachedIndicator(of: indicator)
    }
    
    static func of(_ indicator: T, timeSpan: TimeInterval, updateInterval: TimeInterval) -> CachedIndicator {
        return CachedIndicator(of: indicator, timeSpan: timeSpan, updateInterval: updateInterval)
    }
}
