//
//  ConstantValueIndicator.swift
//  
//
//  Created by Simon-Justus Wimmer on 30.01.22.
//

import Foundation

public struct ConstantValueIndicator: ValueIndicator {
    
    public var cached: Bool = false
    public var calc: (BarSeries, Int) -> Double
    
    public init(_ value: () -> Double) {
        let v = value()
        self.calc = { barSeries, index in return v }
    }
}
