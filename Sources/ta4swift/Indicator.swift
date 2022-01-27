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

public protocol DateIndicator: Indicator {
    func getValue(for index: Int) -> Date
}

public class NumericIndicator: ValueIndicator {
    
    public let delegate: ValueIndicator
    
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

public class DateTimeIndicator: DateIndicator {
    
    public var barSeries: BarSeries
    
    public init(barSeries: BarSeries) {
        self.barSeries = barSeries
    }
    
    public func getValue(for index: Int) -> Date {
        return self.barSeries.bars[index].beginTime
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
    
    public init(indicator: ValueIndicator,  barCount: Int){
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

public class ConstantValueIndicator: ValueIndicator {
    
    public var constant: Double
    public var barSeries: BarSeries
    
    public init(barSeries: BarSeries, constant: Double) {
        self.barSeries = barSeries
        self.constant = constant
    }
    
    public func getValue(for index: Int) -> Double {
        return self.constant
    }
}

// returns true indicator1 crosses down indicator2/constant value
public class CrossedIndicator: BooleanIndicator {
    
    public var barSeries: BarSeries
    public var indicator1: ValueIndicator
    public var indicator2: ValueIndicator
    
    public init(indicator1: ValueIndicator, indicator2: ValueIndicator) {
        assert(indicator1.barSeries === indicator2.barSeries)
        self.barSeries = indicator1.barSeries
        self.indicator1 = indicator1
        self.indicator2 = indicator2
    }
    
    public convenience init(indicator: ValueIndicator, constant: Double) {
        self.init(indicator1: indicator, indicator2: ConstantValueIndicator(barSeries: indicator.barSeries, constant: constant))
    }
    
    public convenience init(constant: Double, indicator: ValueIndicator) {
        self.init(indicator1: ConstantValueIndicator(barSeries: indicator.barSeries, constant: constant), indicator2: indicator)
    }
    
    public func getValue(for index: Int) -> Bool {
        if index == 0 || indicator1.getValue(for: index) >= indicator2.getValue(for: index) {
            return false
        }
        
        var i = index - 1
        if indicator1.getValue(for: i) > indicator2.getValue(for: i) {
            return true
        }
        
        while i > 0 && indicator1.getValue(for: i) == indicator2.getValue(for: i) {
            i = i - 1
        }
        
        return ( i != 0) && indicator1.getValue(for: i) > indicator2.getValue(for: i)
        
    }
    
}
