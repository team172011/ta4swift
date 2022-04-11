//
//  SMAIndicator.swift
//  
//
//  Created by Simon-Justus Wimmer on 24.01.22.
//

import Foundation

public struct SMAIndicator: ValueIndicator {
    
    public var calc: (BarSeries, Int) -> Double
    
    /**
     Creates an SMA indicator based on the close price
     */
    public init(barCount: Int, cached: Bool = true) {
        self.init(barCount: barCount){ ClosePriceIndicator() }
    }
    
    /**
     Creates an SMA indicator based on the given indicator
     */
    public init(barCount: Int, _ base: () -> ValueIndicator) {
        let indicator = base()
        let calc: (BarSeries, Int) -> Double = { barSeries, index in
            var sum = 0.0
            for i in 0.max(index - barCount + 1)...index {
                sum += indicator.calc(barSeries, i)
            }
            return sum / Double(Swift.min(barCount, index + 1))
        }
        self.calc = calc
    }
}
