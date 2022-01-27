//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 24.01.22.
//

import Foundation

public struct EMAIndicator: ValueIndicator {
    
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
