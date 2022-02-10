//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 24.01.22.
//

import Foundation

public struct SMAIndicator: ValueIndicator {
    
    public var calc: calcFuncTypeValue
    
    public init<T: ValueIndicator>(indicator: T,  barCount: Int, cached: Bool = true) {
        let calc: calcFuncTypeValue = { barSeries, index in
            var sum = 0.0
            if index - barCount >= 0 {
                for i in (index - barCount + 1)...index {
                    sum += indicator.calc(barSeries, i)
                }
            }
            return sum / Double(barCount)
        }
        self.calc = calc
    }
    
    public init(barCount: Int, cached: Bool = true) {
        let indicator = ClosePriceIndicator()
        let calc: calcFuncTypeValue = { barSeries, index in
            var sum = 0.0
            if index - barCount >= 0 {
                for i in (index - barCount + 1)...index {
                    sum += indicator.calc(barSeries, i)
                }
            }
            return sum / Double(barCount)
        }
        self.calc = calc
    }
}
