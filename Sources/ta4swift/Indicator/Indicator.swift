//
//  Indicator.swift
//  
//
//
import Foundation


public protocol BooleanIndicator {
    var calc: (BarSeries, Int) -> Bool { get }
}

public protocol ValueIndicator {
    
    var calc: (BarSeries, Int) -> Double { get }
    
    /*
     Returns an array of all calculated values for this bar series
     */
    func values(for barSeries: BarSeries) -> [Double]
    
    /*
     Returns an Map<Date, Value> of all calculated values for this bar series
     */
    func valueMap(for barSeries: BarSeries) -> Dictionary<Date, Double>
    
    /**
     The cached version of this indicator
     */
    func cached () -> CachedIndicator
    
    /**
     The cached version of this indicator
     */
    func cached(timeInterval: TimeInterval, updateInterval: TimeInterval) -> CachedIndicator
    
    /**
     Creates a new ValueIndicator that calculates the sum of this indicator and the given indicator
     */
    func plus(_ indicator: ValueIndicator) -> ValueIndicator
    
    /**
     Creates a new ValueIndicator that calculates the difference of this indicator and the given indicator
     */
    func minus(_ indicator: ValueIndicator) -> ValueIndicator
    
    /**
     Creates a new ValueIndicator that calculates the product of this indicator and the given indicator
     */
    func multiply(_ indicator: ValueIndicator) -> ValueIndicator
    
    func multiply(_ value: Double) -> ValueIndicator
    
    /**
     Creates a new ValueIndicator that calculates the divisor of this indicator and the given indicator
     */
    func divide(_ indicator: ValueIndicator) -> ValueIndicator
    
    func divide(_ value: Double) -> ValueIndicator
    
    /**
     Creates a new ValueIndicator that calculates the minimum value between this indicator and the given indicator
     */
    func min(_ indicator: ValueIndicator) -> ValueIndicator
    
    /**
     Creates a new ValueIndicator that calculates the sum of this indicator and the given indicator
     */
    func max(_ indicator: ValueIndicator) -> ValueIndicator
    
    /**
     Creates a ValueIndicator that calculates the square root of this indicator
     */
    func sqrt() -> ValueIndicator
    
    /**
     Creates a ValueIndicator that calculates the absolute value of this indicator
     */
    func abs() -> ValueIndicator
}

public extension ValueIndicator {

    func values(for barSeries: BarSeries) -> [Double] {
        var values = [Double]()
        for i in 0..<barSeries.bars.count {
            values.append(self.calc(barSeries, i))
        }
        return values
    }
    
    func valueMap(for barSeries: BarSeries) -> Dictionary<Date, Double> {
        var values = Dictionary<Date, Double>()
        for (index, bar) in barSeries.bars.enumerated() {
            values[bar.beginTime] = self.calc(barSeries, index)
        }
        return values
    }
    
    func plus(_ indicator: ValueIndicator) -> ValueIndicator {
        BinaryOperation.sum(left: self, right: indicator)
    }
    
    func minus(_ indicator: ValueIndicator) -> ValueIndicator {
         BinaryOperation.difference(left: self, right: indicator)
     }
     
    func multiply(_ indicator: ValueIndicator) -> ValueIndicator {
         BinaryOperation.product(left: self, right: indicator)
    }
    
    func multiply(_ value: Double) -> ValueIndicator {
        multiply(ConstantValueIndicator{value})
    }
    
    func divide(_ indicator: ValueIndicator) -> ValueIndicator {
        BinaryOperation.quotient(left: self, right: indicator)
    }
    
    func divide(_ value: Double) -> ValueIndicator {
        divide(ConstantValueIndicator{value})
    }
    
    func min(_ indicator: ValueIndicator) -> ValueIndicator {
        BinaryOperation.min(left: self, right: indicator)
    }
    
    func max(_ indicator: ValueIndicator) -> ValueIndicator {
        BinaryOperation.max(left: self, right: indicator)
    }
    
    func sqrt() -> ValueIndicator {
        UnaryOperation.sqrt(indicator: self)
    }
    
    func abs() -> ValueIndicator {
        UnaryOperation.abs(indicator: self)
    }
    
    func cached() -> CachedIndicator {
        return CachedIndicator(of: self)
    }
    
    /**
     Creates a cached version of this inidcator
        - timeInteral:          the size of the cache in seconds (e.g. the cache should store values for one minute = 60 or one day = 60 * 24)
        - updateInterval:    the update intervale in seconds (e.g. how often should the cache be updated and remove old values)
     */
    func cached(timeInterval: TimeInterval, updateInterval: TimeInterval) -> CachedIndicator {
        return CachedIndicator(of: self, timeSpan: timeInterval, updateInterval: updateInterval)
    }
}

public extension Double {
    
    func max(_ other: Double) -> Double {
        Swift.max(self, other)
    }
    
    func max(_ other: Int) -> Double {
        Swift.max(self, Double(other))
    }
    
    func min(_ other: Double) -> Double {
        Swift.min(self, other)
    }
    
    func min(_ other: Int) -> Double {
        Swift.min(self, Double(other))
    }
    
    func abs() -> Double {
        Swift.abs(self)
    }
}

public extension Int {
    
    func max(_ other: Double) -> Int {
        Swift.max(self, Int(other))
    }
    
    func max(_ other: Int) -> Int {
        Swift.max(self, other)
    }
    
    func min(_ other: Double) -> Int {
        Swift.min(self, Int(other))
    }
    
    func min(_ other: Int) -> Int {
        Swift.min(self, other)
    }
    
    func abs() -> Int {
        Swift.abs(self)
    }
}
