//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 20.02.22.
//

import Foundation

/**
 Average true range indicator
 */
public struct ATRIndicator: ValueIndicator {
    
    public var calc: (BarSeries, Int) -> Double
    
    
    public init(barCount: Int) {
        self.init(barCount: barCount){ TRIndicator() }
    }
    
    public init(barCount: Int, trueRange: () -> TRIndicator){
        self.calc = MMAIndicator(barCount: barCount, trueRange).calc
    }
}
