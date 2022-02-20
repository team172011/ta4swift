//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 20.02.22.
//

import Foundation

/**
 True range indicator
 */
public struct TRIndicator: ValueIndicator {
    
    public var calc: calcFuncTypeValue = {
        barSeries, index in
        let bar = barSeries.bars[index]
        let ts = bar.highPrice - bar.lowPrice
        
        var ys = 0.0
        var yst = 0.0
        if index != 0 {
            let prevBar = barSeries.bars[index - 1]
            ys = bar.highPrice - prevBar.closePrice
            yst = prevBar.closePrice - bar.lowPrice
        }
        
        return ts.abs().max(ys.abs()).max(yst.abs())
        
    }
}

public extension Double {
    
    func max(_ other: Double) -> Double {
        Swift.max(self, other)
    }
    
    func abs() -> Double {
        Swift.abs(self)
    }
}
