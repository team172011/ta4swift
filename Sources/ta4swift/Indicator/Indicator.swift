//
//  Indicator.swift
//  
//
//
import Foundation

public typealias calcFuncTypeValue = (BarSeries, Int) -> Double
public typealias calcFuncTypeBool = (BarSeries, Int) -> Bool
public typealias valueCacheType = (@escaping calcFuncTypeValue) -> calcFuncTypeValue

/**
 An Indicator holds a closure for calculating a value of a BarSeries at an index
 */
public protocol Indicator {
    
    /**
     The return type of this indicator
     */
    associatedtype DataType
    
    /**
     The formular f(x) = y for this inidcator and  a given bar series
     */
    var calc: (BarSeries, Int) -> DataType { get }
    
}

public protocol BooleanIndicator: Indicator where DataType == Bool {
    var calc: calcFuncTypeBool { get }
}

public protocol ValueIndicator: Indicator where DataType == Double {
    associatedtype ReturnValue
    var calc: calcFuncTypeValue { get }
    
    /*
     Returns an array of all calculated values for this bar series
     */
    func values(for barSeries: BarSeries) -> [Double]
    
    /*
     Returns an array of all calculated values for this bar series
     */
    func valueMap(for barSeries: BarSeries) -> Dictionary<Date, Double>
    
    /**
     The cached version of this indicator
     */
    var cached: CachedIndicator<Self> { get }
    
    /**
     Creates a new ValueIndicator that calculates the sum of this indicator and the given indicator
     */
    func plus<T: ValueIndicator>(_ indicator: T) -> ReturnValue
    
    /**
     Creates a new ValueIndicator that calculates the difference of this indicator and the given indicator
     */
    func minus<T: ValueIndicator>(_ indicator: T) -> ReturnValue
    
    /**
     Creates a new ValueIndicator that calculates the product of this indicator and the given indicator
     */
    func multiply<T: ValueIndicator>(_ indicator: T) -> ReturnValue
    
    /**
     Creates a new ValueIndicator that calculates the divisor of this indicator and the given indicator
     */
    func divide<T: ValueIndicator>(_ indicator: T) -> ReturnValue
    
    /**
     Creates a new ValueIndicator that calculates the minimum value between this indicator and the given indicator
     */
    func min<T: ValueIndicator>(_ indicator: T) -> ReturnValue
    
    /**
     Creates a new ValueIndicator that calculates the sum of this indicator and the given indicator
     */
    func max<T: ValueIndicator>(_ indicator: T) -> ReturnValue
    
    /**
     Creates a ValueIndicator that calculates the square root of this indicator
     */
    func sqrt() -> ReturnValue
    
    /**
     Creates a ValueIndicator that calculates the absolute value of this indicator
     */
    func abs() -> ReturnValue
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
        return RawIndicator{BinaryOperation.sum(left: self, right: indicator)}
    }
    
    func minus<T>(_ indicator: T) -> RawIndicator where T : ValueIndicator {
         return RawIndicator { BinaryOperation.difference(left: self, right: indicator) }
     }
     
    func multiply<T>(_ indicator: T) -> RawIndicator where T : ValueIndicator {
        return RawIndicator { BinaryOperation.product(left: self, right: indicator) }
    }
    
    func divide<T>(_ indicator: T) -> RawIndicator where T : ValueIndicator {
        return RawIndicator{ BinaryOperation.quotient(left: self, right: indicator) }
    }
    
    func min<T>(_ indicator: T) -> RawIndicator where T : ValueIndicator {
        return RawIndicator{ BinaryOperation.min(left: self, right: indicator) }
    }
    
    func max<T>(_ indicator: T) -> RawIndicator where T : ValueIndicator {
        return RawIndicator{ BinaryOperation.max(left: self, right: indicator) }
    }
    
    func sqrt() -> RawIndicator {
        return RawIndicator{ UnaryOperation.sqrt(indicator: self) }
    }
    
    func abs() -> RawIndicator {
        return RawIndicator { UnaryOperation.abs(indicator: self)}
    }
    
    var cached: CachedIndicator<Self> {
        get {
            return CachedIndicator(of: self)
        }
    }
}


public struct CKey: Hashable, CustomStringConvertible {
    
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

/**
 A CachedIndicator is a wrapper class for an indicator structure. The result of the calc Closure will be cached in
 an externat cache property
 */
public final class CachedIndicator<T: ValueIndicator>: ValueIndicator {
    
    public var calc: calcFuncTypeValue = {a,b in return 0.0}
    var cache: Dictionary<CKey, DataType> = Dictionary()
    
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
