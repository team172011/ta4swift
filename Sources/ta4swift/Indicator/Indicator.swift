//
//  Indicator.swift
//  
//
//
import Foundation

/**
 An Indicator holds a function for calculating a value of a BarSeries at an index
 */
public protocol Indicator {
    associatedtype DataType
    
    var f: (BarSeries, Int) -> DataType { get }
}

public protocol BooleanIndicator: Indicator where DataType == Bool {
    
}

public protocol ValueIndicator: Indicator where DataType == Double {
    
}

public struct ClosePriceIndicator: ValueIndicator {
    public typealias DataType = Double
    
    
    public var f: (BarSeries, Int) -> Double = {$0.bars[$1].closePrice}
    
}

public struct OpenPriceIndicator: ValueIndicator {
    
    public var f: (BarSeries, Int) -> Double = {$0.bars[$1].openPrice}
}

public struct HighPriceIndicator: ValueIndicator {
    
    public var f: (BarSeries, Int) -> Double = {$0.bars[$1].highPrice}
}

public struct LowPriceIndicator: ValueIndicator {
    
    public var f: (BarSeries, Int) -> Double = {$0.bars[$1].lowPrice}
}

public struct VolumePriceIndicator: ValueIndicator {
    
    public var f: (BarSeries, Int) -> Double = {Double($0.bars[$1].volume)}
}
