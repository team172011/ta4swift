//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 24.01.22.
//

import Foundation

public struct EMAIndicator: ValueIndicator {
    
    public var f: (BarSeries, Int) -> Double
    
    init(indicator: ValueIndicator,  barCount: Int){
        

        self.f = { barSeries, index in
            let multiplier = (2.0 / Double((barCount + 1)))
            
            func f_helper(_ barSeries: BarSeries, _ index: Int, _ indicator: ValueIndicator, _ multiplier: Double) -> Double {
                if (index == 0) {
                    return indicator.f(barSeries, 0);
                }
                let prevValue = f_helper(barSeries, index - 1, indicator, multiplier);
                return (indicator.f(barSeries, index) - prevValue) * multiplier + prevValue;
            }
            
            return f_helper(barSeries, index, indicator, multiplier)
        }
    }
}
