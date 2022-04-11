//
//  MMAIndicator.swift
//  
//
//  Created by Simon-Justus Wimmer on 20.02.22.
//

import Foundation

/**
 Modified moving average indicators
 */
public struct MMAIndicator: ValueIndicator {
   
    public var calc: (BarSeries, Int) -> Double
    
    public init(barCount: Int, _ base: () -> ValueIndicator) {
        self.calc = EMAIndicator(barCount: barCount, multiplier: 1.0 / Double(barCount), base).calc
    }
}
