//
//  File.swift
//  
//
//  Created by Simon-Justus Wimmer on 19.02.22.
//

import Foundation

public struct StandardDeviationIndicator: ValueIndicator {
    
    public var calc: calcFuncTypeValue
    
    public init<T: ValueIndicator>(barCount: Int, _ base: () -> T){
        self.calc = VarianceIndicator(barCount: barCount, base).sqrt().calc
    }
}
