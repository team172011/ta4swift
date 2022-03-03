//
//  File 2.swift
//  
//
//  Created by Simon-Justus Wimmer on 03.03.22.
//

import Foundation

public struct MeanDeviationIndicator: ValueIndicator {
    public var calc: calcFuncTypeValue
    
    public init<T: ValueIndicator>(barCount: Int, _ base: () -> T){
        let baseIndicator = base()
        let baseIndicatorSma = SMAIndicator(barCount: barCount){ baseIndicator }
        self.calc = { barSeries, index in
            var absoluteDeviatations = 0.0;
            let average = baseIndicatorSma.calc(barSeries, index)
            let startIndex = 0.max(index - barCount + 1)
            let nbValues =  (Double) (index - startIndex + 1)
            
            for i in startIndex...index {
                absoluteDeviatations = absoluteDeviatations + (baseIndicator.calc(barSeries, i) - average).abs()
            }
            
            return absoluteDeviatations / nbValues
        }
    }
}
