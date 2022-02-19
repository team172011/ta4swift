//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 16.02.22.
//

import Foundation

/**
 A CachedIndicator is a wrapper class for an indicator structure. The result of the calc Closure will be cached in
 an externat cache property
 */
public final class CachedIndicator<T: ValueIndicator>: ValueIndicator {
    
    public var calc: calcFuncTypeValue = {a,b in return 0.0}
    var cache: Dictionary<CKey, Double> = Dictionary()
    
    public init (of indicator: T) {
        self.calc = {
            barSeries, index in
            let beginTime = barSeries.bars[index].beginTime
            let key = CKey(seriesName: barSeries.name, beginTime: beginTime)
            if let cachedValue = self.cache[key] {
                #if Xcode
                print("cache hit")
                #endif
                return cachedValue
            } else {
                let value = indicator.calc(barSeries, index)
                self.cache[key] = value
                #if Xcode
                print("cache miss")
                #endif
                return value
            }
        }
    }
    
    static func of(_ indicator: T) -> CachedIndicator {
        return CachedIndicator(of: indicator)
    }
}

struct CKey: Hashable, CustomStringConvertible {
    
    public var seriesName: String
    public var beginTime: Date
    public var description: String {
        return "\(seriesName): \(beginTime)"
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(seriesName)
        hasher.combine(beginTime)
    }
}
