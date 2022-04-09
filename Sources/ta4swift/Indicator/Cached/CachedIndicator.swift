//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 16.02.22.
//

import Foundation
import Logging

/**
 A CachedIndicator is a wrapper class for an indicator structure. The result of the calc Closure will be cached in
 an external cache property
 */
public final class CachedIndicator: ValueIndicator {
    
    let logger: Logger
    public var calc: (BarSeries, Int) -> Double = {a,b in return 0.0}
    
    private var seriesCaches: Dictionary<String, Cache> = Dictionary()
    private let cache: () -> Cache
    
    public init (of indicator: ValueIndicator, cache: @escaping () -> Cache) {
        self.logger = Logger(label: "CachedIndicator \(indicator)")
        self.cache = cache;
        self.calc = {
            barSeries, index in
            let beginTime = barSeries.bars[index].beginTime
            let seriesCache = self.getSeriesCache(barSeries.name)
            if let cachedValue = seriesCache[beginTime] {
                self.logger.debug("cache hit")
                return cachedValue
            } else {
                let value = indicator.calc(barSeries, index)
                seriesCache.update(for: beginTime, with: value)
                self.logger.debug("cache miss")
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
    
    public func exportCache(for series: BarSeries) -> Cache? {
        return exportCache(for: series.name)
    }
    
    public func exportCache(for seriesName: String) -> Cache? {
        return seriesCaches[seriesName]
    }
    
    private func getSeriesCache(_ seriesName: String) -> Cache {
        if let seriesCache = self.seriesCaches[seriesName] {
            return seriesCache
        } else {
            let seriesCache = cache()
            self.seriesCaches[seriesName] = seriesCache
            return seriesCache
        }
    }
    
}
