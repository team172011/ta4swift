//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 23.01.22.
//

import Foundation

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
