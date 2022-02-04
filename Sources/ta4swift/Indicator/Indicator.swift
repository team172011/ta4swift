//
//  Indicator.swift
//  
//
//
import Foundation

public protocol BooleanIndicator {
    
    var f: (BarSeries, Int) -> Bool { get }
    
}

public protocol ValueIndicator {
    
    var f: (BarSeries, Int) -> Double { get }
}

public struct ClosePriceIndicator: ValueIndicator {
    
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
