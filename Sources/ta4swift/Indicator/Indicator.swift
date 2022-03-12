//
//  Indicator.swift
//  
//
//
import Foundation

public typealias calcFuncTypeValue = (BarSeries, Int) -> Double
public typealias calcFuncTypeBool = (BarSeries, Int) -> Bool
public typealias valueCacheType = (@escaping calcFuncTypeValue) -> calcFuncTypeValue

public protocol BooleanIndicator {
    var calc: calcFuncTypeBool { get }
}

public protocol ValueIndicator {
    
    var calc: calcFuncTypeValue { get }
    
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
    func cached() -> CachedIndicator<Self>
    
    /**
     The cached version of this indicator
     */
    func cached(timeInterval: TimeInterval, updateInterval: TimeInterval) -> CachedIndicator<Self>
    
    /**
     Creates a new ValueIndicator that calculates the sum of this indicator and the given indicator
     */
    func plus<T: ValueIndicator>(_ indicator: T) -> RawIndicator
    
    /**
     Creates a new ValueIndicator that calculates the difference of this indicator and the given indicator
     */
    func minus<T: ValueIndicator>(_ indicator: T) -> RawIndicator
    
    /**
     Creates a new ValueIndicator that calculates the product of this indicator and the given indicator
     */
    func multiply<T: ValueIndicator>(_ indicator: T) -> RawIndicator
    
    func multiply(_ value: Double) -> RawIndicator
    
    /**
     Creates a new ValueIndicator that calculates the divisor of this indicator and the given indicator
     */
    func divide<T: ValueIndicator>(_ indicator: T) -> RawIndicator
    
    func divide(_ value: Double) -> RawIndicator
    
    /**
     Creates a new ValueIndicator that calculates the minimum value between this indicator and the given indicator
     */
    func min<T: ValueIndicator>(_ indicator: T) -> RawIndicator
    
    /**
     Creates a new ValueIndicator that calculates the sum of this indicator and the given indicator
     */
    func max<T: ValueIndicator>(_ indicator: T) -> RawIndicator
    
    /**
     Creates a ValueIndicator that calculates the square root of this indicator
     */
    func sqrt() -> RawIndicator
    
    /**
     Creates a ValueIndicator that calculates the absolute value of this indicator
     */
    func abs() -> RawIndicator
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
    
    func plus<T>(_ indicator: T) -> RawIndicator where T : ValueIndicator {
        RawIndicator{BinaryOperation.sum(left: self, right: indicator)}
    }
    
    func minus<T>(_ indicator: T) -> RawIndicator where T : ValueIndicator {
         RawIndicator { BinaryOperation.difference(left: self, right: indicator) }
     }
     
    func multiply<T>(_ indicator: T) -> RawIndicator where T : ValueIndicator {
        RawIndicator { BinaryOperation.product(left: self, right: indicator) }
    }
    
    func multiply(_ value: Double) -> RawIndicator {
        multiply(ConstantValueIndicator{value})
    }
    
    func divide<T>(_ indicator: T) -> RawIndicator where T : ValueIndicator {
        RawIndicator{ BinaryOperation.quotient(left: self, right: indicator) }
    }
    
    func divide(_ value: Double) -> RawIndicator {
        divide(ConstantValueIndicator{value})
    }
    
    func min<T>(_ indicator: T) -> RawIndicator where T : ValueIndicator {
        RawIndicator{ BinaryOperation.min(left: self, right: indicator) }
    }
    
    func max<T>(_ indicator: T) -> RawIndicator where T : ValueIndicator {
        RawIndicator{ BinaryOperation.max(left: self, right: indicator) }
    }
    
    func sqrt() -> RawIndicator {
        RawIndicator{ UnaryOperation.sqrt(indicator: self) }
    }
    
    func abs() -> RawIndicator {
        RawIndicator { UnaryOperation.abs(indicator: self)}
    }
    
    func cached() -> CachedIndicator<Self> {
        return CachedIndicator(of: self)
    }
    
    /**
     Creates a cached version of this inidcator
        - timeInteral:          the size of the cache in seconds (e.g. the cache should store values for one minute = 60 or one day = 60 * 24)
        - updateInterval:    the update intervale in seconds (e.g. how often should the cache be updated and remove old values)
     */
    func cached(timeInterval: TimeInterval, updateInterval: TimeInterval) -> CachedIndicator<Self> {
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
