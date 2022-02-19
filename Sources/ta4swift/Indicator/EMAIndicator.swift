//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 24.01.22.
//

import Foundation

public struct EMAIndicator: ValueIndicator {
    
    public var calc: calcFuncTypeValue
    
    init<T: ValueIndicator>(barCount: Int, _ base: () -> T){
        let indicator = base()
        let calc: calcFuncTypeValue = { barSeries, index in
            let multiplier = (2.0 / Double((barCount + 1)))
            
            func f_helper<T: ValueIndicator>(_ barSeries: BarSeries, _ index: Int, _ indicator: T, _ multiplier: Double) -> Double {
                if (index == 0) {
                    return indicator.calc(barSeries, 0);
                }
                let prevValue = f_helper(barSeries, index - 1, indicator, multiplier);
                return (indicator.calc(barSeries, index) - prevValue) * multiplier + prevValue;
            }
            
            return f_helper(barSeries, index, indicator, multiplier)
        }
        self.calc = calc
    }
}
