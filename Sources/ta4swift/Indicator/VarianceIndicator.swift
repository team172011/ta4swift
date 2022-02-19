//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 16.02.22.
//

import Foundation

public struct VarianceIndicator: ValueIndicator {
    
    public var calc: calcFuncTypeValue
    
    public init<T: ValueIndicator>(barCount: Int, _ base: () -> T){
        let baseIndicator = base()
        let sma = SMAIndicator(barCount: barCount) { baseIndicator }
        self.calc = {
            barSeries, index in
            let startIndex = Swift.max(0, index - barCount + 1)
            let numberOfObservations = Double(index - startIndex + 1)
            
            var variance = 0.0
            let average = sma.calc(barSeries, index)
            for i in startIndex...index {
                let value = baseIndicator.calc(barSeries, i)
                let pow =  pow(value - average, 2)
                variance = variance + pow
            }
            
            return variance / numberOfObservations
        }
    }
}
