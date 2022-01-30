//
//  Indicator.swift
//  
//
//
import Foundation

public protocol Indicator {
    
    var barSeries: BarSeries { get }
}

public protocol BooleanIndicator: Indicator {
    
    func getValue(for index: Int) -> Bool
}

public protocol ValueIndicator: Indicator{
    
    func getValue(for index: Int) -> Double
}

extension ValueIndicator {
    
    func numeric() -> NumericIndicator {
        return NumericIndicator(of: self);
    }
}

public class ClosePriceIndicator: ValueIndicator {
    
    public var barSeries: BarSeries
    
    public init(barSeries: BarSeries){
        self.barSeries = barSeries;
    }
    
    public func getValue(for index: Int) -> Double {
        return self.barSeries.bars[index].closePrice
    }
}

public class OpenPriceIndicator: ValueIndicator {
    
    public var barSeries: BarSeries
    
    public init(barSeries: BarSeries){
        self.barSeries = barSeries;
    }
    
    public func getValue(for index: Int) -> Double {
        return self.barSeries.bars[index].openPrice
    }
}

public class HighPriceIndicator: ValueIndicator {
    
    public var barSeries: BarSeries
    
    public init(barSeries: BarSeries){
        self.barSeries = barSeries;
    }
    
    public func getValue(for index: Int) -> Double {
        return self.barSeries.bars[index].highPrice
    }
}

public class LowPriceIndicator: ValueIndicator {
    
    public var barSeries: BarSeries
    
    public init(barSeries: BarSeries){
        self.barSeries = barSeries;
    }
    
    public func getValue(for index: Int) -> Double {
        return self.barSeries.bars[index].lowPrice
    }
}

public class VolumePriceIndicator: ValueIndicator {
    
    public var barSeries: BarSeries
    
    public init(barSeries: BarSeries){
        self.barSeries = barSeries;
    }
    
    public func getValue(for index: Int) -> Double {
        return Double(self.barSeries.bars[index].volume)
    }
}
