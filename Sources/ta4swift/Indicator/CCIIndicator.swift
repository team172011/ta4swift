//
//  CCIIndicator.swift
//  
//
//  Created by Simon-Justus Wimmer on 03.03.22.
//

import Foundation

/**
 * Commodity Channel Index (CCI) indicator.
 */
public struct CCIIndicator: ValueIndicator {
    
    public var calc: (BarSeries, Int) -> Double
    
    public init(barCount: () -> Int) {
        let factor = 0.015
        let typicalPriceIndicator = TypicalPriceIndicator()
        let smaIndicator = SMAIndicator(barCount: barCount()) { typicalPriceIndicator }
        let meanDeviatationIndicator = MeanDeviationIndicator(barCount: barCount()) { typicalPriceIndicator }
        
        self.calc = { barSeries, index in
            
            let typicalPrice = typicalPriceIndicator.calc(barSeries, index)
            let typicalPriceAvg = smaIndicator.calc(barSeries, index)
            let meanDeviatation = meanDeviatationIndicator.calc(barSeries, index)
            if meanDeviatation == 0.0 {
                return 0.0
            }
            
            return (typicalPrice - typicalPriceAvg) / (meanDeviatation * factor)
        }
    }
}
