//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 24.01.22.
//

import Foundation

public struct EMAIndicator: ValueIndicator {
    
    public var calc: (BarSeries, Int) -> Double
    
    init(barCount: Int, _ base: () -> ValueIndicator){
        self.init(barCount: barCount, multiplier: 2.0 / Double((barCount + 1)), base)
    }
    
    init(barCount: Int, multiplier: Double,  _ base: () -> ValueIndicator){
        let indicator = base()
        self.calc = {
            barSeries, index in
            
            func f_helper(_ barSeries: BarSeries, _ index: Int, _ indicator: ValueIndicator, _ multiplier: Double) -> Double {
                if (index == 0) {
                    return indicator.calc(barSeries, 0);
                }
                let prevValue = f_helper(barSeries, index - 1, indicator, multiplier);
                return (indicator.calc(barSeries, index) - prevValue) * multiplier + prevValue;
            }
            
            return f_helper(barSeries, index, indicator, multiplier)
        }
    }
}
