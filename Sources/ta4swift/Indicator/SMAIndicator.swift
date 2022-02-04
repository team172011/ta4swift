//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 24.01.22.
//

import Foundation

public struct SMAIndicator: ValueIndicator {
    
    public var f: (BarSeries, Int) -> Double
    
    public init(indicator: ValueIndicator,  barCount: Int){
        
        self.f = { barSeries, index in
            var sum = 0.0
            if index - barCount >= 0 {
                for i in (index - barCount + 1)...index {
                    sum += indicator.f(barSeries, i)
                }
            }
            return sum / Double(barCount)
        }
    }
}
