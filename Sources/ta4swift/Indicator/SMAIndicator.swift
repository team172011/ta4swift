//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 24.01.22.
//

import Foundation

public struct SMAIndicator: ValueIndicator {
    
    public var calc: calcFuncTypeValue
    
    /**
     Creates an SMA indicator based on the close price
     */
    public init(barCount: Int, cached: Bool = true) {
        self.init(barCount: barCount){ ClosePriceIndicator() }
    }
    
    /**
     Creates an SMA indicator based on the given indicator
     */
    public init<T: ValueIndicator>(barCount: Int, _ base: () -> T) {
        let indicator = base()
        let calc: calcFuncTypeValue = { barSeries, index in
            var sum = 0.0
            for i in Swift.max(0, index - barCount + 1)...index {
                sum += indicator.calc(barSeries, i)
            }
            return sum / Double(Swift.min(barCount, index + 1))
        }
        self.calc = calc
    }
}
