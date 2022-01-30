//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 24.01.22.
//

import Foundation

public struct SMAIndicator: ValueIndicator {
    
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
