//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 09.03.22.
//

import Foundation

public protocol Cache: NSCopying {
    associatedtype K
    associatedtype V
    
    func clear()
    func update(for: K, with: V)
    func getValue(for: K) -> V
}

public class DateCache: Cache {
    
    
    /**
    Size of cache in seconds e.g. one day or a week
     */
    let timeSpan: TimeInterval
    
    /**
     How hoften the cache size gets cleaned in seconds e.g. once per day or once in a week
     */
    let updateInterval: TimeInterval
    
    var values: Dictionary<Date, Double> = Dictionary()
   
    
    private var lastUpdated: Date?

    
    public init(timeSpan: TimeInterval, updateInterval: TimeInterval) {
        self.values = Dictionary()
        self.timeSpan = timeSpan
        self.updateInterval = updateInterval
    }
    
    public func getValue(for key: Date) -> Double {
        return self.values[key]!
    }
    
    public func clear() {
        self.values.removeAll()
        self.lastUpdated = nil
    }
    
    public func update(for currentTime: Date, with value: Double) {
        if let lastUpdated = lastUpdated {
            let currentTimespan = lastUpdated - currentTime
            print("TimeSpan \(timeSpan), \(currentTimespan.abs())")
            if currentTimespan.abs() > updateInterval {
                print("Update interval (\(updateInterval) reached. Clear values older than \(timeSpan)")
                self.lastUpdated = currentTime
                clearObsoleteValues(currentTime: currentTime)
            }
        } else {
            self.lastUpdated = currentTime
        }
        self.values[currentTime] = value
        
    }
    
    func clearObsoleteValues(currentTime: Date) {
        for (key, value) in self.values {
            print("Check value for \(key) (\(value))")
            let currentTimespan = key - currentTime
            if(currentTimespan.abs() > self.timeSpan) {
                print("Remove old value for (\(key)) diff: \(currentTimespan)")
                self.values.removeValue(forKey: key)
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
