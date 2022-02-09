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
     Flag if this ValueIndicator has a cache (activated)
     */
     var cached: Bool { get }
    associatedtype DataType
}

public protocol BooleanIndicator: Indicator where DataType == Bool {
    var calc: calcFuncTypeBool { get }
}

public protocol ValueIndicator: Indicator where DataType == Double {
    associatedtype ReturnValue
    var calc: calcFuncTypeValue { get }

    func plus<T: ValueIndicator>(_ indicator: T) -> ReturnValue
    
    
    func minus<T: ValueIndicator>(_ indicator: T) -> ReturnValue
    func multiply<T: ValueIndicator>(_ indicator: T) -> ReturnValue
    func divide<T: ValueIndicator>(_ indicator: T) -> ReturnValue
    func min<T: ValueIndicator>(_ indicator: T) -> ReturnValue
    func max<T: ValueIndicator>(_ indicator: T) -> ReturnValue
    
    func sqrt() -> ReturnValue
    func abs() -> ReturnValue

     }

public struct RawIndicator: ValueIndicator {
    
    public var calc: calcFuncTypeValue
    
    public var cached: Bool
    
    public init(_ cached: Bool = true, _ formular: @escaping () -> calcFuncTypeValue) {
        self.cached = cached
        self.calc = IndicatorFormularBuilder(cached: cached) { formular() }.formular
    }
    
    public init(_ operation: @escaping () -> BinaryOperation){
        self.init(false){operation().calc}
    }
    
    public init(_ operation: @escaping () -> UnaryOperation){
        self.init{operation().calc}
    }
}

public class ClosePriceIndicator: ValueIndicator {
    public var cached: Bool { get { false }}
    public var calc: calcFuncTypeValue = {$0.bars[$1].closePrice}
}

public struct OpenPriceIndicator: ValueIndicator {
    public var cached: Bool = false
    public var calc: calcFuncTypeValue = {$0.bars[$1].openPrice}
}

public struct HighPriceIndicator: ValueIndicator {
    public var cached: Bool = false
    public var calc: calcFuncTypeValue = {$0.bars[$1].highPrice}
}

public struct LowPriceIndicator: ValueIndicator {
    public var cached: Bool = false
    public var calc: calcFuncTypeValue = {$0.bars[$1].lowPrice}
}

public struct VolumePriceIndicator: ValueIndicator {
    public var cached: Bool = false
    public var calc: calcFuncTypeValue = {Double($0.bars[$1].volume)}
}

public extension ValueIndicator {
    
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
}

public struct IndicatorFormularBuilder {
    public typealias DataType = Double
    
    let formular: calcFuncTypeValue;
    
    let cache: valueCacheType = {
        calcFunction in
        var cache: Dictionary<Date, DataType> = Dictionary()
        let cachedCalc: calcFuncTypeValue = {
            barSeries, index in
            let key = barSeries.bars[index].beginTime
            if let cachedValue = cache[key] {
                #if Xcode
                print("cache hit")
                #endif
                return cachedValue
            } else {
                let value = calcFunction(barSeries, index)
                cache[key] = value
                #if Xcode
                print("cache miss")
                #endif
                return value
            }
        }
        return cachedCalc
    }
    
    public init(cached: Bool = true, _ formular: @escaping () -> calcFuncTypeValue) {
        if cached {
            self.formular = cache(formular())
        } else {
            self.formular = formular()
        }
    }
}
