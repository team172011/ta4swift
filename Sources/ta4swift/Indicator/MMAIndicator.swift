//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 20.02.22.
//

import Foundation

/**
 Modified moving average indicators
 */
public struct MMAIndicator: ValueIndicator {
   
    public var calc: calcFuncTypeValue
    
    public init<T>(barCount: Int, _ base: () -> T) where T: ValueIndicator {
        self.calc = EMAIndicator(barCount: barCount, multiplier: 1.0 / Double(barCount), base).calc
    }
}
