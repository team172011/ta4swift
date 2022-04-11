//
//  ROCVIndicator.swift
//  
//
//  Created by Simon-Justus Wimmer on 11.04.22.
//

import Foundation

/**
 * Rate of change of volume (ROCVIndicator) indicator. Aka. Momentum of Volume
 *
 * The ROCVIndicator calculation compares the current volume with the volume "n"
 * periods ago.
 */
public struct ROCVIndicator: ValueIndicator {
    
    public var calc: (BarSeries, Int) -> Double
    
    public init(barCount: Int) {
        
        self.calc = {
            barSeries, index in
            
            let prevIndex = 0.max(index - barCount)
            let valueNPeriodsAgo = Double(barSeries.bars[prevIndex].volume)
            let currentValue = Double(barSeries.bars[index].volume)
            
            return ((currentValue - valueNPeriodsAgo) / valueNPeriodsAgo) * 100.0
        }
    }
}
