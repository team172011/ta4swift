//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 09.03.22.
//

import Foundation
import Logging

public protocol Cache: NSCopying {
    associatedtype K
    associatedtype V
    
    func clear()
    func update(for: K, with: V)
    func getValue(for: K) -> V
}

public class DateCache: Cache {
    
    let logger = Logger(label: "Cache")
    /**
    Size of cache in seconds e.g. one day or a week
     */
    let timeSpan: TimeInterval
    
    /**
     How hoften the cache size gets cleaned in seconds e.g. once per day or once in a week
     */
    let updateInterval: TimeInterval
    
    var values: Dictionary<Date, Double> = Dictionary()
    
    var sortedKeys: [Date]
    
    private var lastUpdated: Date?

    
    public init(timeSpan: TimeInterval, updateInterval: TimeInterval) {
        self.values = Dictionary()
        self.timeSpan = timeSpan
        self.updateInterval = updateInterval
        self.sortedKeys = []
    }
    
    public func getValue(for key: Date) -> Double {
        return self.values[key]!
    }
    
    public func clear() {
        self.values.removeAll()
        self.sortedKeys.removeAll()
        self.lastUpdated = nil
    }
    
    public func update(for currentTime: Date, with value: Double) {
        if let lastUpdated = lastUpdated {
            let currentTimespan = lastUpdated - currentTime
            logger.debug("TimeSpan \(timeSpan), \(currentTimespan.abs())")
            if currentTimespan.abs() > updateInterval {
                logger.debug("Update interval (\(updateInterval) reached. Clear values older than \(timeSpan)")
                self.lastUpdated = currentTime
                clearObsoleteValues(currentTime: currentTime)
            }
        } else {
            self.lastUpdated = currentTime
        }
        self.values[currentTime] = value
        
        let index = self.sortedKeys.insertionIndexOf(currentTime){ date1, date2 in date1 < date2 }
        self.sortedKeys.insert(currentTime, at: index)
    }
    
    func clearObsoleteValues(currentTime: Date) {
        for value in sortedKeys {
            logger.debug("Check (\(value))")
            let currentTimespan = currentTime - value
            if(currentTimespan > self.timeSpan) {
                logger.debug("Remove old value for (\(value)) diff: \(currentTimespan)")
                self.values.removeValue(forKey: value)
            } else {
                break
            }
        }
    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        let cacheCopy = DateCache(timeSpan: self.timeSpan, updateInterval: self.updateInterval)
        cacheCopy.lastUpdated = self.lastUpdated
        cacheCopy.values = self.values
        return cacheCopy
    }
}

public extension Date {
    
    /**
     Difference between this date and another date in seconds
     */
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}


public extension Array {
    func insertionIndexOf(_ elem: Element, isOrderedBefore: (Element, Element) -> Bool) -> Int {
        var lo = 0
        var hi = self.count - 1
        while lo <= hi {
            let mid = (lo + hi)/2
            if isOrderedBefore(self[mid], elem) {
                lo = mid + 1
            } else if isOrderedBefore(elem, self[mid]) {
                hi = mid - 1
            } else {
                return mid // found at position mid
            }
        }
        return lo // not found, would be inserted at position lo
    }
}
