//
//  Indicator.swift
//  
//
//
import Foundation

public protocol ValueIndicator{
    
    var barSeries: BarSeries { get }
    func getValue(for index: Int) -> Double
}

public class NumericIndicator: ValueIndicator {
    
    private let delegate: ValueIndicator
    
    public var barSeries: BarSeries {
        get {
            return delegate.barSeries;
        }
    }
    
    init(of indicator: ValueIndicator) {
        self.delegate = indicator;
    }
    
    public func getValue(for index: Int) -> Double {
        return delegate.getValue(for: index)
    }
    
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


public class EMAIndicator: ValueIndicator {
    
    public var barSeries: BarSeries
    let barCount: Int
    let multiplier: Double
    let indicator: ValueIndicator
    
    init(indicator: ValueIndicator,  barCount: Int){
        self.barSeries = indicator.barSeries
        self.indicator = indicator
        self.barCount = barCount
        self.multiplier = (2.0 / Double((barCount + 1)))
    }
    
    public func getValue(for index: Int) -> Double {
        if (index == 0) {
            return self.indicator.getValue(for: 0);
        }
        let prevValue = self.getValue(for: index - 1);
        return (indicator.getValue(for: index) - prevValue) * multiplier + prevValue;

    }
}

public class SMAIndicator: ValueIndicator {
    
    public var barSeries: BarSeries
    let barCount: Int
    let multiplier: Double
    let indicator: ValueIndicator
    
    init(indicator: ValueIndicator,  barCount: Int){
        self.barSeries = indicator.barSeries
        self.indicator = indicator
        self.barCount = barCount
        self.multiplier = (2.0 / Double((barCount + 1)))
    }
    
    public func getValue(for index: Int) -> Double {
        var sum = 0.0
        if index - barCount >= 0 {
            for i in (index - barCount + 1)...index {
                sum += indicator.getValue(for: i)
            }
        }
        return sum / Double(barCount)
    }
}
