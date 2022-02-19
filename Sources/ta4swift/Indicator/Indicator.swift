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
    
    var cached: CachedIndicator<Self> {
        get {
            return CachedIndicator(of: self)
        }
    }
}
