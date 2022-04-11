//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 19.02.22.
//

import Foundation

public struct StandardDeviationIndicator: ValueIndicator {
    
    public var calc: (BarSeries, Int) -> Double
    
    public init(barCount: Int, _ base: () -> ValueIndicator){
        self.calc = VarianceIndicator(barCount: barCount, base).sqrt().calc
    }
}
